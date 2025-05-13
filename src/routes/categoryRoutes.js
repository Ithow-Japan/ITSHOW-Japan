const express = require('express');
const categoryController = require('../controllers/categoryController');  // 컨트롤러 불러오기
const router = express.Router();

// 카테고리 목록 조회
router.get('/categories', categoryController.getCategories);  // 컨트롤러에서 getCategories 호출

// 카테고리 성취도 조회 
router.get('/category-achievement', categoryController.getCategoryAchievement);

module.exports = router;
