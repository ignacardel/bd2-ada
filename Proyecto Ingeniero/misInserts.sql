rem / LUGAR /
INSERT INTO LUGAR VALUES (S_LUGAR.NEXTVAL, 'BRISBANE', 'CIUDAD', NULL, NULL, v_feriado(to_date('01/01','dd/mm'),to_date('15/08','dd/mm'),to_date('25/12','dd/mm')), 9);

rem / HISTORIA /
INSERT INTO HISTORIA VALUES (S_HISTORIA.NEXTVAL, 'NUMEROSOS ANTROPOLOGOS ASEGURAN QUE HACE CIEN MIL ANOS EL HOMBRE PRIMITIVO ELABORABA UNA BEBIDA A BASE DE RAICES DE CEREALES Y FRUTOS SILVESTRES QUE ANTES MASTICABA PARA DESENCADENAR SU FERMENTACION ALCOHOLICA; EL LIQUIDO RESULTANTE LO CONSUMIA CON DELEITE PARA RELAJARSE','MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM','A.C');
INSERT INTO HISTORIA VALUES (S_HISTORIA.NEXTVAL, 'LA MENCION MAS ANTIGUA DE LA CERVEZA, "UNA BEBIDA OBTENIDA POR FERMENTACION DE GRANOS QUE DENOMINAN SIRAKU", SE HACE EN UNAS TABLAS DE ARCILLA ESCRITAS EN LENGUAJE SUMERIO Y CUYA ANTIGUEDAD SE REMONTA A 4.000 ANOS A. C. EN ELLAS SE REVELA UNA FORMULA DE ELABORACION CASERA DE LA CERVEZA: SE CUECE PAN, SE DESHACE EN MIGAS, SE PREPARA UNA MEZCLA EN AGUA Y SE CONSIGUE UNA BEBIDA QUE TRANSFORMA LA GENTE EN "ALEGRE, EXTROVERTIDA Y FELIZ".','MMMM','A.C');
INSERT INTO HISTORIA VALUES (S_HISTORIA.NEXTVAL, 'EN LA EDAD MEDIA NACERIA LA "CEREVISA MONACORUM", CERVEZA DE LOS MONJES CON DENOMINACION DE ORIGEN, CUYO SECRETO GUARDABA CELOSAMENTE CADA FRAILE BOTICARIO. LOS MONJES LOGRARON MEJORAR EL ASPECTO, EL SABOR Y EL AROMA DE LA BEBIDA.','V','D.C');
INSERT INTO HISTORIA VALUES (S_HISTORIA.NEXTVAL, 'ENTRE LOS SIGLOS XIV Y XVI SURGEN LAS PRIMERAS GRANDES CERVECERIAS, ENTRE LAS QUE DESTACAN LAS DE HAMBURGO Y ZIRTAU.','XIV','D.C');
INSERT INTO HISTORIA VALUES (S_HISTORIA.NEXTVAL, 'A FINALES DEL SIGLO XV, EL DUQUE DE RAVIERA GUILLERMO IV PROMULGA LA PRIMERA LEY DE PUREZA DE LA CERVEZA ALEMANA, QUE PRESCRIBIA EL USO EXCLUSIVO DE MALTA DE CEBADA, AGUA, LUPULO Y LEVADURA EN SU FABRICACION.','XV','D.C');
INSERT INTO HISTORIA VALUES (S_HISTORIA.NEXTVAL, 'LA AUTENTICA EPOCA DORADA DE LA CERVEZA COMIENZA A FINALES DEL SIGLO XVIII CON LA INCORPORACION DE LA MAQUINA DE VAPOR A LA INDUSTRIA CERVECERA Y EL DESCUBRIMIENTO DE LA NUEVA FORMULA DE PRODUCCION EN FRIO, Y CULMINA EN EL ULTIMO TERCIO DEL SIGLO XIX, CON LOS HALLAZGOS DE PASTEUR RELATIVOS AL PROCESO DE FERMENTACION.','XIX','D.C');

