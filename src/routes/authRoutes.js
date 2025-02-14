const express = require('express');
const { signup, login } = require('../controllers/authController');

const router = express.Router();

router.post('/signup', signup);
router.post('/login', login);

router.get('/auth', (req, res) => {
    res.send('Auth route is working!');
}); 

module.exports = router;
