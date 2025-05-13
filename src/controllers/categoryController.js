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

module.exports = { getCategories };


