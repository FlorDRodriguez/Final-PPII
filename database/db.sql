CREATE DATABASE if not exists db_attendance;

USE db_attendance;


CREATE TABLE dias (
    idDia INT(1) NOT NULL,
    dia VARCHAR(45) NOT NULL,
    PRIMARY KEY (idDia)
);
DESCRIBE dias;

INSERT INTO dias (idDia, dia) 
VALUES
    (1, 'Lunes'),
    (2, 'Martes'),
    (3, 'Miércoles'),
    (4, 'Jueves'),
    (5, 'Viernes'),
    (6, 'Sábado');

SELECT * FROM dias;


CREATE TABLE tipoAnuncios (
    idTipoAnuncio INT(1) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    PRIMARY KEY (idTipoAnuncio)
);

DESCRIBE tipoAnuncios;

-- INSERT INTO tipoAnuncios VALUES (
--     (1, 'Aviso examen')
--     (2, 'Cancelación clases')
--     (3, '')
-- );

-- SELECT * from tipoAnuncios;


CREATE TABLE regularidades (
    idRegularidad INT(1) NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    descripcion TEXT NOT NULL, 
    PRIMARY KEY (idRegularidad)
);

DESCRIBE regularidades:

-- INSERT INTO tipoAnuncios VALUES (
--     (1, '')
--     (2, '')
--     (3, '')
-- );

-- SELECT * from tipoAnuncios;


CREATE TABLE tipoCursos (
    idTipoCurso INT(1) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    PRIMARY KEY (idTipoCurso)
);

DESCRIBE tipoCursos;

-- INSERT INTO tipoCursos VALUES (
--     (1, '')
--     (2, '')
--     (3, '')
-- );

-- SELECT * from tipoAnuncios;


CREATE TABLE libros (
    idLibro INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    editorial VARCHAR(45) NOT NULL,
    añoPublicacion INT(4) NOT NULL,
    cantUnidades INT(11) NOT NULL,
    PRIMARY KEY (idLibro)
);

DESCRIBE libros;


CREATE TABLE alumnos (
    dni INT(11) NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    telefono VARCHAR(45),
    contraseña VARCHAR(45) NOT NULL,
    PRIMARY KEY (dni)
);

DESCRIBE alumnos;


CREATE TABLE profesores (
    dni INT(11) NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    telefono VARCHAR(45),
    contraseña VARCHAR(45) NOT NULL,
    PRIMARY KEY (dni)
);

DESCRIBE profesores;


CREATE TABLE cursos (
    idCurso INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    dias INT(1) NOT NULL, 
    CONSTRAINT fk_dias FOREIGN KEY(dias) REFERENCES dias(idDia),
    horario DATETIME NOT NULL,
    anio INT(4) NOT NULL,
    nivel VARCHAR(45) NOT NULL,
    tipo INT(1) NOT NULL,
    CONSTRAINT fk_tipoCurso FOREIGN KEY(tipo) REFERENCES tipoCursos(idTipoCurso),
    profesor INT(11) NOT NULL, 
    CONSTRAINT fk_profesor FOREIGN KEY(profesor) REFERENCES profesores(dni),
    libro INT(11),
    CONSTRAINT fk_libro FOREIGN KEY(libro) REFERENCES libros(idLibro),
    PRIMARY KEY (idCurso)
);

DESCRIBE cursos;


CREATE TABLE anuncios (
    idAnuncio INT(11) NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(45) NOT NULL,
    descripcion TEXT NOT NULL,
    created_at timestamp NOT NULL default current_timestamp,
    curso INT(11) NOT NULL,
    CONSTRAINT fk_curso FOREIGN KEY(curso) REFERENCES cursos(idCurso),
    profesor INT(11) NOT NULL,
    CONSTRAINT fk_profesor_anuncio FOREIGN KEY(profesor) REFERENCES profesores(dni),
    tipo INT(1) NOT NULL,
    CONSTRAINT fk_tipoAnuncio FOREIGN KEY(tipo) REFERENCES tipoAnuncios(idTipoAnuncio),
    PRIMARY KEY (idAnuncio)
);

DESCRIBE anuncios;


CREATE TABLE asistenciaCursos (
    idAsistenciaCurso INT(11) NOT NULL AUTO_INCREMENT,
    alumno INT(11) NOT NULL,
    CONSTRAINT fk_alumno FOREIGN KEY(alumno) REFERENCES alumnos(dni),
    curso INT(11) NOT NULL,
    CONSTRAINT fk_curso_asistencia FOREIGN KEY(curso) REFERENCES cursos(idCurso),
    presentes INT(11) NOT NULL,
    ausentes INT(11) NOT NULL,
    regularidad INT(1) NOT NULL,
    CONSTRAINT fk_regularidad FOREIGN KEY(regularidad) REFERENCES regularidades(idRegularidad),
    PRIMARY KEY (idAsistenciaCurso)
);

DESCRIBE asistenciaCursos;


CREATE TABLE listaAlumnos (
    idListaAlumnos INT(11) NOT NULL AUTO_INCREMENT,
    alumno INT(11) NOT NULL,
    CONSTRAINT fk_alumno_lista FOREIGN KEY(alumno) REFERENCES alumnos(dni),
    curso INT(11) NOT NULL,
    CONSTRAINT fk_curso_lista FOREIGN KEY(curso) REFERENCES cursos(idCurso),
    PRIMARY KEY (idListaAlumnos)
);

DESCRIBE listaAlumnos;

CREATE TABLE clases (
    idClase INT(11) NOT NULL AUTO_INCREMENT,
    fecha timestamp NOT NULL default current_timestamp,
    tema VARCHAR(45) NOT NULL,
    curso INT(11) NOT NULL,
    CONSTRAINT fk_curso_clase FOREIGN KEY(curso) REFERENCES cursos(idCurso),
    unidadUsada INT(11),
    unidadesLibro INT(11) NOT NULL,
    CONSTRAINT fk_unidadesLibro FOREIGN KEY(unidadesLibro) REFERENCES libros(idLibro),
    presentes INT(11) NOT NULL,
    CONSTRAINT fk_presentes FOREIGN KEY(presentes) REFERENCES alumnos(dni),
    ausentes INT(11) NOT NULL,
    CONSTRAINT fk_ausentes FOREIGN KEY(ausentes) REFERENCES alumnos(dni),
    PRIMARY KEY (idClase)

);

DESCRIBE clases;