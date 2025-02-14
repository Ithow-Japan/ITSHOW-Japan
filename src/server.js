const express = require('express');
const dotenv = require('dotenv');
const authRoutes = require('./routes/authRoutes');
const categoryRoutes = require('./routes/categoryRoutes');

dotenv.config(); 

const app = express();
app.use(express.json()); // 요청 본문을 JSON으로 파싱

// 라우팅 설정
app.use('/', authRoutes); 
app.use('/', categoryRoutes);

// 서버 실행
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`서버가 ${PORT}번 포트에서 실행 중...`);
});
