const db = require('../db/db');  

// 출석 여부 확인
const checkAttendance = async (userId, currentDate) => {
  try {
    const [rows] = await db.query('SELECT * FROM attendance WHERE user_id = ? AND date = ?', [userId, currentDate]);
    return rows; // 조회된 결과 반환
  } catch (error) {
    throw new Error('출석 확인 오류: ' + error.message);
  }
};

// 출석 기록 추가
const addAttendance = async (userId, currentDate, streak) => {
  try {
    const query = 'INSERT INTO attendance (user_id, date, streak) VALUES (?, ?, ?)';
    await db.query(query, [userId, currentDate, streak]);
  } catch (error) {
    throw new Error('출석 삽입 중 오류 발생: ' + error.message);
  }
};

module.exports = { checkAttendance, addAttendance };