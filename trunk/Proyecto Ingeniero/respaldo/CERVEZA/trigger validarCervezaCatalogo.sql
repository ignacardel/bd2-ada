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

	 IF ("cantidadDias"(TO_CHAR(:NEW.fechainicio,'dd-mm-yyyy')) <= 0 ) THEN
		raise_application_error(-20006,'AL INSERTAR LA FECHA, ESTA NO PUEDE SER EN UN DIA SUPERIOR AL DE HOY');
	END IF;

END;
