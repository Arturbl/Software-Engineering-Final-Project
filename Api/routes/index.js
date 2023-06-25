const express = require('express');
const router = express.Router();
const routeWrapper = require("../misc/route_wrapper");

router.use('/alarm', require('./_alarm'));
router.use('/user', require('./_user'));
const {storageMiddleware} = require('../misc/storage');
router.use('/uploads', storageMiddleware);
module.exports = router;
