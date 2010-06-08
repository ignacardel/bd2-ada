CREATE OR REPLACE TRIGGER validarPresentacion
BEFORE INSERT ON presentacion
FOR EACH ROW

BEGIN

	IF ( "validarCantidad"(:NEW.capacidad) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UNA PRESENTACION LA CANTIDAD NO DEBE SER MENOR A 0');
	END IF;

END;
