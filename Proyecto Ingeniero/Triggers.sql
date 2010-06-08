REM ** TRIGGER validarLugar **

CREATE OR REPLACE TRIGGER validarLugar
BEFORE INSERT ON lugar
FOR EACH ROW
DECLARE

	jerarquia NUMBER;
	tipo VARCHAR2(20);
	tipoJerarquia VARCHAR2(20);

	CURSOR busqueda IS SELECT * FROM lugar WHERE ID = :NEW.id;
	resultado busqueda % ROWTYPE;

BEGIN

	jerarquia := :NEW.lugar_id;
	tipo := :NEW.tipo;

	IF (jerarquia IS NULL) AND (tipo <> 'CONTINENTE')  THEN
		raise_application_error(-20002,'SE DEBE INSERTAR UN CONTINENTE');
	END IF;

	IF (jerarquia IS NULL) AND (:NEW.moneda IS NOT NULL)  THEN
		raise_application_error(-20004,'LOS ' ||tipo|| ' NO DEBEN TENER MONEDA');
	END IF;

	IF (jerarquia IS NOT NULL) THEN
		
		SELECT tipo  INTO tipoJerarquia FROM lugar WHERE (id = jerarquia);

		IF (tipo = 'PAIS') AND (tipoJerarquia <> 'CONTINENTE') THEN
			raise_application_error(-20003,' ESTA INSERTANDO UN ' ||tipo|| ' EL ID DE SU PADRE DEBE PERTENECER A UN CONTINENTE' );
		END IF;

		IF (tipo = 'PAIS') AND (:NEW.moneda IS  NULL) THEN
			raise_application_error(-20005,'UN PAIS DEBE TENER UNA MONEDA' );
		END IF;

		IF (tipo = 'PAIS') THEN
			IF (:NEW.feriados IS  NULL) THEN
				raise_application_error(-20005,'UN PAIS TIENE QUE TENER AL MENOS 1 DIA FERIADO' );
			END IF;
			FOR i IN 1..:NEW.feriados.COUNT LOOP
				IF (:NEW.feriados(i) IS NULL ) THEN
					raise_application_error(-20006,'EL VECTOR DE DIAS FERIADOS NO PUEDE CONTENER NULL');
				END IF;

				IF ("cantidadDias"(TO_CHAR(:NEW.feriados(i),'dd-mm-yyyy')) > 0 ) THEN
					raise_application_error(-20006,'EL VECTOR DE DIAS FERIADOS NO PUEDE CONTENER FECHAS EN EL FUTURO');
				END IF;
			END LOOP;
		END IF;

		IF (tipo = 'CIUDAD') AND (tipoJerarquia <> 'PAIS') THEN
			raise_application_error(-20003,' ESTA INSERTANDO UN ' ||tipo|| ' EL ID DE SU PADRE DEBE PERTENECER A UN PAIS' );
		END IF;

		IF (tipo = 'CIUDAD') AND (:NEW.moneda IS NOT NULL) THEN
			raise_application_error(-20004,'LA ' ||tipo|| ' NO DEBEN TENER MONEDA');
		END IF;

	END IF;

END;

REM ** INSERTS MALOS **

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'HOLANDA', 'PAIS', 'EURO', 'AMSTERDAM',NULL, 1);

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'HOLANDA', 'PAIS', 'EURO', 'AMSTERDAM', v_feriado(NULL,to_date('30/04/2009','dd/mm/yyyy'),to_date('04/05/2009','dd/mm/yyyy'),to_date('05/05/2009','dd/mm/yyyy'),to_date('15/12/2009','dd/mm/yyyy'),to_date('25/12/2009','dd/mm/yyyy')), 1);

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'HOLANDA', 'PAIS', 'EURO', 'AMSTERDAM', v_feriado(to_date('01/01/2009','dd/mm/yyyy'),to_date('30/04/2009','dd/mm/yyyy'),to_date('04/05/2009','dd/mm/yyyy'),to_date('05/05/2009','dd/mm/yyyy'),to_date('15/12/2021','dd/mm/yyyy'),to_date('25/12/2009','dd/mm/yyyy')), 1);

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'EUROPEO', 'contnte', NULL, NULL, NULL, NULL);

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'EUROPEO', 'contnte', NULL, NULL, NULL, NULL);

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'FRANCIA', 'PAIS', 'DOLAR', NULL, NULL, 6);

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'FRANCIA', 'PAIS', NULL, NULL, NULL, 1);

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'CARACAS', 'CIUDAD', NULL, NULL, NULL, 1);

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'HOUSTON', 'CIUDAD', 'DOLAR', NULL, NULL, 6);

