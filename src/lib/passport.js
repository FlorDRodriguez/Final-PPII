const { validationResult } = require('express-validator/check');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');

passport.use('local.signin', new LocalStrategy({ 
    usernameField: 'dni',
    passwordField: 'contraseña',
    passReqToCallback: true
}, async (req, dni, contraseña, done) => {
    console.log(req.body);
    const rows = await pool.query('SELECT * FROM alumnos WHERE dni = ?', [dni]);
    if (rows.length > 0) { 
        const alumno = rows[0];
        if (alumno) {
            done(null, alumno);
        } else {
            done(null, false);
        }
    } else {
        return done(null, false)
    }
}));





