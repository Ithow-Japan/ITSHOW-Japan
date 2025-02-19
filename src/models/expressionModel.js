const db = require('../db/db');

// 선택한 카테고리의 표현 조회 함수
const getExpressionsByCategory = async (categoryId) => {
    const query = 'SELECT * FROM expressions WHERE category_id = ?';
    try {
        const [results] = await db.query(query, [categoryId]);  // categoryId로 필터링
        return results;
    } catch (err) {
        throw err;  // 에러 처리
    }
};

// 카테고리별 학습한 문장 조회
const getLearnedByCategory = async (categoryId) => {
    const query = `SELECT * FROM expressions WHERE category_id = ? AND completed = 1;`;
    try {
        const [results] = await db.query(query, [categoryId]);
        return results;
    } catch (err) {
        throw err;
    }
};

module.exports = { 
    getExpressionsByCategory,
    getLearnedByCategory
};