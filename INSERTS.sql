rem / INSERTS /

rem / INSERTS LUGAR /

INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL,'PAIS','ESTADOS UNIDOS','ESTADOUNIDENSE',NULL);
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL,'ESTADO','CALIFORNIA',NULL,(SELECT LUGA_ID FROM LUGAR WHERE LUGA_NOMBRE = 'ESTADOS UNIDOS'));
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL,'CIUDAD','HOLLYWOOD',NULL,(SELECT LUGA_ID FROM LUGAR WHERE LUGA_NOMBRE = 'CALIFORNIA' AND LUGA_TIPO = 'ESTADO'));
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL,'CIUDAD','LOS ANGELES',NULL,(SELECT LUGA_ID FROM LUGAR WHERE LUGA_NOMBRE = 'CALIFORNIA' AND LUGA_TIPO = 'ESTADO'));


rem / INSERTS CEREMONIA /

INSERT INTO CEREMONIA VALUES (S_CEREMONIA.NEXTVAL,to_date('20/05/1952','dd/mm/yyyy'),24,'RKO Pantages Theatre',NULL,(SELECT LUGA_ID FROM LUGAR WHERE LUGA_NOMBRE = 'HOLLYWOOD' AND LUGA_TIPO = 'CIUDAD')); 
INSERT INTO CEREMONIA VALUES (S_CEREMONIA.NEXTVAL,to_date('25/05/1985','dd/mm/yyyy'),57,'Dorothy Chandler Pavillion',NULL,(SELECT LUGA_ID FROM LUGAR WHERE LUGA_NOMBRE = 'LOS ANGELES' AND LUGA_TIPO = 'CIUDAD')); 
INSERT INTO CEREMONIA VALUES (S_CEREMONIA.NEXTVAL,to_date('24/05/1986','dd/mm/yyyy'),28,'Dorothy Chandler Pavillion',NULL,(SELECT LUGA_ID FROM LUGAR WHERE LUGA_NOMBRE = 'HOLLYWOOD' AND LUGA_TIPO = 'CIUDAD')); 


rem / INSERTS PREMIO_CATEGORIA /

INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,1,'Rama de actuacion del cine.',nt_nombre(t_nombre('Actores',to_date('01/01/1928','dd/mm/YYYY'),NULL)),'Estatuilla',NULL);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,1,'Rama de guionistas del cine.',nt_nombre(t_nombre('Guionistas',to_date('01/01/1928','dd/mm/YYYY'),NULL)),'Estatuilla',NULL);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,1,'Rama de direccion del cine.',nt_nombre(t_nombre('Directores',to_date('01/01/1928','dd/mm/YYYY'),NULL)),'Estatuilla',NULL);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,1,'Rama de produccion del cine.',nt_nombre(t_nombre('Productores',to_date('01/01/1928','dd/mm/YYYY'),NULL)),'Estatuilla',NULL);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,1,'Rama tecnica del cine.',nt_nombre(t_nombre('Tecnicos',to_date('01/01/1928','dd/mm/YYYY'),NULL)),'Estatuilla',NULL);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de la produccion referida a los largometrajes, es decir, peliculas de mas de 60 min.',nt_nombre(t_nombre('Largometrajes',to_date('1/1/1928','dd/mm/yyyy'),NULL)),'Estatuilla',4);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de la produccion referida a los cortometrajes, es decir, peliculas de menos de 60 min.',nt_nombre(t_nombre('Cortometrajes',to_date('1/1/1931','dd/mm/yyyy'),NULL)),'Estatuilla',4);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los directores enfocados en la direccion general',nt_nombre(t_nombre('Direccion',to_date('1/1/1928','dd/mm/yyyy'),NULL)),'Estatuilla',3);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los actores enfocada en la actuacion',nt_nombre(t_nombre('Actuacion',to_date('1/1/1928','dd/mm/yyyy'),NULL)),'Estatuilla',1);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los guionistas enfocada en la escritura',nt_nombre(t_nombre('Escritura',to_date('1/1/1928','dd/mm/yyyy'),NULL)),'Estatuilla',1);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los tecnicos enfocada en la fotografia',nt_nombre(t_nombre('Fotografia',to_date('1/1/1928','dd/mm/yyyy'),NULL)),'Estatuilla',5);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los directores enfocada a la direccion de arte',nt_nombre(t_nombre('Direccion de Arte',to_date('1/1/1928','dd/mm/yyyy'),NULL)),'Estatuilla',3);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los tecnicos enfocada en el sonido',nt_nombre(t_nombre('Sonido',to_date('1/1/1930','dd/mm/yyyy'),NULL)),'Estatuilla',5);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los tecnicos enfocada en la musica',nt_nombre(t_nombre('Musica',to_date('1/1/1934','dd/mm/yyyy'),NULL)),'Estatuilla',5);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los tecnicos enfocada en la edicion',nt_nombre(t_nombre('Edicion',to_date('1/1/1935','dd/mm/yyyy'),NULL)),'Estatuilla',5);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los tecnicos enfocada en los efectos visuales',nt_nombre(t_nombre('Efectos Visuales',to_date('1/1/1939','dd/mm/yyyy'),NULL)),'Estatuilla',5);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los productores enfocada en los documentales',nt_nombre(t_nombre('Documentales',to_date('1/1/1934','dd/mm/yyyy'),NULL)),'Estatuilla',4);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los tecnicos enfocada en los vestuarios',nt_nombre(t_nombre('Musica',to_date('1/1/1948','dd/mm/yyyy'),NULL)),'Estatuilla',5);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los productores enfocada en peliculas extranjeras',nt_nombre(t_nombre('Peliculas Extranjeras',to_date('1/1/1956','dd/mm/yyyy'),NULL)),'Estatuilla',4);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los tecnicos enfocada en el maquillaje',nt_nombre(t_nombre('Maquilaje',to_date('1/1/1981','dd/mm/yyyy'),NULL)),'Estatuilla',5);
INSERT INTO PREMIO_CATEGORIA VALUES(S_PREMIO.NEXTVAL,2,'Division de los productores enfocada en las peliculas animadas',nt_nombre(t_nombre('Peliculas Animadas',to_date('1/1/2001','dd/mm/yyyy'),NULL)),'Estatuilla',4);


rem / INSERTS ROL /

INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'DIRECTOR',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'ACTOR PRINCIPAL',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'ACTRIZ PRINCIPAL',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'ACTOR DE REPARTO',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'ACTRIZ DE REPARTO',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'PRODUCTOR',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'MUSICO',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'DIRECTOR ARTE',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'MAQUILLISTA',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'EDITOR',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'VESTUARISTA',NULL);
INSERT INTO ROL VALUES(S_ROL.NEXTVAL,'SONIDISTA',NULL);