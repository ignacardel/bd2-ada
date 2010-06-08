CREATE OR REPLACE 
FUNCTION "alimentosTipo" (idd  NUMBER)
RETURN VARCHAR2
AS

alimentos VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM TIPO WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.ALIMENTOS IS NOT NULL THEN
			FOR i IN 1..resultado.ALIMENTOS.COUNT LOOP
				IF resultado.ALIMENTOS(i) <> ' ' then
					IF i=1 then
					alimentos:= resultado.ALIMENTOS(i);
					end if;
					IF i>1 then
alimentos := alimentos || ' , ' ||resultado.ALIMENTOS(i);
					end if;
				END IF;
			END LOOP;
		END IF;
		IF resultado.ALIMENTOS IS NULL THEN
			alimentos:='N/A ';
		END IF;
	END LOOP;
	RETURN alimentos;
END;
/
CREATE OR REPLACE 
FUNCTION "cantidadDias" (fecha  VARCHAR2)
RETURN INT
AS
	
	fechaAux VARCHAR2(10);
	ultimaFecha DATE;
	dias INT;
BEGIN
	--fechaAux := TO_CHAR(fecha,'dd-mm-yyyy');
	ultimaFecha := TO_DATE(fecha,'dd-mm-yyyy');
	SELECT ultimaFecha - sysdate + 1 INTO dias  FROM DUAL;
	RETURN dias;
END;
/
CREATE OR REPLACE 
FUNCTION "descuentos" (idd  NUMBER)
RETURN VARCHAR2
AS
motivo VARCHAR2(500);
por NUMBER;
cantidad NUMBER;
descuentos VARCHAR(2000);
CURSOR busqueda IS SELECT * FROM tour WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.descuentos IS NOT NULL THEN
			FOR i IN 1..resultado.descuentos.COUNT LOOP
				motivo := resultado.descuentos(i).motivo;
				por := resultado.descuentos(i).porcentaje;
				cantidad := resultado.descuentos(i).cantidadxgrupo;
				IF i=1 THEN
descuentos := descuentos || '  ' || 'Descuento por: ' || motivo || ', porcentaje de descuento sobre la entrada  ' || TO_CHAR(por) || '%';
				END IF;
				IF i>1 THEN
descuentos := descuentos || '.  ' || 'Descuento por: ' || motivo || '. porcentaje de descuento sobre la entrada  ' || TO_CHAR(por) || '%';
				END IF;
			END LOOP;
		END IF;
		IF resultado. descuentos IS NULL THEN
			 descuentos:='N/A ';
		END IF;
	END LOOP;
	RETURN  descuentos;
END;
/
CREATE OR REPLACE 
FUNCTION "esMenor" (menor  INT, mayor  INT)
RETURN VARCHAR2
AS
	devolver VARCHAR2(10);
BEGIN
	IF (menor < mayor) THEN
		devolver := 'MENOR';
	END IF;
	IF (menor =  mayor) THEN
		devolver := 'IGUAL';
	END IF;
	IF (menor > mayor) THEN
		devolver := 'MAYOR';
	END IF;
	RETURN devolver;
END;
/
CREATE OR REPLACE 
FUNCTION "formaDePago" (idd  NUMBER)
RETURN VARCHAR2
AS
formaDePago VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM TOUR WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.formasPagos IS NOT NULL THEN
			FOR i IN 1..resultado.formasPagos.COUNT LOOP
				IF resultado.formasPagos(i) <> ' ' then
					IF i=1 then
					formaDePago:= resultado.formasPagos(i);
					end if;
					IF i>1 then
formaDePago := formaDePago || ' , ' ||resultado.formasPagos(i);
					end if;
				END IF;
			END LOOP;
		END IF;
		IF resultado.formasPagos IS NULL THEN
			formaDePago := 'N/A ';
		END IF;
	END LOOP;
	RETURN formaDePago;
