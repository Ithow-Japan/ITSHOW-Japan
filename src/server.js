const express = require('express');
const session = require('express-session');
const dotenv = require('dotenv');
const cors = require('cors');

// 라우트 불러오기
const authRoutes = require('./routes/authRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const expressionRoutes = require('./routes/expressionRoutes');
const quizRoutes = require('./routes/quizRoutes');
const attendanceRoutes = require('./routes/attendanceRouter');
const userStatusRoutes = require('./routes/userStatusRouter');
const pokoroRoutes = require('./routes/pokoroRouter');

dotenv.config();

const app = express();

// CORS 설정
app.use(cors({
  origin: 'http://localhost:3000',
  credentials: true
}));

// JSON 요청 파싱
app.use(express.json());

// 세션 설정
app.use(session({
  name: 'connect.sid',
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: {
    httpOnly: true,
    secure: false,
    maxAge: 1000 * 60 * 60 * 24
  }
}));

// 라우터 연결
app.use('/', authRoutes);
app.use('/', categoryRoutes);
app.use('/', expressionRoutes);
app.use('/', quizRoutes);
app.use('/', attendanceRoutes);
app.use('/', userStatusRoutes);
app.use('/', pokoroRoutes);

// 서버 실행
const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
