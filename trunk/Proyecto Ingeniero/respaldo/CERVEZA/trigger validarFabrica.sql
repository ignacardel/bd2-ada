CREATE OR REPLACE TRIGGER validarFabrica
BEFORE INSERT ON fabrica
FOR EACH ROW

BEGIN

	 IF (:NEW.fechaapertura IS NULL) THEN
		raise_application_error(-20006,'DEBE INSERTAR UNA FECHA DE FUNDACION');
	END IF;

	 IF ("cantidadDias"(TO_CHAR(:NEW.fechaapertura,'dd-mm-yyyy')) <= 0 ) THEN
		raise_application_error(-20006,'DEBE INCERTAR UN FECHA MENOR O IGUAL AL DIA DE HOY');
	END IF;

END;