END;
/
CREATE OR REPLACE 
FUNCTION "historiaEmpresa" (idd  NUMBER)
RETURN VARCHAR2
AS

hecho VARCHAR2(500);
fecha DATE;
historia VARCHAR(5000);
CURSOR busqueda IS SELECT * FROM empresa WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.HISTORIAS IS NOT NULL THEN
			FOR i IN 1..resultado.HISTORIAS.COUNT LOOP
				hecho := resultado.HISTORIAS(i).hecho;
				fecha := resultado.HISTORIAS(i).fecha;
				IF i=1 THEN
historia := historia || '  ' || TO_CHAR(fecha,'yyyy') || '  ' || hecho;
				END IF;
				IF i>1 THEN
historia := historia || ',  ' || TO_CHAR(fecha,'yyyy') || '   ' || hecho;
				END IF;
			END LOOP;
		END IF;

		IF resultado.HISTORIAS IS NULL THEN
			historia:='N/A ';
		END IF;
	END LOOP;

	RETURN historia;
END;
/
CREATE OR REPLACE 
FUNCTION "horarios" (idd  NUMBER)
RETURN VARCHAR2
AS
dia VARCHAR2(500);
horai NUMBER;
horaf NUMBER;
horarios VARCHAR(2000);
CURSOR busqueda IS SELECT * FROM tour WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.horarios IS NOT NULL THEN
			FOR i IN 1..resultado.horarios.COUNT LOOP
				dia := resultado.horarios(i).dia;
				horai := resultado.horarios(i).horai;
				horaf := resultado.horarios(i).horaf;
				IF i=1 THEN
horarios := horarios || '  ' || 'Dia ' || dia || ' horario: de ' || TO_CHAR(horai) || ' hasta ' ||  TO_CHAR(horaf);
				END IF;
				IF i>1 THEN
horarios := horarios || '.  ' || 'Dia ' || dia || ' horario: de ' || TO_CHAR(horai) || ' hasta las ' ||  TO_CHAR(horaf);
				END IF;
			END LOOP;
		END IF;
		IF resultado. horarios IS NULL THEN
			 horarios:='N/A ';
		END IF;
	END LOOP;
	RETURN  horarios;
END;
/
CREATE OR REPLACE 
FUNCTION "infoNutri" (idd  NUMBER)
RETURN VARCHAR2
AS

info VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM CERVEZA_CATALOGO WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.INFNUTRICIONAL  IS NOT NULL THEN
			info :=  TO_CHAR(resultado.INFNUTRICIONAL.calorias) || ' CALORIAS POR ' ||  TO_CHAR(resultado.INFNUTRICIONAL.cantproducto) || 'ml ';
		END IF;
	END LOOP;

	RETURN info;
END;
/
CREATE OR REPLACE 
FUNCTION "pagWeb" (idd  NUMBER)
RETURN VARCHAR2
AS

pag VARCHAR2(50);

CURSOR busqueda IS SELECT * FROM cerveza_catalogo WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.PAGINAWEB IS NOT NULL THEN
			FOR i IN 1..resultado.PAGINAWEB.COUNT LOOP
				IF i=1 THEN
					pag := resultado.PAGINAWEB(i).link || '  ' ||  resultado.PAGINAWEB(i).tipo;
				END IF;
				IF i>1 THEN
					pag := pag || ',  ' || resultado.PAGINAWEB(i).link || '  ' ||  resultado.PAGINAWEB(i).tipo;
				END IF;
			END LOOP;
		END IF;

		IF resultado.PAGINAWEB IS NULL THEN
			pag := 'N/A';
		END IF;
	END LOOP;

	RETURN pag;
END;
/
CREATE OR REPLACE 
FUNCTION "rangoEdad" (idd  NUMBER)
RETURN VARCHAR2
AS
edadMin NUMBER;
edadMax NUMBER;
rangoEdad VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM TOUR WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		edadMin := resultado.rangoEdad.edadMin;
		edadMax := resultado.rangoEdad.edadMax;
		rangoEdad := 'El rango de edad esta comprendido entre ' || TO_CHAR(edadMin) ||  ' anos y ' || TO_CHAR(edadMax) || ' anos.';
	END LOOP;
	RETURN rangoEdad;
