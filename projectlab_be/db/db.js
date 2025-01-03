const mysql = require('mysql');

const DB_OPTION = {
    host: 'localhost', 
    user: 'root',
    password: '',
    database: 'projectlab'
};

var connection = mysql.createConnection(DB_OPTION);

connection.connect();

module.exports = connection;