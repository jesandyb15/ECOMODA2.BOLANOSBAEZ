DROP SCHEMA IF EXISTS ECOMODA2;
CREATE SCHEMA ECOMODA2;
USE ECOMODA2;


CREATE TABLE materiales (
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(45) NOT NULL UNIQUE,
    tipo ENUM('hilo', 'tela'),
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);


CREATE TABLE proveedores (
    nombre_proveedor VARCHAR(25) NOT NULL PRIMARY KEY,
    id_material INT NOT NULL,
    descripcion_material VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    telefono INT NOT NULL,
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
);


CREATE TABLE orden_compra (
    id_orden_compra INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(25) NOT NULL,
    id_material INT NOT NULL,
    cantidad INT NOT NULL,
    precio DOUBLE NOT NULL,
    FOREIGN KEY (nombre_proveedor) REFERENCES proveedores(nombre_proveedor),
    FOREIGN KEY (id_material) REFERENCES materiales(id_material)
);


CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(45) NOT NULL UNIQUE,
    cantidad INT NOT NULL,
    precio_unidad DOUBLE NOT NULL
);


CREATE TABLE clientes (
    nombre_cliente VARCHAR(45) PRIMARY KEY,
    id_producto INT NOT NULL,
    descripcion_producto VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    telefono INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (descripcion_producto) REFERENCES productos(descripcion)
);

