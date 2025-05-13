const db = require('../db/db');

// 새로운 사용자 생성
const createUser = async (userid, hashedPassword, nickname, email) => {
  const query = 'INSERT INTO user (userid, userpw, nickname, email, regDate) VALUES (?, ?, ?, ?, NOW())';
  try {
    const [result] = await db.execute(query, [userid, hashedPassword, nickname, email]);
    return result;
  } catch (err) {
    throw err;
  }
};

// 사용자 아이디로 찾기
const findByUserid = async (userid) => {
  const query = 'SELECT * FROM user WHERE userid = ?';
  try {
    const [rows] = await db.execute(query, [userid]);
    return rows;
  } catch (err) {
    throw err;
  }
};  

// 사용자 correct 값을 가져오는 함수
const getCorrectByUserId = async (userid) => {
  try {
    const query = 'SELECT correct FROM user_status WHERE user_id = ?';
    const [result] = await db.execute(query, [userid]);
    
    if (result.length === 0) {
      console.error(`User with userid ${userid} not found in user_status table.`);
      return null;
    }

    return result[0].correct;
  } catch (err) {
    console.error('Error fetching correct value:', err);
    throw err;
  }
};

// 사용자 레벨과 gage 업데이트 함수
const updateProgress = (id, level, gage, callback) => {
  const query = 'UPDATE user SET level = ?, gage = ? WHERE id = ?';
  db.query(query, [level, gage, id], (err, result) => {
      if (err) {
          return callback(err);
      }
      callback(null, result);
  });
};

// 포코로 레벨과 게이지 조회 함수
const getFokoroLevelAndGage = async (id) => {
  try {
    const query = 'SELECT level, gage FROM user WHERE id = ?';
    const [result] = await db.execute(query, [id]);

    if (result.length === 0) {
      console.error(`User with id ${id} not found.`);
      return null;
    }

    return result[0];  // { level, gage }
  } catch (err) {
    console.error('Error fetching level and gage:', err);
    throw err;
  }
};

module.exports = {
  createUser,
  findByUserid,
  getCorrectByUserId,
  updateProgress,
  getFokoroLevelAndGage
};
