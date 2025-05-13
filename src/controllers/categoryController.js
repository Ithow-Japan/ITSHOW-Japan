const categoryModel = require('../models/categoryModel');  // categoryModel 불러오기

// 카테고리 목록 조회 함수
const getCategories = async (req, res) => {
    try {
        const categories = await categoryModel.getCategories();
        res.json(categories);
    } catch (error) {
        console.error(error);
        res.status(500).send('서버 오류');
    }
};

// 카테고리와 성취도를 반환하는 API
const getCategoryAchievement = async (req, res) => {
    const userId = req.session.user.id;  // 세션에서 user_id 가져오기

    try {
        // 모델에서 카테고리 성취도 조회
        const categoryData = await categoryModel.getCategoryAchievement(userId);

        // 조회된 데이터가 없다면
        if (categoryData.length === 0) {
            return res.status(200).json({ message: '이 사용자에 대한 카테고리가 없습니다.' });
        }

        // 카테고리 성취도 반환
        res.status(200).json({
            message: '카테고리와 업적을 성공적으로 조회했습니다.',
            data: categoryData
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: '데이터를 조회하는 중 오류 발생' });
    }
};

module.exports = { 
    getCategories,
    getCategoryAchievement 
};


