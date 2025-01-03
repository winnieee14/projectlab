var express = require('express');
var router = express.Router();
var db = require('../db/db'); 


router.get('/products', function (req, res, next) {
  var query = 'SELECT * FROM products';

  db.query(query, function (err, results) {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal Server Error' });
    }
    return res.status(200).json(results);
  });
});


router.post('/products', function (req, res, next) {
  var title = req.body.title;
  var price = req.body.price;
  var description = req.body.description;
  var genre = req.body.genre;
  var level = req.body.level;
  var imageUrl = req.body.imageUrl; 

  if (!title || !price || !description || !genre || !level || !imageUrl) {
    return res.status(400).json({ message: 'Semua kolom diperlukan termasuk imageUrl' });
  }

  var query = `INSERT INTO products (title, price, description, genre, level, imageUrl) VALUES (?, ?, ?, ?, ?, ?)`;

  db.query(query, [title, price, description, genre, level, imageUrl], function (err, result) {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Gagal menambahkan produk' });
    }

    return res.status(200).json({
      message: 'Produk berhasil ditambahkan',
      product: { 
        id: result.insertId, 
        title, 
        price, 
        description, 
        genre, 
        level, 
        imageUrl 
      },
    });
  });
});

router.delete('/products/:id', function (req, res, next) {
  var id = req.params.id;

  if (!id) {
    return res.status(400).json({ message: 'ID produk diperlukan' });
  }

  var query = 'DELETE FROM products WHERE id = ?';

  db.query(query, [id], function (err, result) {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Gagal menghapus produk' });
    }

    return res.status(200).json({ message: 'Produk berhasil dihapus' });
  });
});

module.exports = router;
