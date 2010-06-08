rem / VALIDAR MANDATORIEDAD CON PROCEDIMIENTOS /
rem / TDA PAGINA WEB /

create or replace type t_paginaweb as object(
link varchar2(50),
tipo varchar2(14)
);
/

rem / TDA HISTORIA /

create or replace type t_historia as object(
fecha date,
hecho varchar2(500)
);
/

rem / TDA REGLA /

create or replace type t_regla as object(
tipo varchar2(200),
valori number(10,3),
valorf number(10,3),
porcentaje number(10,2),
unidad varchar2(100)
);
/

rem / TDA FORMA DISTRIBUCION /

create or replace type t_formadist as object(
nombre varchar2(50),
descripcion varchar2(150)
);
/

rem / TDA TELEFONO /
	
create or replace type t_telefono as object(
codigo number(5),
numero number(10),
tipo varchar2(15)
);
/

rem / TDA PRESENTACION /
rem / VALIDAR MANDATORIEDAD CON PROCEDIMIENTOS /

create or replace type t_presentacion as object(
peso number(6,3),
unidad varchar2(20),
tipo varchar2(20)
);
/
rem / VARRAY TELEFONOS /

create or replace type v_telefono as varray(20) of t_telefono;
/

rem / TDA CONTACTO /

create or replace type t_contacto as object(
nombre varchar2(50),
apellido varchar2(50),
cargo varchar2(50),
telefonos v_telefono);
/

rem / TDA INF NUTRICIONAL /
	
create or replace type t_infnutricional as object(
calorias number(5,2),
cantproducto number(5,2)
);
/

rem / TDA COLOR /
	
create or replace type t_color as object(
valori number(10,2),
valorf number(10,2)
);
/

rem / TDA DESCUENTO /
	
create or replace type t_descuento as object(
porcentaje number(7,2),
cantidadxgrupo number(7,2),
motivo varchar2(70)
);
/

rem / TDA RANGO EDAD /
	
create or replace type t_rangoedad as object(
edadmin number(4,2),
edadmax number(4,2)
);
/

rem / TDA HORARIO /
rem / VER LO DE LAS HORAS /

create or replace type t_horario as object(
dia varchar2(100),
horai number(7,2),
horaf number(7,2),
frecuencia number(3,2)
);
/

rem / TDA REQ ADQUISICION /	
create or replace type t_reqad as object(
tiempo number(7,4),
unidad varchar2(100)
);
/

rem / TDA TEMPERATURA /
	
create or replace type t_temperatura as object(
valor number(3,2),
unidad varchar2(20)
);
/

rem / VARRAY ALIMENTO /

create or replace type v_alimento as varray(30) of varchar2(30);
/

rem / VARRAY FERIADOS /

create or replace type v_feriado as varray(50) of date;
/

rem / VARRAY TEMPORADA /

create or replace type v_temporada as varray(10) of varchar2(20);
/

rem / VARRAY REQUISITO /

create or replace type v_requisito as varray(50) of varchar2(200);
/

rem / VARRAY FORMA PAGO /

create or replace type v_formapago as varray(20) of varchar2(100);
/

rem / TABLA ANIDADA HISTORIA /

create or replace type nt_historia as table of t_historia;
/

rem / TABLA ANIDADA PAG WEB /

create or replace type nt_pagweb as table of t_paginaweb;
/

rem /TABLA ANIDADA PRESENTACION /

create or replace type nt_presentacion as table of t_presentacion;
/

rem / TABLA ANIDADA FORMA DISTRIBUCION /

create or replace type nt_fdist as table of t_formadist;
/

rem / TABLA ANIDADA DESCUENTOS /
create or replace type nt_descuento as table of t_descuento;
/

rem / TABLA ANIDADA HORARIO /
create or replace type nt_horario as table of t_horario;
/

rem / TABLA ANIDADA REQ ADQUISICION /
create or replace type nt_reqadq as table of t_reqad;
/

rem / TABLA ANIDADA CONTACTO /
create or replace type nt_contacto as table of t_contacto;
/

rem / TABLA ANIDADA TELEFONOS /
create or replace type nt_telefonos as table of t_telefono;
/

rem / Table `LUGAR` /

CREATE TABLE LUGAR (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  Tipo VARCHAR2(45) NOT NULL ,
  Moneda VARCHAR2(45) NULL ,
  Capital VARCHAR2(45) NULL ,
  Feriados v_feriado NULL ,
  LUGAR_Id NUMBER NULL , 
  CONSTRAINT CH_LUGAR CHECK (Tipo IN('CONTINENTE','PAIS','CIUDAD')),
  CONSTRAINT PK_LUGAR PRIMARY KEY (Id)
  );


rem / Table `PROVEEDOR` /


CREATE TABLE PROVEEDOR (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  PaginaWeb t_paginaweb NULL ,
  Direccion VARCHAR2(45) NOT NULL ,
  Telefonos nt_telefonos NULL ,
  Contactos nt_contacto NULL ,
  LUGAR_Id NUMBER NOT NULL ,
  CONSTRAINT PK_PROVEEDOR PRIMARY KEY (Id)
  )nested table Telefonos store as tel1_nt,
  nested table Contactos store as cont_nt;

rem / Table `TIPO` /


CREATE TABLE TIPO (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  Temperatura t_temperatura NOT NULL ,
  IBU VARCHAR2(45) NOT NULL ,
  Descripcion VARCHAR2(500) NOT NULL ,
  Alimentos v_alimento NULL ,
  CONSTRAINT PK_TIPO PRIMARY KEY (Id)
  );

rem / Table `EMPRESA` /


CREATE TABLE EMPRESA (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  PaginaWeb t_paginaweb NULL ,
  Direccion VARCHAR2(45) NOT NULL ,
  Historias nt_historia NULL ,
  FechaFundacion DATE NOT NULL ,
  EMPRESA_Id NUMBER NULL ,
  LUGAR_Id NUMBER NOT NULL ,
  Dueno VARCHAR2(45) NULL ,
  ProduccionAnual NUMBER(6,2) NULL ,
  CONSTRAINT PK_EMPRESA PRIMARY KEY (Id)
  )nested table Historias store as hist_nt;

rem / Table `CERVEZA_CATALOGO` /


CREATE TABLE CERVEZA_CATALOGO (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  PaginaWeb nt_pagweb NULL ,
  ABV NUMBER(4,2) NOT NULL ,
  Marca VARCHAR2(45) NULL ,
  NombreIdiomaOrig VARCHAR2(45) NULL ,
  FechaInicio DATE NOT NULL ,
  Imagen BLOB ,
  Descripcion VARCHAR2(500) NULL ,
  InfNutricional t_infnutricional NOT NULL ,
  Sabor VARCHAR2(45) NOT NULL ,
  Temporada v_temporada NULL ,
  EMPRESA_Id NUMBER NULL ,
  TIPO_Id NUMBER NOT NULL ,
  CONSTRAINT PK_CERVEZA_CATALOGO PRIMARY KEY (Id,EMPRESA_Id)
  )nested table PaginaWeb store as pw_nt;

rem / Table `PRESENTACION` /


CREATE TABLE PRESENTACION (
  Id NUMBER NOT NULL ,
  Capacidad NUMBER(8,3) NOT NULL ,
  Tipo VARCHAR2(45) NOT NULL ,
  Unidad VARCHAR2(45) NOT NULL ,
  CERVEZA_CATALOGO_Id NUMBER NOT NULL ,
  CERVEZA_CATALOGO_EMPRESA_Id NUMBER NOT NULL ,
  CONSTRAINT PK_PRESENTACION PRIMARY KEY  
 (Id,CERVEZA_CATALOGO_Id,CERVEZA_CATALOGO_EMPRESA_Id)
  );


rem / Table `PRESENTACION_has_LUGAR` /


CREATE TABLE PRESENTACION_has_LUGAR (
  PRESENTACION_Id NUMBER NOT NULL ,
  PCERVEZA_CATALOGO_Id NUMBER NOT NULL  ,
  PCERVEZA_CATALOGO_EMPRESA_Id NUMBER NOT NULL ,
  LUGAR_Id NUMBER NOT NULL ,
  CONSTRAINT PK_PRESENTACION_has_LUGAR 
  PRIMARY KEY (PRESENTACION_Id,LUGAR_Id,PCERVEZA_CATALOGO_Id,
  PCERVEZA_CATALOGO_EMPRESA_Id)
);

rem / Table `PROCESO` /


CREATE TABLE PROCESO (
  Id NUMBER NOT NULL ,
  NombreDescrip VARCHAR2(100) NOT NULL ,
  Tipo VARCHAR2(100) NOT NULL ,
  Reglas t_regla NULL ,
  PROCESO_Id NUMBER NULL ,
  CONSTRAINT CH_PROCESO CHECK (Tipo IN('ETAPA','SUB-PROCESO','PASO ACTIVIDAD')),
  CONSTRAINT PK_PROCESO PRIMARY KEY (Id) 
  );

rem / Table `FABRICA` /


CREATE TABLE FABRICA (
  Id NUMBER NOT NULL ,
  FechaApertura DATE NOT NULL ,
  EMPRESA_Id NUMBER NOT NULL ,
  LUGAR_Id NUMBER NOT NULL ,
  CONSTRAINT PK_FABRICA PRIMARY KEY (Id,EMPRESA_Id)
  );

rem / Table `PEDIDO` /


CREATE TABLE PEDIDO (
  Id NUMBER NOT NULL ,
  FechaPedido DATE NOT NULL ,
  FechaEntregaEstimada DATE NOT NULL ,
  FechaLlegada DATE NULL ,
  PROVEEDOR_Id NUMBER NOT NULL ,
  EMPRESA_Id NUMBER NOT NULL,
  CONSTRAINT PK_PEDIDO PRIMARY KEY (Id,PROVEEDOR_Id)
  );


rem / Table `MATERIA_PRIMA` /


CREATE TABLE MATERIA_PRIMA (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  Descripcion VARCHAR2(150) NOT NULL ,
  Tipo VARCHAR2(45) NOT NULL ,
  Presentaciones nt_presentacion NULL ,
  Foto BLOB,
  FormaDistribucion nt_fdist NULL ,
  CONSTRAINT PK_MATERIA_PRIMA PRIMARY KEY (Id)
  )nested table Presentaciones store as pres_nt,
  nested table FormaDistribucion store as fd_nt;


rem / Table `VARIEDAD` /


CREATE TABLE VARIEDAD (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  Tipo VARCHAR2(45) NOT NULL ,
  MaxUso NUMBER(3) NOT NULL ,
  Colors t_color NOT NULL ,
  MATERIA_PRIMA_Id NUMBER NOT NULL ,
  CONSTRAINT CH_VARIEDAD CHECK (Tipo IN('BASE','COLOREADA')),
  CONSTRAINT PK_VARIEDAD PRIMARY KEY (Id,MATERIA_PRIMA_Id)
  );


rem / Table `VARIEDAD_has_LUGAR` /


CREATE TABLE VARIEDAD_has_LUGAR (
  VARIEDAD_Id NUMBER NOT NULL ,
  VMATERIA_PRIMA_Id NUMBER NOT NULL ,
  LUGAR_Id NUMBER NOT NULL ,
  CONSTRAINT PK_VARIEDAD_has_LUGAR 
  PRIMARY KEY (VARIEDAD_Id,LUGAR_Id,VMATERIA_PRIMA_Id)  
  );

rem /  Table `MATERIA_PRIMA_has_PROCESO` /


CREATE TABLE MATERIA_PRIMA_has_PROCESO (
  MATERIA_PRIMA_Id NUMBER NOT NULL ,
  PROCESO_Id NUMBER NOT NULL ,
  CONSTRAINT PK_MATERIA_PRIMA_has_PROCESO
  PRIMARY KEY (MATERIA_PRIMA_Id,PROCESO_Id)
);

rem / Table `CATALOGO_MATERIA` /


CREATE TABLE CATALOGO_MATERIA (
  Id NUMBER NOT NULL ,
  Descripcion VARCHAR2(150) NOT NULL ,
  Presentaciones nt_presentacion NULL ,
  VARIEDAD_Id NUMBER NULL ,
  VMATERIA_PRIMA_Id NUMBER NULL ,
  MATERIA_PRIMA_Id NUMBER NULL ,
  PROVEEDOR_Id NUMBER NULL,
  CONSTRAINT PK_CATALOGO_MATERIA PRIMARY KEY (Id)
)nested table Presentaciones store as pres2_nt;

rem /  Table `EQUIPO` /


CREATE TABLE EQUIPO (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  Descripcion VARCHAR2(150) NOT NULL ,
  CONSTRAINT PK_EQUIPO PRIMARY KEY (Id) 
);

rem /  Table `EQUIPO_has_PROCESO` /


CREATE TABLE EQUIPO_has_PROCESO (
  EQUIPO_Id NUMBER NOT NULL ,
  PROCESO_Id NUMBER NOT NULL ,
  CONSTRAINT PK_EQUIPO_has_PROCESO
  PRIMARY KEY (EQUIPO_Id,PROCESO_Id)
);

rem /  Table `CATALOGO_EQUIPOS` /


CREATE TABLE CATALOGO_EQUIPOS (
  Id NUMBER NOT NULL ,
  ReferenciaTecnica VARCHAR2(45) NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  Foto BLOB,
  DetallesTecnicos VARCHAR2(150) NOT NULL ,
  PROVEEDOR_Id NUMBER NOT NULL ,
  EQUIPO_Id NUMBER NOT NULL ,
  CONSTRAINT PK_CATALOGO_EQUIPOS 
  PRIMARY KEY (Id,PROVEEDOR_Id) 
);

rem /  Table `PEDIDO_has_CATALOGO` /


CREATE TABLE PEDIDO_has_CATALOGO (
  Id NUMBER NOT NULL ,
  PEDIDO_Id NUMBER NOT NULL ,
  CATALO_MATERIA_Id NUMBER NULL ,
  CATALOGO_EQUIPOS_Id NUMBER NULL ,
  PPROVEEDOR_Id NUMBER NULL ,
  Cantidad NUMBER(7) NOT NULL ,
  FormaPresentacion t_presentacion NULL ,
  CONSTRAINT PK_PEDIDO_has_CATALOGO
  PRIMARY KEY (PEDIDO_Id,Id,PPROVEEDOR_Id) 
);

rem / Table `PRODUCCION` /


CREATE TABLE PRODUCCION (
  Id NUMBER NOT NULL ,
  FechaProduccion DATE NOT NULL ,
  Cantidad NUMBER(20,2) NOT NULL ,
  Linea VARCHAR2(100) NOT NULL ,
  FechaVencimiento DATE NOT NULL ,
  FABRICA_Id NUMBER NOT NULL ,
  PRESENTACION_Id NUMBER NOT NULL ,
  FABRICA_EMPRESA_Id NUMBER NOT NULL ,
  PCERVEZA_CATALOGO_Id NUMBER NOT NULL ,
  CONSTRAINT PK_PRODUCCION 
  PRIMARY KEY            
 (Id,FABRICA_Id,PRESENTACION_Id,
 FABRICA_EMPRESA_Id,PCERVEZA_CATALOGO_Id) 
);

rem / Table `DESCUENTO_PEDIDO` /


CREATE TABLE DESCUENTO_PEDIDO (
  Id NUMBER NOT NULL ,
  PFABRICA_Id NUMBER NOT NULL ,
  PPRESENTACION_Id NUMBER NOT NULL ,
  PFABRICA_EMPRESA_Id NUMBER NOT NULL ,
  PCERVEZA_CATALOGO_Id NUMBER NOT NULL ,
  DPEDIDO_Id NUMBER NOT NULL ,
  DPPROVEEDOR_Id NUMBER NOT NULL ,
  Cantidad NUMBER(20,2) NOT NULL ,
  PEDIDO_has_CATALOGO_Id NUMBER NOT NULL ,
  PRODUCCION_Id NUMBER NOT NULL ,
  CONSTRAINT PK_DESCUENTO_PEDIDO 
  PRIMARY KEY (Id,PEDIDO_has_CATALOGO_Id,PRODUCCION_Id,DPEDIDO_Id,
  PFABRICA_Id,PPRESENTACION_Id,
  PFABRICA_EMPRESA_Id,PCERVEZA_CATALOGO_Id,
  DPPROVEEDOR_Id)
);

rem / Table `BAR` /


CREATE TABLE BAR (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  Calle VARCHAR2(45) NOT NULL ,
  CodPostal NUMBER(5) NULL ,
  Telefono t_telefono NULL ,
  LUGAR_Id NUMBER NOT NULL ,
  CONSTRAINT PK_BAR PRIMARY KEY (Id) 
);

rem / Table `HISTORIA` /


