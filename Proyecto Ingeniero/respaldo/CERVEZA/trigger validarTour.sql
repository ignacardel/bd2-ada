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
