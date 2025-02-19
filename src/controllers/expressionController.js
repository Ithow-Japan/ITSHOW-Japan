const expressionModel = require('../models/expressionModel');

// 카테고리별 표현 조회
const getExpressionsByCategory = async (req, res) => {
    const categoryId = req.params.categoryId;
    try {
        const expressions = await expressionModel.getExpressionsByCategory(categoryId);
        res.json({ status: 'success', data: expressions });
    } catch (err) {
        console.error(err);
        res.status(500).json({ status: 'error', message: 'Server error' });
    }
};

module.exports = { getExpressionsByCategory };
