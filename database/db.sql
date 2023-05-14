CREATE DATABASE if not exists db_attendance;

USE db_attendance;


CREATE TABLE dias (
    idDia INT(1) NOT NULL,
    dia VARCHAR(45) NOT NULL,
    PRIMARY KEY (idDia)
);
DESCRIBE dias;


CREATE TABLE tipoAnuncios (
    idTipoAnuncio INT(1) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    PRIMARY KEY (idTipoAnuncio)
);

DESCRIBE tipoAnuncios;


CREATE TABLE regularidades (
    idRegularidad INT(1) NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    descripcion TEXT NOT NULL, 
    PRIMARY KEY (idRegularidad)
);

DESCRIBE regularidades;


CREATE TABLE tipoCursos (
    idTipoCurso INT(1) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    PRIMARY KEY (idTipoCurso)
);

DESCRIBE tipoCursos;


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
    idAlumno INT(11) NOT NULL AUTO_INCREMENT,
    dni INT(11) NOT NULL UNIQUE,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    telefono VARCHAR(45),
    contraseña VARCHAR(45) NOT NULL,
    PRIMARY KEY (idAlumno)
);

DESCRIBE alumnos;


CREATE TABLE profesores (
    idProfesor INT(11) NOT NULL AUTO_INCREMENT,
    dni INT(11) NOT NULL UNIQUE,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    telefono VARCHAR(45),
    contraseña VARCHAR(45) NOT NULL,
    PRIMARY KEY (idProfesor)
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
    CONSTRAINT fk_profesor FOREIGN KEY(profesor) REFERENCES profesores(idProfesor),
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
    CONSTRAINT fk_profesor_anuncio FOREIGN KEY(profesor) REFERENCES profesores(idProfesor),
    tipo INT(1) NOT NULL,
    CONSTRAINT fk_tipoAnuncio FOREIGN KEY(tipo) REFERENCES tipoAnuncios(idTipoAnuncio),
    PRIMARY KEY (idAnuncio)
);

DESCRIBE anuncios;


CREATE TABLE asistenciaCursos (
    idAsistenciaCurso INT(11) NOT NULL AUTO_INCREMENT,
    alumno INT(11) NOT NULL,
    CONSTRAINT fk_alumno FOREIGN KEY(alumno) REFERENCES alumnos(idAlumno),
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
    CONSTRAINT fk_alumno_lista FOREIGN KEY(alumno) REFERENCES alumnos(idAlumno),
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
    CONSTRAINT fk_presentes FOREIGN KEY(presentes) REFERENCES alumnos(idAlumno),
    ausentes INT(11) NOT NULL,
    CONSTRAINT fk_ausentes FOREIGN KEY(ausentes) REFERENCES alumnos(idAlumno),
    PRIMARY KEY (idClase)

);

DESCRIBE clases;

--ALTERS

ALTER TABLE alumnos 
ADD UNIQUE (dni);  

DESCRIBE alumnos;

ALTER TABLE profesores 
ADD UNIQUE (dni);  

DESCRIBE profesores;

ALTER TABLE cursos MODIFY COLUMN horario TIME NOT NULL; 

-- INSERTS

INSERT INTO dias VALUES
    (1, 'Lunes'),
    (2, 'Martes'),
    (3, 'Miércoles'),
    (4, 'Jueves'),
    (5, 'Viernes'),
    (6, 'Sábado');

SELECT * FROM dias;


INSERT INTO tipoCursos VALUES
    (1, 'Conversación'),
    (2, 'Gramática'),
    (3, 'Preparación Exámenes de Ingreso'),
    (4, 'Preparación Exámenes Internacionales'),
    (5, 'Talleres de Apoyo');

SELECT * from tipoCursos;


INSERT INTO regularidades VALUES
    (1, 'Regular', 'Este alumno puede rendir exámenes'),
    (2, 'No Regular', 'Este alumno debe rendir exámenes complementarios');

SELECT * from regularidades;


INSERT INTO tipoAnuncios VALUES
    (1, 'Aviso examen'),
    (2, 'Cancelación de clases'),
    (3, 'Evento'), 
    (4, 'Otro');

SELECT * from tipoAnuncios;


INSERT INTO alumnos VALUES
    (1, 39767395, 'Marcos', 'Guidolin', 'España 650', '2616181199', '39767395');

SELECT * from alumnos;


INSERT INTO profesores VALUES
    (1, 20397682, 'Martín', 'García', 'Italia 650', '2614281475', '20397682');

SELECT * from profesores;


INSERT INTO libros VALUES
    (1, 'Grammar For Use 4', 'Cambridge', 2020, 12);

SELECT * from libros;


INSERT INTO cursos VALUES 
    (1, 'Adultos Avanzado', 2, 203000, 2023, 'B1', 1, 1, 1);

SELECT * from cursos;


INSERT INTO anuncios (idAnuncio, titulo, descripcion, curso, profesor, tipo)
VALUES 
    (1, 'Fecha examen Final', 'Hemos acordado que el examen final sea el viernes 24/8', 1, 1, 1);

SELECT * from anuncios;


INSERT INTO asistenciaCursos VALUES
    (1, 1, 1, 0, 2, 2);

SELECT * from asistenciaCursos;


INSERT INTO listaAlumnos VALUES
    (1, 1, 1);

SELECT * from listaAlumnos;


INSERT INTO clases (idClase, tema, curso, unidadUsada, unidadesLibro, presentes, ausentes)
VALUES
    (1, 'Reported Speech', 1, 2, 1, 1, 1);

SELECT * from clases;