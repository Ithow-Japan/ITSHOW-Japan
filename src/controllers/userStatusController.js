const userStatusModel = require('../models/userStatusModel');

async function addCorrect(req, res) {
    const { userId } = req.body;
    try {
        await userStatusModel.incrementCorrect(userId);
        res.json({ message: 'Correct +1' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Update failed' });
    }
}

async function addTotal(req, res) {
    const { userId } = req.body;
    try {
        await userStatusModel.incrementTotal(userId);
        res.json({ message: 'Total +1' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Update failed' });
    }
}

async function updateProgress(req, res) {
    const { userId, expressionId } = req.body;
    try {
        const updated = await userStatusModel.incrementProgressIfCompleted(userId, expressionId);
        res.json({ message: updated ? 'Progress +3.2258%' : '조건 불충분으로 progress 미증가' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Update failed' });
    }
}

module.exports = {
    addCorrect,
    addTotal,
    updateProgress
};
