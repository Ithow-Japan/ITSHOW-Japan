const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/userModel');

exports.signup = async (req, res) => {
  const { userid, userpw, nickname } = req.body;

  if (!userid || !userpw || !nickname) {
    return res.status(400).json({ message: '모든 필드를 입력해주세요.' });
  }

  try {
    // 비밀번호 해싱
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(userpw, salt);

    // DB에 저장
    User.create(userid, hashedPassword, nickname, (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: '서버 오류가 발생했습니다.' });
      }
      res.status(201).json({ message: '회원가입이 완료되었습니다.' });
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: '서버 오류가 발생했습니다.' });
  }
};

exports.login = (req, res) => {
  const { userid, userpw } = req.body;

  if (!userid || !userpw) {
    return res.status(400).json({ message: '아이디와 비밀번호를 입력해주세요.' });
  }

  User.findByUserid(userid, async (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: '서버 오류가 발생했습니다.' });
    }

    if (result.length === 0) {
      return res.status(404).json({ message: '아이디가 존재하지 않습니다.' });
    }

    const user = result[0];

    // 비밀번호 비교
    const isMatch = await bcrypt.compare(userpw, user.userpw);
    if (!isMatch) {
      return res.status(400).json({ message: '비밀번호가 틀렸습니다.' });
    }

    // JWT 생성
    const token = jwt.sign({ id: user.id, userid: user.userid }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({
      message: '로그인 되었습니다.',
      token,
    });
  });
};