CREATE TABLE HISTORIA (
  Id NUMBER NOT NULL ,
  Hecho VARCHAR2(500) NOT NULL ,
  Siglo VARCHAR2(100) NOT NULL ,
  periodo VARCHAR2(4) NOT NULL,
  CONSTRAINT CH_HISTORIA CHECK (periodo IN('A.C','D.C')),
  CONSTRAINT PK_HISTORIA PRIMARY KEY (Id) 
);

rem / Table `TOUR` /


CREATE TABLE TOUR (
  Id NUMBER NOT NULL ,
  Precio NUMBER(6,3) NOT NULL ,
  Descuentos nt_descuento NULL ,
  RangoEdad t_rangoedad NOT NULL ,
  Horarios nt_horario NULL ,
  Duracion NUMBER(5) NOT NULL ,
  FormasPagos v_formapago NOT NULL ,
  ReqAdquisicions nt_reqadq NULL ,
  Requisitos v_requisito NOT NULL ,
  CONSTRAINT PK_TOUR PRIMARY KEY (Id)
) nested table Descuentos store as des_nt,
  nested table Horarios store as hor_nt,
  nested table ReqAdquisicions store as ra_nt;

rem / Table `FABRICA_has_TOUR` /


CREATE TABLE FABRICA_has_TOUR (
  FABRICA_Id NUMBER NOT NULL ,
  TOUR_Id NUMBER NOT NULL ,
  FABRICA_EMPRESA_Id NUMBER NOT NULL ,
  CONSTRAINT PK_FABRICA_has_TOUR 
  PRIMARY KEY (FABRICA_Id,TOUR_Id,FABRICA_EMPRESA_Id)
);

rem / Table `GRUPO_TOUR` /


CREATE TABLE GRUPO_TOUR (
  Id NUMBER NOT NULL ,
  Descripcion VARCHAR2(150) NULL ,
  Cantidad NUMBER(5) NOT NULL ,
  FABRICA_has_TOUR_FABRICA_Id NUMBER NOT NULL , 
  FABRICA_has_TOUR_TOUR_Id NUMBER NOT NULL ,
  GFABRICA_EMPRESA_Id NUMBER NOT NULL ,
  CONSTRAINT PK_GRUPO_TOUR PRIMARY KEY (Id, FABRICA_has_TOUR_FABRICA_Id, 
  FABRICA_has_TOUR_TOUR_Id,GFABRICA_EMPRESA_Id) 
);

rem / Table `ENTRADA` /


CREATE TABLE ENTRADA (
  Numero NUMBER NOT NULL ,
  Fecha DATE NOT NULL ,
  Hora NUMBER(6) NOT NULL ,
  Tipo VARCHAR2(100) NOT NULL ,
  Precio NUMBER(10,2) NOT NULL ,
  FormaPago VARCHAR2(100) NOT NULL ,
  FABRICA_has_TOUR_FABRICA_Id NUMBER NOT NULL ,
  FABRICA_has_TOUR_TOUR_Id NUMBER NOT NULL ,
  EFABRICA_EMPRESA_Id NUMBER NOT NULL ,
  GRUPO_TOUR_Id NUMBER NULL,
  ENTRADA_Num_Padre NUMBER NULL ,
  CONSTRAINT CH_ENTRADA CHECK (Tipo IN('ADULTO','MENOR')),
  CONSTRAINT PK_ENTRADA PRIMARY KEY (Numero) 
);

rem / Table `EVENTO` /


CREATE TABLE EVENTO (
  Id NUMBER NOT NULL ,
  Nombre VARCHAR2(45) NOT NULL ,
  Descripcion VARCHAR2(150) NOT NULL ,
  CONSTRAINT PK_EVENTO PRIMARY KEY (Id) 
);

rem / Table `EMPRESA_has_EVENTO` /


CREATE TABLE EMPRESA_has_EVENTO (
  Id NUMBER NOT NULL ,
  EMPRESA_Id NUMBER NOT NULL ,
  EVENTO_Id NUMBER NOT NULL ,
  Descripcion VARCHAR2(150) NULL ,
  Fecha DATE NULL ,
  LUGAR_Id NUMBER NOT NULL ,
  CONSTRAINT PK_EMPRESA_has_EVENTO 
  PRIMARY KEY (EMPRESA_Id,EVENTO_Id,Id) 
);

rem / Table `ELABORACION` /


CREATE TABLE ELABORACION (
  CERVEZA_CATALOGO_Id NUMBER NOT NULL ,
  CEMPRESA_Id NUMBER NOT NULL ,
  MATERIA_PRIMA_Id NUMBER NULL ,
  VARIEDAD_Id NUMBER NULL 
);

rem / ALTERS /


rem / ALTER:LUGAR /

ALTER TABLE LUGAR ADD (
CONSTRAINT fk_LUGAR_LUGAR1
FOREIGN KEY (LUGAR_Id)
REFERENCES LUGAR (Id)
);

rem / ALTER:PROVEEDOR /

ALTER TABLE PROVEEDOR ADD (
CONSTRAINT fk_PROVEEDOR_LUGAR
FOREIGN KEY (LUGAR_Id)
REFERENCES LUGAR (Id)
);

rem / ALTER:EMPRESA /

ALTER TABLE EMPRESA ADD (
CONSTRAINT fk_EMPRESA_EMPRESA1
FOREIGN KEY (EMPRESA_Id)
REFERENCES EMPRESA (Id),
CONSTRAINT fk_EMPRESA_LUGAR1
FOREIGN KEY (LUGAR_Id)
REFERENCES LUGAR (Id)
);

rem / ALTER:CERVEZA_CATALOGO /

ALTER TABLE CERVEZA_CATALOGO ADD (
CONSTRAINT fk_CERVEZA_CATALOGO_EMPRESA1
FOREIGN KEY (EMPRESA_Id)
REFERENCES EMPRESA (Id),
CONSTRAINT fk_CERVEZA_CATALOGO_TIPO1
FOREIGN KEY (TIPO_Id)
REFERENCES TIPO (Id)
);

rem / ALTER:PRESENTACION /

ALTER TABLE PRESENTACION ADD (
CONSTRAINT fk_PR_CER_CA1
FOREIGN KEY (CERVEZA_CATALOGO_Id,CERVEZA_CATALOGO_EMPRESA_Id)
REFERENCES CERVEZA_CATALOGO (Id,EMPRESA_Id)
);

rem / ALTER:PRESENTACION_has_LUGAR /

ALTER TABLE PRESENTACION_has_LUGAR ADD (
CONSTRAINT fk_PRE_has_LU_PRESN1
FOREIGN KEY (PRESENTACION_Id,PCERVEZA_CATALOGO_Id,PCERVEZA_CATALOGO_EMPRESA_Id)
REFERENCES PRESENTACION (Id,CERVEZA_CATALOGO_Id,CERVEZA_CATALOGO_EMPRESA_Id),
CONSTRAINT fk_PREN_aR_L1
FOREIGN KEY (LUGAR_Id )
REFERENCES LUGAR (Id)
);

rem / ALTER:PROCESO /

ALTER TABLE PROCESO ADD (
CONSTRAINT fk_PROCESO_PROCESO1
FOREIGN KEY (PROCESO_Id)
REFERENCES PROCESO (Id)
);


rem / ALTER:FABRICA /

ALTER TABLE FABRICA ADD (
CONSTRAINT fk_FABRICA_EMPRESA1
FOREIGN KEY (EMPRESA_Id)
REFERENCES EMPRESA (Id),
CONSTRAINT fk_FABRICA_LUGAR1
FOREIGN KEY (LUGAR_Id)
REFERENCES LUGAR (Id)
);
  
rem / ALTER:PEDIDO /

ALTER TABLE PEDIDO ADD (
CONSTRAINT fk_PEDIDO_PROVEEDOR1
FOREIGN KEY (PROVEEDOR_Id)
REFERENCES PROVEEDOR (Id)
);

rem / ALTER:VARIEDAD /

ALTER TABLE VARIEDAD ADD (
CONSTRAINT fk_VARD_MAA_PA1
FOREIGN KEY (MATERIA_PRIMA_Id)
REFERENCES MATERIA_PRIMA (Id)
);

rem / ALTER:VARIEDAD_has_LUGAR/

ALTER TABLE VARIEDAD_has_LUGAR ADD(
CONSTRAINT fk_VAD_has_LR_VD1
FOREIGN KEY (VARIEDAD_Id,VMATERIA_PRIMA_Id)
REFERENCES VARIEDAD (Id,MATERIA_PRIMA_Id),
CONSTRAINT fk_VARIEDs_LR_L1
FOREIGN KEY (LUGAR_Id)
REFERENCES LUGAR (Id)
);

rem / ALTER:MATERIA_PRIMA_has_PROCESO /

ALTER TABLE MATERIA_PRIMA_has_PROCESO ADD (
CONSTRAINT fk_MATA_A_s_PROMA_P1
FOREIGN KEY (MATERIA_PRIMA_Id)
REFERENCES MATERIA_PRIMA (Id),
CONSTRAINT fk_MEAPI_a_OE_1
FOREIGN KEY (PROCESO_Id)
REFERENCES PROCESO (Id)
);

rem / ALTER:CATALO_MATERIA /

ALTER TABLE CATALOGO_MATERIA ADD (
CONSTRAINT fk_CO_MAA_VAR1
FOREIGN KEY (VARIEDAD_Id,VMATERIA_PRIMA_Id)
REFERENCES VARIEDAD (Id,MATERIA_PRIMA_Id),
CONSTRAINT fk_CALMTI_AEAPI1
FOREIGN KEY (MATERIA_PRIMA_Id)
REFERENCES MATERIA_PRIMA (Id)
);


rem / ALTER:EQUIPO_has_PROCESO /

ALTER TABLE EQUIPO_has_PROCESO ADD (
CONSTRAINT fk_EQUIPO_has_PROCESO_EQUIPO1
FOREIGN KEY (EQUIPO_Id)
REFERENCES EQUIPO (Id),
CONSTRAINT fk_EQUIPO_has_PROCESO_PROCESO1
FOREIGN KEY (PROCESO_Id)
REFERENCES PROCESO (Id)
);

rem / ALTER:CATALOGO_EQUIPOS /

ALTER TABLE CATALOGO_EQUIPOS ADD (
CONSTRAINT fk_CATALOGO_EQUIPOS_PROVEEDOR1
FOREIGN KEY (PROVEEDOR_Id)
REFERENCES PROVEEDOR (Id),
CONSTRAINT fk_CATALOGO_EQUIPOS_EQUIPO1
FOREIGN KEY (EQUIPO_Id)
REFERENCES EQUIPO (Id)
);

rem / ALTER:PEDIDO_has_CATALO /

ALTER TABLE PEDIDO_has_CATALOGO ADD (
CONSTRAINT fk_PDO_has_LO_MA_1
FOREIGN KEY (PEDIDO_Id,PPROVEEDOR_Id)
REFERENCES PEDIDO (Id,PROVEEDOR_Id),
CONSTRAINT fk_PIOh_CTOMEICTL_1
FOREIGN KEY (CATALO_MATERIA_Id)
REFERENCES CATALOGO_MATERIA (Id),
CONSTRAINT f_ED_sTAEICTLG1
FOREIGN KEY (CATALOGO_EQUIPOS_Id, PPROVEEDOR_Id)
REFERENCES CATALOGO_EQUIPOS (Id,PROVEEDOR_Id)
);


rem / ALTER:DESCUENTO_PEDIDO /

ALTER TABLE DESCUENTO_PEDIDO ADD (
CONSTRAINT fk_DO_PO_s_CAT_M1
FOREIGN KEY (PEDIDO_has_CATALOGO_Id,DPEDIDO_Id,DPPROVEEDOR_Id)
REFERENCES PEDIDO_has_CATALOGO (Id,PEDIDO_Id,PPROVEEDOR_Id),
CONSTRAINT fk_ECNOPDDPO1
FOREIGN KEY (PRODUCCION_Id,PFABRICA_Id,PPRESENTACION_Id,
 PFABRICA_EMPRESA_Id,PCERVEZA_CATALOGO_Id)
REFERENCES PRODUCCION (Id,FABRICA_Id,PRESENTACION_Id,
 FABRICA_EMPRESA_Id,PCERVEZA_CATALOGO_Id)
);

rem / ALTER:BAR /

ALTER TABLE BAR ADD (
CONSTRAINT fk_BAR_LUGAR1
FOREIGN KEY (LUGAR_Id)
REFERENCES LUGAR (Id)
);

rem / ALTER:FABRICA_has_TOUR /

ALTER TABLE FABRICA_has_TOUR ADD (
CONSTRAINT fk_FABRIhas_R_FA1
FOREIGN KEY (FABRICA_Id,FABRICA_EMPRESA_Id)
REFERENCES FABRICA (Id,EMPRESA_Id),
CONSTRAINT fk_BRICAas_UR_R1
FOREIGN KEY (TOUR_Id)
REFERENCES TOUR (Id)
);

rem / ALTER:GRUPO_TOUR /

ALTER TABLE GRUPO_TOUR ADD (
CONSTRAINT fk_GPO_TR_FA1
FOREIGN KEY (FABRICA_has_TOUR_FABRICA_Id, 
FABRICA_has_TOUR_TOUR_Id,GFABRICA_EMPRESA_Id)
REFERENCES FABRICA_has_TOUR (FABRICA_Id,TOUR_Id,FABRICA_EMPRESA_Id)
);



rem / ALTER:EMPRESA_has_EVENTO /

ALTER TABLE EMPRESA_has_EVENTO ADD (
CONSTRAINT fk_EMPRESA_has_EVENTO_EMPRESA1
FOREIGN KEY (EMPRESA_Id)
REFERENCES EMPRESA (Id),
CONSTRAINT fk_EMPRESA_has_EVENTO_EVENTO1
FOREIGN KEY (EVENTO_Id)
REFERENCES EVENTO (Id),
CONSTRAINT fk_EMPRESA_has_EVENTO_LUGAR1
FOREIGN KEY (LUGAR_Id)
REFERENCES LUGAR (Id)
);



rem / ALTER:ENTRADA /

ALTER TABLE ENTRADA ADD (
CONSTRAINT fk_ENTRADA_FABRICA_has_TOUR1
FOREIGN KEY (FABRICA_has_TOUR_FABRICA_Id,FABRICA_has_TOUR_TOUR_Id,
EFABRICA_EMPRESA_Id)
REFERENCES FABRICA_has_TOUR (FABRICA_Id,TOUR_Id,FABRICA_EMPRESA_Id),
CONSTRAINT fk_ENTRADA_ENTRADA1
FOREIGN KEY (ENTRADA_Num_Padre)
REFERENCES ENTRADA (Numero)
);

rem / ALTER:ELABORACION /

ALTER TABLE ELABORACION ADD (
CONSTRAINT fk_CEROGO_hasERIA_P1
FOREIGN KEY (CERVEZA_CATALOGO_Id,CEMPRESA_Id)
REFERENCES CERVEZA_CATALOGO (Id,EMPRESA_Id),
CONSTRAINT fk_CERAAAO_a_AE1
FOREIGN KEY (MATERIA_PRIMA_Id)
REFERENCES MATERIA_PRIMA (Id)
);

rem / ALTER:PRODUCCION /

ALTER TABLE PRODUCCION ADD (
CONSTRAINT fk_PRODUCCION_FABRICA1
FOREIGN KEY (FABRICA_Id,FABRICA_EMPRESA_Id)
REFERENCES FABRICA (Id,EMPRESA_Id)
);

create sequence "S_LUGAR"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_BAR"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_HISTORIA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_CERVEZA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_VARIEDAD"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_MATERIA_PRIMA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PRESENTACION"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_TIPO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_EMPRESA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PRODUCCION"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_FABRICA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_DESCUENTO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PEDIDO_CATALOGO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PEDIDO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_CATALOGO_MATERIA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_EVENTO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_TOUR"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PROVEEDOR"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_PROCESO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_EQUIPO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_ENTRADA"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_CATALOGO_EQUIPO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_GRUPO_TOUR"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

create sequence "S_EMPRESA_EVENTO"
start with 1
increment by 1
maxvalue 999
cache 20
nocycle
noorder;

rem / FUNCIONES /

CREATE OR REPLACE 
FUNCTION "alimentosTipo" (idd  NUMBER)
RETURN VARCHAR2
AS

alimentos VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM TIPO WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.ALIMENTOS IS NOT NULL THEN
			FOR i IN 1..resultado.ALIMENTOS.COUNT LOOP
				IF resultado.ALIMENTOS(i) <> ' ' then
					IF i=1 then
					alimentos:= resultado.ALIMENTOS(i);
					end if;
					IF i>1 then
alimentos := alimentos || ' , ' ||resultado.ALIMENTOS(i);
					end if;
				END IF;
			END LOOP;
		END IF;
		IF resultado.ALIMENTOS IS NULL THEN
			alimentos:='N/A ';
		END IF;
	END LOOP;
	RETURN alimentos;
