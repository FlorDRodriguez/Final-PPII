const { validationResult } = require('express-validator/check');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;


const pool = require('../database');
const express = require('express');

//ALUMNOS
passport.use('local.signinAlumno', new LocalStrategy({ 
    usernameField: 'dni',
    passwordField: 'contraseña',
    passReqToCallback: true
}, async (req, dni, contraseña, done) => {
    console.log(req.body);
    const fila = await pool.query('SELECT * FROM alumnos WHERE dni = ?', [dni]);
    if (fila.length > 0) {
        const alumno = fila[0];
        if (dni === contraseña) {
            done(false, alumno, req.flash('success', 'Bienvenid@ ' + alumno.nombre));
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

//PROFESORES
  passport.use('local.signinProfesor', new LocalStrategy({ 
    usernameField: 'dni',
    passwordField: 'contraseña',
    passReqToCallback: true
}, async (req, dni, contraseña, done) => {
    console.log(req.body);
    const fila = await pool.query('SELECT * FROM profesores WHERE dni = ?', [dni]);
    if (fila.length > 0) {
        const profesor = fila[0];
        if (dni === contraseña) {
            done(false, profesor, req.flash('success', 'Bienvenid@ ' + profesor.nombre));
            console.log('SI');
            console.log(profesor.dni);
        } else {
            done(null, false, req.flash('message', 'Contraseña Incorrecta'));
            console.log('NO');
            console.log(profesor);
        }
    } else {
        return done(null, false, req.flash('message', 'El usuario no existe'));
    }
}));

passport.serializeUser((profesor, done) => {
    done(null, profesor.idProfesor);
  });
  
  passport.deserializeUser(async (idProfesor, done) => {
    const rows = await pool.query('SELECT * FROM profesores WHERE idProfesor = ?', [idProfesor]);
    done(null, rows[0]);
  });