REM ** TRIGGER validarEmpresa **

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
		IF ("cantidadDias"(TO_CHAR(busqueda.fecha,'dd-mm-yyyy')) > 0 ) THEN
			raise_application_error(-20006,'AL INSERTAR UNA EMPRESA LA FECHA DE LOS HECHOS HISTORICOS NO PUEDE SER MAYOR AL DIA DE HOY');
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

REM ** INSERTS MALOS **

INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'SABMILLER', t_paginaweb('WWW.SABMILLER.COM','INTERNACIONAL'), 'CITY OF WESTMINISTER', nt_historia(t_historia(to_date('13/11/1895','dd/mm/yyyy'),'FUE FUNDADA EN SUR AFRICA'),t_historia(to_date('06/06/1990','dd/mm/yyyy'),'EMPIEZA A INVERTIR EN EUROPA'),t_historia(to_date('07/07/2010','dd/mm/yyyy'),'LA COMPANIA SALE REFLEJADA EN LA BOLSA DE VALORES DE LONDRES'),t_historia(to_date('09/08/2002','dd/mm/yyyy'),'COMPRAN ALTRIA GROUP PARA EXPANDIRSE')), to_date('13/11/1895','dd/mm/yyyy'), NULL, 33,NULL,NULL);

INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'SABMILLER', t_paginaweb('WWW.SABMILLER.COM','INTERNACIONAL'), 'CITY OF WESTMINISTER', nt_historia(t_historia(to_date('13/11/1895','dd/mm/yyyy'),'FUE FUNDADA EN SUR AFRICA'),t_historia(to_date('06/06/1990','dd/mm/yyyy'),'EMPIEZA A INVERTIR EN EUROPA'),t_historia(to_date('07/07/1999','dd/mm/yyyy'),'LA COMPANIA SALE REFLEJADA EN LA BOLSA DE VALORES DE LONDRES'),t_historia(to_date('09/08/2002','dd/mm/yyyy'),'COMPRAN ALTRIA GROUP PARA EXPANDIRSE')), to_date('21/12/2012','dd/mm/yyyy'), NULL, 33,NULL,NULL);

INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'SABMILLER', t_paginaweb('WWW.SABMILLER.COM','INTERNACIONAL'), 'CITY OF WESTMINISTER', nt_historia(t_historia(NULL,'FUE FUNDADA EN SUR AFRICA')), to_date('13/11/1895','dd/mm/yyyy'), NULL, 33,NULL,NULL);

INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'SABMILLER', t_paginaweb('WWW.SABMILLER.COM','INTERNACIONAL'), 'CITY OF WESTMINISTER', nt_historia(t_historia(to_date('13/11/1895','dd/mm/yyyy'),NULL)), to_date('13/11/1895','dd/mm/yyyy'), NULL, 33,NULL,NULL);

INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'SABMILLER', t_paginaweb('WWW.SABMILLER.COM','INTERNACIONAL'), 'CITY OF WESTMINISTER', NULL, to_date('13/11/1895','dd/mm/yyyy'), NULL, 33,NULL,NULL);

INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'GROLSCH', t_paginaweb('WWW.GROLSCH.NL','NACIONAL'), 'BROUVER GOLPEAR 1', nt_historia(t_historia(to_date('16/11/1615','dd/mm/yyyy'),'FUE FUNDADA POR GROENLO PETER CUYPER'),t_historia(to_date('12/01/1684','dd/mm/yyyy'),'SE FUNDO UNA NUEVA FABRICA EN BROKOLOL'),t_historia(to_date('07/11/1897','dd/mm/yyyy'),'SALE AL MERCADO LA BOTELLA DE LITRO Y MEDIO'),t_historia(to_date('18/09/1922','dd/mm/yyyy'),'FUE FUCIONA CONCERVECERIA EL RELOJ'),t_historia(to_date('16/06/2000','dd/mm/yyyy'),'LA FABRICA FUE ARRASADA POR FUEGOS ARIFICIALES'),t_historia(to_date('24/07/2008','dd/mm/yyyy'),'FUE ADQUIRIDA POR LA FIRMA SABMILLER')), to_date('16/11/1615','dd/mm/yyyy'), 1, 3,'FAMILIA CUYPER', -5.4);

INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'GROLSCH', t_paginaweb('WWW.GROLSCH.NL',NULL), 'BROUVER GOLPEAR 1', nt_historia(t_historia(to_date('16/11/1615','dd/mm/yyyy'),'FUE FUNDADA POR GROENLO PETER CUYPER'),t_historia(to_date('12/01/1684','dd/mm/yyyy'),'SE FUNDO UNA NUEVA FABRICA EN BROKOLOL'),t_historia(to_date('07/11/1897','dd/mm/yyyy'),'SALE AL MERCADO LA BOTELLA DE LITRO Y MEDIO'),t_historia(to_date('18/09/1922','dd/mm/yyyy'),'FUE FUCIONA CONCERVECERIA EL RELOJ'),t_historia(to_date('16/06/2000','dd/mm/yyyy'),'LA FABRICA FUE ARRASADA POR FUEGOS ARIFICIALES'),t_historia(to_date('24/07/2008','dd/mm/yyyy'),'FUE ADQUIRIDA POR LA FIRMA SABMILLER')), to_date('16/11/1615','dd/mm/yyyy'), 1, 3,'FAMILIA CUYPER', 5.4);