CREATE TABLE orden_venta (
    id_orden_venta INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(45) NOT NULL,
    id_producto INT NOT NULL,
    descripcion_producto VARCHAR(45) NOT NULL,
    cantidad INT NOT NULL,
    precio DOUBLE NOT NULL,
    FOREIGN KEY (nombre_cliente) REFERENCES clientes(nombre_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (descripcion_producto) REFERENCES productos(descripcion)
);


CREATE TABLE cuentas_cobrar (
    id_cuenta_cobrar INT AUTO_INCREMENT PRIMARY KEY,
    documento_referencia INT NOT NULL,
    estado ENUM('por cobrar', 'saldada') NOT NULL,
    valor DOUBLE NOT NULL,
    FOREIGN KEY (documento_referencia) REFERENCES orden_venta(id_orden_venta)

);

DROP TABLE IF EXISTS Cuentas_pagar;
CREATE TABLE cuentas_pagar (
    id_cuentas_pagar INT AUTO_INCREMENT PRIMARY KEY,
    documento_referencia INT NOT NULL,
    estado ENUM('por pagar', 'saldada') NOT NULL,
    valor DOUBLE NOT NULL,
    FOREIGN KEY (documento_referencia) REFERENCES orden_compra(id_orden_compra)
);



-- INSERCION  DATOS

use ECOMODA2;
insert into materiales(id_material, descripcion, tipo, cantidad, precio)
values
(00101,     'Tela seda azul'      ,      'tela',   1000,   800.0000),
(00102,     'hilo negro',                'hilo',   150,    2.100),
(00103,     'tela poliester blanco',     'tela',   2500,   1.300000),
(00104,       'hilo blanco',               'hilo',   300,    5.000),
(00105,       'tela algodon negro',       'tela',    500,    500), 
(00106,       'hilo azul',                 'hilo',   350,    450),
(00107,       'tela seda rosa',           'tela',    7000,   300.000),
(00108,       'hilo rosa',                'hilo',    400,    7.000),
(00109,       'tela algodon blanco',      'tela',    9500,   900.000),
(00110,       'hilo rojo',                'hilo',    800,    900),
(00111,       'tela poliester verde',     'tela',    9000,   450.000),
(00112,       'hilo verde' ,               'hilo',   225,    800),
(00113,      'tela poliester azul oscuro', 'tela',   800,    50.000),
(00114,       'hilo azul oscuro' ,         'hilo' ,   200,    600),
(00115,      'Tela Rojo Carmin',           'tela' ,   500, 5500)
;

select * from ecomoda.materiales;

insert into proveedores(nombre_proveedor, id_material, descripcion_material, direccion, telefono)
values
 ('william chams',      101, 'Tela seda azul' ,      'avenida flores 23',  89646232),
 ('hilarium',            102, 'hilo negro',                   'calle 78-126' ,      45334334),
 ('telarium',           103, 'tela poliester blanco',  'avenida chile 45' , 2483323), 
 (' telaris',            104, 'hilo blanco', '               avenida cali 42' , 50383943),
 ('mega tex' ,           105, 'tela algodon negro',           'carrera 112-34' , 323534),
 (' textex',             106,  'hilo azul', 'calle sol 14' , 12232133),
 ('elixis tela',         107,  'tela seda rosa',            'calle 234-89', 243234898),
 ('hilar',              108,  'hilo rosa',      'calle 47-23' , 12313241),
 ('hilos de colombia',  109, 'tela algodon blanco',           'calle 56-123',      234234234),
 (' hilos max',          110,  'hilo rojo', ' calle 14-90' , 39898488),
   (' telimax',          111,  'tela poliester verde',        'avenida 40-345', 233243), 
  ('maxi tela',          112, 'hilo verde'  ,         'calle 45-89',         234198373),
  (' textiler',          113, 'tela poliester azul oscuro',   'avenida 34-98', 37234234),
 ('colombia tela',      114, 'hilo azul oscuro',     'calle 18-25',       23323232),
 ('facol',              115, 'Tela Rojo Carmin',                     'calle 45-32',       234342332)
 ;
 
 select * from proveedores;
 update proveedores set direccion = 'avenida cali 42' where id_material = 104;
select * from proveedores;

insert into orden_compra (id_orden_compra, nombre_proveedor, id_material, cantidad, precio)
values
(5555, 'william chams',      101, 500, 800),
 (5556, 'hilarium',          102, 30, 1050),
 (5557, 'telarium',           103, 40, 3000), 
 (5558, ' telaris',           104, 600, 7800),
 (5559, 'mega tex',           105, 700, 595),
 (5560, ' textex',             106, 820, 4000),
 (5561, 'elixis tela',         107,  200, 3020),
 (5562, 'hilar',              108,  350, 446),
 (5563, 'hilos de colombia',  109, 35, 850),
 (5564, ' hilos max',          110,  80, 1000),
 (5565, ' telimax',          111,  90, 2000), 
 (5566, 'maxi tela',          112, 50, 3500),
 (5567, ' textiler',          113, 120, 700),
 (5568, 'colombia tela',      114, 1000, 1600),
 (5569, 'facol',              115, 300, 450)
 ;
 
 insert into productos(id_producto, descripcion, cantidad, precio_unidad)
 values
 (201 , 'Vestidos azul oscuro largo - talla s',20, 250),
(202, 'Vestidos azul oscuro largo - talla m', 30, 250);
insert into productos(id_producto, descripcion, cantidad, precio_unidad)
 values
(203, 'Vestidos azul oscuro largo - talla l', 25, 250),
(204, 'Vestidos azul oscuro largo - talla xl', 40, 250),
(205, 'Vestido primavera corto - talla s', 15, 180),
(206, 'Vestido primavera corto - talla m', 35, 180),
(207, 'Vestido primavera corto - talla l', 50, 180),
(208, 'Vestido primavera corto - talla xl', 50, 180), 
(209, 'Falda negra plisada ', 10, 300),
(210, 'chaqueta rosa', 20, 200),
(211, 'camisa seda otono verde',55, 100),
(212, 'camisa  otono azul', 34, 90),
(213, 'camisa seda otono blanca', 80, 120),
(214, 'Camiseta  multicolor - talla s', 35, 150),
(215, 'Camiseta  multicolor - talla m', 89, 150)
;
insert into clientes(nombre_cliente, id_producto, descripcion_producto, direccion, telefono)
values
('moda y estilo' , 201, 'Vestidos azul oscuro largo - talla s', 'calle 50-22' , 6253434),
('jeans y mas', 202, 'Vestidos azul oscuro largo - talla m', 'calle 50-24' , 625234324)
;
insert into clientes(nombre_cliente, id_producto, descripcion_producto, direccion, telefono)
values
('palacio de la pantaleta' , 203, 'Vestidos azul oscuro largo - talla l', 'calle 12-56', 13432123),
('colombia moda' , 204, 'Vestidos azul oscuro largo - talla xl', 'Avenida chile 45', 3423432),
('super tex',    205, 'Vestido primavera corto - talla s', 'calle 56-09', 13456546),
('trajes s.a',   206, 'Vestido primavera corto - talla m', ' avenida cordova 34', 5464564),
('vestidos y demas', 207, 'Vestido primavera corto - talla l', 'avenida cali 52',84455234),
(' modismo', 208, 'Vestido primavera corto - talla xl', 'calle 35-90', 32423432),
('ejectivos', 209, 'Falda negra plisada ', 'calle flores 67', 234234234),
('moda y punto' , 210, 'chaqueta rosa', 'calle 89-05',9459387),
('offcors', 211, 'camisa seda otono verde', 'calle 23-21',23755987),
('elegrancia francia', 212, 'camisa  otono azul', 'avenida cali 67', 3003534),
('super seda', 213, 'camisa seda otono blanca', 'avenida cordoba 56', 245663343),
('nova moda', 214, 'Camiseta  multicolor - talla s', 'calle 56-70', 567435599),
('lala fashion', 215, 'Camiseta  multicolor - talla m', 'calle 90-45', 23131494)
;
insert into orden_venta(id_orden_venta, nombre_cliente, id_producto, descripcion_producto, cantidad, precio)
values
(6669,'moda y estilo' , 201, 'Vestidos azul oscuro largo - talla s', 4, 1000),
(6670, 'jeans y mas', 202, 'Vestidos azul oscuro largo - talla m', 22, 5500),
(6655,'palacio de la pantaleta',203, 'Vestidos azul oscuro largo - talla l', 10,2500 ),
(6656, 'colombia moda' , 204, 'Vestidos azul oscuro largo - talla xl', 9, 2250),
(6657, 'super tex',    205, 'Vestido primavera corto - talla s', 11, 1800),
(6658, 'trajes s.a', 206,'Vestido primavera corto - talla m', 30, 5400),
(6659, 'vestidos y demas', 207, 'Vestido primavera corto - talla l', 12, 2160),
(6660, ' modismo', 208, 'Vestido primavera corto - talla xl', 21, 3780),
(6661, 'ejectivos', 209, 'Falda negra plisada ', 8, 240),
(6662, 'moda y punto' , 210, 'chaqueta rosa', 40, 8000),
(6663, 'offcors', 211, 'camisa seda otono verde', 25, 5000),
(6664, 'elegrancia francia', 212, 'camisa  otono azul', 29, 2610),
(6665, 'super seda', 213, 'camisa seda otono blanca', 32, 3840),
(6667,'nova moda', 214, 'Camiseta  multicolor - talla s',20, 3000),
(6668, 'lala fashion', 215, 'Camiseta  multicolor - talla m', 24, 3600)
;

insert into cuentas_cobrar(id_cuenta_cobrar, documento_referencia, estado, valor)
values
(9960, 6669, 'por cobrar', 1000),
(9961, 6670, 'saldada' , 5500),
(9962, 6655, 'por cobrar',2500),
(9963, 6656,'saldada', 2250),
(9964, 6657, 'saldada', 1800),
(9965, 6658, 'por cobrar', 5400),
(9966, 6659, 'por cobrar', 2160),
(9967, 6660,'por cobrar' , 3780),
(9968, 6661, 'saldada', 240),
(9969, 6662, 'saldada', 8000),
(9970, 6663,'saldada' , 5000),
(9971, 6664, 'por cobrar', 2610),
(9972, 6665,'por cobrar' , 3840),
(9973, 6667, 'por cobrar', 3000),
(9974, 6668, 'saldada', 3600)
;

insert into cuentas_pagar(id_cuentas_pagar, documento_referencia, estado, valor)
values
(8850, 5555, 'por pagar', 800),
 (8851, 5556,  'saldada', 1050),
 (8852, 5557, 'saldada', 3000), 
 (8853, 5558, 'por pagar' , 7800),
 (8854, 5559, 'saldada', 595),
 (8855, 5560, 'por pagar', 4000),
 (8856, 5561, 'por pagar' , 3020),
 (8859, 5562, 'por pagar', 446),
 (8860, 5563, 'por pagar' , 850),
 (8861, 5564, 'saldada', 1000),
 (8862, 5565, 'saldada', 2000), 
 (8863, 5566, 'por pagar', 3500),
 (8864, 5567, 'por pagar', 700),
 (8865, 5568,'por pagar' , 1600),
 (8866, 5569, 'por pagar', 450)
 ;
 



