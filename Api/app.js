const express = require('express');
// Setup env variables
const dotenv = require('dotenv');
dotenv.config();

let app = express();

const morgan = require("morgan");
app.use(morgan('combined'));

app.use(express.json());
//teste

app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", req.headers.origin);
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization, Cache-Control, x-ijt, adminauthtoken");
    res.header('Access-Control-Allow-Credentials', "true");
    if ('OPTIONS' === req.method)
        return res.sendStatus(200);
    next();
})

// Attach database connection to all requests
const Client = require('./PostgreSQL');
const routeWrapper = require("./misc/route_wrapper");
app.use(Client.listen);

// Setup routes
app.get('/', routeWrapper(async (req) => {
    return {
        message: "Final project API"
    };
}));

app.use('/api', require("./routes"));

// catch 404 and forward to error handler
app.use(require("./misc/route_wrapper")(() => {
    throw {code: 404, message: "Not found"};
}));

module.exports = app;