REM ** TRIGGER validarCervezaCatalogo **

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

REM ** INSERTS MALOS **

INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM HERFSTBOK', NULL, 6.5, NULL, NULL, to_date('18/09/2000','dd/mm/yyyy'), NULL, 'CALIDA, CON AROMAS Y COLOR ROJO RUBI', t_infnutricional(230, 135), 'DULCE', v_temporada('INVIERNO', NULL), 2, 5);

INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM HERFSTBOK', NULL, -6.5, NULL, NULL, to_date('18/09/2000','dd/mm/yyyy'), NULL, 'CALIDA, CON AROMAS Y COLOR ROJO RUBI', t_infnutricional(230, 135), 'DULCE', v_temporada('INVIERNO', 'PASCUA'), 2, 5);

INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'XXXX BITTER',nt_pagweb(t_paginaweb('WWW.XXXX.COM.AU',NULL)), 4.6, 'XXXX BITTER', NULL, to_date('1924','yyyy'), NULL, 'CERVEZA AUSTRALIANA TRADICIONALES CON UN SABOR LIMPIO, FRESCO Y UNA SATISFACCION DESPUÉS DE LA AMARGURA. XXXX DELICADO AROMA AMARGO PROVIENE DE LA MEZCLA DE DOS VARIEDADES DE LÚPULO Y UN DULCE, SABOR AFRUTADO DE LA LEVADURA. POTABILIDAD DE ALTA EN LOS CLIMAS CALIDOS.', t_infnutricional(3,100), 'FUERTE', NULL, 4, 9);

INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM PILSNER', NULL, 5, NULL, NULL, to_date('01/01/1995','dd/mm/yyyy'), NULL, 'MADURACION NATURAL, HECHA CON ELEMENTOS PRIMIUM', t_infnutricional(185, NULL), 'SUAVE', NULL, 2, 1);

INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM PILSNER', NULL, 5, NULL, NULL, to_date('01/01/1995','dd/mm/yyyy'), NULL, 'MADURACION NATURAL, HECHA CON ELEMENTOS PRIMIUM',NULL, 'SUAVE', NULL, 2, 1);

INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM PILSNER', NULL, 5, NULL, NULL, NULL, NULL, 'MADURACION NATURAL, HECHA CON ELEMENTOS PRIMIUM', t_infnutricional(185, 200), 'SUAVE', NULL, 2, 1);

INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'PREMIUM PILSNER', NULL, 5, NULL, NULL, to_date('21/12/2012','dd/mm/yyyy'), NULL, 'MADURACION NATURAL, HECHA CON ELEMENTOS PRIMIUM', t_infnutricional(185, 200), 'SUAVE', NULL, 2, 1);

REM ** TRIGGER validarTipo **

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

REM ** INSERTS MALOS **

INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'PALE LAGER', NULL, '10-15', 'CERVEZA DE BAJA FERMENTACION', v_alimento('Alimentos picantes'));

INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'PALE LAGER', t_temperatura(NULL, 'CENTIGRADO'), '10-15', 'CERVEZA DE BAJA FERMENTACION', v_alimento('Alimentos picantes'));

INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'PALE LAGER', t_temperatura(6.8, 'C'), '10-15', 'CERVEZA DE BAJA FERMENTACION', v_alimento('Alimentos picantes'));

INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'PALE LAGER', t_temperatura(6.8, 'CENTIGRADO'), '10-15', 'CERVEZA DE BAJA FERMENTACION',NULL);

INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'PALE LAGER', t_temperatura(6.8, 'CENTIGRADO'), '10-15', 'CERVEZA DE BAJA FERMENTACION', v_alimento('Alimentos picantes',NULL));

REM ** TRIGGER validareEmpresaHasEventos **

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

REM ** INSERTS MALOS **

INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 2, 1, 'FESTIVAL DE MUSICA NACIONAL 2007', NULL, 15);

INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 2, 1, 'FESTIVAL DE MUSICA NACIONAL 2007', to_date('21/12/2010','dd/mm/yyyy'), 15);

REM ** TRIGGER validareFabrica **

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

REM ** INSERTS MALOS **

INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, to_date('21/12/2012','dd/mm/yyyy'), 2, 3);

INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, NULL, 2, 3);

REM ** TRIGGER validarPresentacion **