END;
/
CREATE OR REPLACE 
FUNCTION "requisitos" (idd  NUMBER)
RETURN VARCHAR2
AS
requisitos VARCHAR2(200);
CURSOR busqueda IS SELECT * FROM TOUR WHERE ID = idd;
resultado busqueda % ROWTYPE;
BEGIN
	FOR resultado IN busqueda LOOP
		IF resultado.requisitos IS NOT NULL THEN
			FOR i IN 1..resultado.requisitos.COUNT LOOP
				IF resultado.requisitos(i) <> ' ' then
					IF i=1 then
					requisitos:= resultado.requisitos(i);
					end if;
					IF i>1 then
requisitos := requisitos || ' , ' ||resultado.requisitos(i);
					end if;
				END IF;
			END LOOP;
		END IF;
		IF resultado.requisitos IS NULL THEN
			requisitos := 'N/A ';
		END IF;
	END LOOP;
	RETURN requisitos;
END;
/
CREATE OR REPLACE 
FUNCTION "temperaturaAF" (idd  NUMBER)
RETURN NUMBER
AS

temp NUMBER;
CURSOR busqueda IS SELECT * FROM TIPO WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		temp := resultado.TEMPERATURA.valor;
		
		temp := ((9/5) * temp) + 32;

	
	END LOOP;

	RETURN temp;
END;
/
CREATE OR REPLACE 
FUNCTION "temperaturaTipo" (idd  NUMBER)
RETURN VARCHAR2
AS

temperatura VARCHAR2(150);
temp NUMBER;
CURSOR busqueda IS SELECT * FROM TIPO WHERE ID = idd;
resultado busqueda % ROWTYPE;

BEGIN
	FOR resultado IN busqueda LOOP
		temp := resultado.TEMPERATURA.valor;
		
		temperatura := TO_CHAR(temp) || '   ' ||resultado.TEMPERATURA.unidad;

		IF resultado.TEMPERATURA IS NULL THEN
			temperatura:='N/A ';
		END IF;
	END LOOP;

	RETURN temperatura;
END;
/
CREATE OR REPLACE 
FUNCTION "validarCantidad" (cantidad  NUMBER)
RETURN VARCHAR2
AS
	menorMayor VARCHAR2(10);
BEGIN
	
	IF(cantidad > 0) THEN
		menorMayor := 'MAYOR';
	END IF;	
	IF(cantidad = 0) THEN
		menorMayor := 'CERO';
	END IF;	
	IF(cantidad < 0) THEN
		menorMayor := 'MENOR';
	END IF;	
	RETURN menorMayor;
END;
/
CREATE OR REPLACE 
FUNCTION "verificarFeriado" (fecha  VARCHAR2,idd INT)
RETURN VARCHAR2
AS

	fechaAux DATE;
	feriado VARCHAR2(10);
	ultimaFecha date;
	f VARCHAR2(10);
	ff VARCHAR2(10);
	CURSOR busqueda IS SELECT * FROM lugar WHERE ID = idd;
	resultado busqueda % ROWTYPE;

BEGIN

	FOR resultado IN busqueda LOOP
		FOR i IN 1..resultado.feriados.COUNT LOOP
			f := TO_CHAR(resultado.feriados(i),'dd-mm');
			fechaAux := TO_DATE(f,'dd-mm');
			ultimaFecha := TO_DATE(fecha,'dd-mm-yyyy');
			ff := TO_CHAR(ultimaFecha,'dd-mm');
			ultimaFecha := TO_DATE(ff,'dd-mm');
			IF (fechaAux = ultimaFecha ) THEN
				feriado := 'FERIADO';
			END IF;
		END LOOP;
	END LOOP;

RETURN feriado;
END;
