const express = require('express');
const router = express.Router();
const expressionController = require('../controllers/expressionController');

// 선택한 카테고리의 전체 표현 조회
router.get('/expressions/:categoryId', expressionController.getExpressionsByCategory);

// 완료된 표현(학습한 표현)만 조회
router.get('/expressions/learned/:categoryId', expressionController.getLearnedByCategory);

// 표현 완료 처리 & 카테고리 성취도 반영
router.post('/expressions/complete/:id', expressionController.completeExpression); 

module.exports = router;
