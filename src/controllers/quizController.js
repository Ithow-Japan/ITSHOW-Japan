const quizModel = require('../models/quizModel');

// 표현별 퀴즈 조회
const getQuizByExpressions = async (expressionsId) => {
    try {
        const quiz = await quizModel.getQuizByExpressions(expressionsId);
        return quiz;  // 퀴즈 데이터 반환
    } catch (err) {
        console.error(err);
        throw new Error('서버 오류');
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

// 퀴즈 정답 확인
const submitQuizAnswer = async (req, res) => {
    const { quizId } = req.params;
    const { selectedOption } = req.body;

    // 1~4 사이의 숫자인지 확인
    if (![1, 2, 3, 4].includes(selectedOption)) {
        return res.status(400).json({ message: '선택지는 1부터 4 사이여야 합니다.' });
    }

    try {
        const quiz = await quizModel.getQuizAnswerById(quizId); // DB에서 퀴즈 정보 가져오기

        if (!quiz) {
            return res.status(404).json({ message: '해당 퀴즈를 찾을 수 없습니다.' });
        }

        const isCorrect = Number(quiz.answer) === selectedOption; // 정답 비교

        await quizModel.updateQuizResult(quizId, isCorrect ? 1 : 0); // 정답이면 completed=1, 틀리면 completed=0

        return res.status(200).json({
            isCorrect,
            message: isCorrect ? '정답입니다!' : '틀렸습니다.',
            ...(isCorrect ? {} : { correctAnswer: quiz.answer }),
        });
    } catch (err) {
        return res.status(500).json({ message: '채점 중 오류 발생', error: err.message });
    }
};

// 퀴즈 결과 저장
const saveQuizResult = async (req, res) => {
    const { quizId } = req.params;
    const { completed } = req.body;

    if (typeof completed !== 'number') {
        return res.status(400).json({ message: 'completed (0 or 1) is required' });
    }

    try {
        const result = await quizModel.updateQuizResult(quizId, completed);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Quiz not found or not updated' });
        }

        return res.status(200).json({ message: 'Quiz result updated successfully' });
    } catch (err) {
        return res.status(500).json({ message: 'Failed to update quiz result', error: err.message });
    }
};

module.exports = { 
    getQuizByExpressions, 
    getLearnedByExpressions,
    submitQuizAnswer,
    saveQuizResult  
};
