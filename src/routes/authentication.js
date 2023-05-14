const express = require('express');
const router = express.Router();
const passport = require('passport'); 

const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');

router.get('/signin', isNotLoggedIn, (req, res) => {
    res.render('auth/signin');
});

router.post('/signin', isNotLoggedIn, passport.authenticate('local.signin', {
    //Redirigir al home    
    successRedirect: '/',
    failureRedirect: '/signin',
    failureFlash: true
}));

router.get('/profile', isLoggedIn, (req, res) => {
    res.render('profile');
});

router.get('/logout', (req, res) => {
    req.logout(function (err) {
        if (err) { return next(err); }
        res.redirect('/signin');
    });
});

module.exports = router;