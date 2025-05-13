const express = require('express');
const pokoroController = require('../controllers/pokoroController');

const router = express.Router();

// 사용자의 레벨에 맞는 포코로 이미지 반환
router.get('/pokoro/:user_id', pokoroController.getUserPokoroImage);

// 사용자가 얻은 포코로 목록을 조회
router.get('/pokoro/:user_id/pokoros', pokoroController.getUserPokoros);

module.exports = router;
