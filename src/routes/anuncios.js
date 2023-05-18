const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn, authProfesor } = require('../lib/auth');


router.get('/add', isLoggedIn, authProfesor, async (req, res) => {
    const tipo = await pool.query('SELECT * FROM tipoAnuncios');
    // const cursos = await pool.query('SELECT * FROM cursos WHERE profesor = ?', [req.profesor.idProfesor]);

    res.render('anuncios/add', {tipo, 
        // cursos
    });
});

router.post('/add', async (req, res) => {
    const { titulo, descripcion, curso, tipo } = req.body;
    const newAnuncio = {
        titulo,
        descripcion,
        curso,
        tipo,
        profesor: req.profesor.idAnuncio,
    };
    await pool.query('INSERT INTO anuncios set ?', [newAnuncio]);
    req.flash('success', 'Anuncio creado correctamente');
    res.redirect('/anuncios')
});

router.get('/', isLoggedIn, async (req, res) => {
    const anuncios = await pool.query('SELECT * FROM anuncios WHERE curso.idCurso = ?', [req.curso.idCurso]);

    res.render('anuncios/list', {anuncios});
});

router.get('/delete/:idAnuncio', isLoggedIn, authProfesor, async (req, res) => {
    const { idAnuncio } = req.params;
    await pool.query('DELETE FROM anuncios WHERE idAnuncio =?', [idAnuncio]);
    req.flash('success', 'Anuncio eliminado correctamente');
    res.redirect('/anuncios')
});

router.get('/edit/:idAnuncio', isLoggedIn, authProfesor, async (req, res) => {
    const { idAnuncio } = req.params;
    const anuncios = await pool.query('SELECT * FROM anuncios WHERE idAnuncio = ?', [idAnuncio]);
    const tipo = await pool.query('SELECT * FROM tipoAnuncios');
    // const cursos = await pool.query('SELECT * FROM cursos WHERE profesor = ?', [req.profesor.idProfesor]);

    res.render('anuncios/edit', { anuncio: anuncios[0], tipo, 
        // cursos 
    })
});

router.post('/edit/:idAnuncio', async (req, res) => {
    const { idAnuncio } = req.params;
    const { titulo, descripcion, curso, tipo } = req.body;
    const newAnuncio = {
        titulo,
        descripcion,
        curso,
        tipo
    };
    await pool.query('UPDATE genres set ? WHERE idAnuncio = ?', [newAnuncio, idAnuncio]);
    req.flash('success', 'Anuncio editado correctamente');
    res.redirect('/anuncios');
});

router.get('/see/:idAnuncio', isLoggedIn, async (req, res) => {
    const { idAnuncio } = req.params;
    const anuncios = await pool.query('SELECT * FROM anuncios WHERE idAnuncio = ?', [idAnuncio]);
    
    res.render('anuncios/see', { anuncio: anuncios[0]});
});

module.exports = router;