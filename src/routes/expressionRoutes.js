const express = require('express');
const router = express.Router();
const expressionController = require('../controllers/expressionController');

// 선택한 카테고리의 표현 조회
router.get('/expressions/:categoryId', expressionController.getExpressionsByCategory);

module.exports = router;
