const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');
const categoryRoutes = require('./routes/categoryRoutes');

dotenv.config();

const app = express();
app.use(cors()); // CORS 설정 추가
app.use(express.json()); // 요청 본문을 JSON으로 파싱

// 라우팅 설정
app.use('/', authRoutes);
app.use('/', categoryRoutes);

// ✅ MySQL 없이 로그인 테스트할 수 있도록 Mock API 추가
app.post("/mock-login", (req, res) => {
  const { id, password } = req.body; // 'username' → 'id' 변경

  if (id === "testuser" && password === "1234") {
    res.json({ success: true, token: "mocked-jwt-token" });
  } else {
    res.status(401).json({ success: false, message: "Invalid credentials" });
  }
});

// 서버 실행
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`서버가 ${PORT}번 포트에서 실행 중...`);
});