rem / EMPRESA /
INSERT INTO EMPRESA VALUES (S_EMPRESA.NEXTVAL, 'CASTLEMAINE PERKINS',t_paginaweb('WWW.XXXX.COM.AU','INTERNACIONAL'), 'BLACK ST MILTON QLD 4064', nt_historia(t_historia(to_date('1842','yyyy'),'BRISBANE LA CIUDAD ES ESTABLECIDA COMO UNA COLONIA PENAL'),t_historia(to_date('1857','yyyy'),'EDWARD FITZGERAL LLEGA A CASTLEMAINE, VICTORIA PORCEDE A CONSTRUIR UNA FABRICA DE CERVEZA'),t_historia(to_date('1866','yyyy'),'LOS HERMANOS PERKINS COMPRA DE LA FABRICA DE CERVEZA DE LA CIUDAD DE BRISBANE EN MARY STREET. ELLOS VENDIERON SU INTERES EN LA CERVECERIA CASTLEMAINE Y SE TRASLADO A QUEENSLAND'),t_historia(to_date('1877','yyyy'),'FITZGERALD, QUINLAN & CO Y SE FORMA LA COMPANIA ADQUIERE LA DESTILERIA DE MILTON EN EL SITIO DE LA ACTUAL FABRICA DE CERVEZA'),t_historia(to_date('1878','yyyy'),'LA CERVECERIA CASTLEMAINE COMENZO CERVECERA EN MILTON. EL PRIMER LOTE DE CERVEZA ESTABA LISTO PARA LA VENTA Y XXX SPARKLING ALE FUE LANZADO AL P�BLICO EXPECTANTE'),t_historia(to_date('1880','yyyy'),'LA PRIMERA LINEA TELEFONICA EN QUEENSLAND ESTA INSTALADO, QUE UNE LA CERVECERIA CASTLEMAINE CON LA OFICINA DE LA CIUDAD DE LA EMPRESA'),t_historia(to_date('1888','yyyy'),'LA DESTILERIA DE MILTON, EN EL MISMO SITIO QUE LA FABRICA DE CERVEZA CASTLEMAINE SE APAGA DE FORMA PERMANENTE'),t_historia(to_date('1889','yyyy'),'LA CERVECERIA CASTLEMAINE SE CONVIRTIO EN LA PRIMERA CERVECERIA EN QUEENSLAND PARA PRODUCIR LAS CERVEZAS LAGER'),t_historia(to_date('1920','yyyy'),'EXPERIMENTANDO PROBLEMAS T�CNICOS, LA FABRICA EMPLEA RECONOCIDA EN ALEMANIA BREWER ALHOIS WILLIAM (BILL) LEITNER'),t_historia(to_date('1924','yyyy'),'XXXX BITTER ALE SE INTRODUJO POR PRIMERA VEZ. SR. FOUREX APARECE POR PRIMERA VEZ PARA APOYAR EL LANZAMIENTO DE XXXX BITTER ALE. LA PRIMERA EMPRESA QUE INCLUYE DIBUJO DE UN ARTISTA DE LA FABRICA DE CERVEZA EN SUS ETIQUETAS DE CERVEZA. CARABINA STOUT PRODUCIDO'),t_historia(to_date('1928','yyyy'),'LA ADQUISICION DE PERKINS & CO LTD PERKINS HIZO CASTLEMAINE LA CERVECERIA MAS GRANDE DE QUEENSLAND'),t_historia(to_date('1950','yyyy'),'EL SIGNO XXXX ES CONSTRUIDO E INSTALADO EN LA PARTE SUPERIOR DE LA TORRE'),t_historia(to_date('1971','yyyy'),'XXXX PRESENTO CALADO - LA NUEVA CERVEZA PRIMERA ANADIDO A LA GAMA FOUREX QUE EN ESTE MOMENTO CONSISTE EN XXXX BITTER ALE Y CARABINA STOUT'),t_historia(to_date('1974','yyyy'),'DESPU�S DE UNA GRAN INUNDACION A PRINCIPIOS DE ANO, UN GRAN INCENDIO EN LA FABRICA DE CERVEZA CAUSAS $ 1,25 EL VALOR DE LOS DANOS. CASTLEMAINE DL (DIETA LAGER) SE INTRODUCE. UNA SALA DE COCCION ADICIONAL ESTA INSTALADA PARA SATISFACER LA CRECIENTE DEMANDA'),t_historia(to_date('1979','yyyy'),'PRIMERO DE QUEENSLAND CERVEZA REDUCIDO ALCOHOL, XXXX LITE, EN LIBERTAD'),t_historia(to_date('1982','yyyy'),'CASTLEMAINE ES UN IMPORTANTE PATROCINADOR DE LOS JUEGOS DE LA COMMONWEALTH Y LANZA "JUEGOS LAGER ESPECIAL" PARA CONMEMORAR EL EVENTO'),t_historia(to_date('1988','yyyy'),'7-METROS DE ALTURA, EL SR. NEON FOUREX - INSTALADO EN EL LADO DE LA FABRICA DE CERVEZA'),t_historia(to_date('1989','yyyy'),'DOS NUEVAS CERVEZAS INTRODUJO - CASTLEMAINE 2,2 AMARGO Y SECO CASTLEMAINE ESPECIAL'),t_historia(to_date('1991','yyyy'),'XXXX GOLD MARCHA. AMARGA LUZ XXXX ES TAMBI�N PRESENTO (2,75% ABV NOTA: EN LA ACTUALIDAD EL 2,3% ABV) 50 BARRILES DE LITRO SE HAN INTRODUCIDO, CON LA PARTICIPACION DE LA INSTALACION DE UNA NUEVA LINEA DE ENVASADO TOTALMENTE AUTOMATICA. XXXX XXXX ORIGINAL SE CONVIERTE CALADO CALADO'),t_historia(to_date('1999','yyyy'),'LOS ROLLOS DE 5 MIL MILLONES REGORDETES DE LA LINEA DE PRODUCCION. PARTE DE LA ANTIGUA FABRICA DE CERVEZA ES DEMOLIDA PARA DAR PASO A LA NUEVA SALA DE COCCION, Y 5000 LADRILLOS DE LA ANTIGUA FABRICA DE CERVEZA SE VENDEN COMO RECUERDOS DE LA RECAUDACION DE $ 20.000 PARA LA CARIDAD'),t_historia(to_date('2003','yyyy'),'XXXX ALE HOUSE ABRIO SUS PUERTAS'),t_historia(to_date('2006','yyyy'),'30 LEYENDAS DEL CRICKET INTERNACIONAL GOLPEO LA ARENA PARA LA INTERPRETACION DE LA MAYORIA DE LOS AUSTRALIANOS DEL JUEGO - EL PRIMERO XXXX GOLD BEACH CRICKET DE LAS TRES NACIONES'),t_historia(to_date('2007','yyyy'),'LOS ANGELINOS XXXX LLEGO AL ESCENARIO - UN GRUPO DE SIETE BAILARINES PROFESIONALES QUE GIRA ALREDEDOR DE AUSTRALIA COMO EMBAJADORES DE LA XXXX'),t_historia(to_date('2008','yyyy'),'LA PRIMERA XXXX GOLD V8 SUPERCARS EMBAJADOR LOS CONDUCTORES ESTAN ANUNCIADOS. ESTAS CLASES PRINCIPALES PILOTOS DE CARRERA AMPLIAR NUESTRA LARGA V8 SUPERCARS PATROCINIO DEJANDO FANS ACERCARSE MAS QUE NUNCA A LA VIDA EN LOS EQUIPOS DE LA RAZA, EN LOS BOXES Y DETRAS DEL VOLANTE')), to_date('1857','yyyy'), NULL, 34,'FAMILIA PERKINS', 2);

