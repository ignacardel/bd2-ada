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
