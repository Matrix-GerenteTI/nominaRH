/*
SQLyog Community
MySQL - 10.1.32-MariaDB : Database - aabm870128py9
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `abonos_deuda_acreedor` */

CREATE TABLE `abonos_deuda_acreedor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `detalle_deuda_acreedor` bigint(20) DEFAULT NULL,
  `monto_abonado_capital` double DEFAULT NULL,
  `interes_pagado` double DEFAULT NULL,
  `fecha_abono` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detalle_deuda_acreedor` (`detalle_deuda_acreedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `abonos_deuda_acreedor` */

/*Table structure for table `actividades_bitacoras` */

CREATE TABLE `actividades_bitacoras` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombreActividad` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionActividad` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encargadoActividad` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `udn_id` int(11) NOT NULL,
  `rubro_id` int(11) NOT NULL,
  `ruta_img_antes` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ruta_img_despues` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gastoTotal` int(11) DEFAULT NULL,
  `gastoDetallado` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaInicio` datetime DEFAULT NULL,
  `fechaFin` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `actividades_bitacoras` */

/*Table structure for table `amortizaciones` */

CREATE TABLE `amortizaciones` (
  `id_con_cuentas` int(11) NOT NULL,
  `numeroPago` int(11) DEFAULT NULL,
  `fechaPago` date NOT NULL,
  `capital` double DEFAULT NULL,
  `interes` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `saldo` double DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_con_cuentas`,`fechaPago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `amortizaciones` */

/*Table structure for table `appcelular_usuarios` */

CREATE TABLE `appcelular_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `telefono` varchar(20) NOT NULL,
  `dispositivoId` varchar(150) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `idempleado` int(11) NOT NULL,
  `token_firebase_app` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pempleadosid_appceular_usuariosidempleado_idx` (`idempleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Guarda los numeros telefonicos de la empresa y a quien est??n asignados';

/*Data for the table `appcelular_usuarios` */

/*Table structure for table `appcelular_usuarios_mensajes` */

CREATE TABLE `appcelular_usuarios_mensajes` (
  `idcelularusuario` int(11) NOT NULL,
  `idmensaje` int(11) NOT NULL,
  `fecha_lectura` datetime DEFAULT NULL,
  KEY `fk_mensajeid_usuarios_mensajes_idmensaje_idx` (`idmensaje`),
  KEY `fk_usuarioscelulares_id_usuarios_mensajes_idcelular_idx` (`idcelularusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Guarda la relacion de los mensajes con los usuarios que recibir??n las notificaciones en sus equipos moviles';

/*Data for the table `appcelular_usuarios_mensajes` */

/*Table structure for table `appeventos_compartidos` */

CREATE TABLE `appeventos_compartidos` (
  `dispositivoEmisorId` varchar(250) DEFAULT NULL,
  `eventoId` int(11) DEFAULT NULL,
  `dispositivoReceptorId` varchar(250) DEFAULT NULL,
  `status` varchar(2) DEFAULT 'p' COMMENT 'd = descargado\np = pendiente',
  `idEventoGenerado` int(11) DEFAULT NULL,
  UNIQUE KEY `pago_compartido` (`dispositivoEmisorId`,`eventoId`,`dispositivoReceptorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla temporal, para guardar los eventos que quiere compartir un usuario con otros';

/*Data for the table `appeventos_compartidos` */

/*Table structure for table `appmensajes_notificaciones` */

CREATE TABLE `appmensajes_notificaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` text CHARACTER SET latin1 NOT NULL,
  `contenido` text CHARACTER SET latin1,
  `accion` varchar(45) CHARACTER SET latin1 NOT NULL,
  `creado_en` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT NULL,
  `idcompra_sitex` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `sucursal` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Guarda un registro de los mensajes que se enviar??n a los usuarios de los telefonos de la empresa';

/*Data for the table `appmensajes_notificaciones` */

/*Table structure for table `appregistro_llamadas` */

CREATE TABLE `appregistro_llamadas` (
  `idcelular` int(11) NOT NULL,
  `telefono_llamada` varchar(20) NOT NULL,
  `fecha_llamada` date NOT NULL,
  `hora_llamada` varchar(10) NOT NULL,
  `duracion_llamada` varchar(15) NOT NULL,
  `tipo_llamada` varchar(45) NOT NULL,
  PRIMARY KEY (`telefono_llamada`,`fecha_llamada`,`hora_llamada`,`duracion_llamada`),
  KEY `fk_usuario_telefonid_registro_llamadas_idx` (`idcelular`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Regristra las llamadas efectuadas por los usuarios registrados en la tabla appcelular_usuarios';

/*Data for the table `appregistro_llamadas` */

/*Table structure for table `asistencia` */

CREATE TABLE `asistencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempleado` int(11) DEFAULT NULL,
  `foto` blob,
  `latitud` varchar(500) DEFAULT NULL,
  `longitud` varchar(500) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `aplicaIncidencia` decimal(9,2) DEFAULT '-1.00',
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `asistencia` */

/*Table structure for table `asistencia_manual` */

CREATE TABLE `asistencia_manual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempleado` int(11) NOT NULL,
  `fecha_realizado` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `observaciones` text,
  `status` int(11) DEFAULT '1',
  `asistencia` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `asistencia_manual` */

/*Table structure for table `cacciones` */

CREATE TABLE `cacciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(60) DEFAULT NULL,
  `idsubmodulo` int(8) DEFAULT NULL,
  `status` int(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `cacciones` */

insert  into `cacciones`(`id`,`descripcion`,`idsubmodulo`,`status`) values (1,'GUARDAR',1,1);
insert  into `cacciones`(`id`,`descripcion`,`idsubmodulo`,`status`) values (2,'ELIMINAR',1,1);

/*Table structure for table `cal_dispositivos_app` */

CREATE TABLE `cal_dispositivos_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dispositivoId` varchar(150) DEFAULT NULL,
  `token` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_devices` (`dispositivoId`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cal_dispositivos_app` */

/*Table structure for table `cal_pagos_app` */

CREATE TABLE `cal_pagos_app` (
  `id` int(11) DEFAULT NULL,
  `beneficiario` text,
  `concepto` text,
  `monto` text,
  `fecha_evento` date DEFAULT NULL,
  `frecuencia_recordatorio` text,
  `hora_recordatorio` time DEFAULT NULL,
  `tipo_operacion` text,
  `status` text,
  `dispositivo` varchar(250) DEFAULT NULL,
  UNIQUE KEY `id` (`id`,`dispositivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla de respaldo del registro de la base de datos de la app de agenda de pagos';

/*Data for the table `cal_pagos_app` */

/*Table structure for table `cambios_adscripcion` */

CREATE TABLE `cambios_adscripcion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sucursal_salida_id` int(11) DEFAULT NULL,
  `sucursal_llegada_id` int(11) DEFAULT NULL,
  `puesto_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `trabajador_id` int(11) DEFAULT NULL,
  `tipo_movto` varchar(45) DEFAULT NULL,
  `sueldo` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

/*Data for the table `cambios_adscripcion` */

insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (1,1,-1,64,'2022-01-01',1,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (2,1,0,64,'2022-06-10',1,'baja',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (3,1,0,64,'2022-06-10',1,'baja',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (4,0,1,90,'2022-06-11',1,'reingreso',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (5,1,0,90,'2022-06-11',1,'baja',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (6,0,1,90,'2022-06-11',1,'reingreso',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (7,1,0,90,'2022-06-11',1,'baja',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (8,0,1,90,'2022-06-11',1,'reingreso',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (9,3,0,1,'2022-06-09',31,'baja',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (10,0,3,1,'2018-05-18',31,'reingreso',NULL);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (11,1,-1,9,'2022-02-01',1,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (12,1,-1,1,'2015-02-21',2,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (13,1,-1,25,'0000-00-00',3,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (14,1,-1,26,'2021-01-04',4,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (15,1,-1,26,'2021-01-04',5,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (16,1,-1,1,'0000-00-00',6,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (17,1,-1,15,'2011-09-09',7,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (18,1,-1,37,'2013-03-09',8,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (19,1,-1,38,'0000-00-00',9,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (20,1,-1,22,'2015-01-10',10,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (21,1,-1,22,'0000-00-00',11,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (22,1,-1,26,'0000-00-00',12,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (23,1,-1,22,'2019-10-12',13,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (24,1,-1,3,'2020-02-01',14,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (25,1,-1,38,'0000-00-00',15,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (26,1,-1,11,'2020-02-10',16,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (27,1,-1,32,'2021-03-06',17,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (28,1,-1,22,'0000-00-00',18,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (29,1,-1,12,'0000-00-00',19,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (30,1,-1,21,'0000-00-00',20,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (31,1,-1,32,'0000-00-00',21,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (32,1,-1,27,'2022-01-02',22,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (33,1,-1,26,'0000-00-00',23,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (34,1,-1,26,'0000-00-00',24,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (35,1,-1,26,'2022-01-03',25,'ingreso',0);
insert  into `cambios_adscripcion`(`id`,`sucursal_salida_id`,`sucursal_llegada_id`,`puesto_id`,`fecha`,`trabajador_id`,`tipo_movto`,`sueldo`) values (36,1,-1,31,'0000-00-00',26,'ingreso',0);

/*Table structure for table `cautos_marca` */

CREATE TABLE `cautos_marca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `marca` varchar(45) NOT NULL,
  `codradec` varchar(10) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `marca_UNIQUE` (`marca`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cautos_marca` */

/*Table structure for table `cautos_modelo` */

CREATE TABLE `cautos_modelo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelo` varchar(45) DEFAULT NULL,
  `modelo_anio` int(11) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `tipo_carro` varchar(45) DEFAULT 'null',
  `tipo_rin` varchar(45) DEFAULT NULL,
  `idmarca` int(11) NOT NULL,
  `tyres_specs_id` int(11) NOT NULL,
  `status` int(11) DEFAULT '1',
  `img_f1` varchar(150) DEFAULT NULL,
  `img_t1` varchar(150) DEFAULT NULL,
  `img_f2` varchar(150) DEFAULT NULL,
  `img_t2` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `modelo` (`modelo`,`modelo_anio`,`version`,`idmarca`,`tyres_specs_id`,`tipo_carro`,`tipo_rin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cautos_modelo` */

/*Table structure for table `cbanco` */

CREATE TABLE `cbanco` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `nombre` varchar(500) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cbanco` */

insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('','NO APLICA','',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('002','BANAMEX','Banco Nacional de Mexico S.A. Institucion de Banca Multiple Grupo Financiero Banamex',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('006','BANCOMEXT','Banco Nacional de Comercio Exterior Sociedad Nacional de Credito Institucion de Banca de Desarrollo',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('009','BANOBRAS','Banco Nacional de Obras y Servicios Publicos Sociedad Nacional de Credito Institucion de Banca de Desarrollo',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('012','BBVA BANCOMER','BBVA Bancomer S.A. Institucion de Banca Multiple Grupo Financiero BBVA Bancomer',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('014','SANTANDER','Banco Santander (Mexico) S.A. Institucion de Banca Multiple Grupo Financiero Santander',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('019','BANJERCITO','Banco Nacional del Ejercito Fuerza Aerea y Armada Sociedad Nacional de Credito Institucion de Banca de Desarrollo',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('021','HSBC','HSBC Mexico S.A. institucion De Banca Multiple Grupo Financiero HSBC',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('030','BAJIO','Banco del Bajio S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('032','IXE','IXE Banco S.A. Institucion de Banca Multiple IXE Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('036','INBURSA','Banco Inbursa S.A. Institucion de Banca Multiple Grupo Financiero Inbursa',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('037','INTERACCIONES','Banco Interacciones S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('042','MIFEL','Banca Mifel S.A. Institucion de Banca Multiple Grupo Financiero Mifel',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('044','SCOTIABANK','Scotiabank Inverlat S.A.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('058','BANREGIO','Banco Regional de Monterrey S.A. Institucion de Banca Multiple Banregio Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('059','INVEX','Banco Invex S.A. Institucion de Banca Multiple Invex Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('060','BANSI','Bansi S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('062','AFIRME','Banca Afirme S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('072','BANORTE IXE','Banco Mercantil del Norte S.A. Institucion de Banca Multiple Grupo Financiero Banorte',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('102','THE ROYAL BANK','The Royal Bank of Scotland Mexico S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('103','AMERICAN EXPRESS','American Express Bank (Mexico) S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('106','BAMSA','Bank of America Mexico S.A. Institucion de Banca Multiple Grupo Financiero Bank of America',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('108','TOKYO','Bank of Tokyo-Mitsubishi UFJ (Mexico) S.A.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('110','JP MORGAN','Banco J.P. Morgan S.A. Institucion de Banca Multiple J.P. Morgan Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('112','BMONEX','Banco Monex S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('113','VE POR MAS','Banco Ve Por Mas S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('116','ING','ING Bank (Mexico) S.A. Institucion de Banca Multiple ING Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('124','DEUTSCHE','Deutsche Bank Mexico S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('126','CREDIT SUISSE','Banco Credit Suisse (Mexico) S.A. Institucion de Banca Multiple Grupo Financiero Credit Suisse (Mexico)',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('127','AZTECA','Banco Azteca S.A. Institucion de Banca Multiple.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('128','AUTOFIN','Banco Autofin Mexico S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('129','BARCLAYS','Barclays Bank Mexico S.A. Institucion de Banca Multiple Grupo Financiero Barclays Mexico',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('130','COMPARTAMOS','Banco Compartamos S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('131','BANCO FAMSA','Banco Ahorro Famsa S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('132','BMULTIVA','Banco Multiva S.A. Institucion de Banca Multiple Multivalores Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('133','ACTINVER','Banco Actinver S.A. Institucion de Banca Multiple Grupo Financiero Actinver',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('134','WAL-MART','Banco Wal-Mart de Mexico Adelante S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('135','NAFIN','Nacional Financiera Sociedad Nacional de Credito Institucion de Banca de Desarrollo',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('136','INTERCAM BANCO','Intercam Banco S.A. Institucion de Banca Multiple Intercam Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('137','BANCOPPEL','BanCoppel S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('138','ABC CAPITAL','ABC Capital S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('139','UBS BANK','UBS Bank Mexico S.A. Institucion de Banca Multiple UBS Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('140','CONSUBANCO','Consubanco S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('141','VOLKSWAGEN','Volkswagen Bank S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('143','CIBANCO','CIBanco S.A.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('145','BBASE','Banco Base S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('147','BANKAOOL','Bankaool S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('148','PAGATODO','Banco PagaTodo S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('149','FORJADORES','Banco Forjadores S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('150','INMOBILIARIO','Banco Inmobiliario Mexicano S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('151','DONDe','Fundacion Donde Banco S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('152','BANCREA','Banco Bancrea S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('153','PROGRESO','Banco Progreso Chihuahua S.A.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('154','BANCO FINTERRA','Banco Finterra S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('155','ICBC','Industrial and Commercial Bank of China Mexico S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('156','SABADELL','Banco Sabadell S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('157','SHINHAN','Banco Shinhan de Mexico S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('158','MIZUHO BANK','Mizuho Bank Mexico S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('159','BANK OF CHINA','Bank of China Mexico S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('160','BANCO S3','Banco S3 Mexico S.A. Institucion de Banca Multiple',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('166','BANSEFI','Banco del Ahorro Nacional y Servicios Financieros Sociedad Nacional de Credito Institucion de Banca de Desarrollo',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('168','HIPOTECARIA FEDERAL','Sociedad Hipotecaria Federal Sociedad Nacional de Credito Institucion de Banca de Desarrollo',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('600','MONEXCB','Monex Casa de Bolsa S.A. de C.V. Monex Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('601','GBM','GBM Grupo Bursatil Mexicano S.A. de C.V. Casa de Bolsa',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('602','MASARI','Masari Casa de Bolsa S.A.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('605','VALUE','Value S.A. de C.V. Casa de Bolsa',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('606','ESTRUCTURADORES','Estructuradores del Mercado de Valores Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('607','TIBER','Casa de Cambio Tiber S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('608','VECTOR','Vector Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('610','B&B','B y B Casa de Cambio S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('614','ACCIVAL','Acciones y Valores Banamex S.A. de C.V. Casa de Bolsa',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('615','MERRILL LYNCH','Merrill Lynch Mexico S.A. de C.V. Casa de Bolsa',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('616','FINAMEX','Casa de Bolsa Finamex S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('617','VALMEX','Valores Mexicanos Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('618','UNICA','Unica Casa de Cambio S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('619','MAPFRE','MAPFRE Tepeyac S.A.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('620','PROFUTURO','Profuturo G.N.P. S.A. de C.V. Afore',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('621','CB ACTINVER','Actinver Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('622','OACTIN','OPERADORA ACTINVER S.A. DE C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('623','SKANDIA','Skandia Vida S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('626','CBDEUTSCHE','Deutsche Securities S.A. de C.V. CASA DE BOLSA',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('627','ZURICH','Zurich Compa????ia de Seguros S.A.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('628','ZURICHVI','Zurich Vida Compa????ia de Seguros S.A.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('629','SU CASITA','Hipotecaria Su Casita S.A. de C.V. SOFOM ENR',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('630','CB INTERCAM','Intercam Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('631','CI BOLSA','CI Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('632','BULLTICK CB','Bulltick Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('633','STERLING','Sterling Casa de Cambio S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('634','FINCOMUN','Fincomun Servicios Financieros Comunitarios S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('636','HDI SEGUROS','HDI Seguros S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('637','ORDER','Order Express Casa de Cambio S.A. de C.V',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('638','AKALA','Akala S.A. de C.V. Sociedad Financiera Popular',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('640','CB JPMORGAN','J.P. Morgan Casa de Bolsa S.A. de C.V. J.P. Morgan Grupo Financiero',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('642','REFORMA','Operadora de Recursos Reforma S.A. de C.V. S.F.P.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('646','STP','Sistema de Transferencias y Pagos STP S.A. de C.V.SOFOM ENR',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('647','TELECOMM','Telecomunicaciones de Mexico',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('648','EVERCORE','Evercore Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('649','SKANDIA','Skandia Operadora de Fondos S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('651','SEGMTY','Seguros Monterrey New York Life S.A de C.V',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('652','ASEA','Solucion Asea S.A. de C.V. Sociedad Financiera Popular',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('653','KUSPIT','Kuspit Casa de Bolsa S.A. de C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('655','SOFIEXPRESS','J.P. SOFIEXPRESS S.A. de C.V. S.F.P.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('656','UNAGRA','UNAGRA S.A. de C.V. S.F.P.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('659','OPCIONES EMPRESARIALES DEL NOROESTE','OPCIONES EMPRESARIALES DEL NORESTE S.A. DE C.V. S.F.P.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('670','LIBERTAD','Libertad Servicios Financieros S.A. De C.V.',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('901','CLS','Cls Bank International',1);
insert  into `cbanco`(`id`,`descripcion`,`nombre`,`status`) values ('902','INDEVAL','SD. Indeval S.A. de C.V.',1);

/*Table structure for table `ccategoria` */

CREATE TABLE `ccategoria` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombreCategoria` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` bigint(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `ccategoria` */

insert  into `ccategoria`(`id`,`nombreCategoria`,`created_at`,`updated_at`,`status`) values (1,'Equipos de Computo',NULL,NULL,1);
insert  into `ccategoria`(`id`,`nombreCategoria`,`created_at`,`updated_at`,`status`) values (2,'Equipos de Oficina',NULL,NULL,99);
insert  into `ccategoria`(`id`,`nombreCategoria`,`created_at`,`updated_at`,`status`) values (3,'Edificios',NULL,NULL,99);
insert  into `ccategoria`(`id`,`nombreCategoria`,`created_at`,`updated_at`,`status`) values (4,'Veh??culos','2021-10-13 00:00:00','2021-10-13 00:00:00',99);
insert  into `ccategoria`(`id`,`nombreCategoria`,`created_at`,`updated_at`,`status`) values (5,'Herramientas','2021-10-13 00:00:00','2021-10-13 00:00:00',99);
insert  into `ccategoria`(`id`,`nombreCategoria`,`created_at`,`updated_at`,`status`) values (6,'XXXXXXX',NULL,NULL,NULL);
insert  into `ccategoria`(`id`,`nombreCategoria`,`created_at`,`updated_at`,`status`) values (7,'XXXXXXX',NULL,NULL,NULL);

/*Table structure for table `cdepartamento` */

CREATE TABLE `cdepartamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idpatron` int(11) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `idpadre` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `cdepartamento` */

insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (1,1,'GERENCIA DE PARQUE',0,1);
insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (2,1,'PRUEBA',0,1);
insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (3,1,'GERENCIA DE HOTEL',0,1);
insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (4,1,'ADMINISTRACI?????N',0,1);
insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (5,1,'VENTAS',0,1);
insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (6,1,'ALIMENTOS Y BEBIDAS',0,1);
insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (7,1,'MANTENIMIENTO',0,1);
insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (8,1,'DIVISI?????N CUARTOS',0,1);
insert  into `cdepartamento`(`id`,`idpatron`,`descripcion`,`idpadre`,`status`) values (9,1,'SEGURIDAD',0,1);

/*Table structure for table `cestado` */

CREATE TABLE `cestado` (
  `id` char(5) NOT NULL,
  `cve_pais` char(5) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cestado` */

insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('AB','CAN','????Alberta',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('AGU','MEX','Aguascalientes',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('AK','USA','Alaska',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('AL','USA','Alabama',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('AR','USA','Arkansas',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('AZ','USA','Arizona',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('BC','CAN','????Columbia Britanica',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('BCN','MEX','Baja California',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('BCS','MEX','Baja California Sur',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('CA','USA','California',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('CAM','MEX','Campeche',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('CHH','MEX','Chihuahua',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('CHP','MEX','Chiapas',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('CO','USA','Colorado',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('COA','MEX','Coahuila',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('COL','MEX','Colima',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('CT','USA','Connecticut',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('DE','USA','Delaware',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('DIF','MEX','Ciudad de Mexico',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('DUR','MEX','Durango',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('FL','USA','Florida',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('GA','USA','Georgia',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('GRO','MEX','Guerrero',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('GUA','MEX','Guanajuato',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('HI','USA','Hawai',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('HID','MEX','Hidalgo',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('IA','USA','Iowa',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('ID','USA','Idaho',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('IL','USA','Illinois',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('IN','USA','Indiana',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('JAL','MEX','Jalisco',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('KS','USA','Kansas',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('KY','USA','Kentucky',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('LA','USA','Luisiana',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MA','USA','Massachusetts',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MB','CAN','????Manitoba',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MD','USA','Maryland',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('ME','USA','Maine',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MEX','MEX','Estado de Mexico',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MI','USA','Michigan',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MIC','MEX','Michoacan',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MN','USA','Minnesota',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MO','USA','Misuri',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MOR','MEX','Morelos',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MS','USA','Misisipi',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('MT','USA','Montana',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NAY','MEX','Nayarit',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NB','CAN','Nuevo Brunswick????',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NC','USA','Carolina del Norte',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('ND','USA','Dakota del Norte',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NE','USA','Nebraska',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NH','USA','Nuevo Hampshire',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NJ','USA','Nueva Jersey',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NL','CAN','????Terranova y Labrador',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NLE','MEX','Nuevo Leon',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NM','USA','Nuevo Mexico',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NS','CAN','????Nueva Escocia',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NT','CAN','????Territorios del Noroeste',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NV','USA','Nevada',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('NY','USA','Nueva York',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('OAX','MEX','Oaxaca',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('OH','USA','Ohio',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('OK','USA','Oklahoma',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('ON','CAN','Ontario????',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('OR','USA','Oregon',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('PA','USA','Pensilvania',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('PE','CAN','????Isla del Principe Eduardo',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('PUE','MEX','Puebla',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('QC','CAN','????Quebec????',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('QUE','MEX','Queretaro',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('RI','USA','Rhode Island',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('ROO','MEX','Quintana Roo',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('SC','USA','Carolina del Sur',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('SD','USA','Dakota del Sur',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('SIN','MEX','Sinaloa',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('SK','CAN','????Saskatchewan',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('SLP','MEX','San Luis Potosi',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('SON','MEX','Sonora',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('TAB','MEX','Tabasco',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('TAM','MEX','Tamaulipas',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('TLA','MEX','Tlaxcala',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('TN','USA','Tennessee',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('TX','USA','Texas',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('UN','CAN','????Nunavut',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('UT','USA','Utah',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('VA','USA','Virginia',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('VER','MEX','Veracruz',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('VT','USA','Vermont',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('WA','USA','Washington',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('WI','USA','Wisconsin',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('WV','USA','Virginia Occidental',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('WY','USA','Wyoming',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('YT','CAN','????Yukon',0);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('YUC','MEX','Yucatan',1);
insert  into `cestado`(`id`,`cve_pais`,`descripcion`,`status`) values ('ZAC','MEX','Zacatecas',1);

/*Table structure for table `cestadocivil` */

CREATE TABLE `cestadocivil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcionEstadoCivil` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `cestadocivil` */

insert  into `cestadocivil`(`id`,`descripcionEstadoCivil`) values (1,'SOLTERA(O)');
insert  into `cestadocivil`(`id`,`descripcionEstadoCivil`) values (2,'CASADA(O)');
insert  into `cestadocivil`(`id`,`descripcionEstadoCivil`) values (3,'DIVORCIADA(O)');
insert  into `cestadocivil`(`id`,`descripcionEstadoCivil`) values (4,'VIUDO(A)');
insert  into `cestadocivil`(`id`,`descripcionEstadoCivil`) values (5,'UNION LIBRE');

/*Table structure for table `cexamen` */

CREATE TABLE `cexamen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(800) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cexamen` */

/*Table structure for table `cfamiliares_empleados` */

CREATE TABLE `cfamiliares_empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `parentesco` text COLLATE utf8_spanish_ci NOT NULL,
  `edad` int(11) NOT NULL,
  `escolaridad` text COLLATE utf8_spanish_ci,
  `ocupacion` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idempleado` int(11) NOT NULL COMMENT 'Clave foranea',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Almacena los familiares de los empleados, esta informaci??n es obtenida cuando se realiza un estudio socioeconomico';

/*Data for the table `cfamiliares_empleados` */

/*Table structure for table `cfg_descripcion_movimientos` */

CREATE TABLE `cfg_descripcion_movimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cfg_descripcion_movimientos` */

/*Table structure for table `cfg_movtos_automatico` */

CREATE TABLE `cfg_movtos_automatico` (
  `fecha_mvto` date NOT NULL,
  `idSucursal` int(11) NOT NULL,
  `idcuenta` int(11) NOT NULL,
  `idDescripcion` int(11) NOT NULL,
  `idProveedor` int(11) NOT NULL,
  `subtotal` double NOT NULL,
  `iva` double DEFAULT NULL,
  `total` double NOT NULL,
  `status` varchar(2) DEFAULT 'A',
  `expresionPeriodo` text NOT NULL,
  `log` date DEFAULT NULL,
  `caducidad` date NOT NULL,
  `fechaRegistrado` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipoMovimiento` int(11) DEFAULT '1',
  `tipoCuenta` int(11) DEFAULT '3',
  PRIMARY KEY (`fecha_mvto`,`idSucursal`,`idcuenta`,`subtotal`,`total`,`fechaRegistrado`),
  KEY `fk_iddescripcion_idx` (`idDescripcion`),
  KEY `fk_id_proveedor_idx` (`idProveedor`),
  KEY `fk_idSucursal_idx` (`idSucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cfg_movtos_automatico` */

/*Table structure for table `cgeneral` */

CREATE TABLE `cgeneral` (
  `id` varchar(100) DEFAULT NULL,
  `valor` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cgeneral` */

insert  into `cgeneral`(`id`,`valor`) values ('serie','NOM');
insert  into `cgeneral`(`id`,`valor`) values ('noCertificado','00001000000404097228');
insert  into `cgeneral`(`id`,`valor`) values ('folio','504');

/*Table structure for table `checkinventario` */

CREATE TABLE `checkinventario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sucursal` varchar(10) DEFAULT NULL,
  `familia` varchar(200) DEFAULT NULL,
  `subfamilia` varchar(300) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `checkinventario` */

/*Table structure for table `checklist` */

CREATE TABLE `checklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sucursal` int(11) DEFAULT NULL,
  `tipo` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `evaluador` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `checklist` */

/*Table structure for table `cinsumos` */

CREATE TABLE `cinsumos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text NOT NULL,
  `status` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

/*Data for the table `cinsumos` */

insert  into `cinsumos`(`id`,`descripcion`,`status`) values (1,'FABULOSO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (2,'ALMOROL','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (3,'BOLSA DE JABON EN POLVO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (4,'CLORO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (5,'ACIDO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (6,'FRANELA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (7,'TRAPEDOR','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (8,'PAPEL HIGIENICO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (9,'CESTO PARA BASURA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (10,'HOJAS BLANCAS','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (11,'CARTULINA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (12,'CLIPS','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (13,'BROCHE BACO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (14,'BOLSA PARA DINERO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (15,'ESCOBA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (16,'RECOGEDOR DE BASURA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (17,'JABON ZOTE','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (18,'MARCATEXTO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (19,'ROLLO TERMICO 57x35','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (20,'ROLLO TERMICO 80x70','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (21,'ROLLO TERMICO P/ ETIQUETAS','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (22,'BOLSA PARA BASURA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (23,'BLOCK DE GARANTIAS','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (24,'CINTA TRASPARENTE GDE. (CANELA)','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (25,'CINTA DIUREX','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (26,'COJIN PARA SELLO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (27,'CEPILLO DE MANO P/BA??O','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (28,'ESPONJA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (29,'MARCADORES','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (30,'CUTTER','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (31,'GEL ANTIBACTERIAL','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (32,'CINTA MASKING','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (33,'NAVAJA PARA PORALIZAR','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (34,'ACIDO MURIATICO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (35,'CAJA LAPICEROS NEGRO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (36,'GRAPA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (37,'REGLA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (38,'TIJERA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (39,'PERFORADORA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (40,'TOMOS','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (41,'CARPETA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (42,'SOBRE T/C','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (43,'CAJA LAPICEROS AZUL','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (44,'CEPILLO LARGO PARA ESCUSADO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (45,'VALE DE AGUA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (46,'BOLSA CAMISETA','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (47,'OKO','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (48,'QUITAGRAPAS','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (49,'LAPIZ CORRECTOR','1');
insert  into `cinsumos`(`id`,`descripcion`,`status`) values (50,'LIBRETA','1');

/*Table structure for table `cmodulo` */

CREATE TABLE `cmodulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(60) DEFAULT NULL,
  `status` int(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `cmodulo` */

insert  into `cmodulo`(`id`,`descripcion`,`status`) values (1,'Panel Inicial',1);
insert  into `cmodulo`(`id`,`descripcion`,`status`) values (2,'Organizacion',1);
insert  into `cmodulo`(`id`,`descripcion`,`status`) values (3,'Control',1);
insert  into `cmodulo`(`id`,`descripcion`,`status`) values (4,'Nomina',1);
insert  into `cmodulo`(`id`,`descripcion`,`status`) values (5,'Reclutamiento y Seleccion',1);
insert  into `cmodulo`(`id`,`descripcion`,`status`) values (6,'Sistema y Seguridad',1);

/*Table structure for table `cmodulos` */

CREATE TABLE `cmodulos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `href` varchar(200) DEFAULT NULL,
  `icon` varchar(200) DEFAULT NULL,
  `isdropdown` int(11) DEFAULT NULL,
  `idpadre` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `cmodulos` */

insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (1,'Dashboard','index','box',0,1,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (2,'Empresa','empresa','globe',0,2,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (3,'UDNs','udns','home',NULL,2,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (4,'Empleados','empleados','briefcase',NULL,2,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (5,'Estructuras','estructuras','share-2',NULL,2,99);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (6,'Horarios','parametros','clock',NULL,3,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (7,'Calendario Laboral','calendario','calendar',NULL,3,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (8,'Incidencias','incidencias','info',NULL,3,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (9,'Asistencia','asistencia','watch',NULL,3,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (10,'Calculo','calculo','sliders',NULL,4,99);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (11,'Pago y Timbrado','timbrado','pen-tool',NULL,4,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (12,'Aspirantes','aspirantes','folder',NULL,5,99);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (13,'Socioeconomicos','socioeconomicos','book',NULL,5,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (14,'Seleccion','seleccion','check-circle',NULL,5,99);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (15,'Usuarios','usuarios','users',NULL,6,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (16,'Permisos y accesos','permisos','key',NULL,6,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (17,'Bitacora','bitacora','activity',NULL,6,1);
insert  into `cmodulos`(`id`,`title`,`href`,`icon`,`isdropdown`,`idpadre`,`status`) values (18,'Vacaciones','vacaciones','sun',NULL,3,1);

/*Table structure for table `cmodulos_intranet` */

CREATE TABLE `cmodulos_intranet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cmodulos_intranet` */

/*Table structure for table `cnivelestudio` */

CREATE TABLE `cnivelestudio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcionEscolaridad` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `cnivelestudio` */

insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (1,'PRESCOLAR');
insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (2,'PRIMARIA');
insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (3,'SECUNDARIA');
insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (4,'PREPARATORIA');
insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (5,'LICENCIATURA');
insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (6,'MAESTRIA');
insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (7,'DOCTORADO');
insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (8,'POSGRADO');
insert  into `cnivelestudio`(`id`,`descripcionEscolaridad`) values (9,'OTRO');

/*Table structure for table `comentarios_recursos` */

CREATE TABLE `comentarios_recursos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `directorio` text COLLATE utf8_spanish_ci,
  `comentario` text COLLATE utf8_spanish_ci,
  `idempleado` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `posted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `comentarios_recursos` */

/*Table structure for table `con_cuentas` */

CREATE TABLE `con_cuentas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta` varchar(200) NOT NULL,
  `padre` varchar(200) DEFAULT NULL,
  `ejercicio` int(11) NOT NULL,
  `nombre` varchar(500) DEFAULT NULL,
  `naturaleza` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idcudn` int(11) DEFAULT NULL,
  `tipousuario` varchar(50) DEFAULT NULL,
  `idmatch` int(11) DEFAULT NULL,
  PRIMARY KEY (`cuenta`,`ejercicio`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;

/*Data for the table `con_cuentas` */

/*Table structure for table `con_cuentasmatch` */

CREATE TABLE `con_cuentasmatch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta` varchar(100) NOT NULL,
  `nombre` varchar(800) NOT NULL,
  `naturaleza` int(11) NOT NULL,
  `tipo` char(1) NOT NULL,
  `creacion` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `con_cuentasmatch` */

/*Table structure for table `con_cuentasmayor` */

CREATE TABLE `con_cuentasmayor` (
  `id` varchar(10) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `saldoini` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `con_cuentasmayor` */

/*Table structure for table `con_facturassat` */

CREATE TABLE `con_facturassat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfcemisor` varchar(15) DEFAULT NULL,
  `rfcreceptor` varchar(15) DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT NULL,
  `total` decimal(12,2) DEFAULT NULL,
  `nombreemisor` varchar(500) DEFAULT NULL,
  `nombrereceptor` varchar(500) DEFAULT NULL,
  `uuid` varchar(300) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `serie` varchar(100) DEFAULT NULL,
  `folio` varchar(50) DEFAULT NULL,
  `nocuenta` varchar(50) DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nombredoc` text,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=699 DEFAULT CHARSET=latin1;

/*Data for the table `con_facturassat` */

/*Table structure for table `con_movimientos` */

CREATE TABLE `con_movimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emisor` varchar(800) DEFAULT NULL,
  `rfc` varchar(50) DEFAULT NULL,
  `descripcion` text,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `docfecha` date DEFAULT NULL,
  `dochora` time DEFAULT NULL,
  `docserie` varchar(50) DEFAULT NULL,
  `docfolio` varbinary(50) DEFAULT NULL,
  `docuuid` varbinary(300) DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT NULL,
  `iva` decimal(12,2) DEFAULT NULL,
  `ivaretenido` decimal(12,2) DEFAULT NULL,
  `tipo_movimiento` decimal(12,2) DEFAULT NULL COMMENT 'Es 1 cuando es cargo y es 2 cuando es abono',
  `isr` decimal(12,2) DEFAULT NULL,
  `ieps` decimal(12,2) DEFAULT NULL,
  `iepsretenido` decimal(12,2) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `idcbanco` varchar(100) DEFAULT NULL,
  `cuenta` varchar(100) DEFAULT NULL,
  `idcon_cuentas` int(11) DEFAULT NULL,
  `tipoCuenta` int(11) DEFAULT '3',
  `tipo` int(11) DEFAULT '2',
  `financiero` int(11) DEFAULT '0',
  `recurrente` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idcudn` int(11) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `tipopago` int(11) DEFAULT NULL,
  `observaciones` text,
  `idpadre_prorrateo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=95271 DEFAULT CHARSET=latin1;

/*Data for the table `con_movimientos` */

/*Table structure for table `con_partidas` */

CREATE TABLE `con_partidas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(800) DEFAULT NULL,
  `cuenta` varchar(200) DEFAULT NULL,
  `monto` decimal(12,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `con_partidas` */

/*Table structure for table `con_saldini` */

CREATE TABLE `con_saldini` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta` varchar(200) NOT NULL,
  `ejercicio` int(11) NOT NULL,
  `periodo` int(11) NOT NULL,
  `dia` int(11) NOT NULL,
  `saldo` decimal(12,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `con_saldini` */

/*Table structure for table `con_subcuentas` */

CREATE TABLE `con_subcuentas` (
  `id` varchar(10) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `saldoini` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idcon_cuentasmayor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `con_subcuentas` */

/*Table structure for table `conf_accesso_modulo` */

CREATE TABLE `conf_accesso_modulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modulo` varchar(55) DEFAULT NULL,
  `dia_inicio` varchar(45) DEFAULT NULL,
  `dia_fin` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `conf_accesso_modulo` */

/*Table structure for table `copciones_socioeconomico` */

CREATE TABLE `copciones_socioeconomico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idpregunta` int(11) DEFAULT NULL,
  `descripcion` text,
  `tipo` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cpregunta_socioeconomico_opcion_idx` (`idpregunta`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

/*Data for the table `copciones_socioeconomico` */

insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (1,32,'Alumbrado P??blico','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (2,32,'Drenaje','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (3,32,'Recolecci??n de Basura','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (4,32,'Vigilancia Policiaca','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (5,32,'Agua Potable','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (6,32,'Servicios de Salud','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (7,32,'Mercado','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (8,32,'Supermercado','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (9,32,'Transporte P??blico','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (10,32,'Tianguis','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (11,34,'Propia','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (12,34,'Pagandose','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (13,34,'Rentada','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (14,34,'Prestada','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (15,35,'Tierra','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (16,35,'Cemento','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (17,35,'Mosaico','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (18,56,'Agua Potable','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (19,56,'Luz El??ctrica','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (20,56,'Tel??fono','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (21,56,'Drenaje','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (22,56,'TV por cable','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (23,56,'Internet','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (24,36,'Repellado','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (25,36,'Sin Repello','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (26,36,'Madera','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (27,36,'Cart??n','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (28,37,'Concreto','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (29,37,'L??mina','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (30,37,'Teja de Barro','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (31,37,'Teja de asbesto','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (32,37,'Otro','text');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (33,38,'Estufa','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (34,38,'Refrigereador','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (35,38,'Horno de Microondas','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (36,38,'Licuadora','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (37,38,'Lavadora','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (38,38,'Televisi??n','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (39,38,'Grabadora/Stero','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (40,38,'Computadora','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (41,38,'No. Camas','text');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (42,39,'IMSS','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (43,39,'ISSSTE','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (44,39,'Particular','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (45,39,'Cruz Roja','checkbox');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (46,39,'Otro','text');
insert  into `copciones_socioeconomico`(`id`,`idpregunta`,`descripcion`,`tipo`) values (47,32,'Pavimento','checkbox');

/*Table structure for table `corigenrecurso` */

CREATE TABLE `corigenrecurso` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `corigenrecurso` */

insert  into `corigenrecurso`(`id`,`descripcion`,`status`) values ('IF','Ingreso federales.',1);
insert  into `corigenrecurso`(`id`,`descripcion`,`status`) values ('IM','Ingresos mixtos.',1);
insert  into `corigenrecurso`(`id`,`descripcion`,`status`) values ('IP','Ingresos propios.',1);

/*Table structure for table `cparametrosasistencia` */

CREATE TABLE `cparametrosasistencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idpuesto` int(11) DEFAULT NULL,
  `entrada` varchar(50) DEFAULT NULL,
  `entradai` varchar(50) DEFAULT NULL,
  `salidai` varchar(50) DEFAULT NULL,
  `salida` varchar(50) DEFAULT NULL,
  `tolerancia` int(11) DEFAULT NULL,
  `toleranciafalta` int(11) DEFAULT NULL,
  `retardospfalta` int(11) DEFAULT NULL,
  `faltaspdescuento` int(11) DEFAULT NULL,
  `corrido` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `iddepartamento` int(11) DEFAULT NULL,
  `diasemana` int(11) DEFAULT NULL,
  `montodescuento` decimal(9,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=183 DEFAULT CHARSET=latin1;

/*Data for the table `cparametrosasistencia` */

insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (1,0,'','','','',5,NULL,3,1,NULL,0,0,0,0,0,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (2,0,'08:00','','','18:00',5,NULL,3,1,NULL,1,0,0,0,1,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (3,0,'08:00','','','18:00',5,NULL,3,1,NULL,1,0,0,0,2,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (4,0,'08:00','','','18:00',5,NULL,3,1,NULL,1,0,0,0,3,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (5,0,'08:00','','','18:00',5,NULL,3,1,NULL,1,0,0,0,4,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (6,0,'08:00','','','18:00',5,NULL,3,1,NULL,1,0,0,0,5,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (7,0,'08:00','','','18:00',5,NULL,3,1,NULL,1,0,0,0,6,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (8,37,'19:00','','','09:00',0,NULL,3,1,NULL,1,0,8,9,0,241.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (9,37,'19:00','','','09:00',0,NULL,3,1,NULL,1,0,8,9,1,241.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (10,37,'19:00','','','09:00',0,NULL,3,1,NULL,1,0,8,9,2,241.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (11,37,'19:00','','','09:00',0,NULL,3,1,NULL,1,0,8,9,3,241.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (12,37,'19:00','','','09:00',0,NULL,3,1,NULL,1,0,8,9,4,241.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (13,37,'','','','',0,NULL,3,1,NULL,0,0,8,9,5,241.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (14,37,'19:00','','','09:00',0,NULL,3,1,NULL,1,0,8,9,6,241.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (15,0,'22:00','','','08:00',5,NULL,3,1,NULL,1,0,0,9,0,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (16,0,'22:00','','','08:00',5,NULL,3,1,NULL,1,0,0,9,1,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (17,0,'22:00','','','08:00',5,NULL,3,1,NULL,1,0,0,9,2,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (18,0,'22:00','','','08:00',5,NULL,3,1,NULL,1,0,0,9,3,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (19,0,'22:00','','','08:00',5,NULL,3,1,NULL,1,0,0,9,4,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (20,0,'22:00','','','08:00',5,NULL,3,1,NULL,1,0,0,9,5,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (21,0,'22:00','','','08:00',5,NULL,3,1,NULL,1,0,0,9,6,50.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (22,21,'06:30','','','16:30',0,NULL,3,1,NULL,1,0,20,6,0,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (23,21,'06:00','','','16:00',0,NULL,3,1,NULL,1,0,20,6,1,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (24,21,'','','','',0,NULL,3,1,NULL,0,0,20,6,2,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (25,21,'06:00','','','16:00',0,NULL,3,1,NULL,1,0,20,6,3,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (26,21,'06:00','','','16:00',0,NULL,3,1,NULL,1,0,20,6,4,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (27,21,'06:00','','','16:00',0,NULL,3,1,NULL,1,0,20,6,5,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (28,21,'06:00','','','16:00',0,NULL,3,1,NULL,1,0,20,6,6,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (29,22,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,13,6,0,193.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (30,22,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,13,6,1,193.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (31,22,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,13,6,2,193.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (32,22,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,13,6,3,193.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (33,22,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,13,6,4,193.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (34,22,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,13,6,5,193.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (35,22,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,13,6,6,193.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (36,22,'09:00','','','19:00',5,NULL,3,1,NULL,1,0,18,6,0,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (37,22,'','','','',5,NULL,3,1,NULL,0,0,18,6,1,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (38,22,'09:00','','','19:00',5,NULL,3,1,NULL,1,0,18,6,2,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (39,22,'09:00','','','19:00',5,NULL,3,1,NULL,1,0,18,6,3,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (40,22,'09:00','','','19:00',5,NULL,3,1,NULL,1,0,18,6,4,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (41,22,'09:00','','','19:00',5,NULL,3,1,NULL,1,0,18,6,5,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (42,22,'09:00','','','19:00',5,NULL,3,1,NULL,1,0,18,6,6,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (43,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,11,6,0,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (44,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,11,6,1,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (45,22,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,11,6,2,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (46,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,11,6,3,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (47,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,11,6,4,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (48,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,11,6,5,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (49,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,11,6,6,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (50,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,10,6,0,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (51,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,10,6,1,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (52,22,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,10,6,2,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (53,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,10,6,3,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (54,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,10,6,4,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (55,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,10,6,5,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (56,22,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,10,6,6,202.58);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (57,19,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,7,6,0,230.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (58,19,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,7,6,1,230.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (59,19,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,7,6,2,230.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (60,19,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,7,6,3,230.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (61,19,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,7,6,4,230.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (62,19,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,7,6,5,230.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (63,19,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,7,6,6,230.00);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (64,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,21,8,0,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (65,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,21,8,1,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (66,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,21,8,2,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (67,32,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,21,8,3,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (68,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,21,8,4,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (69,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,21,8,5,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (70,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,21,8,6,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (71,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,17,8,0,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (72,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,17,8,1,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (73,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,17,8,2,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (74,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,17,8,3,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (75,32,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,17,8,4,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (76,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,17,8,5,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (77,32,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,17,8,6,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (78,31,'16:00','','','00:00',0,NULL,3,1,NULL,1,0,26,8,0,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (79,31,'16:00','','','00:00',0,NULL,3,1,NULL,1,0,26,8,1,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (80,31,'16:00','','','00:00',0,NULL,3,1,NULL,1,0,26,8,2,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (81,31,'16:00','','','00:00',0,NULL,3,1,NULL,1,0,26,8,3,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (82,31,'16:00','','','00:00',0,NULL,3,1,NULL,1,0,26,8,4,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (83,31,'16:00','','','00:00',0,NULL,3,1,NULL,0,0,26,8,5,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (84,31,'16:00','','','00:00',0,NULL,3,1,NULL,1,0,26,8,6,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (85,3,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,14,3,0,266.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (86,3,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,14,3,1,266.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (87,3,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,14,3,2,266.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (88,3,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,14,3,3,266.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (89,3,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,14,3,4,266.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (90,3,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,14,3,5,266.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (91,3,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,14,3,6,266.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (92,1,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,2,1,0,333.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (93,1,'','','','',0,NULL,3,1,NULL,0,0,2,1,1,333.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (94,1,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,2,1,2,333.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (95,1,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,2,1,3,333.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (96,1,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,2,1,4,333.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (97,1,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,2,1,5,333.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (98,1,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,2,1,6,333.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (99,25,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,3,7,0,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (100,25,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,3,7,1,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (101,25,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,3,7,2,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (102,25,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,3,7,3,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (103,25,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,3,7,4,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (104,25,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,3,7,5,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (105,25,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,3,7,6,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (106,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,25,7,0,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (107,26,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,25,7,1,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (108,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,25,7,2,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (109,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,25,7,3,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (110,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,25,7,4,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (111,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,25,7,5,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (112,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,25,7,6,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (113,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,23,7,0,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (114,26,'09:00','','','19:00',0,NULL,3,1,NULL,0,0,23,7,1,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (115,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,23,7,2,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (116,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,23,7,3,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (117,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,23,7,4,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (118,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,23,7,5,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (119,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,23,7,6,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (120,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,12,7,0,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (121,26,'09:00','','','19:00',0,NULL,3,1,NULL,0,0,12,7,1,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (122,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,12,7,2,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (123,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,12,7,3,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (124,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,12,7,4,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (125,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,12,7,5,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (126,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,12,7,6,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (127,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,5,7,0,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (128,26,'','','','',0,NULL,3,1,NULL,0,0,5,7,1,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (129,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,5,7,2,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (130,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,5,7,3,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (131,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,5,7,4,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (132,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,5,7,5,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (133,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,5,7,6,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (134,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,6,7,0,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (135,26,'09:00','','','19:00',0,NULL,3,1,NULL,0,0,6,7,1,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (136,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,6,7,2,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (137,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,6,7,3,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (138,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,6,7,4,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (139,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,6,7,5,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (140,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,6,7,6,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (141,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,4,7,0,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (142,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,4,7,1,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (143,26,'08:00','','','18:00',0,NULL,3,1,NULL,0,0,4,7,2,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (144,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,4,7,3,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (145,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,4,7,4,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (146,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,4,7,5,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (147,26,'08:00','','','18:00',0,NULL,3,1,NULL,1,0,4,7,6,213.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (148,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,24,7,0,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (149,26,'09:00','','','19:00',0,NULL,3,1,NULL,0,0,24,7,1,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (150,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,24,7,2,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (151,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,24,7,3,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (152,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,24,7,4,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (153,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,24,7,5,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (154,26,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,24,7,6,186.66);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (155,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,15,9,0,219.23);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (156,38,'19:00','','','08:00',0,NULL,3,1,NULL,0,0,15,9,1,219.23);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (157,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,15,9,2,219.23);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (158,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,15,9,3,219.23);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (159,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,15,9,4,219.23);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (160,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,15,9,5,219.23);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (161,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,15,9,6,219.23);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (162,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,9,9,0,219.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (163,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,9,9,1,219.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (164,38,'19:00','','','08:00',0,NULL,3,1,NULL,0,0,9,9,2,219.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (165,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,9,9,3,219.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (166,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,9,9,4,219.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (167,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,9,9,5,219.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (168,38,'19:00','','','08:00',0,NULL,3,1,NULL,1,0,9,9,6,219.22);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (169,11,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,16,5,0,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (170,11,'09:00','','','19:00',0,NULL,3,1,NULL,0,0,16,5,1,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (171,11,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,16,5,2,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (172,11,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,16,5,3,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (173,11,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,16,5,4,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (174,11,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,16,5,5,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (175,11,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,16,5,6,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (176,12,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,19,5,0,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (177,12,'09:00','','','19:00',0,NULL,3,1,NULL,0,0,19,5,1,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (178,12,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,19,5,2,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (179,12,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,19,5,3,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (180,12,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,19,5,4,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (181,12,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,19,5,5,173.33);
insert  into `cparametrosasistencia`(`id`,`idpuesto`,`entrada`,`entradai`,`salidai`,`salida`,`tolerancia`,`toleranciafalta`,`retardospfalta`,`faltaspdescuento`,`corrido`,`status`,`idsucursal`,`idempleado`,`iddepartamento`,`diasemana`,`montodescuento`) values (182,12,'09:00','','','19:00',0,NULL,3,1,NULL,1,0,19,5,6,173.33);

/*Table structure for table `cperiodicidadpago` */

CREATE TABLE `cperiodicidadpago` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cperiodicidadpago` */

insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('01','Diario',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('02','Semanal',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('03','Catorcenal',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('04','Quincenal',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('05','Mensual',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('06','Bimestral',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('07','Unidad obra',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('08','Comision',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('09','Precio alzado',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('10','Decenal',1);
insert  into `cperiodicidadpago`(`id`,`descripcion`,`status`) values ('99','Otra periodicidad',1);

/*Table structure for table `cpregunta` */

CREATE TABLE `cpregunta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cseccion_id` int(11) DEFAULT NULL,
  `descripcion` varchar(800) DEFAULT NULL,
  `valor` decimal(9,2) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1;

/*Data for the table `cpregunta` */

insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (1,1,'HAY LONAS PROMOCIONANDO ALGUN PRODUCTO',1.00,'2019-03-26 09:27:52',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (2,1,'LOS ANUNCIOS LUMINOSOS Y LAMPARAS ESTAN EN CONDICIONES EN BUEN ESTADO (ROTAS, DETERIORADAS)\r\n',1.00,'2019-03-26 09:27:52',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (3,1,'LA ROTULACI??N Y PINTURA ESTA EN BUEN ESTADO\r\n',1.00,'2019-03-26 09:27:53',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (4,1,'LOS PRODUCTOS EXHIBIDOS FUERA EST??N LIMPIOS\r\n',1.00,'2019-03-26 09:27:53',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (5,1,'LA IMAGEN URBANA ES LIMPIA (SIN HIERBA, BASURA, LODO, BANQUETAS LIMPIAS, ETC)\r\n',1.00,'2019-03-26 09:27:53',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (6,1,'LOS PRODUCTOS EXHIBIDOS FUERA EST??N ETIQUETADOS\r\n',1.00,'2019-03-26 09:27:54',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (7,1,'LAS ILUMINARIAS SE ENCUENTRAN ENCENDIDAS/APAGADAS EN EL HORARIO ADECUADO\r\n',1.00,'2019-03-26 09:27:54',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (8,1,'LOS CRISTALES ESTAN LIMPIOS\r\n',1.00,'2019-03-26 09:27:54',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (9,1,'LOS ACCESOS A LA ENTRADA PRINCIPAL DE LA SUCURSAL ESTAN LIBRES DE OBJETOS QUE OBSTACULICEN EL TR??NSITO\r\n',1.00,'2019-03-26 09:27:54',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (10,1,'LOS PRODUCTOS EXHIBIDOS FUERA EST??N EN BUEN ESTADO (ARMOROL, LIMPIEZA)\r\n',1.00,'2019-03-26 09:27:55',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (11,2,'EL KIT DE HERRAMIENTAS PARA SERVICIO EST?? COMPLETO (GATOS, LLAVES, PISTOLAS, ETC)\r\n',1.00,'2019-03-26 09:27:55',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (12,2,'LAS HERRAMIENTAS ESTAN EN CONDICIONES OPTIMAS DE USO (MATRACAS ROTAS, DADOS BARRIDOS, TALADROS SIN CABLE, ETC.)\r\n',1.00,'2019-03-26 09:27:55',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (13,2,'LAS HERRAMIENTAS SE ENCUENTRAN EN UN PANEL DE HERRAMIENTAS (CARRITO, CAJA, ESTANTE, ETC)\r\n',1.00,'2019-03-26 09:27:55',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (14,2,'LA HOJA DE INVENTARIO SE ENCUENTRA EN UN LUGAR VISIBLE CERCA DEL PATIO DE SERVICIO (HOJA IMPRESA CON FECHA ACTUALIZADA)\r\n',1.00,'2019-03-26 09:27:56',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (15,2,'SE CUENTA CON RESGUARDO DE HERRAMIENTAS FIRMADO POR EL ??REA DE INSTALACI??N, ORGANIZADO EN UN RECOPILADOR. (NOMBRAR RESPONSABLES)\r\n',1.00,'2019-03-26 09:27:56',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (16,3,'SE CUENTA CON INSUMOS PARA LA OPERATIVIDAD (ROLLO DE ETIQUETAS, ROLLO DE TICKETS, TINTA PARA IMPRESORAS)\r\n',1.00,'2019-03-26 09:27:56',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (17,3,'SE CUENTA CON BOTIQUIN DE PRIMEROS AUXILIOS\r\n',1.00,'2019-03-26 09:27:56',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (18,3,'SE CUENTA CON PAPELER??A IMPRESA CORPORATIVA A LA VISTA DEL CLIENTE (TARJETAS DE PRESENTACI??N, HOJAS DE COTIZACI??N, CAT??LOGOS)\r\n',1.00,'2019-03-26 09:27:57',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (19,3,'SE CUENTA CON PAPELER??A DE OFICINA (HOJAS, LAPICEROS, GRAPADORAS, PERFORADORAS, CLIPS, PLUMONES, GRAPAS, ETC)\r\n',1.00,'2019-03-26 09:27:57',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (20,3,'LOS DOCUMENTOS OFICIALES ESTAN A LA VISTA DE LOS CLIENTES Y AUTORIDADES (MISION, VISION, AVISO DE PRIVACIDAD, PERMISOS, ETC)\r\n',1.00,'2019-03-26 09:27:57',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (21,3,'SILLAS PARA ??REA DE ESPERA\r\n',1.00,'2019-03-26 09:27:57',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (22,3,'SE CUENTA CON INSUMOS DE LIMPIEZA (JABON, PAPEL DE BA??O, ESCOBA, TRAPEADOR, AROMATIZANTE, CUBETAS, FRANELAS, ETC.)\r\n',1.00,'2019-03-26 09:27:58',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (23,4,'CONDICIONES DE RAMPA (LIMPIA, PINTADA, CON ACEITE, ETC.)\r\n',1.00,'2019-03-26 09:27:58',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (24,4,'CONDICIONES DE DESMONTADORA (LIMPIA, PINTADA, CON ACEITE, ETC.)\r\n',1.00,'2019-03-26 09:27:58',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (25,4,'CONDICIONES DE ALINEADORA (LIMPIA, PINTADA, CON ACEITE, ETC.)\r\n',1.00,'2019-03-26 09:27:58',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (26,4,'CONDICIONES DE BALANCEADORA (LIMPIA, PINTADA, CON ACEITE, ETC.)\r\n',1.00,'2019-03-26 09:27:59',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (27,4,'CONDICIONES DE COMPRESORA (LIMPIA, PINTADA, CON ACEITE, PURGADA, FEHA DE ULTIMO Y PROXIMO MANTENIMIENTO PEGADO EN LA COMPRESORA)\r\n',1.00,'2019-03-26 09:27:59',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (28,4,'CONDICIONES DE MAQUINA DE NITR??GENO  (LIMPIA, PINTADA, CON ACEITE Y MANGUERA EN BUENAS CONDICIONES)\r\n',1.00,'2019-03-26 09:27:59',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (29,4,'CONDICIONES ELECTRICAS (CABLEADO ELECTRICO NO VISIBLE)\r\n',1.00,'2019-03-26 09:27:59',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (30,5,'DISTRIBUCI??N DE ??REA DE MANIOBRAS (QUE SE ENCUENTRE EN SU AREA DELIMITADA)\r\n',1.00,'2019-11-28 08:32:58',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (31,5,'LIMPIEZA DEL PATIO DE MANIOBRAS Y SERVICIO\r\n',1.00,'2019-03-26 09:28:00',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (32,5,'LIMPIEZA DEL ??REA DE ESPERA\r\n',1.00,'2019-03-26 09:28:00',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (33,5,'LIMPIEZA DEL ??REA DE TRABAJO DEL ENCARGADO DE SUCURSAL\r\n',1.00,'2019-03-26 09:28:00',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (34,5,'LIMPIEZA DEL ??REA DE TRABAJO DE LA CAJERA (RECEPCI??N LIMPIA, SIN BASURA, SIN COMIDA, ETC)\r\n',1.00,'2019-03-26 09:28:00',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (35,5,'LIMPIEZA DE EXHIBIDORES DE PRODUCTO (RACK DE LLANTAS, RINES, ACCESORIOS, ETC)\r\n',1.00,'2019-03-26 09:28:01',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (36,5,'LIMPIEZA DE PRODUCTOS EXHIBIDOS\r\n',1.00,'2019-03-26 09:28:01',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (37,5,'LIMPIEZA DE SALA DE EXHIBICI??N\r\n',1.00,'2019-03-26 09:28:01',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (38,5,'LIMPIEZA DE BA??OS \r\n',1.00,'2019-03-26 09:28:01',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (39,6,'CONDICIONES DE PAREDES, TECHO Y HERRERIA (PUERTAS, PORTONES, CORTINAS, ETC)\r\n',1.00,'2019-03-26 09:28:02',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (40,6,'CONDICIONES DE PINTURA Y ROTULACI??N INTERIOR\r\n',1.00,'2019-03-26 09:28:02',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (41,6,'CONDICIONES CERRADURAS Y CANDADOS\r\n',1.00,'2019-03-26 09:28:02',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (42,6,'CONDICIONES DE FONTANER??A (LAVABOS, TARJAS,  TAZAS DE BA??O, MINGITORIOS, DRENAJE)\r\n',1.00,'2019-03-26 09:28:02',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (43,6,'SUMINISTRO DE AGUA POTABLE (SIN FUGAS, BOMBA ELECTRICA FUNCIONANDO CORRECTAMENTE, TINACO EN BUENAS CONDICIONES)\r\n',1.00,'2019-03-26 09:28:02',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (44,6,'CONDICIONES DE VENTILACI??N (VENTANAS, CLIMAS, VENTILADORES, ETC)\r\n',1.00,'2019-03-26 09:28:03',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (45,6,'CONDICIONES DEL ESTRUCTURADO DE RED Y TELEFONIA\r\n',1.00,'2019-11-28 08:32:31',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (46,6,'CONDICIONES DE CRISTALES (NO ROTOS, ESTRELLADOS, ETC)\r\n',1.00,'2019-03-26 09:28:03',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (47,7,'DOCUMENTACI??N DE RH COMPLETA Y ACTUALIZADA (FORMATOS DE: PERMISOS, ALTAS, BAJAS, LISTA NOMINAL, ETC)\r\n',1.00,'2019-03-26 09:28:03',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (48,7,'FORMATO DE PRODUCTOS NEGADOS ACTUALIZADO\r\n',1.00,'2019-03-26 09:28:04',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (49,7,'FORMATO DE PROSPECCI??N ACTUALIZADO Y CORRECTAMENTE LLENADO\r\n',1.00,'2019-03-26 09:28:04',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (50,8,'CONDICIONES DE COMPUTADORAS DE ESCRITORIO Y PORT??TILES (CAJA, ENCARGADO, ALMACEN Y VENDEDORES)\r\n',1.00,'2019-03-26 09:28:04',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (51,8,'CONDICIONES DE EQUIPO DE SONIDO\r\n',1.00,'2019-03-26 09:28:04',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (52,8,'CONDICIONES DE EQUIPO DE IMPRESI??N DIGITAL (IMPRESORAS Y MINIPRINTERS, IMPRESORAS DE ETIQUETAS)\r\n',1.00,'2019-03-26 09:28:05',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (53,8,'CONDICIONES DE ESCANER Y COPIADORA (*)\r\n',1.00,'2019-03-26 09:28:05',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (54,8,'CONDICIONES DE TERMINALES BANCARIAS\r\n',1.00,'2019-03-26 09:28:05',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (55,8,'CONDICIONES DE EQUIPO TELEF??NICO (TEL??FONOS ESTACIONARIOS Y CELULARES)\r\n',1.00,'2019-03-26 09:28:05',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (56,8,'LOS RESGUARDOS DE EQUIPOS TECNOL??GICOS (COMPUTADORAS, TELEFONOS, IMPRESORAS, ETC)\r\n',1.00,'2019-03-26 09:28:05',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (57,8,'CONDICIONES DE RED F??SICA (CABLEADO Y CONECTORES INTEGROS) Y L??GICA (RED DE DATOS OPERANDO EN LOS EQUIPOS)\r\n',1.00,'2019-03-26 09:28:06',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (58,8,'ACCESO Y FUNCIONAMIENTO A SISTEMA INFORM??TICO\r\n',1.00,'2019-03-26 09:28:06',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (59,9,'USO DE UNIFORMES (TODO EL PERSONAL DEBE PORTARLO)\r\n',1.00,'2019-03-26 09:28:06',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (60,9,'HIGIENE DEL PERSONAL (ALIENTO, HOLOR, RASURADO, CORTE DE CABELLO, ETC)\r\n',1.00,'2019-03-26 09:28:08',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (61,9,'LOS EMPLEADOS APLICAN LA GUIA DE ATENCI??N A CLIENTES\r\n',1.00,'2019-03-26 09:28:08',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (62,9,'BUENA PRESENTACI??N Y ACTITUD CON LOS CLIENTES Y COMPA??EROS DE TRABAJO\r\n',1.00,'2019-03-26 09:28:08',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (63,9,'LOS EMPLEADOS CONOCEN Y PONEN EN PRACTICA EL REGLAMENTO INTERNO\r\n',1.00,'2019-03-26 09:28:08',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (64,10,'LIMPIEZA INTERIOR DE UNIDADES  (MOTOS, AUTOS, CAMIONETAS)\r\n',1.00,'2019-03-26 09:28:09',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (65,10,'LIMPIEZA EXTERIOR DE UNIDADES  (MOTOS, AUTOS, CAMIONETAS)\r\n',1.00,'2019-03-26 09:28:09',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (66,10,'LAS UNIDADES SE ENCUENTRAN AL MENOS EN EL ESTADO SEG??N EL RESGUARDO ACTUAL\r\n',1.00,'2019-03-26 09:28:09',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (67,10,'CUENTA CON LA DOCUMENTACI??N ADECUADA\r\n',1.00,'2019-03-26 09:28:09',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (68,10,'EL RESPONSABLE DE LA UNIDAD CUENTA CON LICENCIA VIGENTE\r\n',1.00,'2019-03-26 09:28:09',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (69,10,'LOS RESGUARDOS DE UNIDADES EST??N ACTUALIZADOS\r\n',1.00,'2019-03-26 09:28:10',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (70,10,'LAS UNIDADES ESTAN ROTULADAS\r\n',1.00,'2019-03-26 09:28:10',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (71,10,'LAS LLAVES DE LAS UNIDADES SE ENCUENTRAN DEBIDAMENTE IDENTIFICADAS\r\n',1.00,'2019-03-26 09:28:10',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (72,10,'CUENTAN CON COPIA DEL COMPROBANTE DE SERVICIO REALIZADO\r\n',1.00,'2019-03-26 09:28:10',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (73,10,'CUENTAN CON PROGRAMACI??N DE PR??XIMO SERVICIO (ETIQUETA DE SERVICIO)\r\n',1.00,'2019-03-26 09:28:10',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (74,1,'IMAGEN EXTERIOR',1.00,'2019-03-26 09:42:07',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (75,2,'HERRAMIENTAS',1.00,'2019-03-26 09:42:08',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (76,3,'PAPELERIA E INSUMOS',1.00,'2019-03-26 09:42:08',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (77,4,'AREA OPERATIVA',1.00,'2019-03-26 09:42:09',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (78,5,'LIMPIEZA EN GENERAL',1.00,'2019-03-26 09:42:10',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (79,6,'CONDICIONES DE INFRAESTRUCTURA',1.00,'2019-03-26 09:42:11',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (80,7,'DOCUMENTACION DIGITAL',1.00,'2019-03-26 09:42:11',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (81,8,'TECNOLOGIAS DE INFORMACION Y COMUNICACIONES',1.00,'2019-03-26 09:42:12',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (82,9,'IMAGEN CORPORATIVA',1.00,'2019-03-26 09:42:13',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (83,10,'VEHICULOS',1.00,'2019-03-26 09:42:13',99);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (84,8,'EL SISTEMA DE CCTV ESTA FUNCIONANDO ADECUADAMENTE LOCAL Y EN LINEA',1.00,'2019-11-28 08:34:14',1);
insert  into `cpregunta`(`id`,`cseccion_id`,`descripcion`,`valor`,`timestamp`,`status`) values (85,8,'LA SUCURSAL CUENTA CON INTERNET ESTABLE EN SUS DIFERENTES ENLACES DE ISP',1.00,'2019-11-28 08:34:48',1);

/*Table structure for table `cpreguntas_socioeconomico` */

CREATE TABLE `cpreguntas_socioeconomico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `seccion` text,
  `tipo` varchar(20) DEFAULT NULL,
  `depende_pregunta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

/*Data for the table `cpreguntas_socioeconomico` */

insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (1,'Lugar de nacimiento','personales','text',1);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (2,'Estado civil','personal','text',2);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (3,'Fecha de Nacimiento','personal','date',1);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (4,'Sueldo del Padre','economico','ingreso',4);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (5,'Sueldo de la Madre','economico','ingreso',5);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (6,'sueldo de los Hijos','economico','ingreso',6);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (7,'Becas','economico','ingreso',7);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (8,'Otras percepciones','economico','ingreso',8);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (9,'Alimentaci??n','economico','gasto',9);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (10,'Renta','economico','gasto',10);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (11,'Luz','economico','gasto',11);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (12,'Agua','economico','gasto',12);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (13,'Ropa','economico','gasto',13);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (14,'Tel??fono','economico','gasto',14);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (15,'Colegiaturas','economico','gasto',15);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (16,'Pago a acreedores','economico','gasto',16);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (17,'Seguros/Medicinas','economico','gasto',17);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (18,'Transporte','economico','gasto',18);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (19,'Casa o Terrenos','economico','creditos',19);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (20,'Autom??vil(es)','economico','creditos',20);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (21,'Tarjetas bancarisas','economico','creditos',21);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (22,'Casas comerciales','economico','creditos',22);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (23,'Otros','economico','creditos',23);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (24,'??ltimo grado de estudios','escolaridad','text',24);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (25,'??Actualmente cursa alg??n estudio?','escolaridad','text',25);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (26,'Indique los estudios que est?? realizando','escolaridad','text',25);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (27,'??Cu??nto tiempo tiene de conocerlo?','vecinales','text',27);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (28,'??Ha tenido problemas con su vecino?','vecinales','text',28);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (29,'??C??mo describir??a la relaci??n de la familia?','vecinales','text',29);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (30,'??Lo considera buen vecino?','vecinales','text',30);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (31,'Si,no ??Por qu???','vecinales','text',30);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (32,'Tu colonia cuenta con','colonia_vivienda','check',32);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (33,'Tu casa cuenta con','colonia_vivienda','empty',33);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (34,'Condici??n','colonia_vivienda','check',33);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (35,'Pisos','colonia_vivienda','check',33);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (36,'Muros','colonia_vivienda','check',33);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (37,'Techo','colonia_vivienda','check',33);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (38,'Equipo de la vivienda','colonia_vivienda','check',38);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (39,'Servicios m??dicos con los que cuentan','serv_medicos','empty',39);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (40,'No. de personas que viven en la casa','familia','text',40);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (41,'No. de personas que dependen de los ingresos familiares','familia','text',41);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (42,'En la familia, ??Padece alguien alguna enfermedad cr??nica?','medicos','text',42);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (43,'??Qui??n o quienes?','medicos','text',42);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (44,'??Qu?? tipo de enfermedad?','medicos','text',42);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (45,'??Con cuanta frecuencia viaja con su familia?','sociocultural','text',45);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (46,'??Qu?? lugares visitan?','sociocultural','text',46);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (47,'??Cu??ndo y en qu?? lugar pas?? sus ??ltimas vacaciones?','sociocultural','text',47);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (48,'??Con qu?? frecuencia come en restaurantes?','sociocultural','text',48);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (49,'??Cuantos libros ha le??do este a??o?','sociocultural','text',49);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (50,'??Cuales?','sociocultural','text',49);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (51,'??Cuantos muesos ha visitado en los ??ltimos a??os?','sociocultural','text',51);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (52,'??A cuantas obras de teatro ha asistido en el ??ltimo a??o?','sociocultural','text',52);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (53,'??Practica alg??n deporte? ??Cu??l?','sociocultural','text',53);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (54,'??Sus familiares practican alg??n deporte?','sociocultural','text',54);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (55,'??Cuales?','sociocultural','text',54);
insert  into `cpreguntas_socioeconomico`(`id`,`descripcion`,`seccion`,`tipo`,`depende_pregunta`) values (56,'Servicios','colonia_vivienda','check',33);

/*Table structure for table `cprorrateo` */

CREATE TABLE `cprorrateo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idcsucursal` int(11) DEFAULT NULL,
  `porcentaje` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cprorrateo` */

/*Table structure for table `cpuesto` */

CREATE TABLE `cpuesto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iddepartamento` int(11) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `idpadre` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `cpuesto` */

insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (1,1,'GERENTE DE PARQUE',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (2,2,'PRUEBA1',0,99);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (3,3,'GERENTE DE HOTEL',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (4,4,'AUXILIAR DE RRHH',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (5,4,'AUXILIAR CONTABLE',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (6,5,'AUXILIAR DE MKT',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (7,1,'EJECUTIVO DE VENTAS',0,99);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (8,1,'TAQUILLA',0,99);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (9,5,'EJECUTIVO DE VENTAS',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (10,5,'TAQUILLA',0,99);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (11,5,'ENCARGADA DE BOUTIQUE',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (12,5,'ENCARGADA DE TAQUILLA',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (13,4,'JEFE ADMINISTRATIVO',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (14,5,'JEFE DE VENTAS',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (15,6,'JEFE DE A Y B',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (16,6,'BARMAN',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (17,6,'ENCARGADO DE SNACK',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (18,6,'ENCARGADO DE BANQUETES',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (19,6,'JEFE DE COCINA',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (20,6,'JEFE DE RESTAURANTE',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (21,6,'MESERO',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (22,6,'COCINERO',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (23,6,'STEWARD',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (24,6,'ROOM SERVICE',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (25,7,'JEFE DE MTTO',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (26,7,'AUXILIAR DE MTTO',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (27,7,'AUXILIAR DE LIMPIEZA',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (28,7,'AUXILIAR DE ????REAS P????BLICAS',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (29,8,'AMA DE LLAVES',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (30,8,'JEFE DE RECEPCI?????N',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (31,8,'RECEPCIONISTA',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (32,8,'CAMARISTA',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (33,8,'RESERVAS',0,99);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (34,8,'BELLBOY',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (35,5,'RESERVAS',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (36,8,'LAVANDER????A',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (37,9,'JEFE DE SEGURIDAD',0,1);
insert  into `cpuesto`(`id`,`iddepartamento`,`descripcion`,`idpadre`,`status`) values (38,9,'AUXILIAR DE SEGURIDAD',0,1);

/*Table structure for table `crazones_ventasfallidas` */

CREATE TABLE `crazones_ventasfallidas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `status` varchar(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `crazones_ventasfallidas` */

/*Table structure for table `cregimenfiscal` */

CREATE TABLE `cregimenfiscal` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `fisica` char(2) DEFAULT NULL,
  `moral` char(2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cregimenfiscal` */

insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('601','General de Ley Personas Morales','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('603','Personas Morales con Fines no Lucrativos','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('605','Sueldos y Salarios e Ingresos Asimilados a Salarios','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('606','Arrendamiento','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('607','Regimen de Enajenacion o Adquisicion de Bienes','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('608','Demas ingresos','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('609','Consolidacion','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('610','Residentes en el Extranjero sin Establecimiento Permanente en Mexico','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('611','Ingresos por Dividendos','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('612','Personas Fisicas con Actividades Empresariales y Profesionales','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('614','Ingresos por intereses','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('615','Regimen de los ingresos por obtencion de premios','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('616','Sin obligaciones fiscales','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('620','Sociedades Cooperativas de Produccion que optan por diferir sus ingresos','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('621','Incorporacion Fiscal','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('623','Opcional para Grupos de Sociedades','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('624','Coordinados','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('628','Hidrocarburos','N','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('629','De los Regimenes Fiscales Preferentes y de las Empresas Multinacionales','S','S',1);
insert  into `cregimenfiscal`(`id`,`descripcion`,`fisica`,`moral`,`status`) values ('630','Enajenacion de acciones en bolsa de valores','S','S',1);

/*Table structure for table `criesgopuesto` */

CREATE TABLE `criesgopuesto` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `criesgopuesto` */

insert  into `criesgopuesto`(`id`,`descripcion`,`status`) values ('1','Clase I',1);
insert  into `criesgopuesto`(`id`,`descripcion`,`status`) values ('2','Clase II',1);
insert  into `criesgopuesto`(`id`,`descripcion`,`status`) values ('3','Clase III',1);
insert  into `criesgopuesto`(`id`,`descripcion`,`status`) values ('4','Clase IV',1);
insert  into `criesgopuesto`(`id`,`descripcion`,`status`) values ('5','Clase V',1);

/*Table structure for table `cseccion` */

CREATE TABLE `cseccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(800) DEFAULT NULL,
  `tiempo` time DEFAULT NULL,
  `valor` decimal(9,2) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `cseccion` */

insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (1,'IMAGEN EXTERIOR',NULL,10.00,'2019-03-26 09:41:50',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (2,'HERRAMIENTAS',NULL,10.00,'2019-03-26 09:41:50',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (3,'PAPELERIA E INSUMOS',NULL,10.00,'2019-03-26 09:41:50',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (4,'AREA OPERATIVA',NULL,10.00,'2019-03-26 09:41:51',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (5,'LIMPIEZA GENERAL',NULL,10.00,'2019-03-26 09:41:51',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (6,'CONDICIONES DE INFRAESTRUCTURA',NULL,10.00,'2019-03-26 09:41:51',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (7,'DOCUMENTACION DIGITAL',NULL,10.00,'2019-03-26 09:41:52',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (8,'TECNOLOGIAS DE LA INFORMACION Y COMUNICACIONES',NULL,10.00,'2019-03-26 09:41:52',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (9,'IMAGEN CORPORATIVA',NULL,10.00,'2019-03-26 09:41:52',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (10,'UNIDADES DE EQUIPO Y REPARTO',NULL,10.00,'2019-03-26 09:41:54',1);
insert  into `cseccion`(`id`,`descripcion`,`tiempo`,`valor`,`timestamp`,`status`) values (11,'GENERAL',NULL,10.00,'2019-03-26 09:41:56',99);

/*Table structure for table `csexo` */

CREATE TABLE `csexo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcionSexo` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `csexo` */

insert  into `csexo`(`id`,`descripcionSexo`) values (1,'HOMBRE');
insert  into `csexo`(`id`,`descripcionSexo`) values (2,'MUJER');

/*Table structure for table `csubcategoria` */

CREATE TABLE `csubcategoria` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ccategoria_id` bigint(20) unsigned NOT NULL,
  `nombreSubcategoria` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `csubcategoria_ccategoria_id_foreign` (`ccategoria_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `csubcategoria` */

/*Table structure for table `csubmodulo` */

CREATE TABLE `csubmodulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(60) DEFAULT NULL,
  `idmodulo` int(8) DEFAULT NULL,
  `status` int(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `csubmodulo` */

/*Table structure for table `csubmodulos_intranet` */

CREATE TABLE `csubmodulos_intranet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `urlacceso` text,
  `moduloId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fkModuloId_idx` (`moduloId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `csubmodulos_intranet` */

/*Table structure for table `csucursal` */

CREATE TABLE `csucursal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `idreloj` int(11) DEFAULT NULL,
  `idprediction` int(11) DEFAULT NULL,
  `idherramienta` int(11) DEFAULT NULL,
  `prorrateo` decimal(9,2) DEFAULT NULL,
  `correo` text,
  `filiacion` varchar(45) DEFAULT NULL,
  `zona` int(11) DEFAULT NULL,
  `preporte` int(11) DEFAULT '1',
  `latitud` varchar(200) DEFAULT NULL,
  `longitud` varchar(200) DEFAULT NULL,
  `rango` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `csucursal` */

insert  into `csucursal`(`id`,`descripcion`,`status`,`idreloj`,`idprediction`,`idherramienta`,`prorrateo`,`correo`,`filiacion`,`zona`,`preporte`,`latitud`,`longitud`,`rango`) values (1,'MATRIZ',1,NULL,NULL,NULL,NULL,NULL,NULL,1,1,'16.7758167','-93.2061533',50.00);

/*Table structure for table `ctarea` */

CREATE TABLE `ctarea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(500) DEFAULT NULL,
  `fechainicio` date DEFAULT NULL,
  `horainicio` time DEFAULT NULL,
  `fechafin` date DEFAULT NULL,
  `horafin` time DEFAULT NULL,
  `programacion` varchar(100) DEFAULT NULL,
  `dias` varchar(100) DEFAULT NULL,
  `horas` varchar(500) DEFAULT NULL,
  `diasemana` int(11) DEFAULT NULL,
  `diames` int(11) DEFAULT NULL,
  `nip` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

/*Data for the table `ctarea` */

/*Table structure for table `ctiempocontrato` */

CREATE TABLE `ctiempocontrato` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  `meses` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `ctiempocontrato` */

insert  into `ctiempocontrato`(`id`,`descripcion`,`meses`,`status`) values (1,'3 Meses',3,1);
insert  into `ctiempocontrato`(`id`,`descripcion`,`meses`,`status`) values (2,'6 Meses',6,1);
insert  into `ctiempocontrato`(`id`,`descripcion`,`meses`,`status`) values (3,'12 Meses',12,1);

/*Table structure for table `ctipocontrato` */

CREATE TABLE `ctipocontrato` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctipocontrato` */

insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('01','Contrato de trabajo por tiempo indeterminado',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('02','Contrato de trabajo para obra determinada',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('03','Contrato de trabajo por tiempo determinado',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('04','Contrato de trabajo por temporada',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('05','Contrato de trabajo sujeto a prueba',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('06','Contrato de trabajo con capacitacion inicial',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('07','Modalidad de contratacion por pago de hora laborada',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('08','Modalidad de trabajo por comision laboral',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('09','Modalidades de contratacion donde no existe relacion de trabajo',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('10','Jubilacion pension retiro',1);
insert  into `ctipocontrato`(`id`,`descripcion`,`status`) values ('99','Otro contrato',1);

/*Table structure for table `ctipocuenta` */

CREATE TABLE `ctipocuenta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipocuenta` varchar(45) DEFAULT NULL,
  `tipomovimiento` varchar(45) DEFAULT NULL,
  `operacion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COMMENT='Guarda los tipos de cuentas a los que puede pertenecer un movimiento que se registra en la tabla con_movimientos o en la tabla saldos_bancarios';

/*Data for the table `ctipocuenta` */

insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (1,'Operativo','Ingresos','Ventas');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (2,'Operativo','Egresos','CXP');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (3,'Operativo','Egresos','Gastos Operativos');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (4,'Inversi??n','Ingresos','Ventas Activos Fijos');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (5,'Inversi??n','Egresos','Compras Activos Fijos');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (6,'Financiero','Ingresos','Adquisici??n de Cr??ditos');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (7,'Financiero','Egresos','Pago Cr??dito');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (8,'Financiero','Egresos','Comisiones Bancarias');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (9,'Operativo','Ingresos','Caja Chica');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (10,'Operativo','Ingresos','Ingresos Varios');
insert  into `ctipocuenta`(`id`,`tipocuenta`,`tipomovimiento`,`operacion`) values (11,'Operativo','Egresos','Gastos Generales');

/*Table structure for table `ctipodeduccion` */

CREATE TABLE `ctipodeduccion` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctipodeduccion` */

insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('00001','Desacato',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('00002','Violencia',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('00003','Alteracion del Orden',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('00004','Perjuicios materiales',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('00005','Actos inmorales',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('00006','Estado de ebriedad',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('0001','Retardos',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('0002','Acciones correctivas',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('0003','Pago de deuda interna',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('0004','Pago de uniformes',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('0005','Falta injustificada',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('0006','Permiso sin goce de sueldo',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('0007','Anticipo de salario',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('001','Seguridad social',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('002','ISR',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('003','Aportaciones a retiro cesantia en edad avanzada y vejez.',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('004','Otros',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('005','Aportaciones a Fondo de vivienda',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('006','Descuento por incapacidad',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('007','Pension alimenticia',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('008','Renta',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('009','Prestamos provenientes del Fondo Nacional de la Vivienda para los Trabajadores',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('010','Pago por credito de vivienda',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('011','Pago de abonos INFONACOT',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('012','Anticipo de salarios',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('013','Pagos hechos con exceso al trabajador',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('014','Errores',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('015','Perdidas',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('016','Averias',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('017','Adquisicion de articulos producidos por la empresa o establecimiento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('018','Cuotas para la constitucion y fomento de sociedades cooperativas y de cajas de ahorro',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('019','Cuotas sindicales',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('020','Ausencia (Ausentismo)',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('021','Cuotas obrero patronales',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('022','Impuestos Locales',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('023','Aportaciones voluntarias',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('024','Ajuste en Aguinaldo Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('025','Ajuste en Aguinaldo Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('026','Ajuste en Participacion de los Trabajadores en las Utilidades PTU Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('027','Ajuste en Participacion de los Trabajadores en las Utilidades PTU Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('028','Ajuste en Reembolso de Gastos Medicos Dentales y Hospitalarios Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('029','Ajuste en Fondo de ahorro Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('030','Ajuste en Caja de ahorro Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('031','Ajuste en Contribuciones a Cargo del Trabajador Pagadas por el Patron Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('032','Ajuste en Premios por puntualidad Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('033','Ajuste en Prima de Seguro de vida Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('034','Ajuste en Seguro de Gastos Medicos Mayores Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('035','Ajuste en Cuotas Sindicales Pagadas por el Patron Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('036','Ajuste en Subsidios por incapacidad Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('037','Ajuste en Becas para trabajadores y o hijos Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('038','Ajuste en Horas extra Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('039','Ajuste en Horas extra Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('040','Ajuste en Prima dominical Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('041','Ajuste en Prima dominical Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('042','Ajuste en Prima vacacional Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('043','Ajuste en Prima vacacional Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('044','Ajuste en Prima por antig????edad Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('045','Ajuste en Prima por antig????edad Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('046','Ajuste en Pagos por separacion Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('047','Ajuste en Pagos por separacion Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('048','Ajuste en Seguro de retiro Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('049','Ajuste en Indemnizaciones Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('050','Ajuste en Indemnizaciones Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('051','Ajuste en Reembolso por funeral Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('052','Ajuste en Cuotas de seguridad social pagadas por el patron Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('053','Ajuste en Comisiones Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('054','Ajuste en Vales de despensa Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('055','Ajuste en Vales de restaurante Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('056','Ajuste en Vales de gasolina Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('057','Ajuste en Vales de ropa Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('058','Ajuste en Ayuda para renta Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('059','Ajuste en Ayuda para articulos escolares Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('060','Ajuste en Ayuda para anteojos Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('061','Ajuste en Ayuda para transporte Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('062','Ajuste en Ayuda para gastos de funeral Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('063','Ajuste en Otros ingresos por salarios Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('064','Ajuste en Otros ingresos por salarios Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('065','Ajuste en Jubilaciones pensiones o haberes de retiro Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('066','Ajuste en Jubilaciones pensiones o haberes de retiro Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('067','Ajuste en Pagos por separacion Acumulable',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('068','Ajuste en Pagos por separacion No acumulable',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('069','Ajuste en Jubilaciones pensiones o haberes de retiro Acumulable',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('070','Ajuste en Jubilaciones pensiones o haberes de retiro No acumulable',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('071','Ajuste en Subsidio para el empleo (efectivamente entregado al trabajador)',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('072','Ajuste en Ingresos en acciones o titulos valor que representan bienes Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('073','Ajuste en Ingresos en acciones o titulos valor que representan bienes Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('074','Ajuste en Alimentacion Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('075','Ajuste en Alimentacion Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('076','Ajuste en Habitacion Exento',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('077','Ajuste en Habitacion Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('078','Ajuste en Premios por asistencia',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('079','Ajuste en Pagos distintos a los listados y que no deben considerarse como ingreso por sueldos salarios o ingresos asimilados.',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('080','Ajuste en Viaticos gravados',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('081','Ajuste en Viaticos',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('082','Ajuste en Fondo de ahorro Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('083','Ajuste en Caja de ahorro Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('084','Ajuste en Prima de Seguro de vida Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('085','Ajuste en Seguro de Gastos Medicos Mayores Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('086','Ajuste en Subsidios por incapacidad Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('087','Ajuste en Becas para trabajadores y o hijos Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('088','Ajuste en Seguro de retiro Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('089','Ajuste en Vales de despensa Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('090','Ajuste en Vales de restaurante Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('091','Ajuste en Vales de gasolina Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('092','Ajuste en Vales de ropa Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('093','Ajuste en Ayuda para renta Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('094','Ajuste en Ayuda para articulos escolares Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('095','Ajuste en Ayuda para anteojos Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('096','Ajuste en Ayuda para transporte Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('097','Ajuste en Ayuda para gastos de funeral Gravado',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('098','Ajuste a ingresos asimilados a salarios gravados',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('099','Ajuste a ingresos por sueldos y salarios gravados',1);
insert  into `ctipodeduccion`(`id`,`descripcion`,`status`) values ('100','Ajuste en Viaticos exentos',1);

/*Table structure for table `ctipodoc` */

CREATE TABLE `ctipodoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `ctipodoc` */

insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (1,'SOLICITUD DE EMPLEO',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (2,'CURRICULUM VITAE',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (3,'INE',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (4,'ACTA DE NACIMIENTO',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (5,'COMPROBANTE DE ESTUDIOS',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (6,'CURP',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (7,'RFC',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (8,'LICENCIA DE MANEJO',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (9,'CARTA DE RECOMENDACION',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (10,'COMPROBANTE DE DOMICILIO',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (11,'NSS',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (12,'LICENCIA DE MOTOCICLISTA',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (13,'FOTOGRAFIA',0);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (14,'CONTRATO',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (15,'PAGAR??',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (16,'ACTA DE ENTREGA Y RECEPCION',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (17,'OTROS',1);
insert  into `ctipodoc`(`id`,`descripcion`,`status`) values (18,'HOJA EN BLANCO',1);

/*Table structure for table `ctipoegreso` */

CREATE TABLE `ctipoegreso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='Cat??logo de los metodos de pagos que se realizan en la operaci??n';

/*Data for the table `ctipoegreso` */

insert  into `ctipoegreso`(`id`,`descripcion`,`status`) values (1,'Efectivo',1);
insert  into `ctipoegreso`(`id`,`descripcion`,`status`) values (2,'Transferencia',1);
insert  into `ctipoegreso`(`id`,`descripcion`,`status`) values (3,'Cheque',1);
insert  into `ctipoegreso`(`id`,`descripcion`,`status`) values (4,'Dep??sito',1);
insert  into `ctipoegreso`(`id`,`descripcion`,`status`) values (5,'Tarjeta de cr??dito',1);
insert  into `ctipoegreso`(`id`,`descripcion`,`status`) values (6,'Tarjeta de d??bito',1);

/*Table structure for table `ctipohoras` */

CREATE TABLE `ctipohoras` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctipohoras` */

insert  into `ctipohoras`(`id`,`descripcion`,`status`) values ('01','Dobles',1);
insert  into `ctipohoras`(`id`,`descripcion`,`status`) values ('02','Triples',1);
insert  into `ctipohoras`(`id`,`descripcion`,`status`) values ('03','Simples',1);

/*Table structure for table `ctipoincapacidad` */

CREATE TABLE `ctipoincapacidad` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctipoincapacidad` */

insert  into `ctipoincapacidad`(`id`,`descripcion`,`status`) values ('01','Riesgo de trabajo.',1);
insert  into `ctipoincapacidad`(`id`,`descripcion`,`status`) values ('02','Enfermedad en general.',1);
insert  into `ctipoincapacidad`(`id`,`descripcion`,`status`) values ('03','Maternidad.',1);

/*Table structure for table `ctipojornada` */

CREATE TABLE `ctipojornada` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctipojornada` */

insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('01','Diurna',1);
insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('02','Nocturna',1);
insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('03','Mixta',1);
insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('04','Por hora',1);
insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('05','Reducida',1);
insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('06','Continuada',1);
insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('07','Partida',1);
insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('08','Por turnos',1);
insert  into `ctipojornada`(`id`,`descripcion`,`status`) values ('99','Otra Jornada',1);

/*Table structure for table `ctiponomina` */

CREATE TABLE `ctiponomina` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctiponomina` */

insert  into `ctiponomina`(`id`,`descripcion`,`status`) values ('A','Nomina ordinaria',1);
insert  into `ctiponomina`(`id`,`descripcion`,`status`) values ('E','Nomina extraordinaria',1);

/*Table structure for table `ctipootropago` */

CREATE TABLE `ctipootropago` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctipootropago` */

insert  into `ctipootropago`(`id`,`descripcion`,`status`) values ('001','Reintegro de ISR pagado en exceso',1);
insert  into `ctipootropago`(`id`,`descripcion`,`status`) values ('002','Subsidio para el empleo',1);
insert  into `ctipootropago`(`id`,`descripcion`,`status`) values ('003','Viaticos',1);
insert  into `ctipootropago`(`id`,`descripcion`,`status`) values ('004','Aplicacion de saldo a favor por compensacion anual',1);
insert  into `ctipootropago`(`id`,`descripcion`,`status`) values ('999','Pagos distintos a los listados y que no deben considerarse como ingreso por sueldos salarios o ingresos asimilados',1);

/*Table structure for table `ctipopercepcion` */

CREATE TABLE `ctipopercepcion` (
  `id` char(5) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctipopercepcion` */

insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('001','Sueldos, Salarios,  Rayas y Jornales',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('002','Aguinaldo',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('003','Participacion de los Trabajadores en las Utilidades PTU',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('004','Reembolso de Gastos Medicos Dentales y Hospitalarios',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('005','Fondo de Ahorro',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('006','Caja de ahorro',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('009','Contribuciones a Cargo del Trabajador Pagadas por el Patron',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('010','Premios por puntualidad',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('011','Prima de Seguro de vida',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('012','Seguro de Gastos Medicos Mayores',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('013','Cuotas Sindicales Pagadas por el Patron',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('014','Subsidios por incapacidad',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('015','Becas para trabajadores y o hijos',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('019','Horas extra',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('020','Prima dominical',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('021','Prima vacacional',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('022','Prima por antig????edad',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('023','Pagos por separacion',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('024','Seguro de retiro',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('025','Indemnizaciones',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('026','Reembolso por funeral',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('027','Cuotas de seguridad social pagadas por el patron',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('028','Comisiones',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('029','Vales de despensa',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('030','Vales de restaurante',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('031','Vales de gasolina',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('032','Vales de ropa',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('033','Ayuda para renta',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('034','Ayuda para articulos escolares',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('035','Ayuda para anteojos',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('036','Ayuda para transporte',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('037','Ayuda para gastos de funeral',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('038','Otros ingresos por salarios',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('039','Jubilaciones pensiones o haberes de retiro',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('044','Jubilaciones pensiones o haberes de retiro en parcialidades',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('045','Ingresos en acciones o titulos valor que representan bienes',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('046','Ingresos asimilados a salarios',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('047','Alimentacion',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('048','Habitacion',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('049','Premios por asistencia',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('050','Viaticos',1);
insert  into `ctipopercepcion`(`id`,`descripcion`,`status`) values ('051','Dias de vacaciones',1);

/*Table structure for table `ctiporegimen` */

CREATE TABLE `ctiporegimen` (
  `id` char(5) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ctiporegimen` */

insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('02','Sueldos',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('03','Jubilados',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('05','Asimilados Miembros Sociedades Cooperativas Produccion',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('06','Asimilados Integrantes Sociedades Asociaciones Civiles',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('07','Asimilados Miembros consejos',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('08','Asimilados comisionistas',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('09','Asimilados Honorarios',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('10','Asimilados acciones',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('11','Asimilados otros',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('04','Pensionados',1);
insert  into `ctiporegimen`(`id`,`descripcion`,`status`) values ('12','Jubilados o Pensionados',1);

/*Table structure for table `ctiposangre` */

CREATE TABLE `ctiposangre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcionSangre` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `ctiposangre` */

insert  into `ctiposangre`(`id`,`descripcionSangre`) values (1,'O POSITIVO');
insert  into `ctiposangre`(`id`,`descripcionSangre`) values (2,'O NEGATIVO');
insert  into `ctiposangre`(`id`,`descripcionSangre`) values (3,'A POSITIVO');
insert  into `ctiposangre`(`id`,`descripcionSangre`) values (4,'A NEGATIVO');
insert  into `ctiposangre`(`id`,`descripcionSangre`) values (5,'B POSITIVO');
insert  into `ctiposangre`(`id`,`descripcionSangre`) values (6,'B NEGATIVO');
insert  into `ctiposangre`(`id`,`descripcionSangre`) values (7,'AB POSITIVO');
insert  into `ctiposangre`(`id`,`descripcionSangre`) values (8,'AB NEGATIVO');

/*Table structure for table `ctipousuario` */

CREATE TABLE `ctipousuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(400) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

/*Data for the table `ctipousuario` */

insert  into `ctipousuario`(`id`,`descripcion`,`status`) values (1,'ADMINISTRADOR',1);
insert  into `ctipousuario`(`id`,`descripcion`,`status`) values (2,'JEFE SUCURSAL',1);
insert  into `ctipousuario`(`id`,`descripcion`,`status`) values (3,'USUARIO',1);
insert  into `ctipousuario`(`id`,`descripcion`,`status`) values (4,'CONTABILIDAD',1);
insert  into `ctipousuario`(`id`,`descripcion`,`status`) values (5,'RH',1);
insert  into `ctipousuario`(`id`,`descripcion`,`status`) values (101,'EXTERNO',1);

/*Table structure for table `cuentas_bancarias` */

CREATE TABLE `cuentas_bancarias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero_cuenta` varchar(45) NOT NULL,
  `banco` text NOT NULL,
  `status` int(11) DEFAULT '1',
  `saldo` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_cuena_UNIQUE` (`numero_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cuentas_bancarias` */

/*Table structure for table `czona` */

CREATE TABLE `czona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `czona` */

insert  into `czona`(`id`,`descripcion`,`status`) values (1,'TUXTLA',1);
insert  into `czona`(`id`,`descripcion`,`status`) values (2,'TEST',99);

/*Table structure for table `detalles_deuda_acreedor` */

CREATE TABLE `detalles_deuda_acreedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_acreedor` int(11) DEFAULT NULL,
  `monto_total_deuda` double DEFAULT NULL,
  `plazo_deuda` bigint(20) DEFAULT NULL,
  `interes_deuda` bigint(20) DEFAULT NULL,
  `id_num_abono_deuda` int(11) DEFAULT NULL,
  `restante_deuda` double DEFAULT NULL,
  `fecha_deuda_gen` date DEFAULT NULL,
  `liquidado` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_num_abono_deuda` (`id_num_abono_deuda`),
  KEY `id_acreedor` (`id_acreedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `detalles_deuda_acreedor` */

/*Table structure for table `dipositivos_compartir_eventos_app` */

CREATE TABLE `dipositivos_compartir_eventos_app` (
  `dispositivoEmisor` varchar(250) NOT NULL,
  `dispositivoReceptor` varchar(250) NOT NULL,
  `nombreUsuarioEmisor` text,
  `nombreUsuarioRecepto` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que mantiene el control de que dispositvo es el que puede compartir sus eventos con los dem??s que tengan la app de la agenda';

/*Data for the table `dipositivos_compartir_eventos_app` */

/*Table structure for table `failed_jobs` */

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `flujoefectivo` */

CREATE TABLE `flujoefectivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `sucursal` varchar(100) DEFAULT NULL,
  `efectivo` decimal(9,2) DEFAULT NULL,
  `bxcredito` decimal(9,2) DEFAULT NULL,
  `bxdebito` decimal(9,2) DEFAULT NULL,
  `bxseism` decimal(9,2) DEFAULT NULL,
  `bxdocem` decimal(9,2) DEFAULT NULL,
  `bmseism` decimal(9,2) DEFAULT NULL,
  `bmdocem` decimal(9,2) DEFAULT NULL,
  `stseism` decimal(9,2) DEFAULT NULL,
  `stdocem` decimal(9,2) DEFAULT NULL,
  `transferencia` decimal(9,2) DEFAULT NULL,
  `cheque` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `flujoefectivo` */

/*Table structure for table `gra_edosfinancieros` */

CREATE TABLE `gra_edosfinancieros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sucursal` varchar(100) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `mes` varchar(100) DEFAULT NULL,
  `ventas` decimal(9,2) DEFAULT NULL,
  `costos` decimal(9,2) DEFAULT NULL,
  `operacion` decimal(9,2) DEFAULT NULL,
  `financiero` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `mesint` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `gra_edosfinancieros` */

/*Table structure for table `huellas` */

CREATE TABLE `huellas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempleado` int(11) NOT NULL,
  `huella` blob NOT NULL,
  `estatus` varchar(45) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `huellas` */

/*Table structure for table `incidencia_asistencia` */

CREATE TABLE `incidencia_asistencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trabajadorId` int(11) DEFAULT NULL,
  `inicio_periodo` date DEFAULT NULL,
  `fin_periodo` date DEFAULT NULL,
  `asistencias` decimal(5,2) DEFAULT NULL,
  `faltas` decimal(5,2) DEFAULT NULL,
  `retardos` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `periodo_prenomina` (`inicio_periodo`,`fin_periodo`,`trabajadorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `incidencia_asistencia` */

/*Table structure for table `inventario_excepciones` */

CREATE TABLE `inventario_excepciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `almacen` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `causa` text,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `inventario_excepciones` */

/*Table structure for table `inventarios` */

CREATE TABLE `inventarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` text,
  `descripcion` text,
  `familia` text,
  `subfamilia` text,
  `fisico` double DEFAULT NULL,
  `fisico2` double DEFAULT NULL,
  `fisico3` double DEFAULT NULL,
  `stock` double DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL,
  `sucursal_id` int(11) NOT NULL,
  `fechaCaptura` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tiempo` time DEFAULT NULL,
  `usuario_id` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idpadre_inventario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `inventarios` */

/*Table structure for table `inventarios_copy` */

CREATE TABLE `inventarios_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` text,
  `descripcion` text,
  `familia` text,
  `subfamilia` text,
  `fisico` double DEFAULT NULL,
  `fisico2` double DEFAULT NULL,
  `fisico3` double DEFAULT NULL,
  `stock` double DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL,
  `sucursal_id` int(11) NOT NULL,
  `fechaCaptura` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tiempo` time DEFAULT NULL,
  `usuario_id` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idpadre_inventario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `inventarios_copy` */

/*Table structure for table `lista_acreedores` */

CREATE TABLE `lista_acreedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_entidad` tinytext,
  `alias` tinytext,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `lista_acreedores` */

/*Table structure for table `listado_deudas_acreedores` */

CREATE TABLE `listado_deudas_acreedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_acreedor` int(11) DEFAULT NULL,
  `id_detalle_deuda` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_acreedor` (`id_acreedor`),
  KEY `id_detalle_deuda` (`id_detalle_deuda`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `listado_deudas_acreedores` */

/*Table structure for table `log_calpagos_app` */

CREATE TABLE `log_calpagos_app` (
  `id` int(11) NOT NULL,
  `beneficiario` text,
  `concepto` text,
  `monto` text,
  `fecha_evento` date DEFAULT NULL,
  `frecuencia_recordatorio` int(11) DEFAULT NULL,
  `hora_recordatorio` time DEFAULT NULL,
  `tipo_operacion` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `dispositivo` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `log_calpagos_app` */

/*Table structure for table `logcompras_recepcion` */

CREATE TABLE `logcompras_recepcion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCompratmp` varchar(45) DEFAULT NULL,
  `noFactura` varchar(45) DEFAULT NULL,
  `fechaRecepcion` datetime DEFAULT NULL,
  `fechaIngresoFact` datetime DEFAULT NULL,
  `noCompra` varchar(45) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT '1',
  `idusuarioAuditor` varchar(100) DEFAULT NULL,
  `idusuarioCompras` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `logcompras_recepcion` */

/*Table structure for table `metas_acumulados` */

CREATE TABLE `metas_acumulados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `almacen_id` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `meta_diaria_llanta` int(11) DEFAULT NULL,
  `meta_diaria_rin` float DEFAULT NULL,
  `meta_diaria_colision` int(11) DEFAULT '0',
  `meta_diaria_accesorio` int(11) DEFAULT '0',
  `meta_diaria_oxifuel` int(11) DEFAULT '0',
  `aplicadomingo` int(11) DEFAULT NULL,
  `meta_mensual_llanta` int(11) DEFAULT NULL,
  `meta_mensual_rin` int(11) DEFAULT NULL,
  `meta_mensual_colision` int(11) DEFAULT '0',
  `meta_mensual_accesorio` int(11) DEFAULT '0',
  `meta_mensual_oxifuel` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `metas_acumulados` */

/*Table structure for table `metasfamilias` */

CREATE TABLE `metasfamilias` (
  `familia` varchar(100) DEFAULT NULL,
  `idalmacen` int(11) DEFAULT NULL,
  `vmensual` decimal(9,2) DEFAULT '0.00',
  `vsemanal` decimal(9,2) DEFAULT '0.00',
  `vdiario` decimal(9,2) DEFAULT '0.00',
  `imensual` decimal(9,2) DEFAULT '0.00',
  `isemanal` decimal(9,2) DEFAULT '0.00',
  `idiario` decimal(9,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `metasfamilias` */

/*Table structure for table `metaventas` */

CREATE TABLE `metaventas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` decimal(18,2) DEFAULT NULL,
  `vmensual_rin` decimal(9,2) DEFAULT NULL,
  `vmensual_llanta` decimal(9,2) DEFAULT NULL,
  `vmensual_colision` decimal(9,2) DEFAULT NULL,
  `vmensual_accesorio` decimal(9,2) DEFAULT NULL,
  `vol_diario` decimal(9,2) DEFAULT NULL,
  `idAlmacen` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `metaventas` */

/*Table structure for table `migrations` */

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

/*Table structure for table `nomina_asistencia` */

CREATE TABLE `nomina_asistencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempleado` int(11) DEFAULT NULL,
  `fecfalta` date DEFAULT NULL,
  `fecretardo` date DEFAULT NULL,
  `montofalta` decimal(9,2) DEFAULT '0.00',
  `montoretardo` decimal(9,2) DEFAULT '0.00',
  `fechaaplicacion` date DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `nomina_asistencia` */

/*Table structure for table `pacciones_correctivas` */

CREATE TABLE `pacciones_correctivas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempleado` int(11) NOT NULL,
  `fecha_sancion` date NOT NULL,
  `motivo` text COLLATE utf8_spanish_ci,
  `plan_accion` text COLLATE utf8_spanish_ci,
  `fecha_descuento` date DEFAULT NULL,
  `monto` double NOT NULL DEFAULT '0',
  `sucursalId` int(11) NOT NULL,
  `puestoId` int(11) NOT NULL,
  `status` int(11) DEFAULT '1',
  `id_usuario_aplico_sancion` int(11) DEFAULT NULL,
  `consecutivo` int(11) DEFAULT NULL,
  `aplicado` varchar(45) COLLATE utf8_spanish_ci DEFAULT 'N',
  `idaccion_consecutivo_anterior` int(11) DEFAULT NULL,
  `idtipodeduccion` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `pacciones_correctivas` */

/*Table structure for table `pactivofijos` */

CREATE TABLE `pactivofijos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `csucursal_id` bigint(20) unsigned NOT NULL,
  `ccategoria_id` bigint(20) unsigned NOT NULL,
  `csubcategoria_id` bigint(20) unsigned NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionActivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marca` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `noSerie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `valorAdquisicion` double DEFAULT NULL,
  `fechaAdquisicion` date DEFAULT NULL,
  `noMotor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placa` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipoLinea` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numeroTelefonico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pathImage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pactivofijos_ccategoria_id_foreign` (`ccategoria_id`),
  KEY `pactivofijos_csubcategoria_id_foreign` (`csubcategoria_id`),
  KEY `pactivofijos_csucursal_id_foreign` (`csucursal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `pactivofijos` */

/*Table structure for table `padre_inventario` */

CREATE TABLE `padre_inventario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idalmacen` double DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `observacion` text,
  `accion_correctiva` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `padre_inventario` */

/*Table structure for table `pafiliaciones` */

CREATE TABLE `pafiliaciones` (
  `numero` varchar(100) DEFAULT NULL,
  `banco` int(11) DEFAULT NULL,
  `sucursal` int(11) DEFAULT NULL,
  UNIQUE KEY `unique_afiliacion` (`numero`,`banco`,`sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pafiliaciones` */

/*Table structure for table `pappmenus` */

CREATE TABLE `pappmenus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vista` varchar(200) DEFAULT NULL,
  `option` varchar(100) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `handle` varchar(100) DEFAULT NULL,
  `grupo` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `pappmenus` */

insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (1,'ventasMenu','Buscador de Productos','shopping-cart','productos',3,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (2,'ventasMenu','Ventas Vendedores','certificate','comisiones',3,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (3,'mainMenu','Administracion','book','AdmonMenu',2,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (4,'mainMenu','RH','users','rhMenu',3,1);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (5,'mainMenu','Ventas','credit-card','ventasMenu',3,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (6,'mainMenu','Control','shield','controlMenu',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (7,'mainMenu','Soporte TI','comment','helpdesk',3,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (8,'mainMenu','Inventario','archive','inventario',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (9,'mainMenu','Salir','sign-out','login',3,1);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (10,'admonMenu','Gastos','money','gastos',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (11,'admonMenu','Checklist','check-square','checklist',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (12,'admonMenu','Pagos a Proveedores','dollar','PagoAProveedor',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (13,'admonMenu','Requisici??n de insumos','cubes','reqInsumos',2,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (14,'rhMenu','Asistencia','check','asistencia',3,1);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (15,'rhMenu','CAPs','briefcase','caps',1,1);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (16,'rhMenu','Acciones Correctivas','exclamation-triangle','accionesCorrectivas',2,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (17,'rhMenu','Bajas de Personal','user-times','bajas',1,1);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (18,'rhMenu','Requisici??n de Personal','user-plus','solicitaPersonal',2,1);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (19,'rhMenu','Trabajadores','users','stasAltasBajas',1,1);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (20,'ventasMenu','BI','pie-chart','graficas',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (21,'ventasMenu','Ventas','usd','flujoIngresos',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (22,'ventasMenu','Utilidad de Ventas','pie-chart','utilidadVentas',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (23,'ventasMenu','Meta de sucursales','pie-chart','metaVentas',2,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (24,'ventasMenu','Control de Piso','street-view','controlPiso',3,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (25,'controlMenu','Entradas-Salidas Alamacenes','random','entradasSalidas',1,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (26,'controlMenu','Recepcion-Compras','arrows','comprasEntradas',1,1);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (27,'controlMenu','Fotos Productos','photo','fotoRines',3,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (28,'rhMenu','Quizz','star','quizz',3,0);
insert  into `pappmenus`(`id`,`vista`,`option`,`icon`,`handle`,`grupo`,`status`) values (29,'rhMenu','Nomina','users','nomina',1,0);

/*Table structure for table `pasistencia` */

CREATE TABLE `pasistencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nip` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `asistencia` varchar(200) DEFAULT NULL,
  `observacion` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pasistencia` */

/*Table structure for table `pcalendario` */

CREATE TABLE `pcalendario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL,
  `entrada` varchar(50) DEFAULT NULL,
  `salida` varchar(50) DEFAULT NULL,
  `etiqueta` varchar(1000) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `pcalendario` */

insert  into `pcalendario`(`id`,`fecha`,`tipo`,`entrada`,`salida`,`etiqueta`,`descripcion`,`status`) values (1,'2022-06-25',1,'','','Evento de integraci????n','Salida a Ca????a Hueca para un evento deportivo de la empresa',99);
insert  into `pcalendario`(`id`,`fecha`,`tipo`,`entrada`,`salida`,`etiqueta`,`descripcion`,`status`) values (2,'2022-06-26',2,'08:00','14:00','Dia del padre','Dia del padre',99);
insert  into `pcalendario`(`id`,`fecha`,`tipo`,`entrada`,`salida`,`etiqueta`,`descripcion`,`status`) values (3,'2022-06-25',2,'08:00','16:00','Es una prueba','Prueba de testing production',1);
insert  into `pcalendario`(`id`,`fecha`,`tipo`,`entrada`,`salida`,`etiqueta`,`descripcion`,`status`) values (4,'2022-06-27',1,'','','Prueba 2','Testing producton 2',1);
insert  into `pcalendario`(`id`,`fecha`,`tipo`,`entrada`,`salida`,`etiqueta`,`descripcion`,`status`) values (5,'2022-06-28',3,'','','Prueba 3','Testing event 3',1);
insert  into `pcalendario`(`id`,`fecha`,`tipo`,`entrada`,`salida`,`etiqueta`,`descripcion`,`status`) values (6,'2022-11-14',2,'08:00','18:00','D????a festivo','',1);

/*Table structure for table `pcavim` */

CREATE TABLE `pcavim` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idsucursal` int(11) DEFAULT NULL,
  `idautos_modelo` int(11) DEFAULT NULL,
  `color` varchar(500) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `fechai` date DEFAULT NULL,
  `horai` time DEFAULT NULL,
  `fechaf` date DEFAULT NULL,
  `horaf` time DEFAULT NULL,
  `prediction_id` int(11) DEFAULT NULL,
  `prediction_folio` varchar(100) DEFAULT NULL,
  `prediction_idvendedor` int(11) DEFAULT NULL,
  `prediction_vendedor` varchar(500) DEFAULT NULL,
  `prediction_total` decimal(9,2) DEFAULT NULL,
  `prediction_fecha` date DEFAULT NULL,
  `prediction_hora` time DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pcavim` */

/*Table structure for table `pchecklist_unidades` */

CREATE TABLE `pchecklist_unidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(100) DEFAULT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `idunidad` int(11) DEFAULT NULL,
  `placa` varchar(50) DEFAULT NULL,
  `v_llantacondicion` int(11) DEFAULT '0',
  `v_llantarefaccion` int(11) DEFAULT '0',
  `v_equiporefaccion` int(11) DEFAULT '0',
  `v_nivelaceite` int(11) DEFAULT '0',
  `v_nivelfrenos` int(11) DEFAULT '0',
  `v_range` int(11) DEFAULT '0',
  `v_nivelanticongelante` int(11) DEFAULT '0',
  `v_lucesintermitentes` int(11) DEFAULT '0',
  `v_lucesdelanteras` int(11) DEFAULT '0',
  `v_lucestraceras` int(11) DEFAULT '0',
  `v_lucesstop` int(11) DEFAULT '0',
  `v_direccionales` int(11) DEFAULT '0',
  `v_limpiaparabrisas` int(11) DEFAULT '0',
  `v_espejoslaterales` int(11) DEFAULT '0',
  `v_extintor` int(11) DEFAULT '0',
  `v_optimocarga` int(11) DEFAULT '0',
  `v_senaletica` int(11) DEFAULT '0',
  `v_calibracion` int(11) DEFAULT '0',
  `v_calibracionrefac` int(11) DEFAULT '0',
  `m_llantacondicion` int(11) DEFAULT '0',
  `m_nivelaceite` int(11) DEFAULT '0',
  `m_nivelfrenos` int(11) DEFAULT '0',
  `m_range` int(11) DEFAULT '0',
  `m_nivelanticongelante` int(11) DEFAULT '0',
  `m_lucesintermitentes` int(11) DEFAULT '0',
  `m_lucesdelanteras` int(11) DEFAULT '0',
  `m_lucestraceras` int(11) DEFAULT '0',
  `m_lucesstop` int(11) DEFAULT '0',
  `m_direccionales` int(11) DEFAULT '0',
  `m_espejoslaterales` int(11) DEFAULT '0',
  `m_extintor` int(11) DEFAULT '0',
  `m_optimocarga` int(11) DEFAULT '0',
  `m_senaletica` int(11) DEFAULT '0',
  `m_calibracion` int(11) DEFAULT '0',
  `c_tarjetacirculacion` int(11) DEFAULT '0',
  `c_licencia` int(11) DEFAULT '0',
  `c_condiciones` int(11) DEFAULT '0',
  `c_llaves` int(11) DEFAULT '0',
  `c_casco` int(11) DEFAULT '0',
  `c_polizaseguro` int(11) DEFAULT '0',
  `s_kilometraje` int(11) DEFAULT NULL,
  `s_fechaservicio` date DEFAULT NULL,
  `s_kmservicio` int(11) DEFAULT NULL,
  `observaciones` text,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pchecklist_unidades` */

/*Table structure for table `pcontrato` */

CREATE TABLE `pcontrato` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nip` int(11) DEFAULT NULL,
  `iddireccion` int(11) DEFAULT NULL,
  `iddepartamento` int(11) DEFAULT NULL,
  `idpuesto` int(11) DEFAULT '1',
  `idtipocontrato` char(5) DEFAULT NULL,
  `idtipojornada` char(5) DEFAULT NULL,
  `fechainiciolab` date DEFAULT NULL,
  `sindicalizado` char(2) DEFAULT NULL,
  `idtiporegimen` char(5) DEFAULT NULL,
  `idriesgopuesto` char(5) DEFAULT NULL,
  `idperiodicidadpago` char(5) DEFAULT NULL,
  `salariobase` decimal(9,2) DEFAULT NULL,
  `salariodiario` decimal(9,2) DEFAULT NULL,
  `idbanco` char(5) DEFAULT NULL,
  `cuentabancaria` varchar(50) DEFAULT NULL,
  `subrfc` varchar(100) DEFAULT NULL,
  `subporcentaje` decimal(9,2) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `idtiempocontrato` int(11) DEFAULT NULL,
  `fechaBaja` date DEFAULT NULL,
  `sueldobruto` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

/*Data for the table `pcontrato` */

insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (1,1,51,4,9,'01','01','2022-02-01','No','02','1','01',266.00,266.00,'','','',0.00,'2022-06-18 09:58:14',1,'2022-02-01',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (2,2,52,1,1,'01','01','2015-02-21','No','02','1','04',300.00,300.00,'','2899006001','',0.00,'2022-06-18 12:16:38',1,'2015-02-21',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (3,3,53,7,25,'03','01','2020-01-13','No','02','1','04',213.33,213.33,'','1593846914','',0.00,'2022-06-19 15:31:35',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (4,4,54,7,26,'03','01','2021-04-01','No','02','1','04',213.33,213.33,'','1544844218','',0.00,'2022-06-19 15:37:08',1,'2021-01-04',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (5,5,55,7,26,'03','01','2021-04-01','No','02','1','04',213.33,213.33,'','1544844218','',0.00,'2022-06-19 15:44:30',1,'2021-01-04',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (6,6,56,7,26,'01','01','2013-04-26','No','02','1','04',213.33,213.33,'','2852756498','',0.00,'2022-06-19 15:52:22',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (7,7,57,6,19,'03','01','2011-09-09','No','02','1','04',230.00,230.00,'','2971725815','',0.00,'2022-06-19 15:56:58',1,'2011-09-09',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (8,8,58,9,37,'03','01','2013-09-03','No','02','1','04',221.22,221.22,'','1150036501','',0.00,'2022-06-19 16:16:20',1,'2013-03-09',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (9,9,59,9,38,'01','02','2012-05-24','No','02','1','04',199.23,199.23,'','2970349054','',0.00,'2022-06-19 16:21:51',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (10,10,60,6,22,'03','01','2015-10-01','No','02','1','04',202.58,202.58,'','1161088491','',0.00,'2022-06-19 16:26:12',1,'2015-01-10',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (11,11,61,6,22,'03','01','2016-01-16','No','02','1','01',202.58,202.58,'','1160445282','',0.00,'2022-06-19 16:31:26',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (12,12,62,7,26,'03','01','2019-02-28','No','02','1','04',213.33,213.33,'','1539160739','',0.00,'2022-06-19 16:35:19',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (13,13,63,6,22,'01','01','2019-12-10','No','02','1','04',193.33,193.33,'','1594052563','',0.00,'2022-06-19 16:42:00',1,'2019-10-12',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (14,14,64,3,3,'01','01','2020-02-01','No','02','1','04',266.66,266.66,'','1594168758','',0.00,'2022-06-19 16:46:27',1,'2020-02-01',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (15,15,65,9,38,'01','02','2020-09-23','No','02','1','04',199.23,199.23,'012','1523721378','',0.00,'2022-06-19 16:56:04',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (16,16,66,5,11,'01','01','2020-10-02','No','02','1','04',173.33,173.33,'','1528404590','',0.00,'2022-06-19 17:00:42',1,'2020-02-10',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (17,17,67,8,32,'01','01','2021-06-03','No','02','1','04',173.33,173.33,'','1552729102','',0.00,'2022-06-19 17:05:46',1,'2021-03-06',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (18,18,68,6,22,'01','01','2021-08-15','No','02','1','04',173.33,173.33,'','1523355473','',0.00,'2022-06-19 17:14:45',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (19,19,69,5,12,'01','01','2021-08-13','No','02','1','04',173.33,173.33,'','1580163399','',0.00,'2022-06-19 17:19:55',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (20,20,70,6,21,'01','01','2021-12-15','No','02','1','04',173.33,173.33,'','1552991486','',0.00,'2022-06-19 17:24:08',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (21,21,71,8,32,'01','01','2021-08-23','No','02','1','04',173.33,173.33,'','1580185164','',0.00,'2022-06-19 17:27:24',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (22,22,72,7,27,'01','01','2022-01-02','No','02','1','04',173.33,173.33,'','','',0.00,'2022-06-19 17:30:44',1,'2022-01-02',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (23,23,73,7,26,'01','01','2022-02-24','No','02','1','01',186.66,186.66,'','','',0.00,'2022-06-19 17:35:07',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (24,24,74,7,26,'01','01','2022-02-24','No','02','1','01',186.66,186.66,'','','',0.00,'2022-06-19 17:38:00',1,'0000-00-00',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (25,25,75,7,26,'01','01','2022-03-01','No','02','1','04',186.66,186.66,'','','',0.00,'2022-06-19 17:43:02',1,'2022-01-03',1,NULL,NULL);
insert  into `pcontrato`(`id`,`nip`,`iddireccion`,`iddepartamento`,`idpuesto`,`idtipocontrato`,`idtipojornada`,`fechainiciolab`,`sindicalizado`,`idtiporegimen`,`idriesgopuesto`,`idperiodicidadpago`,`salariobase`,`salariodiario`,`idbanco`,`cuentabancaria`,`subrfc`,`subporcentaje`,`timestamp`,`status`,`fecha_ingreso`,`idtiempocontrato`,`fechaBaja`,`sueldobruto`) values (26,26,76,8,31,'01','01','2022-05-16','No','02','1','01',173.33,173.33,'012','','',0.00,'2022-06-19 17:46:19',1,'0000-00-00',1,NULL,NULL);

/*Table structure for table `pcontrol_piso` */

CREATE TABLE `pcontrol_piso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendedor` varchar(85) NOT NULL,
  `cliente` text,
  `vehiculo` text,
  `correo` varchar(45) DEFAULT NULL,
  `producto` text,
  `estado_venta` varchar(10) NOT NULL,
  `razon_fallida` varchar(45) DEFAULT NULL,
  `registrado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pcontrol_piso` */

/*Table structure for table `pdeducciones` */

CREATE TABLE `pdeducciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipodeduccion` char(5) DEFAULT NULL,
  `importe` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idcontrato` int(11) DEFAULT NULL,
  `fechaCargo` date DEFAULT NULL,
  `fecuencia` int(11) DEFAULT '-1',
  `vencimiento` date DEFAULT NULL,
  `idaccion_correctiva` int(11) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `pdeducciones` */

insert  into `pdeducciones`(`id`,`idtipodeduccion`,`importe`,`status`,`idcontrato`,`fechaCargo`,`fecuencia`,`vencimiento`,`idaccion_correctiva`,`descripcion`) values (1,'00005',0.00,0,0,'2022-06-21',-1,'2022-06-21',NULL,NULL);
insert  into `pdeducciones`(`id`,`idtipodeduccion`,`importe`,`status`,`idcontrato`,`fechaCargo`,`fecuencia`,`vencimiento`,`idaccion_correctiva`,`descripcion`) values (2,'00005',50.00,0,7,'2022-06-30',-1,'2022-06-30',NULL,NULL);
insert  into `pdeducciones`(`id`,`idtipodeduccion`,`importe`,`status`,`idcontrato`,`fechaCargo`,`fecuencia`,`vencimiento`,`idaccion_correctiva`,`descripcion`) values (3,'0001',10.00,1,0,'2022-06-22',-1,'2022-06-22',NULL,NULL);

/*Table structure for table `pdireccion` */

CREATE TABLE `pdireccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nip` int(11) DEFAULT NULL,
  `calle` varchar(500) DEFAULT NULL,
  `numext` varchar(50) DEFAULT NULL,
  `numint` varchar(50) DEFAULT NULL,
  `colonia` varchar(200) DEFAULT NULL,
  `municipio` varchar(100) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `idestado` char(5) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;

/*Data for the table `pdireccion` */

insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (1,0,'RANCHO GRANDE','364','','BENITO JUAREZ (LA AURORA)','NEZAHUALCOYOTL','57000','MEX',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (51,1,'CALLE HIDALGO MANZANA 40 LOTE 14','S/N','','LAS GRANJAS','TUXTLA GUTIERREZ','29019','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (52,2,'AV. 4TA SUR PTE ','310','','PLUMA DE ORO','TUXTLA GUTIERREZ','29057','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (53,3,'PRIVADA EL MULATO','102','','LOMA BONITA','TUXTLA GUTIERREZ','29030','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (54,4,'AVENIDA 4TA NORTE ORIENTE','340','','SAN JACINTO','SUCHIAPA','29150','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (55,5,'AVENIDA 4TA NORTE ORIENTE','340','','SAN JACINTO','SUCHIAPA','29150','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (56,6,'BARRIO AMPLIACI?????N SAN JOS?????','S/N','','S/C','BERRIOZABAL','29130','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (57,7,'PRIVADA EL MULATO','102','','LOMA BONITA','TUXTLA GUTIERREZ','29030','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (58,8,'16 NORTE PONIENTE','310','','PENIPAK NORTE','TUXTLA GUTIERREZ','29030','AGU',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (59,9,'DURANGO MZ. 5','LT. 7','','LAS GRANJAS','TUXTLA GUTIERREZ','29019','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (60,10,'CIRCUITO NORTE LAS FLORES','231','','FRACC. EL CAMPANARIO','TUXTLA GUTIERREZ','29054','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (61,11,'AVENIDA MONTE LOS OLIVOS','300','','NUEVA JERUSALEN','TUXTLA GUTIERREZ','29130','CHH',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (62,12,'MONTE LOS OLIVOS','300','','NUEVA JERUSALEN','TUXTLA GUTIERREZ','29030','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (63,13,'CALLEJON EL MOZMOTE','120','','PLAN DE AYALA AMPLIACION SUR','TUXTLA GUTIERREZ','29020','AGU',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (64,14,'AVENIDA CANDELARIA','LT.1','','RIVERA GUADALUPE','TUXTLA GUTIERREZ','29057','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (65,15,'NUEVO LEON','63A','','PLAN DE AYALA','TUXTLA GUTIERREZ','29110','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (66,16,'CALLEJON RAUL ISIDRO BURGOS','328','','PLAN DE AYALA','TUXTLA GUTIERREZ','29020','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (67,17,'14 SUR PONIENTE','S/N','','S/C','BERRIOZABAL','29130','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (68,18,'CIRCUITO NORTE LAS FLORES','231','','FRACC. EL CAMPANARIO','TUXTLA GUTIERREZ','29054','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (69,19,'CALLEJON EL MOZMOTE','120','','PLAN DE AYALA AMPLIACION SUR','TUXTLA GUTIERREZ','29020','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (70,20,'AVENIDA 4TA SUR PONIENTE','310','','PLUMA DE ORO','TUXTLA GUTIERREZ','29057','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (71,21,'VILLA SANTA MARIA','S/N','','LOS SABINOS','TUXTLA GUTIERREZ','29020','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (72,22,'2DA ORIENTE NORTE','S/N','','SAN JOSE TERAN','TUXTLA GUTIERREZ','29057','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (73,23,'BARRIO ROCHESTER','101','','S/C','BERRIOZABAL','29130','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (74,24,'12 ORIENTE SUR','120','','AMPLIACION TERAN','TUXTLA GUTIERREZ','29050','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (75,25,'AVENIDA 4TA SUR PONIENTE','310','','PLUMA DE ORO','TUXTLA GUTIERREZ','29057','CHP',1);
insert  into `pdireccion`(`id`,`nip`,`calle`,`numext`,`numint`,`colonia`,`municipio`,`cp`,`idestado`,`status`) values (76,26,'NUEVO LEON','26','','PLAN DE AYALA','TUXTLA GUTIERREZ','29020','CHP',1);

/*Table structure for table `pdocumentos` */

CREATE TABLE `pdocumentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(500) DEFAULT NULL,
  `idtipo` int(11) DEFAULT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pdocumentos` */

/*Table structure for table `pedidos` */

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `almacen_origen` text NOT NULL,
  `almacen_destino` text NOT NULL,
  `estado` text,
  `fecha_estado` date DEFAULT NULL,
  `hora_estado` time DEFAULT NULL,
  `usuario_estado` double DEFAULT NULL,
  `usuarioid` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pedidos` */

/*Table structure for table `pempleado` */

CREATE TABLE `pempleado` (
  `nip` int(11) NOT NULL AUTO_INCREMENT,
  `asistencia` int(11) DEFAULT NULL,
  `rfc` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `nombre` varchar(500) CHARACTER SET latin1 DEFAULT NULL,
  `curp` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `nss` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `fechanac` date DEFAULT NULL,
  `edocivil` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `sexo` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `telefono` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `celular` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `extension` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `idpatron` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `foto` varchar(500) CHARACTER SET latin1 DEFAULT NULL,
  `fecha_baja` date DEFAULT NULL,
  `tiposangre` varchar(45) COLLATE latin1_bin DEFAULT NULL,
  `nivelestudios` text COLLATE latin1_bin,
  `numhijos` varchar(50) COLLATE latin1_bin DEFAULT '0-0',
  `religion` text COLLATE latin1_bin,
  `alergias` text COLLATE latin1_bin,
  `asegurado` varchar(1) COLLATE latin1_bin DEFAULT 'n',
  PRIMARY KEY (`nip`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

/*Data for the table `pempleado` */

insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (1,NULL,'EAAS8602163U1','SERGIO DE JESUS ESTRADA AVELAR','EAAS860216HCSSVR06','71118610410','1986-02-16','CASADA(O)','HOMBRE','serygra@gmail.com','9612295343','',NULL,1,99,1,NULL,NULL,'O POSITIVO','LICENCIATURA','0-2','CATOLICO','NINGUNO','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (2,NULL,'SARR900114E67','RAQUEL DE LOS SANTOS ROQUE','SARR900114MCSN09','03159042799','1990-01-14','SOLTERA(O)','MUJER','queli_richi@hotmail.com','','9611074090',NULL,1,1,1,NULL,NULL,'O POSITIVO','LICENCIATURA','undefined-undefined','CATOLICA','RANITIDINA','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (3,NULL,'MOAA850801EP2','JOSE ANTONIO MORALES ANTUNES','MOAA850801HCSRNN00','71088500062','1985-08-01','CASADA(O)','HOMBRE','feco.33jama@gmail.com','','9611304675',NULL,1,1,1,NULL,NULL,'','PRIMARIA','undefined-undefined','NINGUNA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (4,NULL,'TEGR680417P17','RUSBEL TECO GUMETA','TEGR680417HCSCMS02','71016803943','1968-04-17','CASADA(O)','HOMBRE','','','9611133170',NULL,1,1,1,NULL,NULL,'','SECUNDARIA','undefined-undefined','CAT?????LICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (5,NULL,'TEGI6512284Z2','INOCENTE TECO GUMETA','TEGI651228HCSCMN00','71926734246','1965-12-28','CASADA(O)','HOMBRE','inocenteteco1965@gmail.com','','9611991438',NULL,1,1,1,NULL,NULL,'','SECUNDARIA','undefined-undefined','CAT?????LICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (6,NULL,'AACA860113JN9','JOSE ALFREDO ALVAREZ DE LA CRUZ','AACA860113HCSLRL06','19148685464','1986-01-13','SOLTERA(O)','HOMBRE','josealfredoalvaresdelacruz312@gmail.com','','9618751206',NULL,1,1,1,NULL,NULL,'','PRIMARIA','undefined-undefined','CAT?????LICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (7,NULL,'MALA8503054F6','ADRIANA MANUEL LAZARO','MALA850305MCSNZD01','71138505277','1985-03-05','CASADA(O)','MUJER','piscis.amor.32@gmail.com','','9613053851',NULL,1,1,1,NULL,NULL,'','PRIMARIA','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (8,NULL,'PEHM681119RW8','MARIO NOEL PE?????A HENRIQUEZ','PEHM681119HNEXNR03','02166833109','1968-11-19','CASADA(O)','HOMBRE','','','9612733347',NULL,1,1,1,NULL,NULL,'','NINGUNO','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (9,NULL,'GORA550621PM4','JOSE ANTONIO GOMES RAMIREZ','GORA550621HCSMMN08','71135500396','1955-06-21','SOLTERA(O)','HOMBRE','','','9614479685',NULL,1,1,1,NULL,NULL,'','NINGUNO','undefined-undefined','CATOLICO','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (10,NULL,'HEVV720508BLA','VIULAILA HERNANDES VICENTE','HEVV720508MCSRCL08','02167231535','1972-05-08','DIVORCIADA(O)','MUJER','vidahernandezmorales@gmail.com','','9612206399',NULL,1,1,1,NULL,NULL,'','NINGUNO','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (11,NULL,'VESR840125LC9','ROXANA VELAZQUEZ SOLIS','VESR840125MCSLLX07','03158470603','1984-01-25','SOLTERA(O)','MUJER','velazquezroxana627@gmail.com','','9612675145',NULL,1,1,1,NULL,NULL,'','PRIMARIA','undefined-undefined','ADVENTISTA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (12,NULL,'VECE970919T85','ELIOBETH VELAZQUEZ CABALLERO','VECE970919HCSLBL01','26179788489','1997-09-19','CASADA(O)','HOMBRE','obedv0685@hotmail.com','','9612970041',NULL,1,1,1,NULL,NULL,'','PREPARATORIA','undefined-undefined','NAZARENO','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (13,NULL,'ROSE761224BJ3','MARIA ENEIDA RODRIGUEZ SANCHEZ','ROSE761224MCSDNN01','71117602848','1976-12-24','SOLTERA(O)','MUJER','rodriguezsachmary208@gmail.com','','9614714679',NULL,1,1,1,NULL,NULL,'','PREPARATORIA','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (14,NULL,'CAPB901202281','BERNABE CHATU POZO','CAPB901202HCSHZR08','71119032150','1990-02-12','SOLTERA(O)','HOMBRE','bernachatu067@gmail.com','','9612458787',NULL,1,1,1,NULL,NULL,'','LICENCIATURA','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (15,NULL,'LOLA7206144I1','ARTURO LOPEZ LOPEZ','LOLA720614HCSPPR03','71057203201','1972-06-14','CASADA(O)','HOMBRE','arturolopez14061972@hotmail.com','','9614588323',NULL,1,1,1,NULL,NULL,'','SECUNDARIA','undefined-undefined','MORMON','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (16,NULL,'AEGL9808308C6','LUCIA DAMARES ALEMAN GONZALEZ','AEGL980830MCSLNC06','14169870459','1998-08-30','SOLTERA(O)','MUJER','lucia98damares@gmail.com','','9613420983',NULL,1,1,1,NULL,NULL,'','PREPARATORIA','undefined-undefined','CRISTIANA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (17,NULL,'CUDV730203440','VERONICA CRUS DIAS','CUDV730203MCSRSR09','71077305135','1973-02-03','DIVORCIADA(O)','MUJER','veronicacrusdiaz73@gmail.com','','9612992466',NULL,1,1,1,NULL,NULL,'','PRIMARIA','undefined-undefined','NINGUNA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (18,NULL,'HEPN821208E89','NARBEY HERNANDEZ PEREZ','HEPN821208MCSRRR01','2198220747','1982-12-08','SOLTERA(O)','MUJER','hernandezperezbeyi1982@gmail.com','','9613179202',NULL,1,1,1,NULL,NULL,'','NINGUNO','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (19,NULL,'SACJ021127390','JESSICA SANTOS CRUZ','SACJ021127MCSNRSA1','25190279379','2002-11-27','SOLTERA(O)','MUJER','js2215686@gmail.com','','9613219659',NULL,1,1,1,NULL,NULL,'','PREPARATORIA','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (20,NULL,'SARL981223F40','LUCIA BELEN DE LOS SANTOS ROQUE','SARL981223MCSNQC01','12139866417','1998-12-23','CASADA(O)','MUJER','belleeteuk@gmail.com','','9612018807',NULL,1,1,1,NULL,NULL,'','PREPARATORIA','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (21,NULL,'LORP7311207F7','PATRICIA LOPEZ RUIZ','LORP731120MCSPZT01','71077305648','1974-11-20','SOLTERA(O)','MUJER','patito.ruiz1973@gmail.com','','9613296094',NULL,1,1,1,NULL,NULL,'','SECUNDARIA','undefined-undefined','NINGUNA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (22,NULL,'HERA670816E83','ASUNCION HERNANDEZ RIOS','HERA670816MCSRSS04','71966730484','1967-08-16','SOLTERA(O)','MUJER','asuncionrioshdz@hotmail.com','','9613604315',NULL,1,1,1,NULL,NULL,'','PRIMARIA','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (23,NULL,'HEPA010714MZ6','ALEXANDER HERNANDEZ PEREZ','HEPA010714HCSRRLA5','04190155590','2001-07-14','SOLTERA(O)','HOMBRE','ah3086405@gmail.com','','9615643193',NULL,1,1,1,NULL,NULL,'','SECUNDARIA','undefined-undefined','NINGUNA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (24,NULL,'VAMS970831','SALVADOR ANTONIO VAZQUEZ MARTINEZ','VAMS970831HCSZRL04','03229702901','1997-08-31','SOLTERA(O)','HOMBRE','filosofia1997antonio@gmail.com','','9611905248',NULL,1,1,1,NULL,NULL,'','PREPARATORIA','undefined-undefined','NINGUNA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (25,NULL,'SARA940112IU2','ALEXANDER DE LOS SANTOS ROQUE','SARA940112HCSNQL03','71129415387','1994-01-12','SOLTERA(O)','HOMBRE','alexanderdelossantosroque@hotmail.com','','9611118710',NULL,1,1,1,NULL,NULL,'','SECUNDARIA','undefined-undefined','CATOLICA','','n');
insert  into `pempleado`(`nip`,`asistencia`,`rfc`,`nombre`,`curp`,`nss`,`fechanac`,`edocivil`,`sexo`,`email`,`telefono`,`celular`,`extension`,`idpatron`,`status`,`idsucursal`,`foto`,`fecha_baja`,`tiposangre`,`nivelestudios`,`numhijos`,`religion`,`alergias`,`asegurado`) values (26,NULL,'VEAF010603','FERNANDO RAFAEL VELASCO ALVAREZ','VEAF010603HCSLLRA8','73160116973','2001-03-06','SOLTERA(O)','HOMBRE','rvelascoalvarez0306@gmail.com','','9611069912',NULL,1,1,1,NULL,NULL,'','PREPARATORIA','undefined-undefined','CATOLICA','','n');

/*Table structure for table `pentrevista` */

CREATE TABLE `pentrevista` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(500) DEFAULT NULL,
  `entrevistador` varchar(500) DEFAULT NULL,
  `puesto` varchar(200) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `calificacion` int(11) DEFAULT NULL,
  `porquecontratar` text,
  `comentarios` text,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pentrevista` */

/*Table structure for table `pevaluacion_socioeconomico` */

CREATE TABLE `pevaluacion_socioeconomico` (
  `idpregunta` int(11) NOT NULL,
  `idsocioeconomico` int(11) NOT NULL,
  `respuesta` text,
  UNIQUE KEY `idpregunta` (`idpregunta`,`idsocioeconomico`),
  KEY `fk_pregunta_socioeconomico_pevaluacion_idx` (`idpregunta`),
  KEY `fk_psocioeconomico_pevaluacion_idx` (`idsocioeconomico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pevaluacion_socioeconomico` */

/*Table structure for table `pexamen` */

CREATE TABLE `pexamen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cexamen_id` int(11) DEFAULT NULL,
  `pusuario_username` varchar(100) DEFAULT NULL,
  `csucursal_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pexamen` */

/*Table structure for table `pfelicitaciones` */

CREATE TABLE `pfelicitaciones` (
  `nip` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  PRIMARY KEY (`nip`,`anio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pfelicitaciones` */

/*Table structure for table `phorasextra` */

CREATE TABLE `phorasextra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipohoras` char(5) DEFAULT NULL,
  `dias` int(11) DEFAULT NULL,
  `horasextra` int(11) DEFAULT NULL,
  `importepagado` decimal(9,2) DEFAULT NULL,
  `gravado` decimal(9,2) DEFAULT NULL,
  `exento` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idcontrato` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `phorasextra` */

/*Table structure for table `pimagenrespuesta` */

CREATE TABLE `pimagenrespuesta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prespuesta_id` varchar(100) DEFAULT NULL,
  `imagen` varchar(500) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `csucursal_id` int(11) DEFAULT NULL,
  `idchecklist` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pimagenrespuesta` */

/*Table structure for table `pincapacidades` */

CREATE TABLE `pincapacidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipoincapacidad` char(5) DEFAULT NULL,
  `dias` int(11) DEFAULT NULL,
  `importe` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idcontrato` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pincapacidades` */

/*Table structure for table `pjubilaciones` */

CREATE TABLE `pjubilaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipopercepcion` char(5) DEFAULT NULL,
  `unaexhibicion` decimal(9,2) DEFAULT NULL,
  `parcialidades` decimal(9,2) DEFAULT NULL,
  `diario` decimal(9,2) DEFAULT NULL,
  `acumulable` decimal(9,2) DEFAULT NULL,
  `noacumulable` decimal(9,2) DEFAULT NULL,
  `gravado` decimal(9,2) DEFAULT NULL,
  `exento` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idcontrato` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pjubilaciones` */

/*Table structure for table `pmasivexml` */

CREATE TABLE `pmasivexml` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `digest` text NOT NULL,
  `idsolicitud` varchar(800) DEFAULT NULL,
  `idpaquete` varchar(800) DEFAULT '0',
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pmasivexml` */

/*Table structure for table `politica_precios` */

CREATE TABLE `politica_precios` (
  `medida` varchar(200) NOT NULL,
  `p1` decimal(9,2) DEFAULT NULL,
  `p2` decimal(9,2) DEFAULT NULL,
  `p3` decimal(9,2) DEFAULT NULL,
  `p4` decimal(9,2) DEFAULT NULL,
  `p5` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`medida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `politica_precios` */

/*Table structure for table `porganigrama` */

CREATE TABLE `porganigrama` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idhijo` int(11) NOT NULL,
  `iddepa_hijo` int(11) NOT NULL,
  `idsucursal` int(11) DEFAULT NULL,
  `idpadre` int(11) DEFAULT NULL,
  `iddepa_padre` int(11) DEFAULT NULL,
  `abstraccion` text,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uqe_relacion_padrehijo` (`idhijo`,`iddepa_hijo`,`idsucursal`,`idpadre`,`iddepa_padre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `porganigrama` */

insert  into `porganigrama`(`id`,`idhijo`,`iddepa_hijo`,`idsucursal`,`idpadre`,`iddepa_padre`,`abstraccion`,`status`) values (1,5,1,NULL,2,1,'Jef',1);

/*Table structure for table `potrospagos` */

CREATE TABLE `potrospagos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipootropago` char(5) DEFAULT NULL,
  `importe` decimal(9,2) DEFAULT NULL,
  `subsidiocausado` decimal(9,2) DEFAULT NULL,
  `saldofavor` decimal(9,2) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `remanente` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idcontrato` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `potrospagos` */

/*Table structure for table `pparking` */

CREATE TABLE `pparking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idsucursal` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pparking` */

/*Table structure for table `ppatron` */

CREATE TABLE `ppatron` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_razsoc` varchar(500) DEFAULT NULL,
  `rfc` varchar(200) DEFAULT NULL,
  `curp` varchar(100) DEFAULT NULL,
  `registropatronal` varchar(100) DEFAULT NULL,
  `idregimenfiscal` char(5) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `iddireccion` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `background` varchar(50) DEFAULT NULL,
  `abreviatura` varchar(5) DEFAULT NULL,
  `template` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `ppatron` */

insert  into `ppatron`(`id`,`nombre_razsoc`,`rfc`,`curp`,`registropatronal`,`idregimenfiscal`,`telefono`,`email`,`iddireccion`,`status`,`titulo`,`background`,`abreviatura`,`template`) values (1,'MARCO ANTONIO ALVAREZ BARRIENTOS','AABM870128PY9','AABM870128HDFLRR00','1111111','612','','',1,1,'CM RESORTS','001482','CM','dark');

/*Table structure for table `ppercepciones` */

CREATE TABLE `ppercepciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipopercepcion` char(5) DEFAULT NULL,
  `gravado` decimal(9,2) DEFAULT NULL,
  `excento` decimal(9,2) DEFAULT NULL,
  `valormercado` decimal(9,2) DEFAULT NULL,
  `preciootorgarse` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idcontrato` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

/*Data for the table `ppercepciones` */

insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (1,'001',3990.00,0.00,0.00,0.00,1,1);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (2,'001',4500.00,0.00,0.00,0.00,1,2);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (3,'001',3199.95,0.00,0.00,0.00,1,3);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (4,'001',3199.95,0.00,0.00,0.00,1,4);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (5,'001',3199.95,0.00,0.00,0.00,1,5);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (6,'001',3199.95,0.00,0.00,0.00,1,6);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (7,'001',3450.00,0.00,0.00,0.00,1,7);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (8,'001',3318.30,0.00,0.00,0.00,1,8);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (9,'001',2988.45,0.00,0.00,0.00,1,9);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (10,'001',3038.70,0.00,0.00,0.00,1,10);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (11,'001',3038.70,0.00,0.00,0.00,1,11);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (12,'001',3199.95,0.00,0.00,0.00,1,12);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (13,'001',2899.95,0.00,0.00,0.00,1,13);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (14,'001',3999.90,0.00,0.00,0.00,1,14);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (15,'001',2988.45,0.00,0.00,0.00,1,15);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (16,'001',2599.95,0.00,0.00,0.00,1,16);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (17,'001',2599.95,0.00,0.00,0.00,1,17);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (18,'001',2599.95,0.00,0.00,0.00,1,18);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (19,'001',2599.95,0.00,0.00,0.00,1,19);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (20,'001',2599.95,0.00,0.00,0.00,1,20);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (21,'001',2599.95,0.00,0.00,0.00,1,21);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (22,'001',2599.95,0.00,0.00,0.00,1,22);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (23,'001',2799.90,0.00,0.00,0.00,1,23);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (24,'001',2799.90,0.00,0.00,0.00,1,24);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (25,'001',2799.90,0.00,0.00,0.00,1,25);
insert  into `ppercepciones`(`id`,`idtipopercepcion`,`gravado`,`excento`,`valormercado`,`preciootorgarse`,`status`,`idcontrato`) values (26,'001',2599.95,0.00,0.00,0.00,1,26);

/*Table structure for table `ppermiso` */

CREATE TABLE `ppermiso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(8) DEFAULT NULL,
  `iddepto` int(8) DEFAULT NULL,
  `idpuesto` int(8) DEFAULT NULL,
  `idmodulo` int(8) DEFAULT NULL,
  `idsubmodulo` int(8) DEFAULT NULL,
  `idacciones` int(8) DEFAULT NULL,
  `status` int(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ppermiso` */

/*Table structure for table `ppermisos` */

CREATE TABLE `ppermisos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `idempleado` int(11) NOT NULL,
  `motivo` text CHARACTER SET latin1,
  `goce_sueldo` tinyint(4) DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  `puestoId` int(11) NOT NULL,
  `sucursalId` int(11) NOT NULL,
  `dias` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `ppermisos` */

/*Table structure for table `ppregentrevista` */

CREATE TABLE `ppregentrevista` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `texto` varchar(800) DEFAULT NULL,
  `seccion` varchar(500) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ppregentrevista` */

/*Table structure for table `ppregunta` */

CREATE TABLE `ppregunta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseccion_id` int(11) DEFAULT NULL,
  `cpregunta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ppregunta` */

/*Table structure for table `precursos` */

CREATE TABLE `precursos` (
  `path` varchar(250) NOT NULL,
  `permisos` varchar(3) DEFAULT 'rwe',
  `empleado_nip` int(11) NOT NULL,
  `asignacionDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`path`,`empleado_nip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `precursos` */

/*Table structure for table `prediction_ventas` */

CREATE TABLE `prediction_ventas` (
  `ID` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `NUMDOCTO` varchar(200) DEFAULT NULL,
  `SUBTOTAL` decimal(9,2) DEFAULT NULL,
  `IVA` decimal(9,2) DEFAULT NULL,
  `TOTAL` decimal(9,2) DEFAULT NULL,
  `STATUS` varchar(100) DEFAULT NULL,
  `HORA` varchar(100) DEFAULT NULL,
  `TIPO` varchar(100) DEFAULT NULL,
  `CANTIDAD` decimal(9,2) DEFAULT NULL,
  `CODIGO` varchar(100) DEFAULT NULL,
  `DESCRIPCION` varchar(500) DEFAULT NULL,
  `PRECIO` decimal(9,2) DEFAULT NULL,
  `COSTO` decimal(9,2) DEFAULT NULL,
  `IMPORTELINEA` decimal(9,2) DEFAULT NULL,
  `COSTOLINEA` decimal(9,2) DEFAULT NULL,
  `DETIVA` decimal(9,2) DEFAULT NULL,
  `UNIDADMEDIDA` varchar(100) DEFAULT NULL,
  `MARCA` varchar(200) DEFAULT NULL,
  `FAMILIA` varchar(200) DEFAULT NULL,
  `SUBFAMILIA` varchar(200) DEFAULT NULL,
  `ID_PROSPECTO` int(11) DEFAULT NULL,
  `PYM_NOMBRE` varchar(300) DEFAULT NULL,
  `MUNICIPIO` varchar(300) DEFAULT NULL,
  `ESTADO` varchar(300) DEFAULT NULL,
  `PAIS` varchar(300) DEFAULT NULL,
  `CODIGOPOSTAL` varchar(100) DEFAULT NULL,
  `NOMBREVENDEDOR` varchar(300) DEFAULT NULL,
  `ALMACEN` varchar(100) DEFAULT NULL,
  `ZONA` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prediction_ventas` */

/*Table structure for table `pregistros` */

CREATE TABLE `pregistros` (
  `idempleado` int(11) NOT NULL,
  `timecheck` datetime NOT NULL,
  `idreloj` int(11) NOT NULL,
  `aplicaIncidencia` int(11) DEFAULT '-1',
  UNIQUE KEY `checada` (`idempleado`,`timecheck`,`idreloj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pregistros` */

/*Table structure for table `preportes` */

CREATE TABLE `preportes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(500) DEFAULT NULL,
  `familias` varchar(800) DEFAULT NULL,
  `subfamilias` varchar(800) DEFAULT NULL,
  `almacenes` varchar(800) DEFAULT NULL,
  `utilidad` int(11) DEFAULT NULL,
  `costo` int(11) DEFAULT NULL,
  `pvps` varchar(800) DEFAULT NULL,
  `correos` text,
  `agrupado` int(11) DEFAULT '0',
  `almacen` int(11) DEFAULT '1',
  `stock` int(11) DEFAULT '1',
  `titulo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `preportes` */

/*Table structure for table `prequisicion_personal` */

CREATE TABLE `prequisicion_personal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `solicitante` int(11) NOT NULL,
  `fecha_solicitud` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_est_contratar` date NOT NULL,
  `puesto` varchar(60) NOT NULL,
  `num_vacantes` int(11) NOT NULL,
  `cualidades` text,
  `sucursal` int(11) DEFAULT NULL,
  `personal_recomendado_nip` int(11) DEFAULT NULL,
  `motivo_recomendacion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prequisicion_personal` */

/*Table structure for table `prespentrevista` */

CREATE TABLE `prespentrevista` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idpregunta` int(11) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  `identrevista` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prespentrevista` */

/*Table structure for table `prespuesta` */

CREATE TABLE `prespuesta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpregunta_id` int(11) DEFAULT NULL,
  `csucursal_id` int(11) DEFAULT NULL,
  `acierto` int(11) DEFAULT '0',
  `respuesta` text,
  `plan_accion` text,
  `prioridad` varchar(100) DEFAULT NULL,
  `cumplimiento` date DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `autorizado` int(11) DEFAULT '-1',
  `idchecklist` int(11) DEFAULT NULL,
  `usuario` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `prespuesta` */

/*Table structure for table `programacion_inventarios` */

CREATE TABLE `programacion_inventarios` (
  `sucursal_id` double NOT NULL,
  `tipo_inventario` int(11) DEFAULT NULL,
  `familia` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `subfamilia` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `programacion_inventarios` */

/*Table structure for table `programacion_vacaciones` */

CREATE TABLE `programacion_vacaciones` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `trabajador_id` int(11) NOT NULL,
  `estado` varchar(90) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `elaborado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `periodo_vacacional` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `usuario` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `observaciones` varchar(2000) COLLATE utf8_spanish_ci DEFAULT NULL,
  UNIQUE KEY `uq_vacaciones` (`fecha`,`trabajador_id`,`estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `programacion_vacaciones` */

insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (1,'2022-06-02',7,'cancelado@7@2022-06-20 20:04:13','2022-06-20 19:50:44','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (2,'2022-06-03',7,'cancelado@7@2022-06-20 20:04:14','2022-06-20 19:50:44','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (3,'2022-06-04',7,'cancelado@7@2022-06-20 20:04:14','2022-06-20 19:50:44','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (4,'2022-06-05',7,'cancelado@7@2022-06-20 20:04:14','2022-06-20 19:50:44','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (7,'2022-06-22',7,'cancelado@7@2022-06-20 20:58:39','2022-06-20 20:56:50','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (14,'2022-06-22',7,'cancelado@7@2022-06-20 21:12:36','2022-06-20 21:12:29','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (8,'2022-06-23',7,'cancelado@7@2022-06-20 21:02:10','2022-06-20 20:56:50','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (10,'2022-06-23',7,'cancelado@7@2022-06-20 21:08:07','2022-06-20 21:07:52','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (15,'2022-06-23',7,'cancelado@7@2022-06-20 21:12:36','2022-06-20 21:12:29','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (5,'2022-06-24',7,'cancelado@7@2022-06-20 20:55:29','2022-06-20 20:55:00','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (9,'2022-06-24',7,'cancelado@7@2022-06-20 21:02:10','2022-06-20 20:56:50','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (11,'2022-06-24',7,'cancelado@7@2022-06-20 21:08:07','2022-06-20 21:07:52','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (16,'2022-06-24',7,'cancelado@7@2022-06-20 21:14:05','2022-06-20 21:12:29','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (6,'2022-06-25',7,'cancelado@7@2022-06-20 20:55:49','2022-06-20 20:55:00','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (12,'2022-06-25',7,'cancelado@7@2022-06-20 21:08:29','2022-06-20 21:07:52','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (13,'2022-06-26',7,'cancelado@7@2022-06-20 21:08:29','2022-06-20 21:07:52','5/2022 A 4/2023',NULL,NULL);
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (17,'2022-06-27',7,'pendiente','2022-06-25 02:42:33','5/2022 A 4/2023','admin','Vacaciones');
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (18,'2022-06-28',7,'pendiente','2022-06-25 02:42:33','5/2022 A 4/2023','admin','Vacaciones');
insert  into `programacion_vacaciones`(`id`,`fecha`,`trabajador_id`,`estado`,`elaborado`,`periodo_vacacional`,`usuario`,`observaciones`) values (19,'2022-06-29',7,'pendiente','2022-06-25 02:42:33','5/2022 A 4/2023','admin','Vacaciones');

/*Table structure for table `proveedores` */

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `rfc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `proveedores` */

/*Table structure for table `pseccion` */

CREATE TABLE `pseccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pexamen_id` int(11) DEFAULT NULL,
  `cseccion_id` int(11) DEFAULT NULL,
  `horainicio` time DEFAULT NULL,
  `horafin` time DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pseccion` */

/*Table structure for table `pseparaciones` */

CREATE TABLE `pseparaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipopercepcion` char(5) DEFAULT NULL,
  `pagado` decimal(9,2) DEFAULT NULL,
  `anios` int(11) DEFAULT NULL,
  `sueldo` decimal(9,2) DEFAULT NULL,
  `acumulable` decimal(9,2) DEFAULT NULL,
  `noacumulable` decimal(9,2) DEFAULT NULL,
  `gravado` decimal(9,2) DEFAULT NULL,
  `exento` decimal(9,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `idcontrato` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pseparaciones` */

/*Table structure for table `psocioeconomico` */

CREATE TABLE `psocioeconomico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempleado` int(11) NOT NULL,
  `fechaRealizacion` date DEFAULT NULL,
  `evaluador` text,
  `comentarios` text,
  `firma_empleado` text,
  `firma_evaluador` text,
  `fechaCreacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_pempleado_id_psocioeconomico_idempleado_idx` (`idempleado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `psocioeconomico` */

insert  into `psocioeconomico`(`id`,`idempleado`,`fechaRealizacion`,`evaluador`,`comentarios`,`firma_empleado`,`firma_evaluador`,`fechaCreacion`) values (1,1,'0000-00-00','','',NULL,NULL,'2022-06-11 01:50:53');
insert  into `psocioeconomico`(`id`,`idempleado`,`fechaRealizacion`,`evaluador`,`comentarios`,`firma_empleado`,`firma_evaluador`,`fechaCreacion`) values (2,52,NULL,NULL,NULL,NULL,NULL,'2022-06-11 09:38:34');
insert  into `psocioeconomico`(`id`,`idempleado`,`fechaRealizacion`,`evaluador`,`comentarios`,`firma_empleado`,`firma_evaluador`,`fechaCreacion`) values (3,2,NULL,NULL,NULL,NULL,NULL,'2022-06-11 21:44:57');
insert  into `psocioeconomico`(`id`,`idempleado`,`fechaRealizacion`,`evaluador`,`comentarios`,`firma_empleado`,`firma_evaluador`,`fechaCreacion`) values (4,6,NULL,NULL,NULL,NULL,NULL,'2022-06-17 18:27:12');

/*Table structure for table `ptarea` */

CREATE TABLE `ptarea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idrtarea` int(11) DEFAULT NULL,
  `foto` varchar(800) DEFAULT 'noimagen.jpg',
  `observaciones` text,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=254 DEFAULT CHARSET=latin1;

/*Data for the table `ptarea` */

/*Table structure for table `ptimbrado` */

CREATE TABLE `ptimbrado` (
  `serie` char(10) NOT NULL,
  `folio` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `idcontrato` int(11) DEFAULT NULL,
  `fechaIni` date DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  `fechaPago` date DEFAULT NULL,
  `idtiponomina` char(5) DEFAULT NULL,
  `diasPagados` int(11) DEFAULT NULL,
  `totalOtrosPagos` decimal(9,2) DEFAULT NULL,
  `totalDeducciones` decimal(9,2) DEFAULT NULL,
  `totalPercepciones` decimal(9,2) DEFAULT NULL,
  `subtotal` decimal(9,2) DEFAULT NULL,
  `descuento` decimal(9,2) DEFAULT NULL,
  `total` decimal(9,2) DEFAULT NULL,
  `sello` text,
  `certificado` text,
  `noCertificado` varchar(100) DEFAULT NULL,
  `cadenaOriginal` text,
  `wssellocfd` text,
  `wssellosat` text,
  `wsuuid` varchar(200) DEFAULT NULL,
  `wsfecha` varchar(100) DEFAULT NULL,
  `wsrfc` varchar(100) DEFAULT NULL,
  `wsnoCertificado` varchar(100) DEFAULT NULL,
  `uuidanterior` varchar(200) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`serie`,`folio`),
  UNIQUE KEY `folio` (`folio`)
) ENGINE=MyISAM AUTO_INCREMENT=504 DEFAULT CHARSET=latin1;

/*Data for the table `ptimbrado` */

/*Table structure for table `ptipousuariocuenta` */

CREATE TABLE `ptipousuariocuenta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipousuario` int(11) DEFAULT NULL,
  `idcon_cuenta` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ptipousuariocuenta` */

/*Table structure for table `punidades` */

CREATE TABLE `punidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idsucursal` int(11) DEFAULT NULL,
  `tipo` varchar(200) DEFAULT NULL,
  `placa` varchar(100) DEFAULT NULL,
  `serie` varchar(100) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `linea` varchar(100) DEFAULT NULL,
  `modelo` int(11) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `no_motor` varchar(100) DEFAULT NULL,
  `tarjeta_circulacion` varchar(200) DEFAULT NULL,
  `seguro_poliza` varchar(100) DEFAULT NULL,
  `seguro_compania` varchar(100) DEFAULT NULL,
  `seguro_vigencia` date DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `punidades` */

/*Table structure for table `pusuariocuenta` */

CREATE TABLE `pusuariocuenta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `idcon_cuenta` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pusuariocuenta` */

/*Table structure for table `pusuarioproductos` */

CREATE TABLE `pusuarioproductos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idempleado` int(11) DEFAULT NULL,
  `precios` varchar(50) DEFAULT 'PVP1,PVP2,PVP3',
  `familia` varchar(500) DEFAULT 'ALL',
  `paginaini` varchar(200) DEFAULT 'precios_productos',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pusuarioproductos` */

/*Table structure for table `pusuarios` */

CREATE TABLE `pusuarios` (
  `username` varchar(100) NOT NULL,
  `password` varbinary(100) DEFAULT NULL,
  `nombre` varchar(500) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `tipo` int(100) DEFAULT '3',
  `idempleado` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `idempresa` int(11) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pusuarios` */

insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('admin','admin','Administrador CM Resorts','',1,NULL,1,2);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('AHERNANDEZP','140701','ALEXANDER HERNANDEZ PEREZ','ah3086405@gmail.com',3,23,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('AHERNANDEZR','160167','ASUNCION HERNANDEZ RIOS','asuncionrioshdz@hotmail.com',3,22,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('ALOPEZ','140672','ARTURO LOPEZ LOPEZ','arturolopez14061972@hotmail.com',3,15,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('AMANUEL','050385','ADRIANA MANUEL LAZARO','piscis.amor.32@gmail.com',3,7,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('ASANTOS','120194','ALEXANDER DE LOS SANTOS ROQUE','alexanderdelossantosroque@hotmail.com',3,25,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('BCHATU','021290','BERNABE CHATU POZO','bernachatu067@gmail.com',3,14,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('EVELAZQUEZ','190997','ELIOBETH VELAZQUEZ CABALLERO','obedv0685@hotmail.com',3,12,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('FRVELASCO','030601','FERNANDO RAFAEL VELASCO ALVAREZ','rvelascoalvarez0306@gmail.com',3,26,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('ITECO','281265','INOCENTE TECO GUMETA','inocenteteco1965@gmail.com',3,5,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('JAALVAREZ','130186','JOSE ALFREDO ALVAREZ DE LA CRUZ','josealfredoalvaresdelacruz312@gmail.com',3,6,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('JAANTUNES','010885','JOSE ANTONIO MORALES ANTUNES','feco.33jama@gmail.com',3,3,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('JAGOMES','210655','JOSE ANTONIO GOMES RAMIREZ','',3,9,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('JSANTOS','271102','JESSICA SANTOS CRUZ','js2215686@gmail.com',3,19,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('LBSANTOS','231298','LUCIA BELEN DE LOS SANTOS ROQUE','belleeteuk@gmail.com',3,20,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('LDALEMAN','300898','LUCIA DAMARES ALEMAN GONZALEZ','lucia98damares@gmail.com',3,16,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('MERODRIGUEZ','241276','MARIA ENEIDA RODRIGUEZ SANCHEZ','rodriguezsachmary208@gmail.com',3,13,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('MNPE?????A','191168','MARIO NOEL PE?????A HENRIQUEZ','',3,8,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('NHERNANDEZ','081282','NARBEY HERNANDEZ PEREZ','hernandezperezbeyi1982@gmail.com',3,18,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('PRUIZ','201174','PATRICIA LOPEZ RUIZ','patito.ruiz1973@gmail.com',3,21,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('RAQUEL','RAQUEL1','RAQUEL DE LOS SANTOS ROQUE','queli_richi@hotmail.com',3,2,0,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('RSANTOS','140190','RAQUEL DE LOS SANTOS ROQUE','queli_richi@hotmail.com',1,2,1,2);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('RTECO','170468','RUSBEL TECO GUMETA','',3,4,1,2);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('RVELAZQUEZ','250184','ROXANA VELAZQUEZ SOLIS','velazquezroxana627@gmail.com',3,11,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('SAVAZQUEZ','310897','SALVADOR ANTONIO VAZQUEZ MARTINEZ','filosofia1997antonio@gmail.com',3,24,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('sestrada','pass','SERGIO DE JESUS ESTRADA AVELAR','serygra@gmail.com',3,1,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('sestradas','sestradas','SERGIO DE JESUS ESTRADA AVELAR','serygra@gmail.com',3,1,1,1);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('usuario','123','JUAN PEREZ','',1,NULL,1,1);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('VCRUS','030273','VERONICA CRUS DIAS','veronicacrusdiaz73@gmail.com',3,17,1,NULL);
insert  into `pusuarios`(`username`,`password`,`nombre`,`email`,`tipo`,`idempleado`,`status`,`idempresa`) values ('VHERNANDES','080572','VIULAILA HERNANDES VICENTE','vidahernandezmorales@gmail.com',3,10,1,NULL);

/*Table structure for table `pusuariosucursal` */

CREATE TABLE `pusuariosucursal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `idcsucursal` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pusuariosucursal` */

/*Table structure for table `requisicion_details` */

CREATE TABLE `requisicion_details` (
  `idrequisicion` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad_solicitado` int(11) DEFAULT '0',
  `cantidad_entregada` int(11) DEFAULT '0',
  KEY `fkrequisicion_idx` (`idrequisicion`),
  KEY `fkarticulo_idx` (`idarticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `requisicion_details` */

/*Table structure for table `requisiciones` */

CREATE TABLE `requisiciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sucursal_id` int(11) DEFAULT NULL,
  `fecha_solicitado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_entregado` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sucursal` (`sucursal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `requisiciones` */

/*Table structure for table `resgequipocomputo_detail` */

CREATE TABLE `resgequipocomputo_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numResguardo` bigint(20) DEFAULT NULL,
  `num_cel_emp` text,
  `tipo_equipo` text,
  `marca` text,
  `modelo` text,
  `dd_gb` text,
  `ram_gb` text,
  `procesador` text,
  `ns_equipo` text,
  `so` text,
  `licencia` text,
  `monitor` text,
  `ns_monitor` text,
  `teclado` text,
  `ns_teclado` text,
  `mouse` text,
  `ns_mouse` text,
  `cargador` text,
  `ns_cargador` text,
  `impresora` text,
  `ns_impresora` text,
  `no_brake` text,
  `bocina` text,
  `dvd_cd` text,
  `observaciones` text,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `resgequipocomputo_detail` */

/*Table structure for table `resguardo_details` */

CREATE TABLE `resguardo_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `modelo_cel` text,
  `imei_cel` text,
  `num_cel` text,
  `compania` text,
  `uso` text,
  `chk_1` text,
  `chk_2` text,
  `chk_3` text,
  `chk_4` text,
  `chk_5` text,
  `chk_6` text,
  `chk_7` text,
  `chk_8` text,
  `chk_9` text,
  `chk_10` text,
  `chk_11` text,
  `chk_12` text,
  `chk_13` text,
  `chk_14` text,
  `observaciones` text,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `resguardo_details` */

/*Table structure for table `resguardos` */

CREATE TABLE `resguardos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `empresa` text,
  `sucursal` text,
  `nombre_empleado` text,
  `area_depto` text,
  `puesto` text,
  `entrega_equipo` text,
  `tipo_resg` text,
  `fecha` date DEFAULT NULL,
  `pdf_path` text,
  `fkid_detalle_resguardo` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `resguardos` */

/*Table structure for table `rh_bateria_evaluacion` */

CREATE TABLE `rh_bateria_evaluacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_evaluacion` int(11) NOT NULL,
  `id_puesto` int(11) NOT NULL,
  `calif_minima` double DEFAULT NULL,
  `calif_deseada` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_evaluacion_bateria_idx` (`id_evaluacion`),
  KEY `fk_puesto_bateria_idx` (`id_puesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `rh_bateria_evaluacion` */

/*Table structure for table `rh_evalacion` */

CREATE TABLE `rh_evalacion` (
  `id_kardex` int(11) NOT NULL,
  `id_pregunta` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `respuesta_dada` text COLLATE utf8_spanish_ci,
  `acierto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `rh_evalacion` */

/*Table structure for table `rh_evaldeaptitudes` */

CREATE TABLE `rh_evaldeaptitudes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `clave` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `objetivo` text COLLATE utf8_spanish_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave_UNIQUE` (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `rh_evaldeaptitudes` */

/*Table structure for table `rh_kardex_evaluaciones` */

CREATE TABLE `rh_kardex_evaluaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `calificacion` double DEFAULT NULL,
  `firma_evaluado` text COLLATE utf8_spanish_ci,
  `firma_responsable` text COLLATE utf8_spanish_ci,
  `id_solicitud` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_solicitud_kardex_idx` (`id_solicitud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `rh_kardex_evaluaciones` */

/*Table structure for table `rh_pregunta_evaluacion` */

CREATE TABLE `rh_pregunta_evaluacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `respuesta1` text COLLATE utf8_spanish_ci,
  `respuesta2` text COLLATE utf8_spanish_ci,
  `respuesta3` text COLLATE utf8_spanish_ci,
  `respuesta_correcta` text COLLATE utf8_spanish_ci,
  `ponderacion` double DEFAULT NULL,
  `id_evaluacion` int(11) NOT NULL,
  `status` varchar(1) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `fk_pregunta_evaluacion_idx` (`id_evaluacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `rh_pregunta_evaluacion` */

/*Table structure for table `rh_solcitudes_empleo` */

CREATE TABLE `rh_solcitudes_empleo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `apaterno` text COLLATE utf8_spanish_ci NOT NULL,
  `amaterno` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `curp` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `rfc` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `nss` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `grado_estudio` text COLLATE utf8_spanish_ci,
  `licencia` text COLLATE utf8_spanish_ci,
  `experiencia_lab` text COLLATE utf8_spanish_ci,
  `puesto_id` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `calle` text COLLATE utf8_spanish_ci,
  `num_interior` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `num_exterior` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `colonia` text COLLATE utf8_spanish_ci,
  `ciudad` text COLLATE utf8_spanish_ci,
  `municipio` text COLLATE utf8_spanish_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `curp_UNIQUE` (`curp`),
  UNIQUE KEY `rfc_UNIQUE` (`rfc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Data for the table `rh_solcitudes_empleo` */

/*Table structure for table `roles_inventarios` */

CREATE TABLE `roles_inventarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `familia` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `roles_inventarios` */

/*Table structure for table `rtarea` */

CREATE TABLE `rtarea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtarea` int(11) DEFAULT NULL,
  `iddepartamento` int(11) DEFAULT NULL,
  `idpuesto` int(11) DEFAULT NULL,
  `nip` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

/*Data for the table `rtarea` */

/*Table structure for table `rubros_actividades` */

CREATE TABLE `rubros_actividades` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `categoria_rubro` text,
  `accion_rubro` text,
  `concepto_rubro` text,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rubros_actividades` */

/*Table structure for table `rusuariomodulo` */

CREATE TABLE `rusuariomodulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtipousuario` int(11) DEFAULT '0',
  `usuario` varchar(100) DEFAULT NULL,
  `idmodulo` int(11) DEFAULT NULL,
  `guardar` tinyint(1) DEFAULT '0',
  `actualizar` tinyint(1) DEFAULT '0',
  `borrar` tinyint(1) DEFAULT '0',
  `ver` tinyint(1) DEFAULT '0',
  `imprimir` tinyint(1) DEFAULT '0',
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

/*Data for the table `rusuariomodulo` */

insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (1,0,'admin',1,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (2,0,'admin',2,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (3,0,'admin',3,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (4,0,'admin',4,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (5,0,'admin',5,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (6,0,'admin',6,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (7,0,'admin',7,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (8,0,'admin',8,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (9,0,'admin',9,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (10,0,'admin',10,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (11,0,'admin',11,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (12,0,'admin',12,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (13,0,'admin',13,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (14,0,'admin',14,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (15,0,'admin',15,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (16,0,'admin',16,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (17,0,'admin',17,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (18,0,'admin',18,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (19,0,'RAQUEL',1,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (20,0,'RAQUEL',2,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (21,0,'RAQUEL',3,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (22,0,'RAQUEL',4,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (23,0,'RAQUEL',5,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (24,0,'RAQUEL',6,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (25,0,'RAQUEL',7,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (26,0,'RAQUEL',8,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (27,0,'RAQUEL',9,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (28,0,'RAQUEL',10,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (29,0,'RAQUEL',11,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (30,0,'RAQUEL',12,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (31,0,'RAQUEL',13,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (32,0,'RAQUEL',14,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (33,0,'RAQUEL',15,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (34,0,'RAQUEL',16,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (35,0,'RAQUEL',17,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (36,0,'RAQUEL',18,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (50,0,'RSANTOS',1,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (51,0,'RSANTOS',2,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (52,0,'RSANTOS',3,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (53,0,'RSANTOS',4,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (54,0,'RSANTOS',5,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (55,0,'RSANTOS',6,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (56,0,'RSANTOS',7,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (57,0,'RSANTOS',8,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (58,0,'RSANTOS',9,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (59,0,'RSANTOS',10,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (60,0,'RSANTOS',11,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (61,0,'RSANTOS',12,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (62,0,'RSANTOS',13,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (63,0,'RSANTOS',14,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (64,0,'RSANTOS',15,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (65,0,'RSANTOS',16,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (66,0,'RSANTOS',17,1,1,1,1,1,1);
insert  into `rusuariomodulo`(`id`,`idtipousuario`,`usuario`,`idmodulo`,`guardar`,`actualizar`,`borrar`,`ver`,`imprimir`,`status`) values (67,0,'RSANTOS',18,1,1,1,1,1,1);

/*Table structure for table `saldos_bancarios` */

CREATE TABLE `saldos_bancarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `movimiento_id` varchar(45) DEFAULT NULL,
  `beneficiario` text,
  `referencia` varchar(600) DEFAULT NULL,
  `egresos` double DEFAULT NULL,
  `ingresos` double DEFAULT NULL,
  `saldoMovimiento` double DEFAULT NULL,
  `cuenta_bancaria_id` int(11) NOT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `ctipocuenta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueMovimiento` (`fecha`,`movimiento_id`,`egresos`,`ingresos`,`saldoMovimiento`,`referencia`),
  KEY `fk_cuentas_bancarias_id_idx` (`cuenta_bancaria_id`),
  KEY `fk_ctipocuenta_id_idx` (`ctipocuenta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `saldos_bancarios` */

/*Table structure for table `seguimientos_prospecciones` */

CREATE TABLE `seguimientos_prospecciones` (
  `idprospecto` varchar(25) NOT NULL,
  `contacto` varchar(50) DEFAULT NULL,
  `observasiones` text,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `seguimientos_prospecciones` */

/*Table structure for table `utilidadessuc` */

CREATE TABLE `utilidadessuc` (
  `sucursal` varchar(100) DEFAULT NULL,
  `ventas` decimal(9,2) DEFAULT NULL,
  `costo` decimal(9,2) DEFAULT NULL,
  `gastosop` decimal(9,2) DEFAULT NULL,
  `gastosfi` decimal(9,2) DEFAULT NULL,
  `utilidadbruta` decimal(9,2) DEFAULT NULL,
  `utilidadperdida` decimal(9,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `utilidadessuc` */

/* Procedure structure for procedure `ACORRECTIVAS_ACUMULATIVAS` */

DELIMITER $$

/*!50003 CREATE DEFINER=`nuevo`@`%` PROCEDURE `ACORRECTIVAS_ACUMULATIVAS`(
	IN `empleado` INT,
	IN `fechaSancion` DATE,
	IN `motivo` TEXT,
	IN `planAccion` TEXT,
	IN `fechaDescuento` DATE,
	IN `sucursal` INT,
	IN `puesto` INT,
	IN `idSanciona` INT,
	IN `tipoSancion` varchar(45)
)
BEGIN
	DECLARE idConsec INT;
	DECLARE nConsecutivo INT;
	DECLARE dia int;
	DECLARE mes int;
	DECLARE anio int;
	DECLARE i int;
		
	DECLARE exit handler for sqlexception
		BEGIN
		ROLLBACK;
	END;
	
	DECLARE exit handler for sqlwarning
		BEGIN
		ROLLBACK;
	END;
	
	START TRANSACTION;
	
		-- Se extrae los componentes de la fecha para calcular si el acumulado aun aplica para la quincena actual
		SELECT DAY( fechaDescuento ) into dia;
		SELECT MONTH( fechaDescuento ) into mes;
		SELECT YEAR( fechaDescuento ) into anio;	
		

		set i := 1;



		
		IF( dia <= 15) then
			if( exists( SELECT *
				 FROM pacciones_correctivas 
				 WHERE fecha_descuento >= concat(anio ,'-',mes,'-01') and aplicado = 'N' 
				 and idempleado = empleado
				  and fecha_descuento <= concat(anio ,'-',mes,'-',15) 
				 order by id desc limit 1
					) ) THEN

					SELECT id, consecutivo INTO  idConsec,nConsecutivo
					 FROM pacciones_correctivas 
					 WHERE fecha_descuento >= concat(anio ,'-',mes,'-01') and aplicado = 'N' 
					 and idempleado = empleado
					  and fecha_descuento <= concat(anio ,'-',mes,'-', 15) 
					 order by id desc limit 1;
					 
					 select nConsecutivo;
					 
				 if( nConsecutivo = 3 ) THEN

				 	INSERT INTO pacciones_correctivas(idempleado,fecha_sancion,motivo,plan_accion,
				 			fecha_descuento,monto,sucursalId,puestoId,id_usuario_aplico_sancion,
				 			consecutivo,aplicado,idaccion_consecutivo_anterior,idtipodeduccion) 
							 VALUES (empleado,fechaSancion,motivo,planAccion,fechaDescuento,100,
							 sucursal,puesto,idSanciona,4,'S',idConsec, tipoSancion);
							 
							 WHILE(  i <= 3)  DO
							 		set	i = i+1;
							 		
							 		UPDATE pacciones_correctivas SET aplicado = 'S' where id = idConsec;
							 		SELECT idaccion_consecutivo_anterior, consecutivo INTO  idConsec,nConsecutivo
									 FROM pacciones_correctivas 
									 WHERE id = idConsec;
									 

							END WHILE;
							COMMIT; 
				 else

					SET nConsecutivo := nConsecutivo + 1;
				 	INSERT INTO pacciones_correctivas(idempleado,fecha_sancion,motivo,plan_accion,
				 			fecha_descuento,monto,sucursalId,puestoId,id_usuario_aplico_sancion,
				 			consecutivo,aplicado,idaccion_consecutivo_anterior,idtipodeduccion) 
							 VALUES (empleado,fechaSancion,motivo,planAccion,fechaDescuento,-1,
							 sucursal,puesto,idSanciona,nConsecutivo,'N',idConsec, tipoSancion);	
							 COMMIT; 				
				 END IF;
			ELSE			
				 	INSERT INTO pacciones_correctivas(idempleado,fecha_sancion,motivo,plan_accion,
				 			fecha_descuento,monto,sucursalId,puestoId,id_usuario_aplico_sancion,
				 			consecutivo,aplicado,idaccion_consecutivo_anterior,idtipodeduccion) 
							 VALUES (empleado,fechaSancion,motivo,planAccion,fechaDescuento,-1,
							 sucursal,puesto,idSanciona,1,'N',0,tipoSancion);		
							 COMMIT; 			
			END IF;
			
		else
			if( mes = 12 ) THEN
				set mes := 1;
				set anio := anio +1;
			end if;
			
			if( exists( SELECT *
				 FROM pacciones_correctivas 
				 WHERE fecha_descuento > concat(anio ,'-',mes,'-15') and aplicado = 'N' 
				 and idempleado = empleado
				  and fecha_descuento < concat(anio ,'-',mes+1,'-','01') 
				 order by id desc limit 1
					) ) THEN

					SELECT id, consecutivo INTO  idConsec,nConsecutivo
					 FROM pacciones_correctivas 
					 WHERE fecha_descuento > concat(anio ,'-',mes,'-15') and aplicado = 'N' 
					 and idempleado = empleado
					  and fecha_descuento <= concat(anio ,'-',mes,'-','31') 
					 order by id desc limit 1;
				 

				 if( nConsecutivo = 3 ) THEN

				 	INSERT INTO pacciones_correctivas(idempleado,fecha_sancion,motivo,plan_accion,
				 			fecha_descuento,monto,sucursalId,puestoId,id_usuario_aplico_sancion,
				 			consecutivo,aplicado,idaccion_consecutivo_anterior,idtipodeduccion) 
							 VALUES (empleado,fechaSancion,motivo,planAccion,fechaDescuento,100,
							 sucursal,puesto,idSanciona,4,'S',idConsec,tipoSancion);
							 							 
							 WHILE(  i <= 3) DO
							 		set	i = i+1;
							 		
							 		UPDATE pacciones_correctivas SET aplicado = 'S' where id = idConsec;
							 		SELECT idaccion_consecutivo_anterior, consecutivo INTO  idConsec,nConsecutivo
									 FROM pacciones_correctivas 
									 WHERE id = idConsec;

							END WHILE;
							 COMMIT; 
				 else
				 	
					SET nConsecutivo := nConsecutivo + 1;
				 	INSERT INTO pacciones_correctivas(idempleado,fecha_sancion,motivo,plan_accion,
				 			fecha_descuento,monto,sucursalId,puestoId,id_usuario_aplico_sancion,
				 			consecutivo,aplicado,idaccion_consecutivo_anterior,idtipodeduccion) 
							 VALUES (empleado,fechaSancion,motivo,planAccion,fechaDescuento,-1,
							 sucursal,puesto,idSanciona,nConsecutivo,'N',idConsec,tipoSancion);		
							 COMMIT; 			
				 END IF;
			ELSE
				 	INSERT INTO pacciones_correctivas(idempleado,fecha_sancion,motivo,plan_accion,
				 			fecha_descuento,monto,sucursalId,puestoId,id_usuario_aplico_sancion,
				 			consecutivo,aplicado,idaccion_consecutivo_anterior,idtipodeduccion) 
							 VALUES (empleado,fechaSancion,motivo,planAccion,fechaDescuento,-1,
							 sucursal,puesto,idSanciona,1,'N',0,tipoSancion);	
							 COMMIT; 				
			END IF; 
		
		END IF; 
					

END */$$
DELIMITER ;

/* Procedure structure for procedure `ventas` */

DELIMITER $$

/*!50003 CREATE DEFINER=`nuevo`@`%` PROCEDURE `ventas`()
SET @acum = 0 */$$
DELIMITER ;

/* Procedure structure for procedure `SETPROGRAMACION_VACACIONES` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SETPROGRAMACION_VACACIONES`(
	IN `_fecha` DATE,
	IN `empleado` INT,
	IN `_estado` VARCHAR(50),
	IN `_periodo` VARCHAR(50),
	IN `_usuario` VARCHAR(50),
	IN `_observaciones` VARCHAR(2000)

)
BEGIN

	DECLARE idVacaciones INT;
	
	START TRANSACTION;
		
		
		if((SELECT COUNT(*) from programacion_vacaciones where fecha = _fecha AND trabajador_id = empleado AND estado = _estado )=0 ) THEN
			SET @idVacaciones := ( SELECT IFNULL(max(id),0) from programacion_vacaciones );
				set @idVacaciones := @idVacaciones +1;
				-- select @idVacaciones;
			INSERT INTO programacion_vacaciones(id,fecha,trabajador_id,estado,periodo_vacacional,usuario,observaciones) VALUES(@idVacaciones,_fecha, empleado, _estado,_periodo,_usuario,_observaciones);
			COMMIT; 
		END IF;

END */$$
DELIMITER ;

/* Procedure structure for procedure `UPDATE_VACACIONES` */

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_VACACIONES`(
	IN `_fecha` DATE,
	IN `empleado` TEXT,
	IN `_estado` VARCHAR(50)



)
BEGIN
	
	DECLARE currentId INT;
	
	DECLARE exit handler for sqlexception
		BEGIN
		ROLLBACK;
	END;
	
	DECLARE exit handler for sqlwarning
		BEGIN
		ROLLBACK;
	END;
	
	START TRANSACTION;
		
		    
    
	set currentId = ( select id from programacion_vacaciones where fecha = _fecha AND trabajador_id = empleado AND estado = _estado );
		
	if((select COUNT(*) from programacion_vacaciones where fecha = _fecha AND trabajador_id = empleado AND estado = _estado)>0 ) THEN
		UPDATE programacion_vacaciones SET estado= CONCAT("@", empleado, "@", _fecha,"@",_estado,"@",now()) WHERE id= currentId;
		COMMIT; 
	END IF;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
