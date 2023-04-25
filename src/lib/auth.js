module.exports = {
    isLoggedIn(req, res, next) {
        if(req.isAuthenticated()) {
            return next();
        }
        return res.redirect('/signin');
    },   

    //rutas que no quiero que vea el usuario
    isNotLoggedIn(req, res, next) {
        if(!req.isAuthenticated()) {
            return next();
        }
        return res.redirect('/profile');
    }
};

