const db = require('../db/db');

// 선택한 표현의 퀴즈 조회 함수
const getQuizByExpressions = async (expressionsId) => {
    const query = 'SELECT * FROM quiz WHERE expressions_id = 1';
    try {
        const [results] = await db.query(query, [expressionsId]);  // expressionsId로 필터링
        return results;
    } catch (err) {
        throw err;  // 에러 처리
    }
};

// 표현별 학습한 퀴즈 조회
const getLearnedByExpressions = async (expressionsId) => {
    const query = `SELECT * FROM quiz WHERE expressions_id = ? AND completed = 1;`;
    try {
        const [results] = await db.query(query, [expressionsId]);
        return results;
    } catch (err) {
        throw err;
    }
};

module.exports = { 
    getQuizByExpressions,
    getLearnedByExpressions
};