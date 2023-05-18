const express = require('express');
const router = express.Router();
const passport = require('passport'); 

const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');

//ALUMNOS
router.get('/signinAlumno', isNotLoggedIn, (req, res) => {
    res.render('auth/signinAlumno');
});

router.post('/signinAlumno', isNotLoggedIn, passport.authenticate('local.signinAlumno', {
        successRedirect: '/',
        failureRedirect: '/signinAlumno',
        failureFlash: true
}));

//PROFESORES
router.get('/signinProfesor', isNotLoggedIn, (req, res) => {
    res.render('auth/signinProfesor');
});

router.post('/signinProfesor', isNotLoggedIn, passport.authenticate('local.signinProfesor', {
        successRedirect: '/',
        failureRedirect: '/signinProfesor',
        failureFlash: true
}));

router.get('/logout', function(req, res, next) {
    req.logout(function(err) {
      if (err) { return next(err); }
      res.redirect('/signinAlumno');
    });
  });

module.exports = router;