END;
/
CREATE OR REPLACE 
FUNCTION "cantidadDias" (fecha  VARCHAR2)
RETURN INT
AS
	
	fechaAux VARCHAR2(10);
	ultimaFecha DATE;
	dias INT;
BEGIN
	--fechaAux := TO_CHAR(fecha,'dd-mm-yyyy');
	ultimaFecha := TO_DATE(fecha,'dd-mm-yyyy');
	SELECT ultimaFecha - sysdate + 1 INTO dias  FROM DUAL;
	RETURN dias;
END;
/
CREATE OR REPLACE 
FUNCTION "descuentos" (idd  NUMBER)
RETURN VARCHAR2
AS
motivo VARCHAR2(500);
por NUMBER;
cantidad NUMBER;
descuentos VARCHAR(2000);
CURSOR busqueda IS SELECT * FROM tour WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.descuentos IS NOT NULL THEN
			FOR i IN 1..resultado.descuentos.COUNT LOOP
				motivo := resultado.descuentos(i).motivo;
				por := resultado.descuentos(i).porcentaje;
				cantidad := resultado.descuentos(i).cantidadxgrupo;
				IF i=1 THEN
descuentos := descuentos || '  ' || 'Descuento por: ' || motivo || ', porcentaje de descuento sobre la entrada  ' || TO_CHAR(por) || '%';
				END IF;
				IF i>1 THEN
descuentos := descuentos || '.  ' || 'Descuento por: ' || motivo || '. porcentaje de descuento sobre la entrada  ' || TO_CHAR(por) || '%';
				END IF;
			END LOOP;
		END IF;
		IF resultado. descuentos IS NULL THEN
			 descuentos:='N/A ';
		END IF;
	END LOOP;
	RETURN  descuentos;
END;
/
CREATE OR REPLACE 
FUNCTION "esMenor" (menor  INT, mayor  INT)
RETURN VARCHAR2
AS
	devolver VARCHAR2(10);
BEGIN
	IF (menor < mayor) THEN
		devolver := 'MENOR';
	END IF;
	IF (menor =  mayor) THEN
		devolver := 'IGUAL';
	END IF;
	IF (menor > mayor) THEN
		devolver := 'MAYOR';
	END IF;
	RETURN devolver;
END;
/
CREATE OR REPLACE 
FUNCTION "formaDePago" (idd  NUMBER)
RETURN VARCHAR2
AS
formaDePago VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM TOUR WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.formasPagos IS NOT NULL THEN
			FOR i IN 1..resultado.formasPagos.COUNT LOOP
				IF resultado.formasPagos(i) <> ' ' then
					IF i=1 then
					formaDePago:= resultado.formasPagos(i);
					end if;
					IF i>1 then
formaDePago := formaDePago || ' , ' ||resultado.formasPagos(i);
					end if;
				END IF;
			END LOOP;
		END IF;
		IF resultado.formasPagos IS NULL THEN
			formaDePago := 'N/A ';
		END IF;
	END LOOP;
	RETURN formaDePago;
END;
/
CREATE OR REPLACE 
FUNCTION "historiaEmpresa" (idd  NUMBER)
RETURN VARCHAR2
AS

hecho VARCHAR2(500);
fecha DATE;
historia VARCHAR(5000);
CURSOR busqueda IS SELECT * FROM empresa WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.HISTORIAS IS NOT NULL THEN
			FOR i IN 1..resultado.HISTORIAS.COUNT LOOP
				hecho := resultado.HISTORIAS(i).hecho;
				fecha := resultado.HISTORIAS(i).fecha;
				IF i=1 THEN
historia := historia || '  ' || TO_CHAR(fecha,'yyyy') || '  ' || hecho;
				END IF;
				IF i>1 THEN
historia := historia || ',  ' || TO_CHAR(fecha,'yyyy') || '   ' || hecho;
				END IF;
			END LOOP;
		END IF;

		IF resultado.HISTORIAS IS NULL THEN
			historia:='N/A ';
		END IF;
	END LOOP;

	RETURN historia;
END;
/
CREATE OR REPLACE 
FUNCTION "horarios" (idd  NUMBER)
RETURN VARCHAR2
AS
dia VARCHAR2(500);
horai NUMBER;
horaf NUMBER;
horarios VARCHAR(2000);
CURSOR busqueda IS SELECT * FROM tour WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.horarios IS NOT NULL THEN
			FOR i IN 1..resultado.horarios.COUNT LOOP
				dia := resultado.horarios(i).dia;
				horai := resultado.horarios(i).horai;
				horaf := resultado.horarios(i).horaf;
				IF i=1 THEN
horarios := horarios || '  ' || 'Dia ' || dia || ' horario: de ' || TO_CHAR(horai) || ' hasta ' ||  TO_CHAR(horaf);
				END IF;
				IF i>1 THEN
horarios := horarios || '.  ' || 'Dia ' || dia || ' horario: de ' || TO_CHAR(horai) || ' hasta las ' ||  TO_CHAR(horaf);
				END IF;
			END LOOP;
		END IF;
		IF resultado. horarios IS NULL THEN
			 horarios:='N/A ';
		END IF;
	END LOOP;
	RETURN  horarios;
END;
/
CREATE OR REPLACE 
FUNCTION "infoNutri" (idd  NUMBER)
RETURN VARCHAR2
AS

info VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM CERVEZA_CATALOGO WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.INFNUTRICIONAL  IS NOT NULL THEN
			info :=  TO_CHAR(resultado.INFNUTRICIONAL.calorias) || ' CALORIAS POR ' ||  TO_CHAR(resultado.INFNUTRICIONAL.cantproducto) || 'ml ';
		END IF;
	END LOOP;

	RETURN info;
END;
/
CREATE OR REPLACE 
FUNCTION "pagWeb" (idd  NUMBER)
RETURN VARCHAR2
AS

pag VARCHAR2(50);

CURSOR busqueda IS SELECT * FROM cerveza_catalogo WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.PAGINAWEB IS NOT NULL THEN
			FOR i IN 1..resultado.PAGINAWEB.COUNT LOOP
				IF i=1 THEN
					pag := resultado.PAGINAWEB(i).link || '  ' ||  resultado.PAGINAWEB(i).tipo;
				END IF;
				IF i>1 THEN
					pag := pag || ',  ' || resultado.PAGINAWEB(i).link || '  ' ||  resultado.PAGINAWEB(i).tipo;
				END IF;
			END LOOP;
		END IF;

		IF resultado.PAGINAWEB IS NULL THEN
			pag := 'N/A';
		END IF;
	END LOOP;

	RETURN pag;
END;
/
CREATE OR REPLACE 
FUNCTION "rangoEdad" (idd  NUMBER)
RETURN VARCHAR2
AS
edadMin NUMBER;
edadMax NUMBER;
rangoEdad VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM TOUR WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		edadMin := resultado.rangoEdad.edadMin;
		edadMax := resultado.rangoEdad.edadMax;
		rangoEdad := 'El rango de edad esta comprendido entre ' || TO_CHAR(edadMin) ||  ' anos y ' || TO_CHAR(edadMax) || ' anos.';
	END LOOP;
	RETURN rangoEdad;
END;
/
CREATE OR REPLACE 
FUNCTION "requisitos" (idd  NUMBER)
RETURN VARCHAR2
AS
requisitos VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM TOUR WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.requisitos IS NOT NULL THEN
			FOR i IN 1..resultado.requisitos.COUNT LOOP
				IF resultado.requisitos(i) <> ' ' then
					IF i=1 then
					requisitos:= resultado.requisitos(i);
					end if;
					IF i>1 then
requisitos := requisitos || ' , ' ||resultado.requisitos(i);
					end if;
				END IF;
			END LOOP;
		END IF;
		IF resultado.requisitos IS NULL THEN
			requisitos := 'N/A ';
		END IF;
	END LOOP;
	RETURN requisitos;
END;
/
CREATE OR REPLACE 
FUNCTION "temperaturaAF" (idd  NUMBER)
RETURN NUMBER
AS

temp NUMBER;
CURSOR busqueda IS SELECT * FROM TIPO WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		temp := resultado.TEMPERATURA.valor;
		
		temp := ((9/5) * temp) + 32;

	
	END LOOP;

	RETURN temp;
END;
/
CREATE OR REPLACE 
FUNCTION "temperaturaTipo" (idd  NUMBER)
RETURN VARCHAR2
AS

temperatura VARCHAR2(150);
temp NUMBER;
CURSOR busqueda IS SELECT * FROM TIPO WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		temp := resultado.TEMPERATURA.valor;
		
		temperatura := TO_CHAR(temp) || '   ' ||resultado.TEMPERATURA.unidad;

		IF resultado.TEMPERATURA IS NULL THEN
			temperatura:='N/A ';
		END IF;
	END LOOP;

	RETURN temperatura;
END;
/
CREATE OR REPLACE 
FUNCTION "validarCantidad" (cantidad  NUMBER)
RETURN VARCHAR2
AS
	menorMayor VARCHAR2(10);
BEGIN
	
	IF(cantidad > 0) THEN
		menorMayor := 'MAYOR';
	END IF;	
	IF(cantidad = 0) THEN
		menorMayor := 'CERO';
	END IF;	
	IF(cantidad < 0) THEN
		menorMayor := 'MENOR';
	END IF;	
	RETURN menorMayor;
END;
/
CREATE OR REPLACE 
FUNCTION "verificarFeriado" (fecha  VARCHAR2,idd INT)
RETURN VARCHAR2
AS

	fechaAux DATE;
	feriado VARCHAR2(10);
	ultimaFecha date;
	f VARCHAR2(10);
	ff VARCHAR2(10);
	CURSOR busqueda IS SELECT * FROM lugar WHERE ID = idd;
	resultado busqueda % ROWTYPE;

BEGIN

	FOR resultado IN busqueda LOOP
		FOR i IN 1..resultado.feriados.COUNT LOOP
			f := TO_CHAR(resultado.feriados(i),'dd-mm');
			fechaAux := TO_DATE(f,'dd-mm');
			ultimaFecha := TO_DATE(fecha,'dd-mm-yyyy');
			ff := TO_CHAR(ultimaFecha,'dd-mm');
			ultimaFecha := TO_DATE(ff,'dd-mm');
			IF (fechaAux = ultimaFecha ) THEN
				feriado := 'FERIADO';
			END IF;
		END LOOP;
	END LOOP;

RETURN feriado;
END;
/

rem / TRIGGERS /
CREATE OR REPLACE TRIGGER validarEmpresa
BEFORE INSERT ON empresa
FOR EACH ROW
DECLARE

	produccion VARCHAR2(15);
	
	CURSOR cur IS SELECT * FROM TABLE(:new.historias);
	busqueda cur %rowtype;

