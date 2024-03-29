rem / TDA /

rem / TDA HISTORIA /

create type t_historia as object (
hist_fecha date,
hist_hecho varchar2(1000)
);
/

rem / TDA RECIBIDO /

create or replace type t_recibido as object(
reci_nombre varchar2(50),
reci_apellido varchar2(50),
reci_parentesco varchar2(15)
);
/

rem / TDA PROCESO /

create or replace type t_proceso as object (
proc_nombre varchar2(50),
proc_descripcion varchar2(400)
);
/

rem / TDA DATOS_PER /

create or replace type t_datos_per as object(
dato_nombre varchar2(25),
dato_nombre2 varchar2(25),
dato_apellido varchar2(25),
dato_apellido2 varchar2(25),
dato_foto blob,
dato_bio varchar(4000),
dato_fecha_nac date,
dato_etnicidad varchar2(25)
);
/

rem / TDA CREADOR /

create or replace type t_creador as object(
crea_nombre varchar2(50),
crae_rol varchar(50)
);
/

rem / TDA NOMBRE /

create or replace type t_nombre as object(
nomb_nombre varchar2(50),
nomb_fecha_inicio date,
nomb_fecha_fin date
);
/

rem/ TDA MEDIDA /

create or replace type t_medida as object(
medi_altura number(5,0),
medi_ancho number(5,0),
medi_peso number(5,0)
);
/


rem / TABLAS ANIDADAS /


rem / TABLA ANIDADA NOMBRE /

create or replace type nt_nombre as table of t_nombre;
/

rem / TABLA ANIDADA RECIBIDO /

create or replace type nt_recibido as table of t_recibido;
/

rem / TABLA ANIDADA CREADOR /

create or replace type nt_creador as table of t_creador;
/

rem / VARRAY HISTORIA /

create or replace type nt_historia as table of t_historia;
/

rem / TDA ESTATUILLA FALTA/

create or replace type t_estatuilla as object(
este_nombre varchar2(50),
este_creador nt_creador,
este_fabricante varchar2(50),
este_historia nt_historia,
este_medida t_medida,
este_descripcion varchar2(400)
);
/

rem / TABLA PREMIO_CATEGORIA /

CREATE TABLE PREMIO_CATEGORIA(
PREM_ID NUMBER NOT NULL,
PREM_NIVEL NUMBER NOT NULL,
PREM_DESCRIPCION VARCHAR2(400) NOT NULL,
PREM_NOMBRE nt_nombre NULL,
PREM_PREMIO VARCHAR2(50) NOT NULL,
PREM_PADRE NUMBER NULL,
CONSTRAINT PK_PREMIO_CATEGORIA PRIMARY KEY (PREM_ID)
)nested table PREM_NOMBRE store as nom_nt;


rem / TABLA CURIOSIDAD_CRITICA /

CREATE TABLE CURIOSIDAD_CRITICA(
CURI_ID NUMBER NOT NULL,
CURI_COMENTARIO VARCHAR2(400) NOT NULL,
CONSTRAINT PK_CURIOSIDAD_CRITICA PRIMARY KEY(CURI_ID)
);

rem / TABLA DISTRIBUCION_COMP /

CREATE TABLE DISTRIBUCION_COMP(
DIST_ID NUMBER NOT NULL,
DIST_NOMBRE VARCHAR2(100) NOT NULL,
DIST_DESCRIPCION VARCHAR2(4000) NULL,
CONSTRAINT PK_DISTRIBUCION_COMP PRIMARY KEY(DIST_ID)
); 

rem / TABLA DIST_PELI /

CREATE TABLE DIST_PELI(
DP_DIST NUMBER NOT NULL,
DP_PELI NUMBER NOT NULL,
CONSTRAINT PK_DIST_PELI PRIMARY KEY(DP_DIST,DP_PELI)
);

rem / TABLA PREMIO_MIEMBRO /

CREATE TABLE PREMIO_MIEMBRO(
PM_PREMIO NUMBER NOT NULL,
PM_MIEMBRO NUMBER NOT NULL,
CONSTRAINT PK_PREMIO_MIEMBRO PRIMARY KEY(PM_PREMIO,PM_MIEMBRO)
);

rem / TABLA GENERO /

CREATE TABLE GENERO(
GENE_ID NUMBER NOT NULL,
GENE_NOMBRE VARCHAR(50) NOT NULL,
GENE_PADRE NUMBER NULL,
CONSTRAINT PK_GENERO PRIMARY KEY(GENE_ID)
);

