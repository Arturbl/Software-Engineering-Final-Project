const express = require('express');
const router = express.Router();
const routeWrapper = require("../misc/route_wrapper");
const {body} = require("express-validator");
const {sha512} = require("sha512-crypt-ts");

router.get('/', routeWrapper(async (req) => {
        if (req.query.userID)
            return await req.db.query(`select * from registro_alarme inner join "User" on User.userid = registro_alarme.userid`)
        return await req.db.query(`select * from registro_alarme`)
        return teste;
    }));

router.post('/add',
    body("distancia").trim().matches(/^\d+$/),
    routeWrapper(async (req) => {
        let date = new Date();
        let existentUser = await req.db.query(`select *
                                               from "User"
                                               where userid = '${req.body.userID}'`)
        if (existentUser.rows.length === 0)
            throw "USER doesn't exists"
        await req.db.query(`INSERT INTO "registro_alarme"(distancia, admin, "data", "userID")
                            VALUES (${req.body.distancia},
                                    ${req.body.admin ? req.body.admin : false},
                                    ${req.body.data ? req.body.data : date.now()}`);
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
