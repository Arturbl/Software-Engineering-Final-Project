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
        await req.db.query(`select *
                            from "arduino-security-system-postgres-db".registro_alarme`)
        return teste.rows;
    }));

router.post('/add',
    validateBearerToken,
    routeWrapper(async (req) => {
        await req.db.query(`INSERT INTO "arduino-security-system-postgres-db".registro_alarme(distancia,
                                                                                              register_data,
                                                                                              turn_off_data)
                            VALUES ($1, $2)`, [req.body.distancia.toFixed(3),
            req.body.register_data, req.body.turn_off_data]);
        return "Create Alarm";
    }));

router.post('/:alarmID/turnOff',
    body("userID").trim().matches(/^\d+$/),
    validateBearerToken,
    routeWrapper(async (req) => {
        let existentAlarm = await req.db.query(`select *
                                                from "existentAlarm"
                                                where registroid = '${req.params.alarmID}'`)
        if (existentAlarm.rows.length === 0)
            throw "ALARM doesn't exists"
        await req.db.query(`update "existentAlarm"
                            SET userID = req.body.userID
                            where registroid = '${req.params.alarmID}'`);
        await req.db.query(`INSERT INTO "arduino-security-system-postgres-db".alarm_status(active, userid)
                            VALUES (false, $1)`, [req.body.userID]);
        return "Delete Alarm";
    }));


router.post('/turnOn',
    body("userID").trim().matches(/^\d+$/),
    validateBearerToken,
    routeWrapper(async (req) => {

        await req.db.query(`INSERT INTO "arduino-security-system-postgres-db".alarm_status(active, userid)
                            VALUES (true, $1)`, [req.body.userID]);
        return "Delete Alarm";
    }));


module.exports = router;