rem / TABLA CINE /

CREATE TABLE CINE(
CINE_ID NUMBER NOT NULL,
CINE_NOMBRE VARCHAR(50) NOT NULL,
CONSTRAINT PK_CINE PRIMARY KEY(CINE_ID)
);

rem / TABLA CINE_PELICULA /

CREATE TABLE CINE_PELICULA(
CP_FECHA_INICIO DATE NOT NULL,
CP_FECHA_FIN DATE NULL,
CP_CINE NUMBER NOT NULL,
CP_PELICULA NUMBER NOT NULL,
CONSTRAINT PK_CINE_PELICULA PRIMARY KEY(CP_CINE,CP_PELICULA)
);

rem / TABLA PELICULA /

CREATE TABLE PELICULA(
PELI_ID NUMBER NOT NULL,
PELI_TITULO_ORIGINAL VARCHAR2(100) NOT NULL,
PELI_TITULO_TRADUCIDO VARCHAR2(100) NULL,
PELI_POSTER BLOB,
PELI_RESUMEN VARCHAR2(4000) NOT NULL,
PELI_DURACION NUMBER NOT NULL,
PELI_FECHA_ESTRENO DATE NOT NULL,
PELI_FECHA_FIN DATE NULL,
PELI_PARTE_SECUELA NUMBER NULL,
PELI_IDIOMA VARCHAR2(15) NOT NULL,
PELI_CENSURA VARCHAR(3) NOT NULL,
PELI_LUGAR NUMBER NOT NULL,
PELI_GENERO NUMBER NOT NULL,
PELI_PADRE NUMBER NULL,
CONSTRAINT PK_PELICULA PRIMARY KEY(PELI_ID)
);

rem / TABLA ROL /

CREATE TABLE ROL(
ROL_ID NUMBER NOT NULL,
ROL_NOMBRE VARCHAR2(50) NOT NULL,
ROL_DESCRIPCION VARCHAR(400) NULL,
CONSTRAINT PK_ROL PRIMARY KEY (ROL_ID)
);

rem / TABLA STAFF /

CREATE TABLE STAFF(
STAF_ID NUMBER NOT NULL,
STAF_PERSONAJE VARCHAR2(50) NULL,
STAF_CANCION VARCHAR2(50) NULL,
STAF_PELICULA NUMBER NOT NULL,
STAF_PERSONA NUMBER NOT NULL,
STAF_ROL NUMBER NOT NULL,
CONSTRAINT PK_STAFF PRIMARY KEY(STAF_ID)
);

rem / TABLA PERSONA /

CREATE TABLE PERSONA(
PERS_ID NUMBER NOT NULL,
PERS_DATOS t_datos_per NOT NULL,
PERS_LUGAR NUMBER NOT NULL,
CONSTRAINT PK_PERSONA PRIMARY KEY(PERS_ID)
);

rem / TABLA FAMILIAR_PERSONA /

CREATE TABLE FAMILIAR_PERSONA(
FAMI_ID NUMBER NOT NULL,
FAMI_TIPO VARCHAR2(50) NOT NULL,
FAMI_ANO_INICIO DATE NULL,
FAMI_ANO_FIN DATE NULL,
FAMI_PERSONA1 NUMBER NOT NULL,
FAMI_PERSONA2 NUMBER NOT NULL,
CONSTRAINT PK_FAMILIAR_PERSONA PRIMARY KEY(FAMI_ID),
CONSTRAINT CH_FAMI_TIPO CHECK (FAMI_TIPO IN('HIJO','HIJA','PADRE','MADRE','SOBRINO','SOBRINA','TIO','TIA','PRIMO','PRIMA','HERMANO','HERMANA','ABUELO','ABUELA','NIETO','NIETA'))
);

rem / TABLA MIEMBRO /

CREATE TABLE MIEMBRO(
MIEM_ID NUMBER NOT NULL,
MIEM_FECHA_INICIO DATE NOT NULL,
MIEM_VITALICIO VARCHAR2(2) NOT NULL,
MIEM_PERSONA NUMBER NOT NULL,
CONSTRAINT PK_MIEMBRO PRIMARY KEY(MIEM_ID),
CONSTRAINT CH_MIEM_VITALICIO CHECK (MIEM_VITALICIO IN('SI','NO'))
);

rem / TABLA PRESENTADOR /

