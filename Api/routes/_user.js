const express = require('express');
const router = express.Router();
const routeWrapper = require("../misc/route_wrapper");
const {body} = require("express-validator");
const {sha512} = require("sha512-crypt-ts");

router.get('/', routeWrapper(async (req) => {
    let teste = await req.db.query(`SELECT * FROM pg_tables WHERE schemaname = 'arduino-security-system-postgres-db'`)

    return teste;
}));

router.post('/authenticate',
    body("username", "Invalid username").trim().matches(/^[a-z_]+$/),
    body("password", "Invalid password").trim().isLength({min: 1}),
    routeWrapper(async (req) => {
        //TODO

        return "Authenticate Module";
    }));

router.post('/create_user',
    body("username", "Invalid username").trim().matches(/^[a-z]+$/),
    body("password", "Invalid password").trim().isLength({min: 1}),
    body("nif", "Invalid nif").trim().isLength({min: 9}),
    body("morada", "Invalid morada"),
    routeWrapper(async (req) => {
        let existentUser = await req.db.query(`select *
                                               from "User"
                                               where username = '${req.body.username}'`)
        if (existentUser.rows.length !== 0)
            throw "USER ALREADY EXISTS"
        let password = sha512.crypt(req.body.password, "$6$rounds=1000$ueCGNzfSS9DT")
        await req.db.query(`INSERT INTO "User"(nif, "morada", admin, "username", "password")
                            VALUES (${req.body.nif}, ${req.body.morada},
                                    ${req.body.username ? req.body.username : false},
                                    ${req.body.username}, ${password})`);
        return "create_user Module";
    }));

router.post('/delete_user',
    body("username", "Invalid username").trim().matches(/^[a-z]+$/),
    routeWrapper(async (req) => {
        let existentUser = await req.db.query(`select *
                                               from "User"
                                               where username = '${req.body.username}'`)
        if (existentUser.rows.length === 0 || existentUser.rows[0]?.active === false)
            throw "USER DOESN'T EXISTS"
        //TODO ver se é admin
        await req.db.query(`update "User"
                            SET active= false
                            where username = '${req.body.username}'  `);
        return "create_user Module";
    }));

module.exports = router