const express = require('express');
const router = express.Router();
const statusController = require('../controllers/userStatusController');

// correct 증가값 업데이트
router.post('/quiz/correct', statusController.addCorrect);

// total 증가값 업데이트
router.post('/quiz/attempt', statusController.addTotal);

// 학습 진행도 증가값 업데이트
router.post('/progress/update/:expressionId', statusController.updateProgress);

module.exports = router;