rem / TIPO /
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'LAGER', t_temperatura(6.8, 'CENTIGRADO'), '10-15', 'ES UN TIPO DE CERVEZA INGLESA, DERIVADA ORIGINALMENTE DE LA PALE ALE (CERVEZA INGLESA PALIDA). UNA VERSION MAS FUERTE DE LA MISMA SE HA CONVERTIDO EN UNA POPULAR CERVEZA EN BOTELLA.', v_alimento('Pastas, Carnes a la parrilla'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'BITTER', t_temperatura(6.8, 'CENTIGRADO'), '15-20', 'ES UN TIPO DE CERVEZA CON SABOR ACENTUADO QUE SE SIRVE FRIA, CARACTERIZADA POR FERMENTAR EN CONDICIONES MAS LENTAS EMPLEANDO LEVADURAS ESPECIALES, Y QUE EN LAS �LTIMAS PARTES DEL PROCESO SON ALMACENADAS EN BODEGAS DURANTE UN PERIODO DE TIEMPO EN CONDICIONES DE BAJA TEMPERATURA CON EL OBJETO DE LIMPIAR LAS PARTICULAS RESIDUALES Y ESTABILIZAR LOS SABORES', v_alimento('Alimentos picantes'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'LIGHT BITTER', t_temperatura(6.8, 'CENTIGRADO'), '5-10', 'ES SIMILAR AL TIPO BITTER, PERO CON UN SABOR MENOS FUERTE".', v_alimento('Costillas, Granos'));
INSERT INTO TIPO VALUES (S_TIPO.NEXTVAL, 'DRAUGHT', t_temperatura(5.3, 'CENTIGRADO'), '15-20', 'CERVEZA DE BARRIL".', v_alimento('Pollo,Carne'));

rem / CERVEZA_CATALOGO /
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'XXXX GOLD', NULL, 3.5, NULL, NULL, to_date('1991','yyyy'), NULL, 'LANZADO ORIGINALMENTE COMO XXXX LITE EN LA D�CADA DE 1970, ESTE PRODUCTO ES UNO DE LAS PRINCIPALES CERVEZAS DE ALCOHOL MEDIDOS POR LO FUERTE.', t_infnutricional(2, 100), 'FUERTE', NULL, 4, 8);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'XXXX BITTER',nt_pagweb(t_paginaweb('WWW.XXXX.COM.AU','NACIONAL')), 4.6, 'XXXX BITTER', NULL, to_date('1924','yyyy'), NULL, 'CERVEZA AUSTRALIANA TRADICIONALES CON UN SABOR LIMPIO, FRESCO Y UNA SATISFACCION DESPU�S DE LA AMARGURA. XXXX DELICADO AROMA AMARGO PROVIENE DE LA MEZCLA DE DOS VARIEDADES DE L�PULO Y UN DULCE, SABOR AFRUTADO DE LA LEVADURA. POTABILIDAD DE ALTA EN LOS CLIMAS CALIDOS.', t_infnutricional(3,100), 'FUERTE', NULL, 4, 9);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'XXXX LIGHT',NULL,2.3, NULL, NULL, to_date('1991','yyyy'), NULL,'POR LA FRIALDAD T�CNICA DE FILTRADO ESPECIAL QUE BLOQUEA EN EL SABOR A TEMPERATURAS BAJO CERO. ESTO SIGNIFICA QUE NO HAY COMPROMISO DE SABOR A PESAR DEL BAJO CONTENIDO EN ALCOHOL.', t_infnutricional(3,100), 'SUAVE', NULL, 4, 10);
INSERT INTO CERVEZA_CATALOGO VALUES (S_CERVEZA.NEXTVAL, 'XXXX ORIGINAL DRAUGHT',NULL,4.8, NULL, NULL, to_date('1995','yyyy'), NULL,'ESTA CERVEZA ES EFECTIVAMENTE XXXX BITTER ALE CON MENOS DE DI�XIDO DE CARBONO, REDUCIENDO AS� LA "FLATULENCIA"', t_infnutricional(3,100), 'FUERTE', v_temporada('VERANO'), 4, 11);

