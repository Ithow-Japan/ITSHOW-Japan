const expressionModel = require('../models/expressionModel');

// 선택한 카테고리의 표현 전체 조회
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

// 해당 카테고리에서 완료된 표현만 조회
const getLearnedByCategory = async (req, res) => {
    const categoryId = req.params.categoryId;
    try {
        const expressions = await expressionModel.getLearnedByCategory(categoryId);
        if (expressions.length === 0) {
            return res.status(404).json({ status: 'error', message: 'No learned expressions found for this category' });
        }
        res.json({ status: 'success', data: expressions });
    } catch (err) {
        console.error(err);
        res.status(500).json({ status: 'error', message: 'Server error' });
    }
};

// 특정 표현 완료 처리 + 해당 카테고리 성취도 갱신
const completeExpression = async (req, res) => {
    const expressionId = req.params.id;
    try {
        // 표현 완료 표시
        await expressionModel.markExpressionAsCompleted(expressionId);

        // 해당 표현의 카테고리 ID 조회
        const categoryId = await expressionModel.getCategoryIdByExpressionId(expressionId);

        // 카테고리 성취도 갱신
        if (categoryId) {
            await expressionModel.updateCategoryAchievement(categoryId);
        }

        res.status(200).json({ message: '표현 완료 및 카테고리 성취도 업데이트 완료' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: '업데이트 실패' });
    }
};

module.exports = {
    getExpressionsByCategory,
    getLearnedByCategory,
    completeExpression,
};
