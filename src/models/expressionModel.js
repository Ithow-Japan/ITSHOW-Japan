const db = require('../db/db');

// 선택한 카테고리의 표현 전체 조회
const getExpressionsByCategory = async (categoryId) => {
    const query = 'SELECT * FROM expressions WHERE category_id = ?';
    const [results] = await db.query(query, [categoryId]);
    return results;
};

// 해당 카테고리에서 완료된 표현만 조회 (사용자별 완료 기준)
const getLearnedByCategory = async (userId, categoryId) => {
    const query = `
      SELECT e.* FROM expressions e
      JOIN user_expression ue ON e.id = ue.expression_id
      WHERE ue.user_id = ? AND e.category_id = ?
    `;
    const [results] = await db.query(query, [userId, categoryId]);
    return results;
};

// 특정 표현을 완료 상태로 표시 (user_expression 테이블에 기록)
const markExpressionAsCompleted = async (userId, expressionId) => {
    const query = `
      INSERT INTO user_expression (user_id, expression_id, completed, completed_at)
      VALUES (?, ?, 1, CURRENT_TIMESTAMP)
      ON DUPLICATE KEY UPDATE completed = 1, completed_at = CURRENT_TIMESTAMP
    `;
    await db.query(query, [userId, expressionId]);
};

// 카테고리별 표현 개수 설정
const categoryExpressionCount = {
    1: 5,
    2: 6,
    3: 7,
    4: 6,
    5: 7
};

// 사용자별 카테고리의 성취도 계산 후 갱신
const updateCategoryAchievement = async (userId, categoryId) => {
    const totalExpressions = categoryExpressionCount[categoryId];
    if (!totalExpressions) return;

    const query = `
      SELECT COUNT(*) AS completedCount
      FROM user_expression ue
      JOIN expressions e ON ue.expression_id = e.id
      WHERE ue.user_id = ? AND e.category_id = ?
    `;
    const [rows] = await db.query(query, [userId, categoryId]);
    const completedCount = rows[0]?.completedCount || 0;

    const achievement = Math.round((completedCount / totalExpressions) * 100);

    // user_category 테이블에 존재 여부 확인
    const [existing] = await db.query(
        `SELECT id FROM user_category WHERE user_id = ? AND category_id = ?`,
        [userId, categoryId]
    );

    if (existing.length > 0) {
        await db.query(
            `UPDATE user_category SET achievement = ? WHERE user_id = ? AND category_id = ?`,
            [achievement, userId, categoryId]
        );
    } else {
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