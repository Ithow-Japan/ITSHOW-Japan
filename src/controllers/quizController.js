const quizModel = require('../models/quizModel');
const userStatusModel = require('../models/userStatusModel');
const authController = require('../controllers/authController');

// 표현별 퀴즈 조회
const getQuizByExpressions = async (req, res) => {
    const expressionsId = req.params.expressionsId;
    try {
        const quiz = await quizModel.getQuizByExpressions(expressionsId);
        if (quiz.length === 0) {
            return res.status(404).json({ status: 'error', message: '해당 표현의 퀴즈를 찾을 수 없습니다.' });
        }
        return res.status(200).json({ quiz });
    } catch (err) {
        console.error(err);
        res.status(500).json({ status: 'error', message: '서버 오류' });
    }
};

// 사용자가 학습 완료한 퀴즈 조회 (user_quiz 기준)
const getAllCompletedQuizzes = async (req, res) => {
    const userId = req.session.user.id;

    try {
        const quizzes = await quizModel.getUserCompletedQuizzesByUser(userId);
        if (!quizzes || quizzes.length === 0) {
            return res.status(404).json({ message: '완료된 퀴즈가 없습니다.' });
        }
        res.status(200).json({ quizzes });
    } catch (err) {
        console.error('완료된 퀴즈 조회 중 오류:', err);
        res.status(500).json({ message: '서버 오류 발생', error: err.message });
    }
};

// 퀴즈 정답 확인 및 결과 저장
const submitQuizAnswer = async (req, res) => {
    const { quizId } = req.params;
    const { selectedOption } = req.body;
    const userId = req.session.user.id;

    // 유효성 검사
    if (![1, 2, 3, 4].includes(selectedOption)) {
        return res.status(400).json({ message: '선택지는 1부터 4 사이여야 합니다.' });
    }

    try {
        const quiz = await quizModel.getQuizAnswerById(quizId);
        if (!quiz) {
            return res.status(404).json({ message: '해당 퀴즈를 찾을 수 없습니다.' });
        }

        const isCorrect = Number(quiz.answer) === selectedOption;
        const completed = isCorrect ? 1 : 0;

        // user_quiz 테이블에 결과 저장
        await quizModel.saveUserQuizResult(userId, quizId, completed);

        const expressionId = quiz.expressions_id;
        const currentTime = new Date();

        // 사용자 상태 업데이트
        if (userId && expressionId) {
            await userStatusModel.incrementTotal(userId);
            await userStatusModel.updateLastUpdated(userId, currentTime);

            if (isCorrect) {
                await userStatusModel.incrementProgressIfCompleted(userId, expressionId);
                await userStatusModel.incrementCorrect(userId);
                await userStatusModel.updateLastUpdated(userId, currentTime);
                await authController.updateGrowPokoro(req);
            }
        }

        return res.status(200).json({
            isCorrect,
            message: isCorrect ? '정답입니다!' : '틀렸습니다.',
            ...(isCorrect ? {} : { correctAnswer: quiz.answer }),
        });
    } catch (err) {
        console.error(err);
        return res.status(500).json({ message: '채점 중 오류 발생', error: err.message });
    }
};

// 수동으로 결과 저장 (필요 시)
const saveQuizResult = async (req, res) => {
    const { quizId } = req.params;
    const { completed } = req.body;
    const userId = req.session.user.id;

    if (typeof completed !== 'number') {
        return res.status(400).json({ message: 'completed 값(0 또는 1)은 필수입니다.' });
    }

    try {
        const result = await quizModel.saveUserQuizResult(userId, quizId, completed);
        return res.status(200).json({ message: '퀴즈 결과가 저장되었습니다.' });
    } catch (err) {
        console.error(err);
        return res.status(500).json({ message: '퀴즈 결과 저장 실패', error: err.message });
    }
};

module.exports = {
    getQuizByExpressions,
    getAllCompletedQuizzes,
    submitQuizAnswer,
    saveQuizResult
};