rem / PRESENTACION /
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 375, 'BOTELLA', 'ML', 8, 4);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 375, 'LATA', 'ML', 8, 4);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 375, 'BOTELLA', 'ML', 9, 4);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 375, 'LATA', 'ML', 9, 4);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 375, 'BOTELLA', 'ML', 10, 4);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 375, 'LATA', 'ML', 10, 4);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 375, 'BOTELLA', 'ML', 11, 4);
INSERT INTO PRESENTACION VALUES (S_PRESENTACION.NEXTVAL, 375, 'LATA', 'ML', 11, 4);

rem / PRESENTACION_has_LUGAR /
INSERT INTO PRESENTACION_has_LUGAR VALUES (14, 8, 4, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (15, 8, 4, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (16, 9, 4, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (17, 9, 4, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (18, 10, 4, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (19, 10, 4, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (20, 11, 4, 9);
INSERT INTO PRESENTACION_has_LUGAR VALUES (21, 11, 4, 9);

rem / FABRICA /
INSERT INTO FABRICA VALUES (S_FABRICA.NEXTVAL, to_date('1857','yyyy'), 4, 34);

rem / TOUR /
INSERT INTO TOUR VALUES (S_TOUR.NEXTVAL, 22.00, nt_descuento(t_descuento(9, 0, 'CONCESION'),t_descuento(9, 10, 'GRUPO'),t_descuento(18, 0, 'ADULTOS NO BEBEDORES'),t_descuento(31, 0, 'NINO ENTRE 10 Y 18'),t_descuento(100, 0, 'NINOS MENORES DE 10')), t_rangoedad(18,80), nt_horario(t_horario('LUNES', 1100, 1600, 1),t_horario('MARTES', 1100, 1600, 1),t_horario('MIERCOLES', 1100, 1600, 1),t_horario('JUEVES', 1100, 1600, 1),t_horario('VIERNES', 110, 1600, 1),t_horario('SABADO', 1600, 1700, 1),t_horario('DOMINGO', 1230, 1400, 1)), 150, v_formapago('EFECTIVO','MASTERCARD','VISA'), nt_reqadq(t_reqad(60,'DIA')), v_requisito('No traer animales','Si es menor de edad venir acompanado de un representante'));

rem / FABRICA_has_TOUR /
INSERT INTO FABRICA_has_TOUR VALUES (7, 6, 4);

rem / BAR /
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'IRISH MURPHYS', '175 GEORGE STREET', 4000, t_telefono(6107, 32214377, 'TRABAJO'), 34);
INSERT INTO BAR VALUES (S_BAR.NEXTVAL, 'CRITERION TAVERN', 'CNR ADELAIDE STREET & GEORGE STREET', 4000, t_telefono(6107, 32217411, 'TRABAJO'), 34);

rem / EVENTO /
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'XXXX SUMMER BRIGHT LARGE', 'EVENTO MUSICAL');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'IN THE DRIVERS SEAT @ SYDNEY 500 ', 'EVENTO AUTOMOVILISTICO');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'A XXXX CHRISTMAS', 'EVENTO PROMOCIONAL, DONDE RECORREN LA CIUDAD REGALANDO CERVEZAS EN NAVIDAD');
INSERT INTO EVENTO VALUES (S_EVENTO.NEXTVAL, 'XXXX ANGELS @ THE SYDNEY V8S ', 'EVENTO AUTOMOVILISTICO');

rem / EMPRESA_has_EVENTO /
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 4, 11, 'EVENTO MUSICAL QUE SE REALIZA TODOS LOS VERANOS', to_date('15/08/2009','dd/mm/yyyy'), 34);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 4, 12, 'EVENTO AUTOMOVILISTICO', to_date('17/12/2009','dd/mm/yyyy'), 29);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 4, 13, 'EVENTO PROMOCIONAL DE NAVIDAD', to_date('12/2009','mm/yyyy'), 34);
INSERT INTO EMPRESA_has_EVENTO VALUES (S_EMPRESA_EVENTO.NEXTVAL, 4, 14, 'EVENTO AUTOMOVILISTICO', to_date('20/12/2009','dd/mm/yyyy'), 29);

rem / GRUPO_TOUR /
INSERT INTO GRUPO_TOUR VALUES (S_GRUPO_TOUR.NEXTVAL, 'ESTUDIANTES DE INGENIERIA INFORMATICA UCAB', 10, 7, 6, 4);  

rem / ENTRADA /
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('11/01/2010','dd/mm/yyyy'), 1100, 'ADULTO', 200.00, 'VISA', 7, 6, 4, 4, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('03/02/2009','dd/mm/yyyy'), 1100, 'ADULTO', 22.00, 'MASTERCARD', 7, 6, 4, NULL, NULL);
INSERT INTO ENTRADA VALUES (S_ENTRADA.NEXTVAL, to_date('03/02/2009','dd/mm/yyyy'), 1100, 'ADULTO', 18.00, 'MASTERCARD', 7, 6, 4, NULL, NULL);
