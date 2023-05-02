const { validationResult } = require('express-validator/check');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
//const helpers = require('../lib/helpers');

passport.use('local.signin', new LocalStrategy({ 
    usernameField: 'dni',
    passwordField: 'contraseña',
    passReqToCallback: true
}, async (req, dni, contraseña, done) => {
    console.log(req.body);
    const rows = await pool.query('SELECT * FROM alumnos WHERE dni = ?', [dni]);
    if (rows.length > 0) {
        const alumno = rows[0];
        //const validPassword = await helpers.matchPassword(password, user.password);
        if (alumno) {
            done(null, alumno, req.flash('success', 'Bienvenido ' + alumno.nombre)); 
        } else {
            done(null, false, req.flash('message', 'Contraseña incorrecta'));
        }
    } else {
        return done(null, false, req.flash('message', 'No existe el usuario'))
    }
}));

passport.serializeUser((alumno, done) => {
    done(null, alumno.dni);
});

passport.deserializeUser (async(dni, done ) => {
    const rows = await pool.query('SELECT * FROM alumnos WHERE dni = ?', [dni]);
    done(null, rows[0]);
});





