const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
//const helpers = require('../lib/helpers');

passport.use('local.signin', new LocalStrategy({ 
    usernameField: 'dni',
    passwordField: 'contraseña',
    passReqToCallback: true
}, async (req, dni, contraseña, done) => {
    //console.log(req.body);
    const fila = await pool.query('SELECT * FROM alumnos WHERE dni = ?', [dni]);
    if (fila.length > 0) {
        const alumno = fila[0];
        if (contraseña == dni) {
            done(null, alumno, req.flash('success', 'Bienvenid@ ' + alumno.nombre));
        } else {
            done(null, false, req.flash('message', 'Contraseña Incorrecta'));
        }
    } else {
        return done(null, false, req.flash('message', 'El usuario no existe'));
    }
}));

passport.serializeUser((alumno, done) => {
    done(null, alumno.dni);
});

passport.deserializeUser (async(dni, done ) => {
    const rows = await pool.query('SELECT * FROM alumnos WHERE dni = ?', [dni]);
    done(null, rows[0]);
});





