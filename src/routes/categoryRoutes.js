const express = require('express');
const categoryController = require('../controllers/categoryController');  // 컨트롤러 불러오기
const router = express.Router();

// 카테고리 목록 조회 라우트
router.get('/categories', categoryController.getCategories);  // 컨트롤러에서 getCategories 호출

module.exports = router;
