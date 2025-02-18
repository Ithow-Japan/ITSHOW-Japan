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

// ✅ MySQL 없이 로그인 테스트할 수 있도록 Mock API 추가
// Mock 로그인 API (MySQL 없이)
app.post("/mock-login", (req, res) => {
  const { username, password } = req.body;

  // MySQL 없이 로그인 정보를 직접 비교 (하드코딩된 데이터 대신 요청 데이터로 처리)
  if (username === "testuser" && password === "1234") {
    res.json({ success: true, token: "mocked-jwt-token" }); // 로그인 성공 시, 가짜 JWT 토큰 반환
  } else {
    // 로그인 실패 시, 적절한 메시지 반환
    res.status(401).json({ success: false, message: "Invalid credentials" });
  }
});

// 서버 실행
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`서버가 ${PORT}번 포트에서 실행 중...`);
});
