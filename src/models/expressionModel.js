const db = require('../db/db'); 

// 선택한 카테고리의 표현 조회 함수
const getExpressionsByCategory = async (categoryId) => {
    const query = 'SELECT * FROM expressions WHERE category_id = 1';
    try {
        const [results] = await db.query(query, [categoryId]);  // categoryId로 필터링
        return results;
    } catch (err) {
        throw err;  // 에러 처리
    }
};

module.exports = { getExpressionsByCategory };
