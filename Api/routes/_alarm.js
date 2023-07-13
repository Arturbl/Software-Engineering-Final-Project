const express = require('express');
const router = express.Router();
const routeWrapper = require("../misc/route_wrapper");
const {body} = require("express-validator");
const {sha512} = require("sha512-crypt-ts");
const validateBearerToken = require("../misc/validate_bearer");

router.get('/', validateBearerToken
    , routeWrapper(async (req) => {
        let teste = null
        if (req.query.userID)
            return (await req.db.query(`select *
                                        from "arduino-security-system-postgres-db".registro_alarme
                                                 inner join "arduino-security-system-postgres-db"."User"
                                                            on "arduino-security-system-postgres-db"."User".userid =
                                                               "arduino-security-system-postgres-db".registro_alarme.userid`)).rows;
        teste = await req.db.query(`select *
                            from "arduino-security-system-postgres-db".registro_alarme`)
        return teste.rows;
    }));


router.post('/add',
    routeWrapper(async (req) => {
        //alarme disparou
        let user = await req.db.query(`select *
                                       from "arduino-security-system-postgres-db"."User"
                                       where username = '${req.body.username}'`)
        await req.db.query(`
                    INSERT INTO "arduino-security-system-postgres-db".registro_alarme (distancia, register_data, turn_off_data, userid)
                    VALUES ($1, $2, $3, $4)`,
            [req.body.distancia.toFixed(3), req.body.register_data, req.body.turn_off_data, user.rows[0]?.userid || null]
        );

        return "Create Alarm";
    }));

router.post('/turnOff',
    body("userID").trim().matches(/^\d+$/),
    validateBearerToken,
    routeWrapper(async (req) => {
        console.log(req.session)
        await req.db.query(`INSERT INTO "arduino-security-system-postgres-db".alarm_status(active, userid)
                            VALUES (false, $1)`, [req.session.id]);
        return "Delete Alarm";
    }));


router.post('/turnOn',
    body("userID").trim().matches(/^\d+$/),
    validateBearerToken,
    routeWrapper(async (req) => {
        console.log(req.session)
        await req.db.query(`INSERT INTO "arduino-security-system-postgres-db".alarm_status(active, userid)
                            VALUES (true, $1)`, [req.session.id]);
        return "Delete Alarm";
    }));


module.exports = router;