BEGIN

	IF (:NEW.historias IS NULL ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA EMPRESA NO PUEDE COLOCAR LA HISTORIA EN NULL');
	END IF;

	IF ("cantidadDias"(TO_CHAR(:NEW.fechafundacion,'dd-mm-yyyy')) > 0 ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA EMPRESA LA FECHA DE FUNDACION NO PUEDE SER MAYOR AL DIA DE HOY');
	END IF;
	
	FOR busqueda IN cur LOOP
		IF (busqueda.fecha IS NULL ) OR (busqueda.hecho IS NULL) THEN
			raise_application_error(-20006,'AL INSERTAR UNA EMPRESA DEBE COLOCAR LA HISTORIA CON SU FECHA');
		END IF;
	END LOOP;

	produccion := "validarCantidad"(:NEW.ProduccionAnual);
	IF (produccion <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA EMPRESA LA PORDUCCION ANUAL DEBE SER MAYOR A 1 Y DIFERENTE DE 0');
	END IF;

	IF (:NEW.paginaweb.link IS NULL ) OR (:NEW.paginaweb.tipo IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR UNA EMPRESA DEBE COLOCAR LA PAGINA WEB CON SU LINK Y TIPO');
	END IF;

END;
/
CREATE OR REPLACE TRIGGER validarCervezaCatalogo
BEFORE INSERT ON cerveza_catalogo
FOR EACH ROW
DECLARE

	abv VARCHAR2(15);
	
	CURSOR cur IS SELECT * FROM TABLE(:new.paginaweb);
	busqueda cur %rowtype;

BEGIN

	abv := "validarCantidad"(:NEW.abv);
	IF (abv = 'MENOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA CERVEZA EL ABV NO DEBE SER MENOR A 0');
	END IF;

	IF (:NEW.InfNutricional IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR UNA CERVEZA DEBE TENER SU INFORMACION NUTRICIONAL');
	END IF;

	IF (:NEW.InfNutricional.calorias IS NULL) OR (:NEW.InfNutricional.cantproducto IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR UNA CERVEZA LAS NI LAS CALORIAS NI LA CANTIDAD POR PRODUCTO PUEDE SER NULL');
	END IF;

	IF (:NEW.temporada IS NOT NULL) THEN
		FOR i IN 1..:NEW.temporada.COUNT LOOP
			IF (:NEW.temporada(i) IS NULL ) THEN
				raise_application_error(-20006,'AL INSERTAR UNA CERVEZA Y TIENE ALIMENTOS EL VECTOR NO PUEDE CONTENER NULL');
			END IF;
		END LOOP;
	END IF;

	IF (:NEW.paginaweb IS NOT NULL) THEN
		FOR busqueda IN cur LOOP
			IF (busqueda.link IS NULL ) OR (busqueda.tipo IS NULL) THEN
				raise_application_error(-20006,'AL INSERTAR UNA CERVEZA DEBE COLOCAR LA PAGINA WEB CON SU LINK Y TIPO');
			END IF;
		END LOOP;
	END IF;

	 IF (:NEW.fechainicio IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR LA FECHA, DEBE TENER UNA FECHA');
	END IF;

	 IF ("cantidadDias"(TO_CHAR(:NEW.fechainicio,'dd-mm-yyyy')) > 0 ) THEN
		raise_application_error(-20006,'AL INSERTAR LA FECHA, ESTA NO PUEDE SER EN UN DIA SUPERIOR AL DE HOY');
	END IF;

END;
/
CREATE OR REPLACE TRIGGER validarTipo
BEFORE INSERT ON tipo
FOR EACH ROW

BEGIN

	IF (:NEW.temperatura IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR UN TIPO DE CERVEZA DEBE TENER SU TEMPERATURA IDEAL');
	END IF;

	IF (:NEW.temperatura.valor IS NULL) OR (:NEW.temperatura.unidad IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR UN TIPO DE CERVEZA EN LA TEMPERATURA NO SE PUEDE DEJAR EN NULL EL CAMPO VALOR NI UNIDAD');
	END IF;

	IF (:NEW.temperatura.unidad <> 'CENTIGRADO' ) THEN
		raise_application_error(-20006,'AL INSERTAR UN TIPO LA UNIDAD DE LA TEMPERATURA NO PUEDE SER OTRA COSA QUE NO SEA CENTIGRADO');
	END IF;

	IF (:NEW.alimentos IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR UN TIPO DEBE TENER ALMENOS UN ALIMENTO');
	END IF;

	FOR i IN 1..:NEW.alimentos.COUNT LOOP
		IF (:NEW.alimentos(i) IS NULL ) THEN
			raise_application_error(-20006,'AL INSERTAR UN TIPO VECTOR DE ALIMENTOS NO PUEDE CONTENER NULL');
		END IF;
	END LOOP;

END;
/
CREATE OR REPLACE TRIGGER validarEmpresaHasEvento
BEFORE INSERT ON empresa_has_evento
FOR EACH ROW

BEGIN

	 IF (:NEW.fecha IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR LA FECHA DE UN EVENTO DEBE TENER UNA FECHA');
	END IF;

	 IF ("cantidadDias"(TO_CHAR(:NEW.fecha,'dd-mm-yyyy')) > 0 ) THEN
		raise_application_error(-20006,'AL INSERTAR LA FECHA DE UN EVENTO, ESTA NO PUEDE SER EN UN DIA SUPERIOR AL DE HOY');
	END IF;

END;
/
CREATE OR REPLACE TRIGGER validarFabrica
BEFORE INSERT ON fabrica
FOR EACH ROW

BEGIN

	 IF (:NEW.fechaapertura IS NULL) THEN
		raise_application_error(-20006,'DEBE INSERTAR UNA FECHA DE FUNDACION');
	END IF;

	 IF ("cantidadDias"(TO_CHAR(:NEW.fechaapertura,'dd-mm-yyyy')) > 0 ) THEN
		raise_application_error(-20006,'DEBE INCERTAR UN FECHA MENOR O IGUAL AL DIA DE HOY');
	END IF;

END;
/
CREATE OR REPLACE TRIGGER validarPresentacion
BEFORE INSERT ON presentacion
FOR EACH ROW

BEGIN

	IF ( "validarCantidad"(:NEW.capacidad) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA PRESENTACION LA CANTIDAD NO DEBE SER MENOR A 0');
	END IF;

END;
/
CREATE OR REPLACE TRIGGER validarProveedor
BEFORE INSERT ON proveedor
FOR EACH ROW
DECLARE

	abv VARCHAR2(15);
	
	CURSOR cur IS SELECT * FROM TABLE(:new.telefonos);
	busqueda cur %rowtype;

	CURSOR cur2 IS SELECT * FROM TABLE(:new.contactos);
	busqueda2 cur %rowtype;

BEGIN

	IF (:NEW.paginaweb IS NULL ) THEN
		raise_application_error(-20006,'AL INSERTAR UN PROVEEDOR DEBE COLOCAR UNA PAG WEB');
	END IF;

	IF (:NEW.paginaweb.link IS NULL ) OR (:NEW.paginaweb.tipo IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR UN PROVEEDOR DEBE COLOCAR LA PAGINA WEB CON SU LINK Y TIPO');
	END IF;

	IF (:NEW.telefonos IS NULL ) THEN
		raise_application_error(-20006,'AL INSERTAR UN PROVEEDOR DEBE COLOCAR AL MENOS UN TELEFONO');
	END IF;

	FOR busqueda IN cur LOOP

		IF (busqueda.codigo IS NULL ) OR (busqueda.tipo IS NULL) OR (busqueda.numero IS NULL) THEN
			raise_application_error(-20006,'AL INSERTAR UN PROVEEDOR SU NUMERO DE TELEFONO LLENANDO LOS CAMPOS NUMERO CODIGO Y TIPO, NINGUNO PUEDE SER NULL');
		END IF;

		IF ("validarCantidad"(busqueda.codigo) <> 'MAYOR' ) OR ("validarCantidad"(busqueda.numero) <> 'MAYOR' ) THEN
			raise_application_error(-20006,'AL INSERTAR UN PROVEEDOR EL NUMERO Y EL CODIGO TIENEN QUE SER POSITIVO ');
		END IF;

	END LOOP;

	IF (:NEW.contactos IS NULL ) THEN
		raise_application_error(-20006,'AL INSERTAR UN PROVEEDOR DEBE COLOCAR AL MENOS UN CONTACTO');
	END IF;

	FOR busqueda2 IN cur2 LOOP

		IF (busqueda2.nombre IS NULL ) OR (busqueda2.apellido IS NULL) OR (busqueda2.cargo IS NULL) OR (busqueda2.telefonos IS NULL) THEN
			raise_application_error(-20006,'AL INSERTAR UN PROVEEDOR EN LA TABLA ANIDADA CONTACTO NO PUEDE DEJAR NINGUN CAMPO VACIO');
		END IF;

		FOR i IN 1..busqueda2.telefonos.COUNT LOOP
	
			IF (busqueda2.telefonos(i).codigo IS NULL ) OR (busqueda2.telefonos(i).tipo IS NULL) OR (busqueda2.telefonos(i).numero IS NULL) THEN
				raise_application_error(-20006,'AL INSERTAR UN TELEFONO DE CONTACTO SU NUMERO DE TELEFONO LLENANDO LOS CAMPOS NUMERO CODIGO Y TIPO, NINGUNO PUEDE SER NULL');
			END IF;

			IF ("validarCantidad"(busqueda2.telefonos(i).codigo) <> 'MAYOR' ) OR ("validarCantidad"(busqueda2.telefonos(i).numero) <> 'MAYOR' ) THEN
				raise_application_error(-20006,'AL INSERTAR UN TELEFONO DE CONTACTO EL NUMERO Y EL CODIGO TIENEN QUE SER POSITIVO ');
			END IF;

		END LOOP;

	END LOOP;

END;
/
CREATE OR REPLACE TRIGGER validarTour
BEFORE INSERT ON tour
FOR EACH ROW
DECLARE

	CURSOR cur IS SELECT * FROM TABLE(:new.descuentos);
	busqueda cur %rowtype;

	CURSOR cur2 IS SELECT * FROM TABLE(:new.horarios);
	busqueda2 cur %rowtype;

	CURSOR cur3 IS SELECT * FROM TABLE(:new.reqadquisicions);
	busqueda3 cur %rowtype;

BEGIN

	IF ( "validarCantidad"(:NEW.precio) = 'MENOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UN TOUR EL PRECIO NO PUEDE SER NEGATIVO');
	END IF;

	IF ( "validarCantidad"(:NEW.duracion) = 'MENOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UN TOUR LA DURACION NO PUEDE SER NEGATIVO');
	END IF;

	IF (:NEW.rangoedad IS NULL ) THEN
		raise_application_error(-20006,'AL INSERTAR UN TOUR TIENE QUE COLOCAR EL RANGO DE LA EDAD');
	END IF;

	IF (:NEW.rangoedad.edadmin IS NULL ) OR (:NEW.rangoedad.edadmax IS NULL ) THEN
		raise_application_error(-20006,'AL INSERTAR UN TOUR EL RANGO DE EDAD NO PUEDE CONTENER NULL');
	END IF;

	IF ("validarCantidad"(:NEW.rangoedad.edadmin) <> 'MAYOR' ) OR ("validarCantidad"(:NEW.rangoedad.edadmax) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UN TOUR EL RANGO DE EDAD NO PUEDE CONTENER NUMEROS NEGATIVOS');
	END IF;

	IF ("esMenor"(:NEW.rangoedad.edadmin,:NEW.rangoedad.edadmax) <> 'MENOR'  ) THEN
		raise_application_error(-20006,'AL INSERTAR UN TOUR TIENE EL RANGO DE EDAD LA EDA MINIMA NO PUEDE SER MAYOR A LA MAXIMA');
	END IF;

	IF (:NEW.descuentos IS NOT NULL) THEN
		FOR busqueda IN cur LOOP

			IF (busqueda.porcentaje IS NULL ) OR (busqueda.cantidadxgrupo IS NULL) OR (busqueda.motivo IS NULL) THEN
				raise_application_error(-20006,'AL INSERTAR UN TOUR SU DESCUENTO NO PUEDE CONTENER CAMPOS NULL');
			END IF;

			IF ("validarCantidad"(busqueda.porcentaje) <> 'MAYOR' ) OR ("validarCantidad"(busqueda.cantidadxgrupo) = 'MENOR' ) THEN
				raise_application_error(-20006,'AL INSERTAR UN TOUR SU DESCUENTO NO PUEDE TENER CAMPOS NEGATIVOS ');
			END IF;

		END LOOP;
	END IF;

	IF (:NEW.horarios IS NULL ) THEN
		raise_application_error(-20006,'AL INSERTAR UN TOUR TIENE QUE TENER HORARIOS');
	END IF;

	FOR busqueda2 IN cur2 LOOP

		IF (busqueda2.dia IS NULL ) OR (busqueda2.horai IS NULL) OR (busqueda2.horaf IS NULL) OR (busqueda2.frecuencia IS NULL) THEN
			raise_application_error(-20006,'AL INSERTAR UN TOUR TIENE QUE TENER HORARIOS CON TODOS SUS CAMPOS, NO PUEDEN CONTENER NULL');
		END IF;

		IF ("validarCantidad"(busqueda2.horai) <> 'MAYOR' ) OR ("validarCantidad"(busqueda2.horaf) <> 'MAYOR' ) OR ("validarCantidad"(busqueda2.frecuencia) <> 'MAYOR' ) THEN
			raise_application_error(-20006,'AL INSERTAR UN TOUR TIENE QUE TENER HORARIOS CON TODOS SUS CAMPOS POSITIVOS ');
		END IF;

	END LOOP;

	IF (:NEW.reqadquisicions IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR UN TOUR TIENE QUE TENER REQADQUISICIONS');
	END IF;

	FOR busqueda3 IN cur3 LOOP

		IF (busqueda3.tiempo IS NULL ) OR (busqueda3.unidad IS NULL) THEN
			raise_application_error(-20006,'AL INSERTAR UN TOUR SU REQADQUISICION NO PUEDE CONTENER CAMPOS NULL');
		END IF;

		IF ("validarCantidad"(busqueda3.tiempo) <> 'MAYOR' ) THEN
			raise_application_error(-20006,'AL INSERTAR UN TOUR SU REQADQUISICION NO PUEDE TENER CAMPOS NEGATIVOS ');
		END IF;

	END LOOP;

	FOR i IN 1..:NEW.formaspagos.COUNT LOOP
		IF (:NEW.formaspagos(i) IS NULL ) THEN
			raise_application_error(-20006,'AL INSERTAR UN TOUR VECTOR DE FORMA DE PAGO NO PUEDE CONTENER NULL');
		END IF;
	END LOOP;

	FOR i IN 1..:NEW.requisitos.COUNT LOOP
		IF (:NEW.requisitos(i) IS NULL ) THEN
			raise_application_error(-20006,'AL INSERTAR UN TOUR VECTOR DE REQUISITOS NO PUEDE CONTENER NULL');
		END IF;
	END LOOP;

END;
/
CREATE OR REPLACE TRIGGER validarEntrada
BEFORE INSERT ON entrada
FOR EACH ROW
DECLARE 

	IDD INT;

BEGIN

	IF ( "validarCantidad"(:NEW.hora) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA ENTRADA LA HORA NO PUEDE SER NEGATIVA');
	END IF;

	IF ( "validarCantidad"(:NEW.precio) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA ENTRADA EL PRECIO NO PUEDE SER NEGATIVO');
	END IF;

	IF ("cantidadDias"(TO_CHAR(:NEW.fecha,'dd-mm-yyyy')) < 0 ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA ENTRADA LA FECHA DE COMPRA NO PUEDE SER MENOR AL DIA DE HOY');
	END IF;

	SELECT lugar_id  INTO idd FROM empresa WHERE (id = :NEW.efabrica_empresa_id);

	IF ("verificarFeriado"(TO_CHAR(:NEW.fecha,'dd-mm-yyyy'),idd) = 'FERIADO') THEN
		raise_application_error(-20006,'AL INSERTAR UNA ENTRADA LA FECHA NO PUEDE SER UN FERIADO DE ESE PAIS');
	END IF;


END;
/
CREATE OR REPLACE TRIGGER validarGrupoTour
BEFORE INSERT ON grupo_tour
FOR EACH ROW

BEGIN

	IF ("validarCantidad"(:NEW.cantidad) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UN GRUPO PARA EL TOUR LA CANTIDAD TIENE QUE SER MAYOR A 0');
	END IF;

END;
/
rem / INSERTS /

rem / LUGAR /
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'EUROPEO', 'CONTINENTE', NULL, NULL, NULL, NULL);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'HOLANDA', 'PAIS', 'EURO', 'AMSTERDAM', v_feriado(to_date('01/01/2009','dd/mm/yyyy'),to_date('30/04/2009','dd/mm/yyyy'),to_date('04/05/2009','dd/mm/yyyy'),to_date('05/05/2009','dd/mm/yyyy'),to_date('15/12/2009','dd/mm/yyyy'),to_date('25/12/2009','dd/mm/yyyy')), 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'ENSCHEDE', 'CIUDAD', 'EURO', NULL, v_feriado(to_date('01/01/2009','dd/mm/yyyy'),to_date('30/04/2009','dd/mm/yyyy'),to_date('04/05/2009','dd/mm/yyyy'),to_date('05/05/2009','dd/mm/yyyy'),to_date('15/12/2009','dd/mm/yyyy'),to_date('25/12/2009','dd/mm/yyyy')), 2);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'AMERICA', 'CONTINENTE', NULL, NULL, NULL, NULL);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'OCEANIA', 'CONTINENTE', NULL, NULL, NULL, NULL);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'ESTADOS UNIDOS', 'PAIS', 'DOLAR', 'WASHINGTON', NULL, 4);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'CANADA', 'PAIS', 'DOLAR CANADIENSE', 'OTTAWA', NULL, 4);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'FRANCIA', 'PAIS', 'EURO', 'PARIS', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'AUSTRALIA', 'PAIS', 'DOLAR AUSTRALIANO', 'CANBERRA', NULL, 5);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'RUSIA', 'PAIS', 'RUBLO', 'MOSCU', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'NUEVA ZELANDA', 'PAIS', 'ZELANDA DOLAR', 'WELLINGTON', NULL, 5);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'GROENLO', 'CIUDAD', 'EURO', NULL, v_feriado(to_date('01/01/2009','dd/mm/yyyy'),to_date('30/04/2009','dd/mm/yyyy'),to_date('04/05/2009','dd/mm/yyyy'),to_date('05/05/2009','dd/mm/yyyy'),to_date('15/12/2009','dd/mm/yyyy'),to_date('25/12/2009','dd/mm/yyyy')), 2);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'AUCKLAND', 'CIUDAD', 'EURO', NULL, v_feriado(to_date('01/01/2009','dd/mm/yyyy'),to_date('30/04/2009','dd/mm/yyyy'),to_date('04/05/2009','dd/mm/yyyy'),to_date('05/05/2009','dd/mm/yyyy'),to_date('15/12/2009','dd/mm/yyyy'),to_date('25/12/2009','dd/mm/yyyy')), 2);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'BOEKELO', 'CIUDAD', 'EURO', NULL, v_feriado(to_date('01/01/2009','dd/mm/yyyy'),to_date('30/04/2009','dd/mm/yyyy'),to_date('04/05/2009','dd/mm/yyyy'),to_date('05/05/2009','dd/mm/yyyy'),to_date('15/12/2009','dd/mm/yyyy'),to_date('25/12/2009','dd/mm/yyyy')), 2);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'AMSTERDAM', 'CIUDAD', 'EURO', NULL, v_feriado(to_date('01/01/2009','dd/mm/yyyy'),to_date('30/04/2009','dd/mm/yyyy'),to_date('04/05/2009','dd/mm/yyyy'),to_date('05/05/2009','dd/mm/yyyy'),to_date('15/12/2009','dd/mm/yyyy'),to_date('25/12/2009','dd/mm/yyyy')), 2);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'LITHUANIA', 'PAIS', 'LITAS', 'VILNIUS', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'REPUBLICA CHECA', 'PAIS', 'KORONA', 'PRAGA', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'ITALIA', 'PAIS', 'EURO', 'ROMA', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'PRAGA', 'CIUDAD', 'EURO', NULL, NULL, 17);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'ROMA', 'CIUDAD', 'EURO', NULL, NULL, 18);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'VILNIUS', 'CIUDAD', 'LITAS', NULL, NULL, 16);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'ESPANA', 'PAIS', 'EURO', 'MADRID', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'BARCELONA', 'CIUDAD', 'EURO', NULL, NULL, 22);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'PARIS', 'CIUDAD', 'EURO', NULL, NULL, 8);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'ALEMANIA', 'PAIS', 'EURO', 'BERLIN', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'BELGICA', 'PAIS', 'EURO', 'BRUSELAS', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'REINO UNIDO', 'PAIS', 'LIBRA ESTERLINA', 'LONDRES', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'MELBURNE', 'CIUDAD', 'DOLAR AUSTRALIANO', NULL, NULL, 9);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'SYDNEY', 'CIUDAD', 'DOLAR AUSTRALIANO', NULL, NULL, 9);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'FINLANDIA', 'PAIS', 'EURO', 'HELSINKI', NULL, 1);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'LAHTI', 'CIUDAD', 'EURO', NULL, NULL, 30);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'DORTMUND', 'CIUDAD', 'EURO', NULL, NULL, 25);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'LONDRES', 'CIUDAD', 'LIBRA ESTERLINA', NULL, NULL, 27);

