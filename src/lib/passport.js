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
    const fila = await pool.query('SELECT * FROM alumnos WHERE dni = ?', [dni]);
    if (fila.length > 0) {
        const alumno = fila[0];
        if (dni === contraseña) {
            done(null, alumno, req.flash('success', 'Bienvenid@ ' + alumno.dni));
            console.log('SI');
            console.log(alumno.dni);
        } else {
            done(null, false, req.flash('message', 'Contraseña Incorrecta'));
            console.log('NO');
            console.log(alumno);
        }
    } else {
        return done(null, false, req.flash('message', 'El usuario no existe'));
    }
}));

passport.serializeUser((alumno, done) => {
    done(null, alumno.idAlumno);
  });
  
  passport.deserializeUser(async (idAlumno, done) => {
    const rows = await pool.query('SELECT * FROM alumnos WHERE idAlumno = ?', [idAlumno]);
    done(null, rows[0]);
  });





