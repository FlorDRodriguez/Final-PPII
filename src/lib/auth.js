module.exports = {
    isLoggedIn(req, res, next) {
        if(req.isAuthenticated()) {
            return next();
        }
        return res.redirect('/signin');
    },   

    isNotLoggedIn(req, res, next) {
        if(!req.isAuthenticated()) {
            return next();
        }
        return res.redirect('/profile');
    },
    
    authProfesor(req, res, next) {
        if (req.profesor !== null) {
            return next();}
            req.flash('message', 'Contraseña Incorrecta')
            return res.redirect('/index');
        }
};
