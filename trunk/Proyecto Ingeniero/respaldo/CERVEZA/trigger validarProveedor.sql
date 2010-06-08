CREATE OR REPLACE TRIGGER validarProveedor
BEFORE INSERT ON proveedor
FOR EACH ROW
DECLARE
	
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
