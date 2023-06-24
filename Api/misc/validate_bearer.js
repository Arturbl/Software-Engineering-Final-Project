async function validateBearerToken(req, res, next) {
    try {
        const authHeader = String(req.headers['authorization'] || '');
        if (!authHeader.startsWith('Bearer ')) {
            throw {code: 401, message: "Invalid bearer token"};
        }

        const token = authHeader.substring(7);
        let session = await req.db.query(`SELECT *,
                                                 CASE
                                                     WHEN NOW() >= date_expires THEN true
                                                     ELSE false
                                                     END AS expired
                                          FROM "arduino-security-system-postgres-db"."user_session"
                                          WHERE token = '${token}'`);

        /*await req.db.knexOne(knex("user_session")
            .select("user_session.*", "username", "auth_admin", knex.raw("NOW() >= date_expire as expired"))
            .join("user", "user.id", "user_session.user")
            .where({token}));*/
        if (session && session.expired) {
            await req.db.query(`DELETE FROM "arduino-security-system-postgres-db"."user_session" WHERE token = ${token}`);
            session = null;
        }
        if (!session) {
            throw {code: 401, message: "Invalid bearer token"};
        }

        // Refresh token

        await req.db.query(`UPDATE "arduino-security-system-postgres-db"."user_session"
                            SET date_expires = CURRENT_TIMESTAMP + INTERVAL '5 minutes'
                            WHERE token = $1`, [token]);


        req.session = session;
        await req.db.commit();
        await req.db.startTransaction();

        // Continue
        next();
    } catch (e) {
        await req.db.rollback();
        await req.db.release();
        res.status(e.code || 500).json(e);
    }
}

module.exports = validateBearerToken;