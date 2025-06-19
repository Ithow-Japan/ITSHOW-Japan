const expressionModel = require('../models/expressionModel');
//const quizModel = require('../models/quizModel');

// 선택한 카테고리의 표현 전체 조회
const getExpressionsByCategory = async (req, res) => {
    const categoryId = req.params.categoryId;
    try {
        const expressions = await expressionModel.getExpressionsByCategory(categoryId);
        res.json({ status: '성공', data: expressions });
    } catch (err) {
        console.error(err);
        res.status(500).json({ status: 'error', message: '서버 오류' });
    }
};

// 해당 카테고리에서 완료된 표현만 조회 (사용자별 완료 기준)
const getLearnedByCategory = async (req, res) => {
    const categoryId = req.params.categoryId;
    const userId = req.session.user.id;
    try {
        const expressions = await expressionModel.getLearnedByCategory(userId, categoryId);
        if (expressions.length === 0) {
            return res.status(404).json({ status: 'error', message: '해당 카테고리에서 학습된 표현이 없음.' });
        }
        res.json({ status: '성공', data: expressions });
    } catch (err) {
        console.error(err);
        res.status(500).json({ status: 'error', message: '서버 오류' });
    }
};

// 특정 표현 완료 처리 + 해당 카테고리 성취도 갱신
const completeExpression = async (req, res) => {
    const expressionId = req.params.id;
    const userId = req.session.user.id;
    try {
        // 표현 완료 표시 (사용자 ID 포함)
        await expressionModel.markExpressionAsCompleted(userId, expressionId);

        // 해당 표현의 카테고리 ID 조회
        const categoryId = await expressionModel.getCategoryIdByExpressionId(expressionId);
        if (!categoryId) {
            return res.status(400).json({ error: '카테고리 정보를 찾을 수 없습니다.' });
        }

        // 카테고리 성취도 갱신
        await expressionModel.updateCategoryAchievement(userId, categoryId);

        // 퀴즈 정보 조회 가능
        //const quiz = await quizModel.getQuizByExpressions(expressionId);

        res.status(200).json({
            message: '표현 완료 및 카테고리 성취도 업데이트 완료',
            // quiz: quiz
        });
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