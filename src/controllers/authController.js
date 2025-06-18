const bcrypt = require('bcryptjs');
const User = require('../models/userModel');

// 회원가입
const register = async (req, res) => {
  const { userid, userpw, nickname, email } = req.body;

  if (!userid || !userpw || !nickname || !email) {
    return res.status(400).json({ message: '모든 필드를 입력해주세요.' });
  }

  try {
    const existingUsers = await User.findByUserid(userid);
    if (existingUsers.length > 0) {
      return res.status(409).json({ message: '이미 존재하는 아이디입니다.' });
    }

    const hashedPassword = await bcrypt.hash(userpw, 10);
    await User.createUser(userid, hashedPassword, nickname, email);
    return res.status(201).json({ message: '회원가입 성공' });

  } catch (err) {
    console.error('회원가입 오류:', err);
    return res.status(500).json({ message: '서버 오류' });
  }
};

// 로그인
const login = async (req, res) => {
  const { userid, userpw } = req.body;

  if (!userid || !userpw) {
    return res.status(400).json({ message: '아이디와 비밀번호를 입력해주세요.' });
  }

  try {
    const users = await User.findByUserid(userid);

    if (users.length === 0) {
      return res.status(401).json({ message: '존재하지 않는 아이디입니다.' });
    }

    const user = users[0];

    const isMatch = await bcrypt.compare(userpw, user.userpw);
    if (!isMatch) {
      return res.status(401).json({ message: '비밀번호가 틀렸습니다.' });
    }

    req.session.user = {
      id: user.id,
      userid: user.userid,
      nickname: user.nickname
    };

    return res.status(200).json({ message: '로그인 성공', user: req.session.user });

  } catch (err) {
    console.error('로그인 오류:', err);
    return res.status(500).json({ message: '서버 오류' });
  }
};

// 로그아웃
const logout = (req, res) => {
  req.session.destroy((err) => {
    if (err) return res.status(500).json({ message: '로그아웃 실패' });
    res.clearCookie('connect.sid');
    return res.status(200).json({ message: '로그아웃 성공' });
  });
};

// level과 gage를 계산하는 함수
function calculateLevelAndGage(correct) {
  let level = 1;
  let gage = 0;

  if (correct <= 5) {
    level = 1;
    gage = Math.floor((correct / 10) * 100);
} else if (correct <= 10) {
    level = 2;
    gage = Math.floor(((correct - 5) / 10) * 100);
} else if (correct <= 15) {
    level = 3;
    gage = Math.floor(((correct - 10) / 10) * 100);
} else if (correct <= 20) {  
    level = 4;
    gage = Math.floor(((correct - 15) / 10) * 100);
} else {
    level = 5;
    gage = 100;
}

  return { level, gage };
}

// 사용자 진행도 업데이트
const updateGrowPokoro = async (req, res) => {
  const id = req.session.user.id; 
  if (!id) {
    return res.status(400).json({ error: 'id는 필수입니다.' });
  }

  try {
    const currentCorrect = await User.getCorrectByUserId(id)
    
    if (currentCorrect === undefined) {
      return res.status(404).json({ error: '사용자 정보를 찾을 수 없습니다.' });
    }

    const updatedCorrect = currentCorrect + 0;

    const { level, gage } = calculateLevelAndGage(updatedCorrect);

    await User.updateProgress(id, level, gage);

    res.json({
      message: '포코로 진행도 업데이트 완료',
      id,
      level,
      gage,
    });
  } catch (err) {
    console.error('DB 업데이트 오류:', err);
    return res.status(500).json({ error: 'DB 업데이트 실패' });
  }
};

// 포코로 레벨과 게이지 조회
const getPokoroStatus = async (req, res) => {
  const id = req.session.user.id;  // URL에서 userid 받기

  try {
      const pokoroStatus = await User.getPokoroLevelAndGage(id);  // 사용자 정보 조회

      if (!pokoroStatus) {
          return res.status(404).json({ message: '사용자를 찾을 수 없습니다.' });
      }

      // 성공적으로 레벨과 게이지를 조회한 경우
      return res.status(200).json({
          message: '포코로 레벨과 게이지 조회 성공',
          level: pokoroStatus.level,
          gage: pokoroStatus.gage
      });
  } catch (err) {
      console.error('포코로 상태 조회 오류:', err);
      return res.status(500).json({ message: '서버 오류', error: err.message });
  }
};

module.exports = {
  register,
  login,
  logout,
  updateGrowPokoro,
  getPokoroStatus
};