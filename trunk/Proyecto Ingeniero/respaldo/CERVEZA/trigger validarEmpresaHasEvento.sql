CREATE OR REPLACE TRIGGER validarEmpresaHasEvento
BEFORE INSERT ON empresa_has_evento
FOR EACH ROW

BEGIN

	 IF (:NEW.fecha IS NULL) THEN
		raise_application_error(-20006,'AL INSERTAR LA FECHA DE UN EVENTO DEBE TENER UNA FECHA');
	END IF;

	 IF ("cantidadDias"(TO_CHAR(:NEW.fecha,'dd-mm-yyyy')) <= 0 ) THEN
		raise_application_error(-20006,'AL INSERTAR LA FECHA DE UN EVENTO, ESTA NO PUEDE SER EN UN DIA SUPERIOR AL DE HOY');
	END IF;

END;
