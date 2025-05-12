const express = require('express');
const router = express.Router();
const statusController = require('../controllers/userStatusController');

router.post('/quiz/correct', statusController.addCorrect);
router.post('/quiz/attempt', statusController.addTotal);
router.post('/progress/update', statusController.updateProgress);

module.exports = router;
