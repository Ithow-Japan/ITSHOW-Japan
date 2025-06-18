const { checkAttendance, addAttendance, getAttendance } = require('../models/attendanceModel');
const moment = require('moment');  // 날짜 계산을 위한 라이브러리

// 출석 체크
const markAttendance = async (req, res) => {
  const userId = req.session.user.id; 
  const currentDate = moment().format('YYYY-MM-DD');  // 현재 날짜

  if (!userId) {
    return res.status(400).json({ message: 'userId가 필요합니다.' });
  }

  try {
    // 출석 여부 확인
    const existingAttendance = await checkAttendance(userId, currentDate);

    if (existingAttendance.length > 0) {
      return res.status(400).json({ message: '이미 출석 체크가 되었습니다.', "checked": true });
    }

    // 연속 출석일수 계산 (어제 출석 체크가 있으면 연속 출석 일수 +1)
    const previousAttendance = await checkAttendance(userId, moment(currentDate).subtract(1, 'days').format('YYYY-MM-DD'));

    let streak = 1;  // 기본값: 첫 출석
    if (previousAttendance.length > 0) {
      const lastDate = moment(previousAttendance[0].date);
      const diffInDays = moment(currentDate).diff(lastDate, 'days');

      if (diffInDays === 1) {
        streak = previousAttendance[0].streak + 1;  // 연속 출석일수 증가
      }
    }

    // 출석 기록 저장
    await addAttendance(userId, currentDate, streak);

    res.status(200).json({ message: '출석 체크 완료!', streak: streak });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: '서버 오류가 발생했습니다.' });
  }
};

// 출석 기록 전체 조회
const getAttendanceData = async (req, res) => {
  const userId = req.session.user.id; 

  if (!userId) {
    return res.status(400).json({ message: 'userId가 필요합니다.' });
  }

  try {
    const records = await getAttendance(userId);
    res.status(200).json({ message: '출석 기록 조회 성공', data: records });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: '출석 기록 조회 중 오류 발생' });
  }
};

module.exports = { markAttendance, getAttendanceData };
