const express = require('express');
const router = express.Router();
const routeWrapper = require("../misc/route_wrapper");
const {body} = require("express-validator");
const {sha512} = require("sha512-crypt-ts");

router.get('/', routeWrapper(async (req) => {
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
    routeWrapper(async (req) => {
        let existentUser = await req.db.query(`select *
                                               from "arduino-security-system-postgres-db"."User"
                                               where userid = '${req.body.userID}'`)
        if (existentUser.rows.length === 0)
            throw "USER doesn't exists"
        await req.db.query(`INSERT INTO "arduino-security-system-postgres-db".registro_alarme(distancia, userid)
                            VALUES ($1, $2)`, [req.body.distancia.toFixed(3),
            req.body.userID]);
        return "Create Alarm";
    }));

router.post('/:alarmID/turnOff',
    body("userID").trim().matches(/^\d+$/),
    routeWrapper(async (req) => {
        let existentAlarm = await req.db.query(`select *
                                                from "existentAlarm"
                                                where registroid = '${req.params.alarmID}'`)
        if (existentAlarm.rows.length === 0)
            throw "ALARM doesn't exists"
        await req.db.query(`update "existentAlarm"
                            SET userID = req.body.userID
                            where registroid = '${req.params.alarmID}'`);
        return "Delete Alarm";
    }));


module.exports = router;
