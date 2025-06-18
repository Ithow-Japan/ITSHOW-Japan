 const pokoroModel = require('../models/pokoroModel');

// 사용자 ID를 받아서 해당 사용자의 레벨에 맞는 포코로 반환
const getUserPokoroImage = async (req, res) => {
    const user_id = req.session.user.id;
    
    try {
      // 사용자의 레벨을 가져옴
      const user = await pokoroModel.getUserLevel(user_id);
  
      if (!user) {
        return res.status(404).json({ message: '유저를 찾을 수 없음.' });
      }
  
      const userLevel = user.level;
  
      // 사용자의 레벨에 맞는 포코로를 가져옴
      const pokoro = await pokoroModel.getPokoroByLevel(userLevel);
  
      if (!pokoro) {
        return res.status(404).json({ message: '이 레벨에서 포코로를 찾을 수 없음.' });
      }
  
      // 포코로 이미지를 매핑하는 부분 
      const pokoroImage = `assets/${pokoro.pokoro_name}.png`; 
  
      // 사용자가 포코로를 얻었을 때 user_pokoro 테이블에 삽입
      await pokoroModel.insertUserPokoro(user_id, pokoro.pokoro_name);
  
      return res.status(200).json({
        pokoro_name: pokoro.pokoro_name,
        image: pokoroImage,
        level_required: pokoro.level_required,
      });
    } catch (error) {
      console.error('사용자 포코로를 가져오는 중 오류 발생:', error);
      return res.status(500).json({ message: '서버 오류' });
    }
};

// 사용자가 얻은 포코로 목록을 반환하는 API
const getUserPokoros = async (req, res) => {
    const user_id = req.session.user.id;
  
    try {
      // 사용자가 얻은 포코로 목록을 가져옴
      const userPokoros = await pokoroModel.getUserPokoros(user_id);
  
      if (!userPokoros || userPokoros.length === 0) {
        return res.status(404).json({ message: '이 사용자에게서 포코로를 찾을 수 없음.' });
      }
  
      // 각 포코로에 대한 이미지 URL을 추가하여 반환
      const pokorosWithImages = userPokoros.map(pokoro => {
        const pokoroImage = `/assets/${pokoro.pokoro_name}.png`;  
        return {
          pokoro_name: pokoro.pokoro_name,
          image: pokoroImage,
          date_obtained: pokoro.date_obtained,
        };
      });
  
      return res.status(200).json(pokorosWithImages);
    } catch (error) {
      console.error('"사용자 포코로를 가져오는 중 오류 발생:', error);
      return res.status(500).json({ message: '서버 오류' });
    }
};
  
module.exports = {
    getUserPokoroImage,
    getUserPokoros
};