rem / EMPRESA /
INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'SABMILLER', t_paginaweb('WWW.SABMILLER.COM','INTERNACIONAL'), 'CITY OF WESTMINISTER', nt_historia(t_historia(to_date('13/11/1895','dd/mm/yyyy'),'FUE FUNDADA EN SUR AFRICA'),t_historia(to_date('06/06/1990','dd/mm/yyyy'),'EMPIEZA A INVERTIR EN EUROPA'),t_historia(to_date('07/07/1999','dd/mm/yyyy'),'LA COMPANIA SALE REFLEJADA EN LA BOLSA DE VALORES DE LONDRES'),t_historia(to_date('09/08/2002','dd/mm/yyyy'),'COMPRAN ALTRIA GROUP PARA EXPANDIRSE')), to_date('13/11/1895','dd/mm/yyyy'), NULL, 33,NULL,NULL);
INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'GROLSCH', t_paginaweb('WWW.GROLSCH.NL','NACIONAL'), 'BROUVER GOLPEAR 1', nt_historia(t_historia(to_date('16/11/1615','dd/mm/yyyy'),'FUE FUNDADA POR GROENLO PETER CUYPER'),t_historia(to_date('12/01/1684','dd/mm/yyyy'),'SE FUNDO UNA NUEVA FABRICA EN BROKOLOL'),t_historia(to_date('07/11/1897','dd/mm/yyyy'),'SALE AL MERCADO LA BOTELLA DE LITRO Y MEDIO'),t_historia(to_date('18/09/1922','dd/mm/yyyy'),'FUE FUCIONA CONCERVECERIA EL RELOJ'),t_historia(to_date('16/06/2000','dd/mm/yyyy'),'LA FABRICA FUE ARRASADA POR FUEGOS ARIFICIALES'),t_historia(to_date('24/07/2008','dd/mm/yyyy'),'FUE ADQUIRIDA POR LA FIRMA SABMILLER')), to_date('16/11/1615','dd/mm/yyyy'), 1, 3,'FAMILIA CUYPER', 5.4);
INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'FOSTERS GROUP', t_paginaweb('WWW.FOSTERSBEER.COM','INTERNACIONAL'), '77 SOUTHBANK BOULEVARD', nt_historia(t_historia(to_date('19/07/1887','dd/mm/yyyy'),'FUE FUNDADA CON EL NOMBRE DE CERVECERIA ELDERS'),t_historia(to_date('12/01/1907','dd/mm/yyyy'),'SE UNIO CON LA CERVECERIA LOCAL CARLTON'),t_historia(to_date('15/09/1983','dd/mm/yyyy'),'SE FUCIONA CON CERVECERIAS UNIDAS'),t_historia(to_date('09/08/1990','dd/mm/yyyy'),'SE CAMBIA EL NOMBRE A FOSTERS GROUP'),t_historia(to_date('20/06/2005','dd/mm/yyyy'),'SE FUCIONAN CON UN VINEDO LLAMADO CORPORACION DEL SUR')), to_date('19/07/1887','dd/mm/yyyy'), NULL, 28,'FAMILIA FOSTERS',4.7);

rem / TIPO /
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'PALE LAGER', t_temperatura(6.8, 'CENTIGRADO'), '10-15', 'CERVEZA DE BAJA FERMENTACION', v_alimento('Alimentos picantes'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'AMERICAN BLONDE ALE', t_temperatura(5.7, 'CENTIGRADO'), '20-25', 'CERVEZA DE SABOR FRESCO', v_alimento('Fruta Fría', 'Ensaladas', 'Carnes', 'Pizzas'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'LIGHT LAGER', t_temperatura(4, 'CENTIGRADO'), '5-10', 'CERVEZA REFRESCANTE', v_alimento('Costillas', 'Jalapeños', 'Granos'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'HEFEWEIZEN', t_temperatura(6.5, 'CENTIGRADO'), '10-15', 'CERVEZA DE TRADICION ALEMANA', v_alimento('Alimentos frios'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'BOCK', t_temperatura(8.7, 'CENTIGRADO'), '20-25', 'CERVEZA DE SABOR SUAVE Y DULCE', v_alimento('Crustáceos', 'Quesos Fuertes'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'MALT LAGER', t_temperatura(6.3, 'CENTIGRADO'), '10-15', 'CERVEZA REFRESCANTE Y BRILLANTE', v_alimento('Fruta', 'Costillas', 'Crustáceos'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'PREMIUM ALE', t_temperatura(6.3, 'CENTIGRADO'), '10-15', 'CERVEZA REFRESCANTE CARAMELIZADA', v_alimento('Ensaladas', 'Pizzas'));

rem / CERVEZA_CATALOGO /
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM PILSNER', NULL, 5, NULL, NULL, to_date('01/01/1995','dd/mm/yyyy'), empty_blob(), 'MADURACION NATURAL, HECHA CON ELEMENTOS PRIMIUM', t_infnutricional(185, 200), 'SUAVE', NULL, 2, 1);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM BLOND', NULL, 4.2, NULL, NULL, to_date('30/04/1998','dd/mm/yyyy'), empty_blob(), 'LIGERA, 30% MENOS CALORIAS', t_infnutricional(130, 200), 'FRESCO', NULL, 2, 2);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'LEMON 2.5', NULL, 2.5, NULL, NULL, to_date('01/04/2002','dd/mm/yyyy'), empty_blob(), 'EXOTICA, ALTAMENTE REFRESCANTE', t_infnutricional(80, 110), 'LIMON', v_temporada(' VERANO'), 2, 3);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM HERFSTBOK', NULL, 6.5, NULL, NULL, to_date('18/09/2000','dd/mm/yyyy'), empty_blob(), 'CALIDA, CON AROMAS Y COLOR ROJO RUBI', t_infnutricional(230, 135), 'DULCE', v_temporada('INVIERNO', 'PASCUA'), 2, 5);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM WEIZEN', NULL, 5.5, NULL, NULL, to_date('15/12/2000','dd/mm/yyyy'), empty_blob(), 'FUERTE, DE LARGA TRADICION', t_infnutricional(190, 125), 'FUERTE', NULL, 2, 4);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM ALE', NULL, 5.5, NULL, NULL, to_date('18/03/1997','dd/mm/yyyy'), empty_blob(), 'SABOR CARAMELO AL FINAL DEL SORBO', t_infnutricional(100, 167), 'CARAMELO', NULL, 3, 7);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'LAGER', NULL, 5, NULL, NULL, to_date('19/07/1887','dd/mm/yyyy'), empty_blob(), 'REFRESCANTE Y SABOR FUERTE', t_infnutricional(100, 167), 'NORMAL', NULL, 3, 6);

rem / PRESENTACION /
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 33, 'BOTELLA', 'CL', 1, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 50, 'LATA', 'CL', 1, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 33, 'LATA', 'CL', 2, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 50, 'LATA', 'CL', 2, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 25, 'MONO BOTELLA', 'CL', 3, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 30, 'TUBO', 'CL', 4, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 50, 'LATA', 'CL', 4, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 30, 'BOTELLA', 'CL', 5, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 19.5, 'FUST', 'CL', 5, 2);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 25.4, 'LATA', 'ONZA', 7, 3);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 12, 'BOTELLA', 'ONZA', 7, 3);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 12, 'LATA', 'ONZA', 7, 3);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 25.4, 'LATA', 'ONZA', 6, 3);

rem / PRESENTACION_has_LUGAR /
INSERT INTO PRESENTACION_has_LUGAR VALUES (1, 1, 2, 8);
INSERT INTO PRESENTACION_has_LUGAR VALUES (2, 1, 2, 6);
INSERT INTO PRESENTACION_has_LUGAR VALUES (3, 2, 2, 6);
INSERT INTO PRESENTACION_has_LUGAR VALUES (4, 2, 2, 7);
INSERT INTO PRESENTACION_has_LUGAR VALUES (5, 3, 2, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (6, 4, 2, 11);
INSERT INTO PRESENTACION_has_LUGAR VALUES (7, 4, 2, 10);
INSERT INTO PRESENTACION_has_LUGAR VALUES (8, 5, 2, 10);
INSERT INTO PRESENTACION_has_LUGAR VALUES (9, 5, 2, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (1, 1, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (2, 1, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (3, 2, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (4, 2, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (5, 3, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (6, 4, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (7, 4, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (8, 5, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (9, 5, 2, 2);
INSERT INTO PRESENTACION_has_LUGAR VALUES (10, 7, 3, 6);
INSERT INTO PRESENTACION_has_LUGAR VALUES (11, 7, 3, 7);
INSERT INTO PRESENTACION_has_LUGAR VALUES (10, 7, 3, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (11, 7, 3, 27);
INSERT INTO PRESENTACION_has_LUGAR VALUES (11, 7, 3, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (12, 7, 3, 6);
INSERT INTO PRESENTACION_has_LUGAR VALUES (12, 7, 3, 25);
INSERT INTO PRESENTACION_has_LUGAR VALUES (12, 7, 3, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (13, 6, 3, 6);
INSERT INTO PRESENTACION_has_LUGAR VALUES (13, 6, 3, 7);
INSERT INTO PRESENTACION_has_LUGAR VALUES (13, 6, 3, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (13, 6, 3, 27);

rem / FABRICA /
INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, to_date('25/01/2004','dd/mm/yyyy'), 2, 3);
INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, to_date('12/09/2000','dd/mm/yyyy'), 2, 12);
INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, to_date('30/10/1999','dd/mm/yyyy'), 2, 13);
INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, to_date('03/05/1995','dd/mm/yyyy'), 2, 14);
INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, to_date('13/11/1983','dd/mm/yyyy'), 3, 28);
INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, to_date('12/09/2000','dd/mm/yyyy'), 3, 29);

rem / TOUR /
INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));
INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 12.50, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 1330, 1615, 1),t_horario('MARTES',1330, 1615, 1),t_horario('MIERCOLES', 1330, 1615, 1),t_horario('JUEVES', 1330, 1615, 1)), 165, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));
INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 1700, 1930, 1),t_horario('MARTES', 1700, 1930, 1),t_horario('MIERCOLES', 1700, 1930, 1),t_horario('JUEVES', 1700, 1930, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));
INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 15.00, nt_descuento(t_descuento(15, 50, 'ESTUDIANTE'),t_descuento(20, 150, 'ESTUDIANTE')), t_rangoedad(14,75), nt_horario(t_horario('LUNES', 1600, 1800, 1),t_horario('MARTES', 1600, 1800, 1),t_horario('MIERCOLES', 1600, 1800, 1),t_horario('JUEVES', 1600, 1800, 1)), 120, v_formapago('EFECTIVO','MASTERCARD','VISA','AMMERICAN EXPRESS'), nt_reqadq(t_reqad(90,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante','No se pueden consumir comida/bebidas dentro de la planta'));
INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 15.00, nt_descuento(t_descuento(15, 50, 'ESTUDIANTE'),t_descuento(20, 150, 'ESTUDIANTE')), t_rangoedad(14,75), nt_horario(t_horario('LUNES', 1400, 1600, 1),t_horario('MARTES', 1400, 1600, 1),t_horario('MIERCOLES', 1400, 1600, 1),t_horario('JUEVES', 1400, 1600, 1),t_horario('VIERNES', 1400, 1600, 1)), 120, v_formapago('EFECTIVO','MASTERCARD','VISA','AMMERICAN EXPRESS'), nt_reqadq(t_reqad(90,'DIA')), v_requisito('No traer animales','Si es menor de 18 venir acompanado de un representante'));

rem / FABRICA_has_TOUR /
INSERT INTO FABRICA_has_TOUR VALUES (1, 1, 2);
INSERT INTO FABRICA_has_TOUR VALUES (1, 2, 2);
INSERT INTO FABRICA_has_TOUR VALUES (1, 3, 2);
INSERT INTO FABRICA_has_TOUR VALUES (2, 2, 2);
INSERT INTO FABRICA_has_TOUR VALUES (5, 4, 3);
INSERT INTO FABRICA_has_TOUR VALUES (5, 5, 3);
INSERT INTO FABRICA_has_TOUR VALUES (6, 5, 3);

rem / BAR /
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'WERK', 'SPUI 30', 1016, t_telefono(020, 6274079, 'TRABAJO'), 15);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'DE KAS', 'KAMERLINGH ONNESLAAN 3', 1097, t_telefono(020, 4624562, 'TRABAJO'), 15);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'WILHELMINA DOK', 'NOORDWAL 1', 1021, t_telefono(020, 6323701, 'TRABAJO'), 15);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'BLENDER', 'PALMKADE 16', 1017, t_telefono(020, 6259232, 'TRABAJO'), 15);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'ALVERNA', 'BILDERDIJKSTRAAT 104/106', 1053, t_telefono(020, 6124455, 'TRABAJO'), 15);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'WANDI PUB', 'MORSES CREEK ROAD', 3744, t_telefono(610, 7551311, 'TRABAJO'), 28);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'MINK', '2B ACLAND ST', 3182, t_telefono(610, 5361199, 'TRABAJO'), 28);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'THE ELWOOD LOUNGE', '49-51 GLENHUNTLY ROAD', 3184, t_telefono(610, 5257688, 'TRABAJO'), 28);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'THE BENDED ELBOW GEELONG', '69 YARRA STREET', 3220, t_telefono(610, 2294477, 'TRABAJO'), 28);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'LIMEBURNERS', '5 - 15 HOTAM ROAD', 3943, t_telefono(610, 9842206 , 'TRABAJO'), 28);

rem / EVENTO /
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'NATIONAL FESTIVAL OF MUSIC 2007', 'FESTIVAL DE MUSICA NACIONAL 2007');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'NATIONAL FESTIVAL OF MUSIC 2008', 'FESTIVAL DE MUSICA NACIONAL 2008');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'EMA', 'PREMIACION DE MUSICA EUROPEA');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'AMSTERDAM FOOD STYLE', 'EVENTO DE COMPETENCIA DE COMIDAS');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'NATIONAL SKYDIVING 2006', 'COMPETENCIA EN EL 2006 DE SKYDIVING');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'NATIONAL HONEY FEST.', 'FESTVAL NACIONAL DE MIEL AUSTRALIANA');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'FESTIVAL OF REGGEA MUSIC 2008', 'FESTIVAL DE MUSICA REGGEA EN 2008');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'FESTIVAL OF REGGEA MUSIC 2009', 'FESTIVAL DE MUSICA REGGEA EN 2009');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'FOOD: ALL YOU CAN EAT!', 'FESTIVAL DE COMIDA TODO LO QUE PUEDAS COMER');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'FC AUSTRALIAN', 'APOYO A LA FEDERACION DE FUTBOL AUSTRALIANO');

rem / EMPRESA_has_EVENTO /
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 2, 1, 'FESTIVAL DE MUSICA NACIONAL 2007', to_date('24/07/2007','dd/mm/yyyy'), 15);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 2, 2, 'FESTIVAL DE MUSICA NACIONAL 2008', to_date('24/07/2008','dd/mm/yyyy'), 15);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 2, 3, 'PREMIACION DE MUSICA EUROPEA', to_date('22/11/2009','dd/mm/yyyy'), 24);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 2, 4, 'EVENTO DE COMPETENCIA DE COMIDAS', to_date('02/02/2000','dd/mm/yyyy'), 15);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 2, 5, 'COMPETENCIA DE SKYDIVING', to_date('15/09/2006','dd/mm/yyyy'), 28);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 3, 6, 'FESTVAL NACIONAL', to_date('07/07/2007','dd/mm/yyyy'), 29);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 3, 7, 'FESTIVAL DE MUSICA REGGEA', to_date('25/09/2008','dd/mm/yyyy'), 28);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 3, 8, 'FESTIVAL DE MUSICA REGGEA', to_date('25/09/2009','dd/mm/yyyy'), 28);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 3, 9, 'FESTIVAL DE COMIDA', to_date('12/02/2009','dd/mm/yyyy'), 29);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 3, 10, 'FEDERACION DE FUTBOL AUSTRALIANO', to_date('26/04/2007','dd/mm/yyyy'), 29);

rem / GRUPO_TOUR /
INSERT INTO GRUPO_TOUR VALUES (S_GRUPO_TOUR.NEXTVAL, 'ESTUDIANTES DE INGENIERIA DE PRODUCCION', 10, 1, 1, 2);  
INSERT INTO GRUPO_TOUR VALUES (S_GRUPO_TOUR.NEXTVAL, 'ESTUDIANTES DE AMSTERDAM SCHOOL', 200, 1, 2, 2);  
INSERT INTO GRUPO_TOUR VALUES (S_GRUPO_TOUR.NEXTVAL, 'ESTUDIANTES DE SYDNEY HIGH SCHOOL', 300, 5, 4, 3);  

rem / ENTRADA /
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('02/02/2007','dd/mm/yyyy'), 0900, 'ADULTO', 100.00, 'MASTERCARD', 1, 1, 2, 1, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('02/02/2008','dd/mm/yyyy'), 1000, 'ADULTO', 12.50, 'VISA', 1, 2, 2, NULL, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('02/02/2008','dd/mm/yyyy'), 1000, 'ADULTO', 12.50, 'VISA', 1, 2, 2, NULL, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('13/11/2007','dd/mm/yyyy'), 1300, 'ADULTO', 10.00, 'EFECTIVO', 1, 3, 2, NULL, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('02/02/2008','dd/mm/yyyy'), 1000, 'MENOR', 12.50, 'VISA', 1, 2, 2, NULL, 2);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('01/02/2009','dd/mm/yyyy'), 0830, 'ADULTO', 2250.00, 'MASTERCARD', 1, 2, 2, 2, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('15/11/2002','dd/mm/yyyy'), 1100, 'ADULTO', 3600.00, 'VISA', 5, 4, 3, 3, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('13/06/2009','dd/mm/yyyy'), 1145, 'ADULTO', 15.00, 'AMMERICAN EXPRESS', 5, 5, 3, NULL, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('13/06/2009','dd/mm/yyyy'), 1146, 'MENOR', 15.00, 'AMMERICAN EXPRESS', 5, 5, 3, NULL, 8);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('13/06/2009','dd/mm/yyyy'), 1147, 'MENOR', 15.00, 'AMMERICAN EXPRESS', 5, 5, 3, NULL, 8);

