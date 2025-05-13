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

// 카테고리별 표현 개수 설정
const categoryExpressionCount = {
    1: 5,
    2: 6,
    3: 7,
    4: 6,
    5: 7
};

// 카테고리의 성취도(achievement)를 계산하여 갱신
const updateCategoryAchievement = async (userId, categoryId) => {
    // 해당 카테고리의 표현 개수 가져오기
    const totalExpressions = categoryExpressionCount[categoryId];
    if (!totalExpressions) return;

    // 성취도 계산: 완료된 표현의 개수 / 카테고리의 총 표현 개수 * 100
    const selectQuery = `
        SELECT ROUND(100.0 * SUM(CASE WHEN completed = 1 THEN 1 ELSE 0 END) / ?) AS achievement
        FROM expressions
        WHERE category_id = ?
    `;
    const [rows] = await db.query(selectQuery, [totalExpressions, categoryId, userId]);
    const achievement = rows[0]?.achievement ?? 0;

    // user_category 테이블에 존재 여부 확인
    const [existing] = await db.query(
        `SELECT id FROM user_category WHERE user_id = ? AND category_id = ?`,
        [userId, categoryId]
    );

    if (existing.length > 0) {
        // 이미 존재하면 업데이트
        await db.query(
            `UPDATE user_category SET achievement = ? WHERE user_id = ? AND category_id = ?`,
            [achievement, userId, categoryId]
        );
    } else {
        // 존재하지 않으면 삽입
        await db.query(
            `INSERT INTO user_category (user_id, category_id, achievement) VALUES (?, ?, ?)`,
            [userId, categoryId, achievement]
        );
    }
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
