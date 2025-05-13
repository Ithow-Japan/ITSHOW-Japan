const express = require('express');
const router = express.Router();
const { markAttendance } = require('../controllers/attendanceController');

// 출석 체크
router.post('/attendance/check', markAttendance);

module.exports = router;
