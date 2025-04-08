const quizModel = require('../models/quizModel');

// 표현별 퀴즈 조회
const getQuizByExpressions = async (req, res) => {
    const expressionsId = req.params.expressionsId;
    try {
        const quiz = await quizModel.getQuizByExpressions(expressionsId);
        res.json({ status: 'success', data: quiz });
    } catch (err) {
        console.error(err);
        res.status(500).json({ status: 'error', message: 'Server error' });
    }
};

// 학습한 퀴즈 조회
const getLearnedByExpressions = async (req, res) => {
    const expressionsId = req.params.expressionsId;
    try {
        const quiz = await expressionModel.getLearnedByExpressions(categoryId);
        if (quiz.length === 0) {
            return res.status(404).json({ status: 'error', message: 'No learned expressions found for this category' });
        }
        res.json({ status: 'success', data: expressions });
    } catch (err) {
        console.error(err);
        res.status(500).json({ status: 'error', message: 'Server error' });
    }
};

module.exports = { 
    getQuizByExpressions, 
    getLearnedByExpressions  
};
