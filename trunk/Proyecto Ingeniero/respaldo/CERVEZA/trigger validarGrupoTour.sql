CREATE OR REPLACE TRIGGER validarGrupoTour
BEFORE INSERT ON grupo_tour
FOR EACH ROW

BEGIN

	IF ("validarCantidad"(:NEW.cantidad) <> 'MAYOR' ) THEN
		raise_application_error(-20006,'AL INSERTAR UN GRUPO PARA EL TOUR LA CANTIDAD TIENE QUE SER MAYOR A 0');
	END IF;

END;