rem / PROVEEDOR /
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, 8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', v_telefono(t_telefono(370, 8541256,'CASA')))), 21);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'AGRO HAVLAT S.R.O', t_paginaweb('WWW.AGRO-HAVLAT.CZ','NACIONAL'), '59451 KRIZANOV', nt_telefonos(t_telefono(420, 6521014, 'OFICINA'),t_telefono(420, 6521016, 'FAX')), nt_contacto(t_contacto('ALZBETA','BEDRICH', 'DIRECTOR', v_telefono(t_telefono(420, 9854210,'CELULAR')))), 19);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'CASCARANO VINCENZO AND C. SAS', t_paginaweb('WWW.CASCARANO.IT','NACIONAL'), 'LOSETO 70010 VALENZANO', nt_telefonos(t_telefono(390, 8046750 , 'OFICINA'),t_telefono(390, 6721787, 'FAX')), nt_contacto(t_contacto('TOMASO','GREC', 'DIRECTOR', v_telefono(t_telefono(390, 6778945,'CELULAR')))), 20);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'HYDREL SYSTEM', t_paginaweb('WWW.HYDREL.ES','NACIONAL'), 'TRAVERSA TORRELLES', nt_telefonos(t_telefono(349, 6562797, 'OFICINA'),t_telefono(349, 6769825, 'FAX')), nt_contacto(t_contacto('LUIS','GARCIA', 'GERENTE', v_telefono(t_telefono(349, 3245987,'CELULAR')))), 23);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'PARISE COMPRESSORI SRL', t_paginaweb('WWW.PARISE.IT','NACIONAL'), 'FILZI FABIO 36051 CREAZZO', nt_telefonos(t_telefono(390, 4520472, 'OFICINA'),t_telefono(390, 4523436, 'FAX')), nt_contacto(t_contacto('FABIO','ABRIZZO', 'GERENTE', v_telefono(t_telefono(390, 7856231,'CELULAR')))), 20);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'AMAFILTERGROUP', t_paginaweb('WWW.AMAFILTERGROUP.COM','INTERNACIONAL'), '18 RUE DE LESTEREL', nt_telefonos(t_telefono(331, 5120530, 'OFICINA'),t_telefono(331, 6875868, 'FAX')), nt_contacto(t_contacto('JEAN','PAUX', 'DIRECTOR', v_telefono(t_telefono(331, 7463251,'CELULAR')))), 24);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'ATAGUIA, S.A.', t_paginaweb('WWW.ATAGUIA.ES','NACIONAL'), '21 - POL. IND. ALCOBENDAS', nt_telefonos(t_telefono(349, 6613727, 'OFICINA'),t_telefono(349, 6614289, 'FAX')), nt_contacto(t_contacto('MAURICIO','COLMENARES', 'DIRECTOR', v_telefono(t_telefono(349, 2684951,'CELULAR')))), 23);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'TOURNAIRE', t_paginaweb('WWW.TOURNAIRE.FR','NACIONAL'), 'ROUTE DE LA PAOUTE', nt_telefonos(t_telefono(334, 3093434, 'OFICINA'),t_telefono(334, 3093400, 'FAX')), nt_contacto(t_contacto('PETTIT','COUATEX', 'GERENTE', v_telefono(t_telefono(334, 2415362,'CELULAR')))), 24);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'VIKING MALT OY', t_paginaweb('WWW.VIKINGMALT.COM','INTERNACIONAL'), 'NIEMENKATU 18 PL', nt_telefonos(t_telefono(358, 386415, 'OFICINA')), nt_contacto(t_contacto('FRANK','OY', 'GERENTE', v_telefono(t_telefono(358, 8524697,'CELULAR')))), 31);
INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'PRAMODAN AND DINESH OHG', t_paginaweb('WWW.INDUSAL.EU','INTERNACIONAL'), 'DUSTERSTRAE', nt_telefonos(t_telefono(492, 9598755, 'OFICINA'),t_telefono(492, 9598756, 'FAX')), nt_contacto(t_contacto('FURER','DUSTRE', 'GERENTE', v_telefono(t_telefono(492, 9874561,'CELULAR')))), 32);

rem / EQUIPO /
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'OLLA', 'SIRVE PARA COCINAR, MEZCLAR, FERMENTAR Y FILTRAR MEZCLAS');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'CALDERO', 'GENERAN VAPOR NECESARIO PARA LAS COCINAS');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'MOTOR', 'SIRVEN PARA EL MOVIMIENTO DE BANDAS TRANSPORTADORAS');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'MOTOR DIESEL', 'SIRVEN PARA EL MOVIMIENTO DE BANDAS TRANSPORTADORAS, CON AHORRO DE ENERGIA');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'COMPRESOR', 'SIRVE PARA COMPRIMIR EL AIRE QUE SE INYECTA EN LA FERMENTACION');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'BOMBA', 'SIRVE PARA TRANSPORTAR DIFERENTES FLUIDOS');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'VENTILADOR', 'SIRVE PARA LA EXTRACCION DEL POLVO');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'BANDA', 'SIRVE PARA TRANSPORTAR DIFERENTES MATERIALES');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'ELEVADOR', 'SIRVE PARA TRANSPORTAR DIFERENTES MATERIALES EN FORMA VERTICAL');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'MONTACARGAS', 'SIRVE PARA TRANSPORTAR MATERIALES MAS COMUNES');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'MOLINOS', 'SIRVE PARA TRITURAR LA MALTA');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'HORNO', 'SIRVE PARA PASTEURIZAR MEZCLAS');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'LLENADORA', 'SIRVE PARA ENVASAR');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'FILTRO', 'SIRVE PARA SEPARAR DOS MATERIALES');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'TANQUE CONTRPRESION', 'SIRVE PARA MANTENER EL GAS DE LA CERVEZA');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'TANQUE', 'SIRVE PARA ALMACENAR FLUIDOS');
INSERT INTO EQUIPO VALUES (S_EQUIPO.NEXTVAL, 'CENTRIFUGAS', 'SIRVE PARA ELIMINAR 99% DE LA LEVADURA PRESENTE EN LA MEZCLA');

rem / CATALOGO_EQUIPO /
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AISI 304-2B', 'OLLA DE COCCION ACERO INOX.', empty_blob(), 'ACERO INOXIDABLE', 4, 1);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AISI 305-2B', 'OLLA MASHING ACERO INOX.', empty_blob(), 'ACERO INOXIDABLE', 4, 1);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AISI 140-2C', 'CALDERO ACERO INOX.',empty_blob() , 'ACERO INOXIDABLE', 4, 2);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AISI 142-2C', 'CALDERO CON CONTROL AUTOMATICO', empty_blob(), 'ACERO INOXIDABLE', 4, 2);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'SI 1740-R2C', 'TANQUE MADURADOR', empty_blob(), 'ACERO INOXIDABLE Y CONTROL DE TEMPERATURA', 4, 16);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ISI 1840-V2Y', 'FILTRO PRENSA',empty_blob() , '40X40 DE 16 PLACAS', 4, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AI40-2C', 'FILTRO PRENSA', empty_blob(), '20X20 DE 8 PLACAS', 4, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AI-UB 140-2C', 'CENTRIFUGA', empty_blob(), 'ACERO INOXIDABLE Y MASHING 99.99%', 4, 17);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'QWR 845-UI2', 'LLENADORA CIRCULAR', empty_blob(), 'ISOBARICA DE 12 VALVULAS', 5, 13);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'QWR 135-VH5', 'LLENADORA EN SERIE', empty_blob(), '6 VALVULAS', 5, 13);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'HOR PO41-78', 'HORNO PLEX',empty_blob() , 'TEMP. MAX. 999 CENTIGRADO', 5, 12);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'CNG 54K-12I', 'HORNO FLOT', empty_blob(), 'TEMP. MAX. 2000 CENTIGRADO', 5, 12);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AI 1B40-26C', 'FILTRO PRENSA', empty_blob(), '40X40 DE 16 PLACAS', 5, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AI 1940-2M5', 'FILTRO GAUSS', empty_blob(), 'DOSIFICADOR CON BOMBA INSTALADA', 5, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ARDI 1B-2N6C', 'OLLA LAUTHER', empty_blob(), 'ACERO INOXIDABLE', 5, 1);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'XFDI AZ-8NXF', 'OLLA DE COCCION ACERO INOX.',empty_blob() , 'ACERO INOXIDABLE', 5, 1);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'LKJ 75-VYN35', 'BANDA BUILDER 3', empty_blob(), '300 MT LONGUITUD', 6, 8);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'COR 845-DOK', 'COMPRESOR CON UHP', empty_blob(), '7 HP', 6, 5);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, '15CT-MBPPF-N', 'MOTOR CARLENNI', empty_blob(), '1.2 HP', 6, 3);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'C897V UGC-57', 'BOMBA DE INYEC.',empty_blob() , 'INYECCION DIRECTA A LA MEZCLA', 6, 6);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'VRY 421-OK60', 'VENTILADOR 300', empty_blob(), 'SUCCIONADOR 300 CON 91% EFC.', 6, 7);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'COR 153-DOL', 'COMPRESOR QWERTY',empty_blob() , '12 HP', 6, 5);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ERT BHJV-M', 'FILTRO GAUSS', empty_blob(), 'DOSIFICADOR CON BOMBA INSTALADA', 6, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'FG 511VY-CG', 'HORNO PLEX', empty_blob(), 'TEMP. MAX. 999 CENTIGRADO', 6, 12);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ASD 852-2Q', 'OLLA DE COCCION ACERO INOX.', empty_blob(), 'ACERO INOXIDABLE', 7, 1);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ASD 3456-2D', 'OLLA MASHING ACERO INOX.',empty_blob() , 'ACERO INOXIDABLE', 7, 1);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ASD 123-2G', 'CALDERO ACERO INOX.', empty_blob(), 'ACERO INOXIDABLE', 7, 2);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ASD 845-2U', 'CALDERO CON CONTROL AUTOMATICO',empty_blob() , 'ACERO INOXIDABLE', 7, 2);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'SI1 3215-RC', 'TANQUE MADURADOR', empty_blob(), 'ACERO INOXIDABLE Y CONTROL DE TEMPERATURA', 7, 16);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'IS 183-B5S', 'FILTRO PRENSA', empty_blob(), '40X40 DE 16 PLACAS', 7, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'S54D-C2', 'FILTRO PRENSA', empty_blob(), '20X20 DE 8 PLACAS', 7, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'A2D5 5D5W', 'CENTRIFUGA', empty_blob(), 'ACERO INOXIDABLE Y MASHING 99.99%', 7, 17);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'BGH 963-BET', 'LLENADORA CIRCULAR', empty_blob(), 'ISOBARICA DE 12 VALVULAS', 8, 13);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'BGH 741-DVD', 'LLENADORA EN SERIE', empty_blob(), '6 VALVULAS', 8, 13);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'HOR 987-A1', 'HORNO PLEX',empty_blob() , 'TEMP. MAX. 999 CENTIGRADO', 8, 12);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ROH 70K-1IW', 'HORNO FLOT', empty_blob(), 'TEMP. MAX. 2000 CENTIGRADO', 8, 12);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'FIL 1B4-S75', 'FILTRO PRENSA', empty_blob(), '40X40 DE 16 PLACAS', 8, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'FIL 190-36C', 'FILTRO GAUSS', empty_blob(), 'DOSIFICADOR CON BOMBA INSTALADA', 8, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ALLO 69-12DW', 'OLLA LAUTHER',empty_blob() , 'ACERO INOXIDABLE', 8, 1);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ALLO 78-1Q23', 'OLLA DE COCCION ACERO INOX.',empty_blob() , 'ACERO INOXIDABLE', 8, 1);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'AN 59-A5N4D', 'BANDA BUILDER 3', empty_blob(), '300 MT LONGUITUD', 7, 8);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'MOC 852-KOD', 'COMPRESOR CON UHP', empty_blob(), '7 HP', 8, 5);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, '1SDN-1D5W4-N', 'MOTOR CARLENNI', empty_blob(), '1.2 HP', 7, 3);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ANID 941-57', 'BOMBA DE INYEC.', empty_blob(), 'INYECCION DIRECTA A LA MEZCLA', 8, 6);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'YRV 325-A21D', 'VENTILADOR 300', empty_blob(), 'SUCCIONADOR 300 CON 91% EFC.', 7, 7);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'MOC 365-LOD', 'COMPRESOR QWERTY',empty_blob() , '12 HP', 8, 5);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'LIF 1D5S-26', 'FILTRO GAUSS', empty_blob(), 'DOSIFICADOR CON BOMBA INSTALADA', 7, 14);
INSERT INTO CATALOGO_EQUIPOS VALUES (S_CATALOGO_EQUIPO.NEXTVAL, 'ROM SD15-W5', 'HORNO PLEX', empty_blob(), 'TEMP. MAX. 999 CENTIGRADO', 8, 12);

rem / MATERIA_PRIMA /
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'PILSNER', 'LIGERO, CUERPO A LA CERVEZA', 'MALTA', nt_presentacion(t_presentacion(50,'KILOGRAMO','BOLSA'),t_presentacion(100,'TONELADA','CONTENEDOR')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'PELE', 'DORADO, CUERPO A LA CERVEZA', 'MALTA', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA'),t_presentacion(20,'KILOGRAMO','BOLSA'),t_presentacion(100,'TONELADA','CONTENEDOR')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'MARRON', 'CUERPO MARRON A LA CERVEZA', 'MALTA', nt_presentacion(t_presentacion(10,'KILOGRAMO','BOLSA'),t_presentacion(30,'KILOGRAMO','BOLSA')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'MILD PALE', 'DORADO SUAVE, CUERPO A LA CERVEZA', 'MALTA', nt_presentacion(t_presentacion(150,'TONELADA','CONTENEDOR')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'CRYSTAL', 'NO-ENZIMATICO', 'MALTA', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA'),t_presentacion(25,'KILOGRAMO','BOLSA'),t_presentacion(50,'KILOGRAMO','BOLSA')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'HALLERTAU', 'ACIDO DE 3.5%', 'LUPULO', nt_presentacion(t_presentacion(1,'KILOGRAMO','BOLSA'),t_presentacion(20,'KILOGRAMO','CAJA')), empty_blob(), nt_fdist(t_formadist('SECO','VIENE EN TABLETAS'),t_formadist('NATURAL','RECIEN RECOGIDO DE LA PLANTACION')));
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'SPALT', 'ACIDO DE 4-5%', 'LUPULO', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA'),t_presentacion(10,'KILOGRAMO','CAJA')), empty_blob(), nt_fdist(t_formadist('SECO','VIENE EN TABLETAS'),t_formadist('REHIDRATADO','VIENE EN TABLETAS PARA REHIDRATAR')));
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'TETTNANG', 'ACIDO DE 5.5%', 'LUPULO', nt_presentacion(t_presentacion(10,'KILOGRAMO','BOLSA')), empty_blob(), nt_fdist(t_formadist('NATURAL','RECIEN RECOGIDO DE LA PLANTACION')));
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'SAAZ', 'ACIDO DE 3%', 'LUPULO', nt_presentacion(t_presentacion(50,'KILOGRAMO','CAJA')), empty_blob(), nt_fdist(t_formadist('SECO','VIENE EN TABLETAS'),t_formadist('REHIDRATADO','VIENE EN TABLETAS PARA REHIDRATAR'),t_formadist('NATURAL','RECIEN RECOGIDO DE LA PLANTACION')));
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'SORGO', 'CARENTE DE GLUTEN', 'ADJUNTO', nt_presentacion(t_presentacion(20,'KILOGRAMO','BOLSA'),t_presentacion(200,'TONELADA','CONTENEDOR')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'CENTENO', 'CARENTE DE GLUTEN, BAJO DE COLOR', 'ADJUNTO', nt_presentacion(t_presentacion(100,'TONELADA','CONTENEDOR')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'ARROZ', 'DESGANTE, SABORIZADOR', 'ADJUNTO', nt_presentacion(t_presentacion(20,'KILOGRAMO','BOLSA')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'CEBADA', 'COLORIZANTE', 'ADJUNTO', nt_presentacion(t_presentacion(30,'KILOGRAMO','BOLSA'),t_presentacion(100,'TONELADA','CONTENEDOR')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'MAIZ', 'CARENTE DE GLUTEN, COLORIZANTE', 'ADJUNTO', nt_presentacion(t_presentacion(100,'TONELADA','CONTENEDOR'),t_presentacion(200,'TONELADA','CONTENEDOR')), empty_blob(), NULL);
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'UREDINOMYCETES', 'EVOLUCION FLOTANTE', 'LEVADURA', nt_presentacion(t_presentacion(1,'KILOGRAMO','EMPAQUE'),t_presentacion(5,'KILOGRAMO','EMPAQUE')), empty_blob(), nt_fdist(t_formadist('CULTIVO LIQUIDO','DILUIDAS')));
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'BASIDIOMYCALO', 'EVOLUCION FLOTANTE', 'LEVADURA', nt_presentacion(t_presentacion(1,'KILOGRAMO','EMPAQUE'),t_presentacion(0.5,'KILOGRAMO','EMPAQUE')), empty_blob(), nt_fdist(t_formadist('CULTIVO LIQUIDO','DILUIDAS')));
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'TAPHRINOMYCOTINA', 'EVOLUCION FONDO', 'LEVADURA', nt_presentacion(t_presentacion(0.5,'KILOGRAMO','EMPAQUE'),t_presentacion(1.5,'KILOGRAMO','EMPAQUE')), empty_blob(), nt_fdist(t_formadist('CULTIVO LIOFILIZADO','TABLETAS O POLVO')));
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'SPORIDIALES', 'EVOLUCION FONDO', 'LEVADURA', nt_presentacion(t_presentacion(0.5,'KILOGRAMO','EMPAQUE')), empty_blob(), nt_fdist(t_formadist('CULTIVO LIQUIDO','DILUIDAS'),t_formadist('CULTIVO LIOFILIZADO','TABLETAS O POLVO')));
INSERT INTO MATERIA_PRIMA VALUES (S_MATERIA_PRIMA.NEXTVAL, 'SACHAROMYCETALES', 'EVOLUCION FLOTANTE', 'LEVADURA', nt_presentacion(t_presentacion(0.90,'KILOGRAMO','EMPAQUE'),t_presentacion(1.55,'KILOGRAMO','EMPAQUE')), empty_blob(), nt_fdist(t_formadist('CULTIVO LIQUIDO','DILUIDAS'),t_formadist('CULTIVO LIOFILIZADO','TABLETAS O POLVO')));
rem / VARIEDAD /
INSERT INTO VARIEDAD VALUES (S_VARIEDAD.NEXTVAL, 'PILSNER', 'BASE', 100, t_color(3,4), 1);
INSERT INTO VARIEDAD VALUES (S_VARIEDAD.NEXTVAL, 'PALE', 'BASE', 100, t_color(5,8), 2);
INSERT INTO VARIEDAD VALUES (S_VARIEDAD.NEXTVAL, 'MARRON', 'COLOREADA', 15, t_color(950,1200), 3);
INSERT INTO VARIEDAD VALUES (S_VARIEDAD.NEXTVAL, 'MILD PALE', 'BASE', 60, t_color(6,9), 4);
INSERT INTO VARIEDAD VALUES (S_VARIEDAD.NEXTVAL, 'CRYSTAL', 'COLOREADA', 20, t_color(90,320), 5);

