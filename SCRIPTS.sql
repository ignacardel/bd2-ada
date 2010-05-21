rem / TDA /

rem / TDA HISTORIA /

create or replace type t_historia as object (
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

create or replace tyoe t_creador as object(
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

rem / TDA ESTATUILLA FALTA/


rem / TABLAS ANIDADAS /


rem / TABLA ANIDADA NOMBRE /

create or replace type nt_nombre as table of t_nombre;


rem / TABLA ANIDADA RECIBIDO /

create or replace type nt_recibido as table of t_recibido;


rem / VARRAYS /


rem / VARRAY CREADOR /

create or replace type v_creador as varray(10) of t_creador;


rem / VARRAY HISTORIA /

create or replace type v_historia as varray(10) of t_historia;


rem / TABLAS /

rem / TABLA PREMIO_CATEGORIA /

CREATE TABLE PREMIO_CATEGORIA(
PREM_ID NUMBER NOT NULL,
PREM_NIVEL NUMBER NOT NULL,
PREM_DESCRIPCION VARCHAR2(400) NOT NULL,
PREM_NOMBRE nt_nombre NOT NULL,
PREM_PREMIO VARCHAR2(50) NOT NULL,
PREM_ESTATUILLA t_estatuilla NOT NULL,
CONSTRAINT PK_PREMIO_CATEGORIA PRIMARY KEY (PREM_ID)
);

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
DIST_DESCRIPCION VARCHAR2(400) NULL,
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