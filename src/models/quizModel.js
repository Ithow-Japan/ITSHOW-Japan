const db = require('../db/db');

// 표현별 퀴즈 전체 조회
const getQuizByExpressions = async (expressionsId) => {
    const query = 'SELECT * FROM quiz WHERE expressions_id = ?';
    try {
        const [results] = await db.query(query, [expressionsId]);
        return results;
    } catch (err) {
        throw err;
    }
};

// 사용자가 학습 완료한 퀴즈 조회
const getUserCompletedQuizByExpression = async (userId, expressionsId) => {
    const query = `
      SELECT q.*
      FROM quiz q
      JOIN user_quiz uq ON q.id = uq.quiz_id
      WHERE uq.user_id = ? AND q.expressions_id = ? AND uq.completed = 1;
    `;
    try {
        const [results] = await db.query(query, [userId, expressionsId]);
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
        return results[0];
    } catch (err) {
        throw err;
    }
};

// 사용자별 퀴즈 결과 저장 또는 갱신
const saveUserQuizResult = async (userId, quizId, completed = 1) => {
    const query = `
      INSERT INTO user_quiz (user_id, quiz_id, completed)
      VALUES (?, ?, ?)
      ON DUPLICATE KEY UPDATE completed = VALUES(completed), completed_at = CURRENT_TIMESTAMP;
    `;
    try {
        const [result] = await db.query(query, [userId, quizId, completed]);
        return result;
    } catch (err) {
        throw err;
    }
};

module.exports = {
    getQuizByExpressions,
    getLearnedByExpressions: getUserCompletedQuizByExpression,
    getQuizAnswerById,
    saveUserQuizResult,
};