rem / VARIEDAD_has_LUGAR /
INSERT INTO VARIEDAD_has_LUGAR VALUES (1,1,2);
INSERT INTO VARIEDAD_has_LUGAR VALUES (1,1,26);
INSERT INTO VARIEDAD_has_LUGAR VALUES (2,2,2);
INSERT INTO VARIEDAD_has_LUGAR VALUES (2,2,27);
INSERT INTO VARIEDAD_has_LUGAR VALUES (3,3,27);
INSERT INTO VARIEDAD_has_LUGAR VALUES (3,3,17);
INSERT INTO VARIEDAD_has_LUGAR VALUES (4,4,25);
INSERT INTO VARIEDAD_has_LUGAR VALUES (4,4,27);
INSERT INTO VARIEDAD_has_LUGAR VALUES (5,5,26);
INSERT INTO VARIEDAD_has_LUGAR VALUES (5,5,25);
INSERT INTO VARIEDAD_has_LUGAR VALUES (3,3,28);

rem / PROCESO /
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'COCIMIENTO', 'ETAPA', NULL, NULL);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'FERMENTACION', 'ETAPA', NULL, NULL);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'ENVASADO', 'ETAPA', NULL, NULL);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'FILTRACION GRANO', 'SUB-PROCESO', t_regla('FILTRADO', 100, 60, 40, 'DENSIDAD'), 1);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'COCCION MOSTO', 'SUB-PROCESO', t_regla('COCCION', 20, 459, NULL, 'CENTIGRADO'), 1);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'INYECCION LEVADURA', 'PASO ACTIVIDAD', t_regla('INYECCION',0,56,24,'MILIBAR'), 1);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'FERMENTACION PRIP', 'SUB-PROCESO', t_regla('FERMENTACION',NULL,4.6,NULL,'ACIDEZ'), 2);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'FILTRACION REDUCTORA', 'SUB-PROCESO', t_regla('FILTRADO', 100, 20, 80, 'DENSIDAD'), 2);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'CARBONATACION', 'PASO ACTIVIDAD', t_regla('CARBONATACION', 0, 20,NULL,'MILIBAR'), 2);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'LLENADO', 'SUB-PROCESO', t_regla('LLENADO',NULL,2000000,60,NULL), 3);
INSERT INTO PROCESO VALUES (S_PROCESO.NEXTVAL, 'ETIQUETADO', 'SUB-PROCESO', t_regla('ETIQUETADO',NULL,2000000,NULL,NULL), 3);

rem / EQUIPO_has_PROCESO /
INSERT INTO EQUIPO_has_PROCESO VALUES (14,4);
INSERT INTO EQUIPO_has_PROCESO VALUES (12,5);
INSERT INTO EQUIPO_has_PROCESO VALUES (5,6);
INSERT INTO EQUIPO_has_PROCESO VALUES (16,7);
INSERT INTO EQUIPO_has_PROCESO VALUES (14,8);
INSERT INTO EQUIPO_has_PROCESO VALUES (15,9);
INSERT INTO EQUIPO_has_PROCESO VALUES (13,10);
INSERT INTO EQUIPO_has_PROCESO VALUES (10,4);

rem / MATERIA_has_PROCESO /
INSERT INTO MATERIA_PRIMA_has_PROCESO VALUES (18,7);
INSERT INTO MATERIA_PRIMA_has_PROCESO VALUES (1,4);
INSERT INTO MATERIA_PRIMA_has_PROCESO VALUES (6,4);
INSERT INTO MATERIA_PRIMA_has_PROCESO VALUES (16,5);
INSERT INTO MATERIA_PRIMA_has_PROCESO VALUES (10,3);

rem / CATALOGO_MATERIA /
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA FRESAC DEL CAMPO', nt_presentacion(t_presentacion(50,'KILOGRAMO','BOLSA'),t_presentacion(100,'TONELADA','CONTENEDOR')), 1, 1, NULL, 3);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA FRESAC DEL CAMPO', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA')), 2, 2, NULL, 3);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA POSA', nt_presentacion(t_presentacion(10,'KILOGRAMO','BOLSA'),t_presentacion(30,'KILOGRAMO','BOLSA')), 3, 3, NULL, 3);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA REMBRING', nt_presentacion(t_presentacion(150,'TONELADA','CONTENEDOR')), 4, 4, NULL, 3);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA QWERTY', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA'),t_presentacion(25,'KILOGRAMO','BOLSA')), 5, 5, NULL, 3);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA FRESAC DEL CAMPO', nt_presentacion(t_presentacion(100,'TONELADA','CONTENEDOR')), 1, 1, NULL, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO MAX', nt_presentacion(t_presentacion(1,'KILOGRAMO','BOLSA')), NULL, NULL, 6, 2);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO TREX', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA'),t_presentacion(10,'KILOGRAMO','CAJA')), NULL, NULL, 7, 2);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO MAX', nt_presentacion(t_presentacion(10,'KILOGRAMO','BOLSA')), NULL, NULL, 8, 2);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO FLEX', nt_presentacion(t_presentacion(50,'KILOGRAMO','CAJA')), NULL, NULL, 9, 2);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO TYUI', nt_presentacion(t_presentacion(1,'KILOGRAMO','BOLSA'),t_presentacion(20,'KILOGRAMO','CAJA')), NULL, NULL, 6, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO CEREALX', nt_presentacion(t_presentacion(20,'KILOGRAMO','BOLSA')), NULL, NULL, 10, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO CERELAC', nt_presentacion(t_presentacion(100,'TONELADA','CONTENEDOR')), NULL, NULL, 11, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO TREWQ', nt_presentacion(t_presentacion(20,'KILOGRAMO','BOLSA')), NULL, NULL, 12, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO MNBX', nt_presentacion(t_presentacion(30,'KILOGRAMO','BOLSA'),t_presentacion(100,'TONELADA','CONTENEDOR')), NULL, NULL, 13, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO POIUY', nt_presentacion(t_presentacion(100,'TONELADA','CONTENEDOR'),t_presentacion(200,'TONELADA','CONTENEDOR')), NULL, NULL, 14, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO LCRTD', nt_presentacion(t_presentacion(20,'KILOGRAMO','BOLSA'),t_presentacion(200,'TONELADA','CONTENEDOR')), NULL, NULL, 10, 3);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA APPPLE', nt_presentacion(t_presentacion(1,'KILOGRAMO','EMPAQUE')), NULL, NULL, 15, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA VOUITT', nt_presentacion(t_presentacion(1,'KILOGRAMO','EMPAQUE'),t_presentacion(0.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 16, 2);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA BAYYER', nt_presentacion(t_presentacion(0.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 17, 2);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA SILDER', nt_presentacion(t_presentacion(0.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 18, 3);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA REXOM', nt_presentacion(t_presentacion(0.90,'KILOGRAMO','EMPAQUE'),t_presentacion(1.55,'KILOGRAMO','EMPAQUE')), NULL, NULL, 19, 2);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA NUTELLA', nt_presentacion(t_presentacion(0.5,'KILOGRAMO','EMPAQUE'),t_presentacion(1.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 17, 3);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA KODDAK', nt_presentacion(t_presentacion(1.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 17, 1);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA FRESAC DEL CAMPO', nt_presentacion(t_presentacion(50,'KILOGRAMO','BOLSA'),t_presentacion(100,'TONELADA','CONTENEDOR')), 1, 1, NULL, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA FRESAC DEL CAMPO', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA')), 2, 2, NULL, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA POSA', nt_presentacion(t_presentacion(10,'KILOGRAMO','BOLSA'),t_presentacion(30,'KILOGRAMO','BOLSA')), 3, 3, NULL, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA REMBRING', nt_presentacion(t_presentacion(150,'TONELADA','CONTENEDOR')), 4, 4, NULL, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA QWERTY', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA'),t_presentacion(25,'KILOGRAMO','BOLSA')), 5, 5, NULL, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'MALTA FRESAC DEL CAMPO', nt_presentacion(t_presentacion(100,'TONELADA','CONTENEDOR')), 1, 1, NULL, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO MAX', nt_presentacion(t_presentacion(1,'KILOGRAMO','BOLSA')), NULL, NULL, 6, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO TREX', nt_presentacion(t_presentacion(5,'KILOGRAMO','BOLSA'),t_presentacion(10,'KILOGRAMO','CAJA')), NULL, NULL, 7, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO MAX', nt_presentacion(t_presentacion(10,'KILOGRAMO','BOLSA')), NULL, NULL, 8, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO FLEX', nt_presentacion(t_presentacion(50,'KILOGRAMO','CAJA')), NULL, NULL, 9, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LUPULO TYUI', nt_presentacion(t_presentacion(1,'KILOGRAMO','BOLSA'),t_presentacion(20,'KILOGRAMO','CAJA')), NULL, NULL, 6, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO CEREALX', nt_presentacion(t_presentacion(20,'KILOGRAMO','BOLSA')), NULL, NULL, 10, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO CERELAC', nt_presentacion(t_presentacion(100,'TONELADA','CONTENEDOR')), NULL, NULL, 11, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO TREWQ', nt_presentacion(t_presentacion(20,'KILOGRAMO','BOLSA')), NULL, NULL, 12, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO MNBX', nt_presentacion(t_presentacion(30,'KILOGRAMO','BOLSA'),t_presentacion(100,'TONELADA','CONTENEDOR')), NULL, NULL, 13, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO POIUY', nt_presentacion(t_presentacion(100,'TONELADA','CONTENEDOR'),t_presentacion(200,'TONELADA','CONTENEDOR')), NULL, NULL, 14, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'ADJUNTO LCRTD', nt_presentacion(t_presentacion(20,'KILOGRAMO','BOLSA'),t_presentacion(200,'TONELADA','CONTENEDOR')), NULL, NULL, 10, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA APPPLE', nt_presentacion(t_presentacion(1,'KILOGRAMO','EMPAQUE')), NULL, NULL, 15, 10);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA VOUITT', nt_presentacion(t_presentacion(1,'KILOGRAMO','EMPAQUE'),t_presentacion(0.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 16, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA SILDER', nt_presentacion(t_presentacion(0.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 18, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA REXOM', nt_presentacion(t_presentacion(0.90,'KILOGRAMO','EMPAQUE'),t_presentacion(1.55,'KILOGRAMO','EMPAQUE')), NULL, NULL, 19, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA NUTELLA', nt_presentacion(t_presentacion(0.5,'KILOGRAMO','EMPAQUE'),t_presentacion(1.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 17, 9);
INSERT INTO CATALOGO_MATERIA VALUES (S_CATALOGO_MATERIA.NEXTVAL, 'LEVADURA KODDAK', nt_presentacion(t_presentacion(1.5,'KILOGRAMO','EMPAQUE')), NULL, NULL, 17, 10);

rem / PEDIDO /
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('16/09/2000','dd/mm/yyyy'), to_date('16/11/2000','dd/mm/yyyy'), to_date('16/11/2000','dd/mm/yyyy'), 1,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('24/03/2001','dd/mm/yyyy'), to_date('24/07/2001','dd/mm/yyyy'), to_date('24/07/2001','dd/mm/yyyy'), 1,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('28/07/2000','dd/mm/yyyy'), to_date('28/10/2000','dd/mm/yyyy'), to_date('16/12/2000','dd/mm/yyyy'), 2,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('19/12/2002','dd/mm/yyyy'), to_date('19/02/2003','dd/mm/yyyy'), to_date('19/03/2003','dd/mm/yyyy'), 2,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2000','dd/mm/yyyy'), to_date('15/03/2000','dd/mm/yyyy'), to_date('15/03/2000','dd/mm/yyyy'), 3,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2004','dd/mm/yyyy'), to_date('15/03/2004','dd/mm/yyyy'), to_date('15/03/2004','dd/mm/yyyy'), 3,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2005','dd/mm/yyyy'), to_date('15/03/2005','dd/mm/yyyy'), to_date('15/03/2005','dd/mm/yyyy'), 3,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/12/2009','dd/mm/yyyy'), to_date('15/02/2010','dd/mm/yyyy'), NULL, 3,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('20/11/2009','dd/mm/yyyy'), to_date('20/04/2010','dd/mm/yyyy'), NULL, 2,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('01/01/2000','dd/mm/yyyy'), to_date('01/02/2000','dd/mm/yyyy'), to_date('01/02/2000','dd/mm/yyyy'), 4,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2001','dd/mm/yyyy'), to_date('15/02/2001','dd/mm/yyyy'), to_date('15/02/2001','dd/mm/yyyy'), 4,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2002','dd/mm/yyyy'), to_date('15/03/2002','dd/mm/yyyy'), to_date('15/03/2002','dd/mm/yyyy'), 4,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('30/01/2002','dd/mm/yyyy'), to_date('30/05/2002','dd/mm/yyyy'), to_date('15/07/2002','dd/mm/yyyy'), 5,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('19/12/2002','dd/mm/yyyy'), to_date('19/02/2003','dd/mm/yyyy'), to_date('15/05/2003','dd/mm/yyyy'), 5,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2003','dd/mm/yyyy'), to_date('15/03/2003','dd/mm/yyyy'), to_date('15/03/2003','dd/mm/yyyy'), 6,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2004','dd/mm/yyyy'), to_date('15/03/2004','dd/mm/yyyy'), to_date('15/03/2004','dd/mm/yyyy'), 6,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/12/2009','dd/mm/yyyy'), to_date('15/03/2010','dd/mm/yyyy'), NULL, 6,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('01/11/2009','dd/mm/yyyy'), to_date('01/05/2010','dd/mm/yyyy'), NULL, 4,2);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('20/02/2004','dd/mm/yyyy'), to_date('20/04/2004','dd/mm/yyyy'), to_date('20/04/2004','dd/mm/yyyy'), 9,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2007','dd/mm/yyyy'), to_date('15/03/2007','dd/mm/yyyy'), to_date('15/03/2007','dd/mm/yyyy'), 9,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('05/05/2008','dd/mm/yyyy'), to_date('05/05/2008','dd/mm/yyyy'), to_date('05/05/2008','dd/mm/yyyy'), 9,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('10/12/2009','dd/mm/yyyy'), to_date('10/03/2010','dd/mm/yyyy'), NULL, 9,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2004','dd/mm/yyyy'), to_date('15/03/2004','dd/mm/yyyy'), to_date('15/03/2004','dd/mm/yyyy'), 10,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2006','dd/mm/yyyy'), to_date('15/03/2006','dd/mm/yyyy'), to_date('21/08/2006','dd/mm/yyyy'), 10,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('01/11/2009','dd/mm/yyyy'), to_date('01/04/2010','dd/mm/yyyy'), NULL, 10,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('02/02/2000','dd/mm/yyyy'), to_date('02/03/2000','dd/mm/yyyy'), to_date('02/03/2000','dd/mm/yyyy'), 7,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('02/01/2001','dd/mm/yyyy'), to_date('02/01/2001','dd/mm/yyyy'), to_date('02/01/2001','dd/mm/yyyy'), 7,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/03/2002','dd/mm/yyyy'), to_date('15/04/2002','dd/mm/yyyy'), NULL, 7,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/05/2000','dd/mm/yyyy'), to_date('15/06/2000','dd/mm/yyyy'), to_date('30/07/2000','dd/mm/yyyy'), 8,3);
INSERT INTO PEDIDO VALUES (S_PEDIDO.NEXTVAL, to_date('15/01/2009','dd/mm/yyyy'), to_date('01/03/2009','dd/mm/yyyy'), NULL, 8,3);

