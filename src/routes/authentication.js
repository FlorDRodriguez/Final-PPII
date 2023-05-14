const express = require('express');
const router = express.Router();
const passport = require('passport'); 

const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');

router.get('/signinP', isNotLoggedIn, (req, res) => {
    res.render('auth/signinP');
});

router.get('/signinA', isNotLoggedIn, (req, res) => {
    res.render('auth/signinA');
});

router.post('/signinP', isNotLoggedIn, passport.authenticate('local.signin', {
    //Redirigir al home    
    successRedirect: '/',
    failureRedirect: '/signinP',
    failureFlash: true
}));

router.post('/signinA', isNotLoggedIn, passport.authenticate('local.signin', {
    //Redirigir al home    
    successRedirect: '/',
    failureRedirect: '/signinA',
    failureFlash: true
}));

router.get('/profile', isLoggedIn, (req, res) => {
    res.render('profile');
});

router.get('/logout', (req, res) => {
    req.logout(function (err) {
        if (err) { return next(err); }
        res.redirect('/signinA');
    });
});

module.exports = router;