CREATE OR REPLACE TRIGGER validarPresentacion
BEFORE INSERT ON presentacion
FOR EACH ROW

BEGIN

	IF ( "validarCantidad"(:NEW.capacidad) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA PRESENTACION LA CANTIDAD NO DEBE SER MENOR A 0');
	END IF;

END;

REM ** INSERTS MALOS **

INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, -2, 'BOTELLA', 'CL', 1, 2);

REM ** TRIGGER validarProveedor **

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

REM ** INSERTS MALOS **

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', NULL, '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, 8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', v_telefono(t_telefono(370, 8541256,'CASA')))), 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT',NULL), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, 8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', v_telefono(t_telefono(370, 8541256,'CASA')))), 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', NULL, nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', v_telefono(t_telefono(370, 8541256,'CASA')))), 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, NULL),t_telefono(370, 8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', v_telefono(t_telefono(370, 8541256,'CASA')))), 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, -8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', v_telefono(t_telefono(370, 8541256,'CASA')))), 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, 8731655, 'FAX')),NULL, 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, 8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas',NULL, v_telefono(t_telefono(370, 8541256,'CASA')))), 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, 8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', NULL)), 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, 8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', v_telefono(t_telefono(370, -8541256,'CASA')))), 21);

INSERT INTO PROVEEDOR VALUES (S_PROVEEDOR.NEXTVAL, 'MALTOSA, UAB', t_paginaweb('WWW.MALTOSA.LT','NACIONAL'), '9A, SVENCIONELIAI', nt_telefonos(t_telefono(370, 8731115, 'OFICINA'),t_telefono(370, 8731655, 'FAX')), nt_contacto(t_contacto('Juozas','Kalinauskas', 'GERENTE', v_telefono(t_telefono(NULL, 8541256,'CASA')))), 21);

REM ** TRIGGER validarTour **

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

REM ** INSERTS MALOS **

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, -10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(-10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, NULL, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(-16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(80,16), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), null, 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario(NULL, 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', -930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER',NULL,'DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'),NULL, v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 10.00, nt_descuento(t_descuento(10, 100, 'ESTUDIANTE'),t_descuento(15, 50, 'VERANO')), t_rangoedad(16,80), nt_horario(t_horario('LUNES', 930, 1200, 1),t_horario('MARTES', 930, 1200, 1),t_horario('MIERCOLES', 930, 1200, 1),t_horario('JUEVES', 930, 1200, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','DISCORVER','VISA','DINNERS CLUB'), nt_reqadq(t_reqad(60,'DIA')), v_requisito(NULL,'Si es menor de edad venir acompanado de un representante'));

REM ** TRIGGER validarEntrada **

CREATE OR REPLACE TRIGGER validarEntrada
BEFORE INSERT ON entrada
FOR EACH ROW
DECLARE 

	IDD INT;

BEGIN

	IF (:NEW.grupo_tour_id IS NOT NULL) THEN
		IF (:NEW.entrada_num_padre IS NOT NULL) THEN
			raise_application_error(-20006,'AL INSERTAR UNA ENTRADA NO PUEDE TENER PREDRE Y GRUPO, UNO DE LOS DOS DEBE SER NULL Y LOS DOS');
		END IF;
	END IF;

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

REM ** INSERTS MALOS **

INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('02/02/2007','dd/mm/yyyy'), 0900, 'ADULTO', 100.00, 'MASTERCARD', 1, 1, 2, 1, 1);

INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('21-12-2012','dd/mm/yyyy'), 0900, 'ADULTO', 100.00, 'MASTERCARD', 1, 1, 2, 1, NULL);

INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('02/02/2007','dd/mm/yyyy'), -0900, 'ADULTO', 100.00, 'MASTERCARD', 1, 1, 2, 1, NULL);

INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('02/02/2007','dd/mm/yyyy'), 0900, 'ADULTO', -100.00, 'MASTERCARD', 1, 1, 2, 1, NULL);

INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('01-01-2012','dd/mm/yyyy'), 0900, 'ADULTO', 100.00, 'MASTERCARD', 1, 1, 2, 1, NULL);

REM ** TRIGGER validarGrupoTour **

CREATE OR REPLACE TRIGGER validarGrupoTour
BEFORE INSERT ON grupo_tour
FOR EACH ROW

BEGIN

	IF ("validarCantidad"(:NEW.cantidad) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UN GRUPO PARA EL TOUR LA CANTIDAD TIENE QUE SER MAYOR A 0');
	END IF;

END;


REM ** INSERTS MALOS **

INSERT INTO GRUPO_TOUR VALUES (S_GRUPO_TOUR.NEXTVAL, 'ESTUDIANTES DE INGENIERIA DE PRODUCCION', -10, 1, 1, 2);  

