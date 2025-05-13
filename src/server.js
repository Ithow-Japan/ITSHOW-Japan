const express = require('express');
const session = require('express-session');
const dotenv = require('dotenv');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const expressionRoutes = require('./routes/expressionRoutes');
const quizRoutes = require('./routes/quizRoutes');
const attendanceRoutes = require('./routes/attendanceRouter');
const userStatusRoutes = require('./routes/userStatusRouter');

dotenv.config();

const app = express();
app.use(cors()); // CORS 설정 추가
app.use(express.json()); // 요청 본문을 JSON으로 파싱
app.use(session({
  secret: process.env.SESSION_SECRET,  // 환경 변수에서 secret 값을 가져옵니다.
  resave: false,
  saveUninitialized: true
}));

// 라우팅 설정
app.use('/', authRoutes);
app.use('/', categoryRoutes);
app.use('/', expressionRoutes);
app.use('/', quizRoutes);
app.use('/', attendanceRoutes);
app.use('/', userStatusRoutes);

// 서버 실행
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`서버가 ${PORT}번 포트에서 실행 중...`);
});
