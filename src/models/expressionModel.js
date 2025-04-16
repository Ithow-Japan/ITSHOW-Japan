const db = require('../db/db');

// 선택한 카테고리의 표현 전체 조회
const getExpressionsByCategory = async (categoryId) => {
    const query = 'SELECT * FROM expressions WHERE category_id = ?';
    try {
        const [results] = await db.query(query, [categoryId]);
        return results;
    } catch (err) {
        throw err;
    }
};

// 해당 카테고리에서 완료(completed)된 표현만 조회
const getLearnedByCategory = async (categoryId) => {
    const query = 'SELECT * FROM expressions WHERE category_id = ? AND completed = 1';
    try {
        const [results] = await db.query(query, [categoryId]);
        return results;
    } catch (err) {
        throw err;
    }
};

// 특정 표현을 완료 상태로 표시
const markExpressionAsCompleted = async (expressionId) => {
    const query = 'UPDATE expressions SET completed = 1 WHERE id = ?';
    await db.query(query, [expressionId]);
};

// 카테고리의 성취도(achievement)를 계산하여 갱신
const updateCategoryAchievement = async (categoryId) => {
    const query = `
        UPDATE category
        SET achievement = (
            SELECT ROUND(100.0 * SUM(CASE WHEN completed = 1 THEN 1 ELSE 0 END) / COUNT(*))
            FROM expressions
            WHERE category_id = ?
        )
        WHERE id = ?
    `;
    await db.query(query, [categoryId, categoryId]);
};

// 표현 ID를 통해 해당 표현의 카테고리 ID 조회
const getCategoryIdByExpressionId = async (expressionId) => {
    const query = 'SELECT category_id FROM expressions WHERE id = ?';
    const [rows] = await db.query(query, [expressionId]);
    return rows[0]?.category_id || null;
};

module.exports = {
    getExpressionsByCategory,
    getLearnedByCategory,
    markExpressionAsCompleted,
    updateCategoryAchievement,
    getCategoryIdByExpressionId,
};