CREATE TABLE PRESENTADOR(
PRES_ID NUMBER NOT NULL,
PRES_PRINCIPAL VARCHAR2(2) NOT NULL,
PRES_RECIBIO VARCHAR2(50),
PRES_PERSONA NUMBER NOT NULL,
PRES_CEREMONIA NUMBER NOT NULL,
CONSTRAINT PK_PRESENTADOR PRIMARY KEY(PRES_ID),
CONSTRAINT CH_PERS_PRINCIPAL CHECK (PRES_PRINCIPAL IN('SI,','NO'))
);

rem / TABLA CEREMONIA /

CREATE TABLE CEREMONIA(
CERE_ID NUMBER NOT NULL,
CERE_FECHA DATE NOT NULL,
CERE_NUMERO NUMBER NOT NULL,
CERE_SEDE VARCHAR2(100),
CERE_COMENTARIO VARCHAR2(400),
CERE_LUGAR NUMBER NOT NULL,
CONSTRAINT PK_CEREMONIA PRIMARY KEY(CERE_ID)
);

rem / TABLA VOTO /

CREATE TABLE VOTO(
VOTO_ID NUMBER NOT NULL,
VOTO_FECHA DATE NOT NULL,
VOTO_TIPO VARCHAR2(1),
VOTO_POSTULADO NUMBER NOT NULL,
CONSTRAINT PK_VOTO PRIMARY KEY(VOTO_ID),
CONSTRAINT CH_VOTO_TIPO CHECK (VOTO_TIPO IN('N','G'))
);

rem / TABLA POSTULADO /

CREATE TABLE POSTULADO(
POST_ID NUMBER NOT NULL,
POST_FECHA DATE NOT NULL,
POST_NOMINADA VARCHAR2(2) NOT NULL,
POST_GANADORA VARCHAR2(2) NOT NULL,
POST_ACEPTADO VARCHAR2(2),
POST_RECIBIDO nt_recibido NULL,
POST_PREMIO NUMBER NOT NULL,
POST_PELICULA NUMBER NOT NULL,
POST_STAFF NUMBER,
CONSTRAINT PK_POSTULADO PRIMARY KEY(POST_ID),
CONSTRAINT CH_POST_NOMINADA CHECK(POST_NOMINADA IN('SI','NO')),
CONSTRAINT CH_POST_GANADORA CHECK(POST_GANADORA IN('SI','NO')),
CONSTRAINT CH_POST_ACEPTADO CHECK(POST_ACEPTADO IN('SI','NO'))
)nested table POST_RECIBIDO store as rec_nt;

rem / TABLA LUGAR /

CREATE TABLE LUGAR(
LUGA_ID NUMBER NOT NULL,
LUGA_TIPO VARCHAR2(20) NOT NULL,
LUGA_NOMBRE VARCHAR2(50) NOT NULL,
LUGA_NACIONALIDAD VARCHAR2(50) NULL,
LUGA_PADRE NUMBER NULL,
CONSTRAINT PK_LUGAR PRIMARY KEY(LUGA_ID),
CONSTRAINT CH_LUGAR_TIPO CHECK(LUGA_TIPO IN('PAIS','ESTADO','CIUDAD'))
);



rem / TABLA POST_PRES /

CREATE TABLE POST_PRES(
PP_ID NUMBER NOT NULL,
PP_PRESENTADOR NUMBER NOT NULL,
PP_POSTULADO NUMBER NOT NULL,
CONSTRAINT PK_PP PRIMARY KEY(PP_ID)
);

rem / ALTERS /

rem / ALTER:DIST_PELI /

ALTER TABLE DIST_PELI ADD (
CONSTRAINT FK_DIST_PELI1 FOREIGN KEY (DP_DIST) REFERENCES DISTRIBUCION_COMP (DIST_ID),
CONSTRAINT FK_DIST_PELI2 FOREIGN KEY (DP_PELI) REFERENCES PELICULA (PELI_ID)
);

ALTER TABLE PREMIO_MIEMBRO ADD(
CONSTRAINT FK_PREMIO_MIEMBRO1 FOREIGN KEY (PM_PREMIO) REFERENCES PREMIO_CATEGORIA (PREM_ID),
CONSTRAINT FK_PREMIO_MIEMBRO2 FOREIGN KEY (PM_MIEMBRO) REFERENCES MIEMBRO (MIEM_ID)
);

ALTER TABLE GENERO ADD(
CONSTRAINT FK_GENERO FOREIGN KEY (GENE_PADRE) REFERENCES GENERO(GENE_ID)
);

