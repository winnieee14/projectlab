var express = require('express');
var router = express.Router();
var db = require('../db/db');
var jwt = require('jsonwebtoken');

function generateToken(user) {
  var payload = {
    id: user.id,
    username: user.username,
    role: user.role, 
  };

  return jwt.sign(payload, 'SECRET_KEY'); 
}


router.post('/login', function (req, res, next) {
  var username = req.body.username;
  var password = req.body.password;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username dan password diperlukan' });
  }

  var query = 'SELECT id, username, role FROM users WHERE username = ? AND password = ?';

  db.query(query, [username, password], function (err, results) {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal Server Error' });
    }

    if (results.length === 0) {
      return res.status(403).json({ message: 'Invalid credentials' });
    }

    var user = results[0];
    var token = generateToken(user);


    db.query('UPDATE users SET token = ? WHERE id = ?', [token, user.id]);

    return res.status(200).json({
      message: 'Login berhasil',
      user: { 
        id: user.id, 
        username: user.username, 
        role: user.role, 
      },
      token: token,
    });
  });
});


router.post('/register', function (req, res, next) {
  var username = req.body.username;
  var password = req.body.password;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username dan password diperlukan' });
  }

  var query = 'INSERT INTO users (username, password, role) VALUES (?, ?, ?)';

  db.query(query, [username, password, 'user'], function (err, result) {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Gagal mendaftarkan user' });
    }
    return res.status(200).json({ message: 'Registrasi berhasil' });
  });
});

module.exports = router;
