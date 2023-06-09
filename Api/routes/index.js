const express = require('express');
const router = express.Router();
const routeWrapper = require("../misc/route_wrapper");

router.use('/alarm', require('./_alarm'));
router.use('/user', require('./_user'));

module.exports = router;
