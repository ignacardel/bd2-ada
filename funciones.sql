CREATE OR REPLACE 
FUNCTION "calcularEdad" (fecha  DATE)
RETURN NUMBER
AS
	dias INT;
BEGIN
	SELECT (sysdate - fecha)/365 INTO dias  FROM DUAL;
	RETURN dias;
END;

CREATE OR REPLACE 
FUNCTION "calcularAno" (fecha  DATE)
RETURN VARCHAR2
AS
	anos varchar2(4);
BEGIN
	anos := TO_CHAR(fecha,'yyyy');
	RETURN anos;
END;