ALTER TABLE CINE_PELICULA ADD(
CONSTRAINT FK_CINE_PELICULA1 FOREIGN KEY (CP_PELICULA) REFERENCES PELICULA (PELI_ID),
CONSTRAINT FK_CINE_PELICULA2 FOREIGN KEY (CP_CINE) REFERENCES CINE (CINE_ID)
);

ALTER TABLE PELICULA ADD (
CONSTRAINT FK_PELICULA1 FOREIGN KEY(PELI_LUGAR) REFERENCES LUGAR (LUGA_ID),
CONSTRAINT FK_PELICULA2 FOREIGN KEY(PELI_GENERO) REFERENCES GENERO (GENE_ID),
CONSTRAINT FK_PELICULA3 FOREIGN KEY(PELI_PADRE) REFERENCES PELICULA (PELI_ID)
);

ALTER TABLE STAFF ADD (
CONSTRAINT FK_STAFF1 FOREIGN KEY(STAF_PELICULA) REFERENCES PELICULA (PELI_ID),
CONSTRAINT FK_STAFF2 FOREIGN KEY(STAF_PERSONA) REFERENCES PERSONA (PERS_ID),
CONSTRAINT FK_STAFF3 FOREIGN KEY(STAF_ROL) REFERENCES ROL (ROL_ID)
);

ALTER TABLE PERSONA ADD(
CONSTRAINT FK_PERSONA FOREIGN KEY(PERS_LUGAR) REFERENCES LUGAR (LUGA_ID)
);

ALTER TABLE FAMILIAR_PERSONA ADD(
CONSTRAINT FK_FAMILIAR1 FOREIGN KEY (FAMI_PERSONA1) REFERENCES PERSONA (PERS_ID),
CONSTRAINT FK_FAMILIAR2 FOREIGN KEY (FAMI_PERSONA2) REFERENCES PERSONA (PERS_ID)
);

ALTER TABLE PRESENTADOR ADD(
CONSTRAINT FK_PRESENTADOR1 FOREIGN KEY (PRES_PERSONA) REFERENCES PERSONA (PERS_ID),
CONSTRAINT FK_PRESENTADOR2 FOREIGN KEY (PRES_CEREMONIA) REFERENCES CEREMONIA (CERE_ID)
);

ALTER TABLE CEREMONIA ADD (
CONSTRAINT FK_CEREMONIA FOREIGN KEY (CERE_LUGAR) REFERENCES LUGAR (LUGA_ID)
);

ALTER TABLE VOTO ADD(
CONSTRAINT FK_VOTO FOREIGN KEY(VOTO_POSTULADO) REFERENCES POSTULADO(POST_ID)
);

ALTER TABLE POSTULADO ADD(
CONSTRAINT FK_POSTULADO1 FOREIGN KEY(POST_PREMIO) REFERENCES PREMIO_CATEGORIA(PREM_ID),
CONSTRAINT FK_POSTULADO2 FOREIGN KEY(POST_PELICULA) REFERENCES PELICULA (PELI_ID),
CONSTRAINT FK_POSTULADO3 FOREIGN KEY(POST_STAFF) REFERENCES STAFF (STAF_ID)
);

ALTER TABLE LUGAR ADD (
CONSTRAINT FK_LUGAR FOREIGN KEY (LUGA_PADRE) REFERENCES LUGAR (LUGA_ID)
);

ALTER TABLE POST_PRES ADD(
CONSTRAINT FK_PP1 FOREIGN KEY (PP_PRESENTADOR) REFERENCES PRESENTADOR (PRES_ID),
CONSTRAINT FK_PP2 FOREIGN KEY (PP_POSTULADO) REFERENCES POSTULADO (POST_ID)
);

ALTER TABLE MIEMBRO ADD(
CONSTRAINT FK_MIEMBRO FOREIGN KEY (MIEM_PERSONA) REFERENCES PERSONA (PERS_ID)
);

ALTER TABLE PREMIO_CATEGORIA ADD(
CONSTRAINT FK_PREMIO FOREIGN KEY (PREM_PADRE) REFERENCES PREMIO_CATEGORIA(PREM_ID)
);

create sequence "S_PREMIO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_CURIOSIDAD"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_DISTRIBUCION"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_GENERO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_CINE"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PELICULA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_ROL"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_STAFF"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PERSONA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_FAMILIAR"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_MIEMBRO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PRESENTADOR"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_CEREMONIA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_VOTO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_POSTULADO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_LUGAR"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_POST_PRES"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;