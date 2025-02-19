const express = require('express');
const router = express.Router();
const expressionController = require('../controllers/expressionController');

// 선택한 카테고리의 표현 조회
router.get('/expressions/:categoryId', expressionController.getExpressionsByCategory);

// 학습한 문장 조회
router.get('/expressions/learned/:categoryId', expressionController.getLearnedByCategory);

module.exports = router;
