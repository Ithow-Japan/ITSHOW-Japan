const db = require('../db/db');  

// 카테고리 목록 조회 함수
const getCategories = async () => {
    const query = 'SELECT * FROM category';
    try {
        const [results] = await db.query(query); 
        return results;
    } catch (err) {
        throw err;  // 에러 처리
    }
};

// 특정 사용자의 카테고리 성취도를 조회하는 함수
const getCategoryAchievement = async (userId) => {
    try {
        const [rows] = await db.query(
            `SELECT category_id, achievement
             FROM user_category
             WHERE user_id = ?`, 
            [userId]
        );
        return rows;  // 결과를 반환
    } catch (err) {
        throw new Error('Error retrieving category achievements');
    }
};

module.exports = { 
    getCategories,
    getCategoryAchievement 
};
