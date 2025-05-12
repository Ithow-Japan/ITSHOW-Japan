const db = require('../db/db');

// 선택한 표현의 퀴즈 조회 함수
const getQuizByExpressions = async (expressionsId) => {
    const query = 'SELECT * FROM quiz WHERE expressions_id = ?';
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

// 퀴즈 정답, 표현 아이디 조회
const getQuizAnswerById = async (quizId) => {
    const query = 'SELECT answer, expressions_id FROM quiz WHERE id = ?';
    try {
        const [results] = await db.query(query, [quizId]);
        return results[0];  // 단일 객체 반환
    } catch (err) {
        throw err;
    }
};

// 퀴즈 결과 저장 (completed 값 업데이트)
const updateQuizResult = async (quizId, isCorrect) => {
    const query = 'UPDATE quiz SET completed = ? WHERE id = ?';
    try {
        const [result] = await db.query(query, [isCorrect ? 1 : 0, quizId]);
        return result;
    } catch (err) {
        throw err;
    }
};

module.exports = { 
    getQuizByExpressions,
    getLearnedByExpressions,
    getQuizAnswerById,
    updateQuizResult
};