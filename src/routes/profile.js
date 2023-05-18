const express = require('express');
const { isLoggedIn } = require('../lib/auth')
const router = express.Router();

const pool = require('../database');

router.get('/', isLoggedIn, async (req, res) => {
    const { idAlumno } = req.user;
    const alumno =  await pool.query('SELECT * FROM alumnos WHERE idAlumno = ?' ,[idAlumno]);
    console.log(alumno)
    res.render('profile', { alumno });
});

module.exports = router;