const db = require('../db/db');  

// 카테고리 목록 조회 함수
const getCategories = async () => {
    const query = 'SELECT * FROM category';
    try {
        const [results] = await db.query(query);  // db.query()로 Promise 사용
        return results;
    } catch (err) {
        throw err;  // 에러 처리
    }
};

module.exports = { getCategories };
