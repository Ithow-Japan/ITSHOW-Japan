const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/userModel');

// level과 gage를 계산하는 함수
function calculateLevelAndGage(correct) {
  let level = 1;
  let gage = 0;

  if (correct <= 5) {
    level = 1;
    gage = Math.floor((correct / 10) * 100);
  } else if (correct <= 10) {
    level = 2;
    gage = Math.floor(((correct - 10) / 10) * 100);
  } else if (correct <= 15) {  
    level = 3;
    gage = Math.floor(((correct - 20) / 10) * 100);
  } else {
    level = 4;
    gage = 100;
  }

  return { level, gage };
}

// 사용자 진행도 업데이트
const updateGrowFokoro = async (req, res) => {
  const { id } = req.body; 
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

    // res.json({
    //   message: '포코로 진행도 업데이트 완료',
    //   id,
    //   level,
    //   gage,
    // });
  } catch (err) {
    console.error('DB 업데이트 오류:', err);
    return res.status(500).json({ error: 'DB 업데이트 실패' });
  }
};

// 포코로 레벨과 게이지 조회
const getFokoroStatus = async (req, res) => {
  const { id } = req.params;  // URL에서 userid 받기

  try {
      const fokoroStatus = await User.getFokoroLevelAndGage(id);  // 사용자 정보 조회

      if (!fokoroStatus) {
          return res.status(404).json({ message: '사용자를 찾을 수 없습니다.' });
      }

      // 성공적으로 레벨과 게이지를 조회한 경우
      return res.status(200).json({
          message: '포코로 레벨과 게이지 조회 성공',
          level: fokoroStatus.level,
          gage: fokoroStatus.gage
      });
  } catch (err) {
      console.error('포코로 상태 조회 오류:', err);
      return res.status(500).json({ message: '서버 오류', error: err.message });
  }
};

module.exports = {
  updateGrowFokoro,
  getFokoroStatus
};