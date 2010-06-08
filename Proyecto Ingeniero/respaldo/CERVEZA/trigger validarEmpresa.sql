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

	IF ("cantidadDias"(TO_CHAR(:NEW.fechafundacion,'dd-mm-yyyy')) <= 0 ) THEN
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
