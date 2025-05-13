const userStatusModel = require('../models/userStatusModel');

// correct 증가
async function addCorrect(req, res) {
    const userId = req.session.user.id;
    try {
        await userStatusModel.incrementCorrect(userId);
        res.json({ message: 'Correct +1' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: '업데이트 실패' });
    }
}

// total 증가
async function addTotal(req, res) {
    const userId = req.session.user.id;
    try {
        await userStatusModel.incrementTotal(userId);
        res.json({ message: 'Total +1' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: '업데이트 실패' });
    }
}

// 학습 진행도 증가
async function updateProgress(req, res) {
    const userId = req.session.user.id;
    const { expressionId } = req.params;
    try {
        const updated = await userStatusModel.incrementProgressIfCompleted(userId, expressionId);
        res.json({ message: updated ? 'Progress +3.2258%' : '조건 불충분으로 progress 미증가' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: '업데이트 실패' });
    }
}

module.exports = {
    addCorrect,
    addTotal,
    updateProgress
};