rem / PEDIDO_has_CATALOGO /
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 1, 6, NULL, 1, 20000, t_presentacion(100,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 1, 12, NULL, 1, 40000, t_presentacion(20,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 2, 6, NULL, 1, 30000, t_presentacion(100,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 2, 15, NULL, 1, 100000, t_presentacion(100,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 2, 24, NULL, 1, 10000, t_presentacion(1.5,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 3, 8, NULL, 2, 100000, t_presentacion(10,'KILOGRAMO','CAJA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 3, 7, NULL, 2, 50000, t_presentacion(1,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 3, 10, NULL, 2, 5000, t_presentacion(50,'KILOGRAMO','CAJA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 3, 19, NULL, 2, 70000, t_presentacion(0.5,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 3, 22, NULL, 2, 15000, t_presentacion(1.55,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 4, 8, NULL, 2, 10000, t_presentacion(10,'KILOGRAMO','CAJA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 4, 19, NULL, 2, 70000, t_presentacion(0.5,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 4, 9, NULL, 2, 25000, t_presentacion(10,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 5, 2, NULL, 3, 100000, t_presentacion(5,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 5, 4, NULL, 3, 30000, t_presentacion(150,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 5, 17, NULL, 3, 50000, t_presentacion(200,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 5, 23, NULL, 3, 50000, t_presentacion(1.5,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 6, 2, NULL, 3, 200000, t_presentacion(5,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 6, 4, NULL, 3, 6000, t_presentacion(150,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 6, 23, NULL, 3, 10000, t_presentacion(1.5,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 7, 2, NULL, 3, 300000, t_presentacion(5,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 7, 17, NULL, 3, 15000, t_presentacion(200,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 7, 4, NULL, 3, 80000, t_presentacion(150,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 8, 21, NULL, 3, 500000, t_presentacion(0.5,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 8, 2, NULL, 3, 400000, t_presentacion(5,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 9, 8, NULL, 2, 200000, t_presentacion(10,'KILOGRAMO','CAJA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 10, NULL, 1, 4, 3, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 10, NULL, 6, 4, 5, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 10, NULL, 3, 4, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 11, NULL, 8, 4, 4, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 11, NULL, 2, 4, 5, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 11, NULL, 7, 4, 4, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 12, NULL, 5, 4, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 12, NULL, 4, 4, 1, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 13, NULL, 9, 5, 1, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 13, NULL, 11, 5, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 14, NULL, 12, 5, 1, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 14, NULL, 14, 5, 6, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 14, NULL, 16, 5, 1, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 15, NULL, 18, 6, 5, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 15, NULL, 20, 6, 3, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 15, NULL, 24, 6, 1, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 16, NULL, 20, 6, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 16, NULL, 18, 6, 1, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 17, NULL, 19, 6, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 17, NULL, 23, 6, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 18, NULL, 6, 4, 5, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 19, 28, NULL, 9, 500000, t_presentacion(150,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 19, 43, NULL, 9, 1000000, t_presentacion(1,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 19, 26, NULL, 9, 500000, t_presentacion(5,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 19, 27, NULL, 9, 500000, t_presentacion(30,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 20, 28, NULL, 9, 500000, t_presentacion(150,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 20, 43, NULL, 9, 1000000, t_presentacion(1,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 20, 26, NULL, 9, 500000, t_presentacion(5,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 20, 27, NULL, 9, 500000, t_presentacion(30,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 21, 28, NULL, 9, 550000, t_presentacion(150,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 21, 43, NULL, 9, 1000000, t_presentacion(1,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 21, 26, NULL, 9, 550000, t_presentacion(5,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 21, 27, NULL, 9, 550000, t_presentacion(30,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 22, 28, NULL, 9, 1000000, t_presentacion(150,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 22, 26, NULL, 9, 1000000, t_presentacion(5,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 22, 27, NULL, 9, 1000000, t_presentacion(30,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 23, 34, NULL, 10, 500000, t_presentacion(50,'KILOGRAMO','CAJA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 23, 37, NULL, 10, 500000, t_presentacion(100,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 23, 33, NULL, 10, 70000, t_presentacion(10,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 23, 42, NULL, 10, 100000, t_presentacion(1,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 24, 34, NULL, 10, 1000000, t_presentacion(50,'KILOGRAMO','CAJA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 24, 37, NULL, 10, 1000000, t_presentacion(100,'TONELADA','CONTENEDOR'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 24, 33, NULL, 10, 140000, t_presentacion(10,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 24, 42, NULL, 10, 200000, t_presentacion(1,'KILOGRAMO','EMPAQUE'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 25, 34, NULL, 10, 1000000, t_presentacion(50,'KILOGRAMO','CAJA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 25, 33, NULL, 10, 400000, t_presentacion(10,'KILOGRAMO','BOLSA'));
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 26, NULL, 25, 7, 4, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 26, NULL, 30, 7, 6, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 26, NULL, 27, 7, 3, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 27, NULL, 32, 7, 5, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 27, NULL, 26, 7, 6, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 27, NULL, 31, 7, 5, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 28, NULL, 29, 7, 3, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 28, NULL, 28, 7, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 29, NULL, 33, 8, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 29, NULL, 35, 8, 3, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 30, NULL, 36, 8, 2, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 30, NULL, 38, 8, 7, NULL);
INSERT INTO PEDIDO_has_CATALOGO VALUES (S_PEDIDO_CATALOGO.NEXTVAL, 30, NULL, 40, 8, 2, NULL);

rem / ELABORACION /
INSERT INTO ELABORACION VALUES (1, 2, NULL, 1);
INSERT INTO ELABORACION VALUES (1, 2, 7, NULL);
INSERT INTO ELABORACION VALUES (1, 2, 10, NULL);
INSERT INTO ELABORACION VALUES (1, 2, 17, NULL);
INSERT INTO ELABORACION VALUES (2, 2, NULL, 2);
INSERT INTO ELABORACION VALUES (2, 2, 6, NULL);
INSERT INTO ELABORACION VALUES (2, 2, 13, NULL);
INSERT INTO ELABORACION VALUES (2, 2, 19, NULL);
INSERT INTO ELABORACION VALUES (3, 2, NULL, 4);
INSERT INTO ELABORACION VALUES (3, 2, 9, NULL);
INSERT INTO ELABORACION VALUES (3, 2, 13, NULL);
INSERT INTO ELABORACION VALUES (3, 2, 16, NULL);
INSERT INTO ELABORACION VALUES (4, 2, NULL, 2);
INSERT INTO ELABORACION VALUES (4, 2, 8, NULL);
INSERT INTO ELABORACION VALUES (4, 2, 10, NULL);
INSERT INTO ELABORACION VALUES (4, 2, 16, NULL);
INSERT INTO ELABORACION VALUES (4, 2, 19, NULL);
INSERT INTO ELABORACION VALUES (5, 2, NULL, 4);
INSERT INTO ELABORACION VALUES (5, 2, 7, NULL);
INSERT INTO ELABORACION VALUES (5, 2, 13, NULL);
INSERT INTO ELABORACION VALUES (5, 2, 17, NULL);
INSERT INTO ELABORACION VALUES (5, 2, 10, NULL);
INSERT INTO ELABORACION VALUES (7, 3, NULL, 4);
INSERT INTO ELABORACION VALUES (7, 3, 9, NULL);
INSERT INTO ELABORACION VALUES (7, 3, 11, NULL);
INSERT INTO ELABORACION VALUES (7, 3, 16, NULL);
INSERT INTO ELABORACION VALUES (6, 3, NULL, 2);
INSERT INTO ELABORACION VALUES (6, 3, NULL, 3);
INSERT INTO ELABORACION VALUES (6, 3, 8, NULL);
INSERT INTO ELABORACION VALUES (6, 3, 11, NULL);
INSERT INTO ELABORACION VALUES (6, 3, 15, NULL);

rem / PRODUCCION /
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('16/09/2001','dd/mm/yyyy'), 1000000, '1-A', to_date('16/09/2003','dd/mm/yyyy'), 1, 1, 2, 1);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('16/09/2001','dd/mm/yyyy'), 500000, '1-B', to_date('16/09/2003','dd/mm/yyyy'), 1, 3, 2, 2);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('16/09/2001','dd/mm/yyyy'), 50000, '1-C', to_date('16/09/2003','dd/mm/yyyy'), 1, 5, 2, 3);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('16/09/2004','dd/mm/yyyy'), 100000, '1-D', to_date('16/09/2006','dd/mm/yyyy'), 1, 6, 2, 4);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('15/11/2004','dd/mm/yyyy'), 1000000, '2-A', to_date('15/11/2006','dd/mm/yyyy'), 2, 9, 2, 5);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('17/11/2002','dd/mm/yyyy'), 5000000, '2-B', to_date('15/11/2004','dd/mm/yyyy'), 2, 2, 2, 1);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('12/11/2001','dd/mm/yyyy'), 500000, '2-C', to_date('15/11/2004','dd/mm/yyyy'), 2, 4, 2, 2);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('13/11/2003','dd/mm/yyyy'), 500000, '2-D', to_date('15/11/2005','dd/mm/yyyy'), 2, 7, 2, 4);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('16/09/2003','dd/mm/yyyy'), 10000000, '1-A', to_date('16/09/2005','dd/mm/yyyy'), 3, 1, 2, 1);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('16/09/2004','dd/mm/yyyy'), 20000000, '2-A', to_date('16/09/2006','dd/mm/yyyy'), 4, 3, 2, 2);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('16/09/2005','dd/mm/yyyy'), 30000000, '3-A', to_date('16/09/2007','dd/mm/yyyy'), 1, 1, 2, 1);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('05/05/2006','dd/mm/yyyy'), 1000000, '5-A', to_date('05/05/2008','dd/mm/yyyy'), 5, 10, 3, 7);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('10/05/2006','dd/mm/yyyy'), 5000000, '5-B', to_date('10/05/2008','dd/mm/yyyy'), 5, 11, 3, 7);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('05/05/2007','dd/mm/yyyy'), 5000000, '5-C', to_date('05/05/2009','dd/mm/yyyy'), 5, 12, 3, 7);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('15/05/2006','dd/mm/yyyy'), 1000000, '6-A', to_date('15/05/2008','dd/mm/yyyy'), 6, 13, 3, 6);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('05/05/2007','dd/mm/yyyy'), 5000000, '6-B', to_date('05/05/2009','dd/mm/yyyy'), 6, 13, 3, 6);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('05/05/2008','dd/mm/yyyy'), 10000000, '5-C', to_date('05/05/2010','dd/mm/yyyy'), 5, 12, 3, 7);
INSERT INTO PRODUCCION VALUES (S_PRODUCCION.NEXTVAL, to_date('05/05/2008','dd/mm/yyyy'), 10000000, '6-B', to_date('05/05/2010','dd/mm/yyyy'), 6, 13, 3, 6);

rem / DESCUENTO_PEDIDO /
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 1, 2, 1,  1, 1,  10, 1, 1); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 1, 2, 1,  3, 2,  10, 6, 1); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 1, 2, 1,  1, 1,  10, 2, 1); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 1, 2, 1,  5, 3,  10, 17, 1); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 3, 2, 2,  5, 3,  5, 14, 2); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 3, 2, 2,  3, 2,  5, 7, 2); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 3, 2, 2,  2, 1,  5, 4, 2); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 3, 2, 2,  3, 2,  5, 10, 2); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 5, 2, 3,  5, 3,  5, 15, 3); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 5, 2, 3,  3, 2,  5, 8, 3); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 5, 2, 3,  2, 1,  5, 4, 3); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 5, 2, 3,  3, 2,  5, 9, 3); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 6, 2, 4,  5, 3,  10, 14, 4); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 6, 2, 4,  4, 2,  10, 13, 4); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 6, 2, 4,  1, 1,  10, 2, 4);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 6, 2, 4,  3, 2,  10, 9, 4); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 6, 2, 4,  3, 2,  10, 10, 4); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 9, 2, 5,  5, 3,  50, 15, 5); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 9, 2, 5,  3, 2,  50, 6, 5);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 9, 2, 5,  2, 1,  50, 4, 5);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 9, 2, 5,  2, 1,  50, 5, 5);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 9, 2, 5,  1, 1,  50, 2, 5);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 2, 2, 1,  1, 1,  50, 1, 6); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 2, 2, 1,  3, 2,  50, 6, 6); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 2, 2, 1,  1, 1,  50, 2, 6); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 2, 2, 1,  5, 3,  50, 17, 6); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 4, 2, 2,  5, 3,  5, 14, 7); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 4, 2, 2,  3, 2,  5, 7, 7); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 4, 2, 2,  2, 1,  5, 4, 7); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 4, 2, 2,  3, 2,  5, 10, 7); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 7, 2, 4,  5, 3,  50, 14, 8); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 7, 2, 4,  4, 2,  50, 13, 8); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 7, 2, 4,  1, 1,  50, 2, 8);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 7, 2, 4,  3, 2,  50, 9, 8); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 2, 7, 2, 4,  3, 2,  50, 10, 8);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 3, 1, 2, 1,  1, 1,  100, 1, 9); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 3, 1, 2, 1,  3, 2,  100, 6, 9); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 3, 1, 2, 1,  1, 1,  100, 2, 9); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 3, 1, 2, 1,  5, 3,  100, 17, 9); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 4, 3, 2, 2,  5, 3,  200, 14, 10); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 4, 3, 2, 2,  3, 2,  200, 7, 10); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 4, 3, 2, 2,  2, 1,  200, 4, 10); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 4, 3, 2, 2,  3, 2,  200, 10, 10); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 1, 2, 1,  1, 1,  300, 1, 11); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 1, 2, 1,  3, 2,  300, 6, 11); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 1, 2, 1,  1, 1,  300, 2, 11); 
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 1, 1, 2, 1,  5, 3,  300, 17, 11);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 10, 3, 7,  19, 9,  10, 48, 12);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 10, 3, 7,  23, 10,  10, 63, 12);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 10, 3, 7,  23, 10,  10, 64, 12);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 10, 3, 7,  19, 9,  10, 49, 12);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 11, 3, 7,  19, 9,  50, 48, 13);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 11, 3, 7,  23, 10,  50, 63, 13);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 11, 3, 7,  23, 10,  50, 64, 13);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 11, 3, 7,  19, 9,  50, 49, 13);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 12, 3, 7,  19, 9,  50, 48, 14);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 12, 3, 7,  23, 10,  50, 63, 14);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 12, 3, 7,  23, 10,  50, 64, 14);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 12, 3, 7,  19, 9,  50, 49, 14);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  19, 9,  10, 50, 15);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  19, 9,  10, 51, 15);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  10, 65, 15);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  10, 64, 15);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  10, 66, 15);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  19, 9,  50, 50, 16);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  19, 9,  50, 51, 16);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  50, 65, 16);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  50, 64, 16);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  50, 66, 16);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 12, 3, 7,  19, 9,  100, 48, 17);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 12, 3, 7,  23, 10,  100, 63, 17);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 12, 3, 7,  23, 10,  100, 64, 17);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 5, 12, 3, 7,  19, 9,  100, 49, 17);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  19, 9,  100, 50, 18);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  19, 9,  100, 51, 18);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  100, 65, 18);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  100, 64, 18);
INSERT INTO DESCUENTO_PEDIDO VALUES (S_DESCUENTO.NEXTVAL, 6, 13, 3, 6,  23, 10,  100, 66, 18);