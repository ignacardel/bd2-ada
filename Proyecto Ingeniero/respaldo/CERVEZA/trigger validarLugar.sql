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

				IF ("cantidadDias"(TO_CHAR(:NEW.feriados(i),'dd-mm-yyyy')) <= 0 ) THEN
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
