const express = require('express');
const router = express.Router();
const routeWrapper = require("../misc/route_wrapper");
const {body} = require("express-validator");
const {sha512} = require("sha512-crypt-ts");
const validateBearerToken = require("../misc/validate_bearer");
const crypto = require("crypto");

router.get('/', validateBearerToken, routeWrapper(async (req) => {
    let teste = await req.db.query(`select *
                                    from "arduino-security-system-postgres-db"."User"`)
    return teste.rows;
}));

router.post('/authenticate',
    routeWrapper(async (req) => {
        //TODO

        let password = sha512.crypt(req.body.password, "$6$rounds=1000$ueCGNzfSS9DT")
        let userLogin = await req.db.query(`select *
                                            from "arduino-security-system-postgres-db"."User"
                                            WHERE password = '${password}'
                                              and username = '${req.body.username}'`)
        let token = crypto.randomUUID();

        let teste = await req.db.query(`INSERT INTO "arduino-security-system-postgres-db"."user_session" (userid, token, date_expires)
                                        VALUES ($1, $2, CURRENT_TIMESTAMP + INTERVAL '5 minutes')`,
            [parseInt(userLogin.rows[0].userid), token]);
        return {...userLogin.rows[0], token};
    }));

router.post('/create_user',
    body("username", "Invalid username").trim().matches(/^[a-z]+$/),
    body("password", "Invalid password").trim().isLength({min: 1}),
    body("nif", "Invalid nif").trim().isLength({min: 9}),
    body("morada", "Invalid morada"),
    routeWrapper(async (req) => {
        let existentUser = await req.db.query(`select *
                                               from "arduino-security-system-postgres-db"."User"
                                               where username = '${req.body.username}'`)
        if (existentUser.rows.length !== 0)
            throw "USER ALREADY EXISTS"
        let password = sha512.crypt(req.body.password, "$6$rounds=1000$ueCGNzfSS9DT")
        await req.db.query(`INSERT INTO "arduino-security-system-postgres-db"."User" (nif, "morada", admin, "username", "password")
                            VALUES ($1, $2, $3, $4, $5)`,
            [req.body.nif, req.body.morada, req.body.admin || false, req.body.username, password]);

        return "create_user Module";
    }));

router.post('/delete_user',
    body("username", "Invalid username").trim().matches(/^[a-z]+$/),
    routeWrapper(async (req) => {
        let existentUser = await req.db.query(`select *
                                               from "arduino-security-system-postgres-db"."User"
                                               where username = '${req.body.username}'`)
        if (existentUser.rows.length === 0 || existentUser.rows[0]?.active === false)
            throw "USER DOESN'T EXISTS"
        //TODO ver se é admin
        await req.db.query(`update "arduino-security-system-postgres-db"."User"
                            SET active= false
                            where username = '${req.body.username}'  `);
        return "create_user Module";
    }));

module.exports = router