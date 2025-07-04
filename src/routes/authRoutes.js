const express = require('express');
const authController  = require('../controllers/authController');

const router = express.Router();

// 회원가입
router.post('/register', authController.register);

// 로그인
router.post('/login', authController.login);

// 로그아웃
router.post('/logout', authController.logout);

// 사용자 정보 조회
router.get('/userInfo', authController.userInfo);

// 포코로 성장 (레벨과 게이지)
router.get('/grow', authController.updateGrowPokoro);

// 포코로 상태 조회 (레벨과 게이지)
router.get('/pokoroStatus', authController.getPokoroStatus);

router.get('/auth', (req, res) => {
    res.send('Auth route is working!');
}); 

module.exports = router;
