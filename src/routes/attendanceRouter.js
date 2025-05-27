const express = require('express');
const router = express.Router();
const { markAttendance, getAttendanceData } = require('../controllers/attendanceController');

// 출석 체크
router.post('/attendance/check', markAttendance);

// 출석 기록 조회
router.get('/records', getAttendanceData);

module.exports = router;
