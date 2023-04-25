const mysql = require('mysql');
const { database } = require('./keys');
const { promisify } = require('util');

const pool = mysql.createPool(database);

pool.getConnection((err, connection) => {
  if (err) {
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      console.error('La conexión a la DB se cerró');
    }
    if (err.code === 'ER_CON_COUNT_ERROR') {
      console.error('La DB tiene demasiadas conexiones'); 
    }
    if (err.code === 'ECONNREFUSED') {
      console.error('La conexión a la DB fue rechazada');
    }
  }

  if (connection) connection.release();
  console.log('DB Conectada');

  return;
});

pool.query = promisify(pool.query); 

module.exports = pool;


