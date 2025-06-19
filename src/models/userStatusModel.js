const db = require('../db/db');

// 없으면 user_status에 생성
async function ensureUserStatusExists(userId) {
    await db.query(`
        INSERT IGNORE INTO user_status (user_id, correct, total, last_updated, progress)
        VALUES (?, 0, 0, NOW(), 0)
    `, [userId]);
}

// correct 증가
async function incrementCorrect(userId) {
    await ensureUserStatusExists(userId);
    await db.query('UPDATE user_status SET correct = correct + 1 WHERE user_id = ?', [userId]);
}

// total 증가
async function incrementTotal(userId) {
    await ensureUserStatusExists(userId);
    await db.query('UPDATE user_status SET total = total + 1 WHERE user_id = ?', [userId]);
}

// 마지막 갱신일 업데이트
async function updateLastUpdated(userId, currentTime) {
    await ensureUserStatusExists(userId);
    const query = 'UPDATE user_status SET last_updated = ? WHERE user_id = ?';
    try {
        await db.query(query, [currentTime, userId]);
    } catch (err) {
        throw err;
    }
}

// 학습 진행도 증가
async function incrementProgressIfCompleted(userId, expressionId) {
    await ensureUserStatusExists(userId);

    // 1. user_expression에서 완료 여부 확인 (completed = 1)
    const [expressionRows] = await db.query(`
        SELECT 1 FROM user_expression
        WHERE user_id = ? AND expression_id = ? AND completed = 1
    `, [userId, expressionId]);

    if (expressionRows.length === 0) {
        console.log('user_expression 완료된 기록 없음');
        return false;
    }

    // 2. 해당 expression에 속한 quiz 목록 가져오기
    const [quizIds] = await db.query(`
        SELECT id FROM quiz WHERE expressions_id = ?
    `, [expressionId]);

    if (quizIds.length === 0) {
        console.log('expression에 속한 퀴즈 없음');
        return false;
    }

    const quizIdList = quizIds.map(row => row.id);
    if (quizIdList.length === 0) {
        console.log('퀴즈 ID 리스트가 비어있음');
        return false;
    }

    // 3. user_quiz 테이블에서 유저가 완료한 quiz 개수 조회 (completed = 1 조건 추가)
    const [userQuizRows] = await db.query(`
        SELECT COUNT(*) AS completedCount
        FROM user_quiz
        WHERE user_id = ? AND quiz_id IN (${quizIdList.map(() => '?').join(',')}) AND completed = 1
    `, [userId, ...quizIdList]);

    const completedCount = userQuizRows[0].completedCount;
    console.log(`전체 퀴즈 수: ${quizIdList.length}, 완료한 퀴즈 수: ${completedCount}`);

    // 4. 전체 퀴즈 수와 유저 완료 수가 같으면 진행도 증가
    if (completedCount === quizIdList.length) {
        const [updateResult] = await db.query(`
            UPDATE user_status 
            SET progress = progress + 3.2258
            WHERE user_id = ?
        `, [userId]);
        console.log('progress 업데이트 결과:', updateResult);
        return true;
    }

    return false;
}

module.exports = {
    incrementCorrect,
    incrementTotal,
    updateLastUpdated,
    incrementProgressIfCompleted,
    ensureUserStatusExists
};