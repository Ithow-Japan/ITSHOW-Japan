const express = require('express');
const dotenv = require('dotenv');
const authRoutes = require('./routes/authRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const db = require('./db/db'); // DB 연결 파일 불러오기

dotenv.config();

const app = express();
app.use(express.json()); // JSON 요청 본문 파싱

// 라우트 등록
app.use('/', authRoutes);  // '/' 경로로 모든 authRoutes 연결
app.use('/', categoryRoutes);
    
// 서버 실행
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`서버가 ${PORT}번 포트에서 실행 중...`);
});
