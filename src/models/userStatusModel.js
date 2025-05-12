const db = require('../db/db');  

async function incrementCorrect(userId) {
    await db.query('UPDATE user_status SET correct = correct + 1 WHERE user_id = ?', [userId]);
}

async function incrementTotal(userId) {
    await db.query('UPDATE user_status SET total = total + 1 WHERE user_id = ?', [userId]);
}

async function updateLastUpdated(userId, currentTime) {
    const query = 'UPDATE user_status SET last_updated = ? WHERE user_id = ?';
    try {
        await db.query(query, [currentTime, userId]);
    } catch (err) {
        throw err;
    }
}

async function incrementProgressIfCompleted(userId, expressionId) {
    const [rows] = await db.query(`
        SELECT 
            e.completed AS expressionCompleted,
            q.completed AS quizCompleted
        FROM expressions e
        JOIN quiz q ON q.expressions_id = e.id
        WHERE e.id = ?`, [expressionId]);

    if (rows.length === 0) return false;

    const { expressionCompleted, quizCompleted } = rows[0];

    if (expressionCompleted && quizCompleted) {
        await db.query(`
            INSERT INTO user_status (user_id, progress)
            VALUES (?, 3.2258)
            ON DUPLICATE KEY UPDATE progress = progress + 3.2258
        `, [userId]);
        return true;
    }

    return false;
}

module.exports = {
    incrementCorrect,
    incrementTotal,
    updateLastUpdated,
    incrementProgressIfCompleted
};