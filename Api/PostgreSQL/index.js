const {Pool} = require('pg')
const knex = require('knex')({client: 'pg'});

const pool = new Pool({
    host: "192.168.1.78",
    user: process.env.POSTGRES_USER, // alterado para POSTGRES_USER
    port: 5432,
    password: process.env.POSTGRES_PASSWORD, // alterado para POSTGRES_PASSWORD
    database: process.env.POSTGRES_DB, // alterado para POSTGRES_DB
    max: 20,
});

const MyConnection = require("./connection");

function getConnection() {
    return new Promise(function (resolve, reject) {
        pool.connect(function (err, connection) {
            if (err)
                return reject(err);
            return resolve(new MyConnection(connection));
        });
    });
}

module.exports = {
    listen: async function (req, res, next) {
        try {
            // Save db on req
            req.db = await getConnection();
            await req.db.startTransaction();
            next();
        } catch (e) {
            return res.status(500).json({message: "PostGreSQL" + ": " + e.message, code: 500});
        }
    },
    knex,
    getConnection
};