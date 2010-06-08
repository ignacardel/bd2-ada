create role administrador;
create role maestro;
create role vendedor;
create role comprador;
create role productor;

grant insert, select on lugar to vendedor;
grant select on empresa to vendedor;
grant select on tour to vendedor;
grant select, insert, update on grupo_tour to vendedor;
grant select, insert, update on entrada to vendedor;
grant select on fabrica_has_tour to vendedor;
grant select on fabrica to vendedor;

grant insert, select on lugar to comprador;
grant select on empresa to comprador;
grant select, insert, update on proveedor to comprador;
grant select, insert, update on variedad_has_lugar to comprador;
grant select, insert, update on variedad to comprador;
grant select, insert, update on materia_prima to comprador;
grant select, insert, update on catalogo_materia to comprador;
grant select on descuento_pedido to comprador;
grant select, insert, update on pedido_has_catalogo to comprador;
grant select, insert, update on equipo to comprador;
grant select, insert, update on pedido to comprador;
grant select, insert, update on catalogo_equipos to comprador;

grant insert, select on lugar to productor;
grant select on empresa to productor;
grant select on tipo to productor;
grant select on cerveza_catalogo to productor;
grant select on presentacion to productor;
grant select on variedad to productor;
grant select on elaboracion to productor;
grant select on materia_prima to productor;
grant select, insert, update on produccion to productor;
grant select on materia_prima_has_proceso to productor;
grant select, insert, update on descuento_pedido to productor;
grant select on pedido_has_catalogo to productor;
grant select on proceso to productor;
grant select on equipo_has_proceso to productor;
grant select on equipo to productor;

grant insert, select on lugar to maestro;
grant select on empresa to maestro;
grant select, insert, update on tipo to maestro;
grant select, insert, update on cerveza_catalogo to maestro;
grant select, insert, update on presentacion to maestro;
grant select, insert, update on presentacion_has_lugar to maestro;
grant select on variedad_has_lugar to maestro;
grant select on variedad to maestro;
grant select, insert, update on elaboracion to maestro;
grant select on materia_prima to maestro;
grant select, insert, update on materia_prima_has_proceso to maestro;
grant select, insert, update on proceso to maestro;
grant select, insert, update on equipo_has_proceso to maestro;
grant select on equipo to maestro;

grant insert, select on lugar to administrador;
grant select, insert, update on bar to administrador;
grant select, insert, update on historia to administrador;
grant select, insert, update on evento to administrador;
grant select, insert, update on empresa to administrador;
grant select, insert, update on empresa_has_evento to administrador;
grant select, insert, update on tour to administrador;
grant select on grupo_tour to administrador;
grant select on proveedor to administrador;
grant select on entrada to administrador;
grant select, insert, update on fabrica_has_tour to administrador;
grant select, insert, update on fabrica to administrador;
grant select on tipo to administrador;
grant select on cerveza_catalogo to administrador;
grant select on presentacion to administrador;
grant select on presentacion_has_lugar to administrador;
grant select on variedad to administrador;
grant select on elaboracion to administrador;
grant select on materia_prima to administrador;
grant select on produccion to administrador;
grant select on descuento_pedido to administrador;
grant select on pedido_has_catalogo to administrador;
grant select on proceso to administrador;
grant select on equipo to administrador;
grant select on pedido to administrador;


create user gerente1
identified by gerente
default tablespace users;
create user gerente2
identified by gerente
default tablespace users;
create user gerente3
identified by gerente
default tablespace users;

create user maestro1
identified by maestro
default tablespace users;
create user maestro2
identified by maestro
default tablespace users;
create user maestro3
identified by maestro
default tablespace users;


create user productor1
identified by productor
default tablespace users;
create user productor2
identified by productor
default tablespace users;
create user productor3
identified by productor
default tablespace users;

create user comprador1
identified by comprador
default tablespace users;
create user comprador2
identified by comprador
default tablespace users;
create user comprador3
identified by comprador
default tablespace users;

create user vendedor1
identified by vendedor
default tablespace users;
create user vendedor2
identified by vendedor
default tablespace users;
create user vendedor3
identified by vendedor
default tablespace users;

CREATE USER ADMINISTRADOR_BD
IDENTIFIED BY ADMINISTRADOR_BD;

GRANT DBA TO ADMINISTRADOR_BD;

grant maestro to maestro1, maestro2, maestro3;
grant vendedor to vendedor1, vendedor2, vendedor3;
grant productor to productor1, productor2, productor3;
grant comprador to comprador1, comprador2, comprador3;
grant administrador to gerente1, gerente2, gerente3;