const db = require('../db/db');

const User = {
  create: (userid, hashedPassword, nickname, callback) => {
    const query = 'INSERT INTO User (userid, userpw, nickname, regDate) VALUES (?, ?, ?, NOW())';
    db.query(query, [userid, hashedPassword, nickname], callback);
  },
  
  findByUserid: (userid, callback) => {
    const query = 'SELECT * FROM User WHERE userid = ?';
    db.query(query, [userid], callback);
  }
};

module.exports = User;
