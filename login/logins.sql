/*
SQLyog Community
MySQL - 10.1.32-MariaDB : Database - logins
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `clientes` */

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `password` varbinary(400) NOT NULL,
  `nombre` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_ingreso` date NOT NULL,
  `rfc` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `url` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timbresPrecio` decimal(10,2) DEFAULT NULL,
  `timbresGratis` int(11) DEFAULT NULL,
  `timbresUsados` int(11) DEFAULT NULL,
  `timbresRestantes` int(11) DEFAULT NULL,
  `abreviatura` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `clientes` */

insert  into `clientes`(`id`,`usuario`,`password`,`nombre`,`fecha_ingreso`,`rfc`,`status`,`url`,`timbresPrecio`,`timbresGratis`,`timbresUsados`,`timbresRestantes`,`abreviatura`,`template`) values (40,'admin7l','admin7l','SIETE LEGUAS','2022-06-18','gls0101157m0',1,'fe161d',0.00,0,NULL,NULL,'7L','light');
insert  into `clientes`(`id`,`usuario`,`password`,`nombre`,`fecha_ingreso`,`rfc`,`status`,`url`,`timbresPrecio`,`timbresGratis`,`timbresUsados`,`timbresRestantes`,`abreviatura`,`template`) values (41,'admincm','admincm','CM RESORTS','2022-06-18','aabm870128py9',1,'001482',0.00,0,NULL,NULL,'CM','dark');

/*Table structure for table `intercambio` */

CREATE TABLE `intercambio` (
  `nombre` varchar(200) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `intercambio` */

insert  into `intercambio`(`nombre`) values ('Sergio');
insert  into `intercambio`(`nombre`) values ('Moni');
insert  into `intercambio`(`nombre`) values ('tere ');
insert  into `intercambio`(`nombre`) values ('FabiÃ¡n ');
insert  into `intercambio`(`nombre`) values ('Hector');
insert  into `intercambio`(`nombre`) values ('Cheli');
insert  into `intercambio`(`nombre`) values ('Marco');
insert  into `intercambio`(`nombre`) values ('Cheli ');
insert  into `intercambio`(`nombre`) values ('Sergio');
insert  into `intercambio`(`nombre`) values ('Ramon');
insert  into `intercambio`(`nombre`) values ('Sergio');
insert  into `intercambio`(`nombre`) values ('TÃ­a leti');
insert  into `intercambio`(`nombre`) values ('Minerva gg');
insert  into `intercambio`(`nombre`) values ('Andres');
insert  into `intercambio`(`nombre`) values ('Fabiola');

/*Table structure for table `sesiones` */

CREATE TABLE `sesiones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(500) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `cliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=829 DEFAULT CHARSET=latin1;

/*Data for the table `sesiones` */

insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (1,'9184e6c90d1a6adb5b90247d58a5cb17','200.77.70.18','2014-03-31','01:02:09',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (2,'9184e6c90d1a6adb5b90247d58a5cb17','200.77.70.18','2014-03-31','01:04:11',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (3,'9184e6c90d1a6adb5b90247d58a5cb17','200.77.70.18','2014-03-31','01:39:50',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (4,'9184e6c90d1a6adb5b90247d58a5cb17','200.77.70.18','2014-03-31','01:41:19',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (5,'5544be61438d8c85a7e79b1c5bd89e28','187.143.139.185','2014-03-31','10:28:51',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (6,'d24d420951f0d4424489787e77270329','187.143.151.98','2014-04-01','10:33:14',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (7,'d24d420951f0d4424489787e77270329','187.143.151.98','2014-04-01','10:44:13',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (8,'48e4f3b43a1b3794aa1f9a73fbeb2fa4','187.143.235.24','2014-04-01','12:06:00',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (9,'6dc1059b0288c6ecb5368b3e973e17df','187.143.151.98','2014-04-01','12:27:34',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (10,'b8f44703ea973a32c26545fcce697975','187.143.235.24','2014-04-01','12:55:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (11,'6b23c6950a9f018f6aa7b263a0091edf','187.143.235.24','2014-04-01','12:59:34',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (12,'6b23c6950a9f018f6aa7b263a0091edf','187.143.235.24','2014-04-01','12:59:34',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (13,'cbe4df5a2c32a60efb8f70552927a25f','187.143.156.81','2014-04-01','16:21:40',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (14,'4e4725932e2468cfce7993b0daaed7f2','187.143.156.81','2014-04-01','17:31:32',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (15,'872e7b7728321f10ef5e65481aa82d71','187.143.156.81','2014-04-01','17:43:01',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (16,'5f8b607199887ad30154bc838f8af023','187.143.156.81','2014-04-01','18:21:52',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (17,'3c77b4db2cb2b029806f38817d79e481','200.77.70.18','2014-04-02','00:41:27',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (18,'c3efbe996f4cfba56bcc58fe9a0868ed','200.77.70.18','2014-04-02','00:44:24',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (19,'c3efbe996f4cfba56bcc58fe9a0868ed','200.77.70.18','2014-04-02','00:49:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (20,'3224bf85746ca76e3453452673d141f8','187.143.143.184','2014-04-02','17:37:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (21,'3c77b4db2cb2b029806f38817d79e481','200.77.70.18','2014-04-02','19:50:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (22,'f559e0255f45941cb321a67200936d16','200.77.70.18','2014-04-05','09:44:00',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (23,'1be9b6b3d841db5c00e4ee8067e16ee7','189.236.131.239','2014-04-08','15:32:35',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (24,'gqtq2o74jhpl9m01a08esf4537','189.236.131.239','2014-04-09','10:09:27',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (25,'lacrurp4ra4ft3npppejov8a93','189.236.131.239','2014-04-09','10:21:33',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (26,'14uqrjmufof8qkpkcfre2a0hi4','189.236.131.239','2014-04-09','11:10:27',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (27,'09l8rihd9taksc71j6jokcvgl4','187.143.142.23','2014-04-09','11:16:49',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (28,'jtui556l60691khaev2392evs6','187.143.142.23','2014-04-09','11:36:48',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (29,'bmacre1nk1ssmv40eu3h5750i5','189.236.131.239','2014-04-09','13:18:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (30,'lacrurp4ra4ft3npppejov8a93','10.181.153.29','2014-04-09','13:23:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (31,'62s32pvnttgh6fa522dh842k40','189.236.131.239','2014-04-09','14:05:11',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (32,'ldkoqdre8cn4mugeutl4ttjvd5','189.236.131.239','2014-04-09','14:25:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (33,'jislcbb3mifk8kmkrh1kmsg962','200.77.70.18','2014-04-09','14:35:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (34,'c56qg84q12o8129qfq4jtmhde0','189.236.131.239','2014-04-09','15:20:17',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (35,'hcc3fv5q1jhs98q911441mn9d5','200.77.70.18','2014-04-09','15:42:18',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (36,'hcc3fv5q1jhs98q911441mn9d5','200.77.70.18','2014-04-09','19:33:22',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (37,'fg1ov610p7dcds9485p14lrdt7','187.143.167.144','2014-04-10','17:51:29',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (38,'tkgqffostp2s1hei0dm3s18b90','187.143.167.144','2014-04-10','18:04:09',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (39,'99nbb2j14ddm0nsvflod0jfvu6','200.77.70.18','2014-04-10','18:18:24',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (40,'9mupupptg8ktg2qn15aq8mj663','187.143.239.165','2014-04-11','09:14:53',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (41,'svon0u5g3f7o255s7d50i0h7s5','187.143.167.144','2014-04-11','09:36:01',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (42,'9mupupptg8ktg2qn15aq8mj663','187.143.239.165','2014-04-11','09:39:29',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (43,'svon0u5g3f7o255s7d50i0h7s5','187.143.167.144','2014-04-11','10:29:52',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (44,'svon0u5g3f7o255s7d50i0h7s5','187.143.167.144','2014-04-11','10:29:52',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (45,'gbhmso9tamija9jhith42a2q13','187.143.167.144','2014-04-11','10:38:44',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (46,'3i3c7cr4ocqk0mudjnptfu5v71','187.143.167.144','2014-04-11','10:41:08',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (47,'2gto5550njdihh2k2k5miud9s5','187.143.167.144','2014-04-11','10:41:20',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (48,'74ea1e6ku4t70jedcrfq5v3qm6','187.143.167.144','2014-04-11','10:45:50',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (49,'amtomk8sf1uravskbbvk3vr515','187.143.167.144','2014-04-11','11:00:10',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (50,'v9r827q2c7v0ppt8ibvqba53a0','189.236.131.239','2014-04-11','12:23:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (51,'v9r827q2c7v0ppt8ibvqba53a0','189.236.131.239','2014-04-11','12:23:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (52,'jh4sdekf97c27i4br4lbbscha3','189.236.131.239','2014-04-12','12:11:28',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (53,'jh4sdekf97c27i4br4lbbscha3','189.236.131.239','2014-04-12','12:11:28',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (54,'03ahneert0uo77uf7kuael56b1','187.143.241.65','2014-04-12','19:22:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (55,'aotoov4sgem9g0jdvjrekrudb0','187.143.241.65','2014-04-12','19:33:23',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (56,'f5f3kl95b7q72looucsvg0a007','187.143.255.128','2014-04-14','09:55:35',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (57,'7fviqc28n8sa3o78t0090q1lj1','187.143.255.128','2014-04-14','10:37:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (58,'7fviqc28n8sa3o78t0090q1lj1','187.143.255.128','2014-04-14','10:37:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (59,'lacrurp4ra4ft3npppejov8a93','187.143.255.128','2014-04-14','10:52:18',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (60,'dm8tc6t95jhc6s0b2hdd1neab6','187.143.255.128','2014-04-14','10:57:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (61,'44pm6oklepfppe4suujijacr71','200.77.70.18','2014-04-14','13:42:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (62,'dm8tc6t95jhc6s0b2hdd1neab6','189.236.119.220','2014-04-14','13:45:52',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (63,'1ju8idsr6gn7aja928a654akc1','200.77.70.18','2014-04-14','13:54:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (64,'oo837ad0at25arf3n7fhd53382','189.236.119.220','2014-04-14','14:03:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (65,'s0uv3l9ch10g76c8ikmf27ol76','189.236.119.220','2014-04-14','16:25:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (66,'s0uv3l9ch10g76c8ikmf27ol76','189.236.119.220','2014-04-14','16:25:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (67,'jj8aibpqnas8eoerfsrkueldg1','189.236.119.220','2014-04-14','16:33:46',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (68,'jj8aibpqnas8eoerfsrkueldg1','189.236.119.220','2014-04-14','16:39:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (69,'opqd4ot2d3adg21jd4c5llhit2','189.236.129.65','2014-04-16','02:11:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (70,'6jua3589chknbhbpgrrj7d77t5','200.77.70.18','2014-04-16','10:34:02',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (71,'7cur6q1roa0kt02ogtp2bilu94','201.114.225.176','2014-04-16','14:57:58',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (72,'7cur6q1roa0kt02ogtp2bilu94','201.114.225.176','2014-04-16','14:57:58',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (73,'p9h60dqsdsmkt6k5fnhfuiqa70','189.132.182.70','2014-04-16','15:15:00',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (74,'3rd1h71lu765ciflino18h7j81','201.114.225.176','2014-04-16','15:39:01',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (75,'2ro9iv8vtfb5cgb6ha2s59uhi4','201.114.231.188','2014-04-23','21:28:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (76,'2ro9iv8vtfb5cgb6ha2s59uhi4','201.114.231.188','2014-04-23','21:28:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (77,'8suq6bl4g6atodmard6r22dem0','187.143.226.230','2014-04-25','12:43:34',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (78,'80fh3udm1alpol7p52b1fdo4h0','187.143.226.230','2014-04-25','12:59:32',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (79,'nko9ur9toaitqujpig3j9b8220','187.143.226.230','2014-04-25','17:26:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (80,'nko9ur9toaitqujpig3j9b8220','187.143.226.230','2014-04-25','17:26:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (81,'hlhticobk1jrshal8om9g298p7','187.143.226.230','2014-04-28','10:32:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (82,'hlhticobk1jrshal8om9g298p7','187.143.226.230','2014-04-28','10:32:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (83,'tahhu6ui2nl0lq04pfod00c284','187.143.226.230','2014-04-28','10:51:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (84,'918ietb8ojedurdkkujqsfqgi4','187.143.227.78','2014-05-02','11:53:28',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (85,'vnun0bppaebahjbhnphs96m576','187.143.164.126','2014-05-02','12:34:02',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (86,'3an47iehia7ltmlgsao584j2m4','187.143.227.78','2014-05-02','12:36:44',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (87,'3an47iehia7ltmlgsao584j2m4','187.143.227.78','2014-05-02','12:36:44',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (88,'8gco0rfmba6ioqdi3amuusc4k1','187.143.227.78','2014-05-07','15:40:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (89,'oh7vjd6ldngskj6nva2nvtruc7','189.236.118.1','2014-05-12','20:08:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (90,'oh7vjd6ldngskj6nva2nvtruc7','189.236.118.1','2014-05-12','20:08:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (91,'3ij2dlkhr2u7mtpt2aqauqvgg0','189.236.118.1','2014-05-13','10:00:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (92,'lhu69g8r7rtaa5e9a5um9omp52','189.236.128.92','2014-05-13','20:59:03',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (93,'lhu69g8r7rtaa5e9a5um9omp52','189.236.128.92','2014-05-13','20:59:03',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (94,'0g1o626qvlfiee1008p6gdjqp2','189.236.133.137','2014-05-14','10:58:26',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (95,'bo6k3aeul590ivenq8k15okim1','189.236.132.124','2014-05-14','21:16:16',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (96,'bo6k3aeul590ivenq8k15okim1','189.236.132.124','2014-05-14','21:16:16',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (97,'96la0eeh062i862h4u6be3sq96','189.236.132.124','2014-05-15','09:00:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (98,'i7aif8ql4t91nf1vusmnoktvv7','189.236.132.124','2014-05-16','09:01:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (99,'i7aif8ql4t91nf1vusmnoktvv7','189.236.132.124','2014-05-16','09:01:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (100,'072q37gcfbnp3oi8o7nmk7j657','187.143.255.109','2014-05-19','11:34:01',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (101,'kr1mie9ugsv0lg3lg0c8mt8466','187.143.255.109','2014-05-19','11:51:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (102,'kr1mie9ugsv0lg3lg0c8mt8466','187.143.255.109','2014-05-19','11:51:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (103,'f38s0tmbsajsa2v0k95t9vksl7','187.143.255.109','2014-05-19','13:02:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (104,'f38s0tmbsajsa2v0k95t9vksl7','187.143.255.109','2014-05-19','13:02:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (105,'9oq1oo3pa2vrdojk12al4poc25','187.143.160.58','2014-05-20','10:16:11',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (106,'9kb3uprqcsl2n2pa1dmt3p5qj5','187.143.255.109','2014-05-21','09:25:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (107,'26u596keca31vj6hng6f2k15n1','187.143.255.109','2014-05-21','10:35:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (108,'26u596keca31vj6hng6f2k15n1','187.143.255.109','2014-05-21','10:35:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (109,'98695q683hulh921no2guta0o7','189.236.115.45','2014-05-23','17:43:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (110,'k98ricc928dv9vi55olvdoooe4','189.236.115.45','2014-05-23','21:43:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (111,'ofv7at4mof0mr2460jkp7b2dj0','189.133.5.201','2014-05-27','09:39:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (112,'6atgnl2fg74e64bb4dqik9egm1','189.133.5.201','2014-05-27','18:24:19',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (113,'lpe5ft2bvlkrl8cca4l9jjgiq5','200.77.71.161','2014-05-28','08:49:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (114,'3beh0v1b9a901k4ocuhe3rbp45','187.143.250.45','2014-05-28','08:51:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (115,'3beh0v1b9a901k4ocuhe3rbp45','187.143.250.45','2014-05-28','08:51:14',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (116,'5q91go6p82t62h8u2eiffpfsi3','187.143.250.45','2014-05-28','09:37:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (117,'6mbtk70h9aiq0l2bpsjl33te44','187.143.250.45','2014-05-28','20:44:11',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (118,'nhuetkam939ka56d3eu7atuqk6','187.143.250.45','2014-05-28','20:54:40',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (119,'nhuetkam939ka56d3eu7atuqk6','187.143.250.45','2014-05-28','20:54:40',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (120,'pvfudth0c71i0jhkjn9nrm7293','187.143.250.45','2014-05-29','10:51:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (121,'pvfudth0c71i0jhkjn9nrm7293','187.143.250.45','2014-05-29','10:51:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (122,'ig2bcqe5t1fq28e6ug93d5kln2','201.114.237.144','2014-05-30','11:06:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (123,'l3mn86i9ohq8skn1a17s6kvc97','201.114.237.144','2014-05-30','12:05:19',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (124,'6fo5ovb3d41hfik7549o69t931','201.114.206.215','2014-06-02','10:58:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (125,'jrs51av0fglno3iprbjis2e4f2','189.236.52.230','2014-06-04','15:47:32',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (126,'edc334pkhc9ghnd5htm5vrgfl7','189.236.52.230','2014-06-05','09:35:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (127,'edc334pkhc9ghnd5htm5vrgfl7','189.236.52.230','2014-06-05','09:35:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (128,'mstp8on0i7coqju8hokutmdbk7','187.143.235.207','2014-06-07','08:56:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (129,'gpq42ekm345jgbjr3ta2ns3tt2','187.143.235.207','2014-06-07','09:15:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (130,'gpq42ekm345jgbjr3ta2ns3tt2','187.143.235.207','2014-06-07','09:15:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (131,'9acvk7bpdleqiirdd3420gb570','187.143.235.207','2014-06-13','08:10:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (132,'9acvk7bpdleqiirdd3420gb570','187.143.235.207','2014-06-13','08:10:23',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (133,'91pjoju64gpn144lvgr2495gf2','187.143.235.207','2014-06-13','10:40:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (134,'nalbshru69974qicid0lki1u66','187.143.235.207','2014-06-14','17:28:50',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (135,'17pcmaok0j8atosepp994smgq6','187.143.235.207','2014-06-16','11:47:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (136,'j12bqua172ea6g3s7chldbq407','187.143.235.207','2014-06-17','21:42:07',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (137,'j12bqua172ea6g3s7chldbq407','187.143.235.207','2014-06-17','21:42:07',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (138,'ock7q7lhfm9psjn5240r1darn0','187.143.235.207','2014-06-18','07:52:05',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (139,'ock7q7lhfm9psjn5240r1darn0','187.143.235.207','2014-06-18','07:52:05',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (140,'bubkg1nrmptf1pnnp2jqdut5l1','187.143.235.207','2014-06-18','09:50:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (141,'6qqciol0u9rfvclkttb7o6ml07','189.243.136.89','2014-06-19','09:12:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (142,'ikhf2o6ebhe7e9mng4cpcfker1','189.243.136.89','2014-06-19','13:57:40',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (143,'ikhf2o6ebhe7e9mng4cpcfker1','189.243.136.89','2014-06-19','13:57:40',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (144,'rsua5pd4r74nojbk22i46estc4','187.143.239.39','2014-06-23','10:19:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (145,'18ckqkc8j6nrn95v05qau0on00','189.236.112.162','2014-06-25','11:50:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (146,'18ckqkc8j6nrn95v05qau0on00','189.236.112.162','2014-06-25','11:50:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (147,'ak8kj2kjnk36ult5hpsinqufj6','189.236.112.162','2014-06-25','15:10:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (148,'ak8kj2kjnk36ult5hpsinqufj6','189.236.112.162','2014-06-25','15:10:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (149,'fm1i00k6h0beqt846vnip2c8i0','189.236.112.162','2014-06-26','09:12:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (150,'idhsqard5s88t1c6ocotbavj76','189.236.112.162','2014-06-26','10:17:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (151,'ka5gr35b5qs6gdv6u9r3jeka60','189.236.112.162','2014-06-27','09:06:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (152,'nlh7k2b49comd02g7vn73808b7','189.236.112.162','2014-06-27','11:00:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (153,'03eoosb0gqg5vm7cd4omnqqeh3','189.236.112.162','2014-06-28','15:07:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (154,'03eoosb0gqg5vm7cd4omnqqeh3','189.236.112.162','2014-06-28','15:07:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (155,'4fs5cm0hev1nh14b7j7g0rjh00','189.236.112.162','2014-06-30','12:28:07',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (156,'5c4hh93u4947mf8dlbhfmv6sm6','189.236.112.162','2014-07-02','13:13:14',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (157,'5c4hh93u4947mf8dlbhfmv6sm6','189.236.112.162','2014-07-02','13:13:14',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (158,'asoq9s0lchs916eab17drtcoj6','189.236.112.162','2014-07-03','07:33:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (159,'asoq9s0lchs916eab17drtcoj6','189.236.112.162','2014-07-03','07:33:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (160,'r4qaa8bih94jk5qiagu5rffkv7','189.236.180.132','2014-07-05','08:41:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (161,'a2k66taf83scf8k9mjve7qudo1','189.236.180.132','2014-07-05','08:44:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (162,'6b1h13osgia3dt58qd9d8l2if1','187.143.252.101','2014-07-10','17:08:14',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (163,'6b1h13osgia3dt58qd9d8l2if1','187.143.252.101','2014-07-10','17:08:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (164,'arb9cbbpf15p9gv38kgn8fbpt3','187.143.233.32','2014-07-15','14:42:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (165,'arb9cbbpf15p9gv38kgn8fbpt3','187.143.233.32','2014-07-15','14:42:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (166,'pu8tfkujmmunritegn172vdpi0','187.143.233.32','2014-07-15','14:47:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (167,'pu8tfkujmmunritegn172vdpi0','187.143.233.32','2014-07-15','14:47:16',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (168,'3ik76hq5r73pam18hkc4cshs52','187.143.233.32','2014-07-16','09:10:10',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (169,'3ik76hq5r73pam18hkc4cshs52','187.143.233.32','2014-07-16','09:10:11',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (170,'su96dq1iscr3ff7t2gei8fcoe7','187.143.233.32','2014-07-16','11:35:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (171,'su96dq1iscr3ff7t2gei8fcoe7','187.143.233.32','2014-07-16','11:35:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (172,'d0v85jq616pusfjvs67gahei63','187.143.233.32','2014-07-16','11:37:17',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (173,'d0v85jq616pusfjvs67gahei63','187.143.233.32','2014-07-16','11:37:17',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (174,'rjq3121t2ri608d1rcqdom0hd5','189.236.53.73','2014-07-16','20:52:29',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (175,'rjq3121t2ri608d1rcqdom0hd5','189.236.53.73','2014-07-16','20:52:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (176,'77ee61h9268hu3t8crqmuoron5','187.175.99.218','2014-07-19','07:17:03',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (177,'77ee61h9268hu3t8crqmuoron5','187.175.99.218','2014-07-19','07:17:03',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (178,'b43crqclk14fnop984oogm7le6','187.175.99.218','2014-07-21','16:22:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (179,'b43crqclk14fnop984oogm7le6','187.175.99.218','2014-07-21','16:22:23',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (180,'e7j5rc7i675bbm2tnatsp522j2','187.175.99.218','2014-07-21','16:41:10',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (181,'e7j5rc7i675bbm2tnatsp522j2','187.175.99.218','2014-07-21','16:41:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (182,'13vcvmbo45t6i8ko08bpctah86','187.175.94.215','2014-07-25','15:15:38',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (183,'13vcvmbo45t6i8ko08bpctah86','187.175.94.215','2014-07-25','15:15:38',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (184,'rk0tghcmbfog7c52ick877ah62','187.175.94.215','2014-07-25','17:44:58',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (185,'bdo0k2q24qf58cigoirrhfqkm2','189.133.12.70','2014-07-26','11:54:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (186,'h0lkbnmmqcicar606e27biaoi7','187.143.149.153','2014-07-26','12:32:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (187,'dmu3tgidrmdbvfaaooemd4bq32','187.143.231.26','2014-07-27','19:46:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (188,'dmu3tgidrmdbvfaaooemd4bq32','187.143.231.26','2014-07-27','19:46:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (189,'4q6dqr5n17vb37jnmke2pgpc30','187.143.231.26','2014-07-28','09:50:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (190,'d1gm2kaf28q6hr9qho0e557r94','187.143.231.26','2014-07-28','13:07:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (191,'d1gm2kaf28q6hr9qho0e557r94','187.143.231.26','2014-07-28','13:07:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (192,'ua77dc8mqlaqbkr075l470t4m4','189.236.119.103','2014-07-29','13:55:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (193,'1g3i1p6csi8uo1psuqk711naf1','189.236.119.103','2014-07-30','17:38:45',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (194,'rob5rq9klkotodo7r0gm4neqj5','189.236.119.103','2014-07-31','08:54:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (195,'rob5rq9klkotodo7r0gm4neqj5','189.236.119.103','2014-07-31','08:54:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (196,'mpd4qocnmbfokt13tgjt7nj7a0','187.143.252.217','2014-08-06','09:01:11',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (197,'k3g4e0iev18ognvb0qpa2ip4n4','187.143.252.217','2014-08-07','12:17:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (198,'bk501gmjo86mbitkquh2u41mm4','187.143.252.217','2014-08-07','14:51:44',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (199,'mru8qd73ekc1405pnjp94v9lf0','189.133.6.213','2014-08-12','10:40:14',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (200,'uer4b8d1pcg2i4oubhnkitonn1','189.133.6.213','2014-08-12','10:42:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (201,'eloplalr3sp0eqsv7n3m2bqdc5','189.133.6.213','2014-08-20','13:52:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (202,'89g8r20c1se78un4h80paq5td4','189.133.6.213','2014-08-20','14:06:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (203,'89g8r20c1se78un4h80paq5td4','189.133.6.213','2014-08-20','14:06:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (204,'un06d90sbfs9a9ivn22c3c5ip1','189.133.6.213','2014-08-20','14:08:46',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (205,'un06d90sbfs9a9ivn22c3c5ip1','189.133.6.213','2014-08-20','14:08:46',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (206,'ibhrr8qvhrcahkaddn59r1vg25','189.133.6.213','2014-08-20','14:40:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (207,'atacaas1roor0dcetfpba2psc2','187.143.224.150','2014-08-21','16:32:35',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (208,'qfpi1ftkbddrheeaac8s9f81b3','187.143.224.150','2014-08-21','16:38:40',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (209,'c9j5oqi0d74ovqop09mvlv6cs5','187.175.11.224','2014-08-22','15:53:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (210,'c9j5oqi0d74ovqop09mvlv6cs5','187.175.11.224','2014-08-22','15:53:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (211,'lsrf8atu5bo90086hbfrap4io3','187.143.139.243','2014-08-25','18:38:48',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (212,'mjk6aqq2telgj6g2kkosm7jml4','189.236.117.141','2014-08-26','08:05:05',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (213,'ejl66ru2cvt5m58ltp4mm2ai64','189.236.113.181','2014-08-30','09:54:27',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (214,'u4mk7dkq5g13p5mnb1gp57qkd7','189.236.113.181','2014-08-30','10:05:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (215,'n29kvjae1c7ef9en9nlv16cb61','189.236.113.181','2014-08-30','15:24:08',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (216,'3shhbk5gufd5qnoi2n0kfnpqb1','189.133.13.165','2014-09-03','15:32:10',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (217,'3shhbk5gufd5qnoi2n0kfnpqb1','189.133.13.165','2014-09-03','15:32:10',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (218,'t5p0ssl78jeajns9418pgd9504','189.236.181.233','2014-09-04','08:55:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (219,'t5p0ssl78jeajns9418pgd9504','189.236.181.233','2014-09-04','08:55:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (220,'cm6e6vkdfo3c3ecthv08ufdjg3','187.143.167.184','2014-09-06','12:09:40',1);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (221,'cm6e6vkdfo3c3ecthv08ufdjg3','187.143.167.184','2014-09-06','12:10:07',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (222,'a7rqcin6mv7a0g0orgr6b1b3r6','189.236.181.233','2014-09-06','13:47:46',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (223,'a7rqcin6mv7a0g0orgr6b1b3r6','189.236.181.233','2014-09-06','13:47:46',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (224,'4vnugedvitndo35ktvl3kejg46','189.236.181.233','2014-09-09','10:46:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (225,'4vnugedvitndo35ktvl3kejg46','189.236.181.233','2014-09-09','10:46:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (226,'40sglnl164gn1ujjt5toqlrm21','189.236.181.233','2014-09-09','10:52:58',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (227,'dq12cd92fu916aoklvo3u29f92','189.236.181.233','2014-09-10','09:34:52',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (228,'ft79flhkp9oijg8h7l5l4pqvj1','189.133.3.108','2014-09-18','09:28:03',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (229,'ft79flhkp9oijg8h7l5l4pqvj1','189.133.3.108','2014-09-18','09:28:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (230,'2blujjglp9j2eg3pkdp9gqhac4','189.236.131.215','2014-09-19','11:32:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (231,'dm6o4aiitoukua2nrbu5feqng6','189.236.131.215','2014-09-24','10:07:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (232,'aam011pa6mbq8m3ar25q4fun27','189.236.131.215','2014-09-24','11:39:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (233,'pkssq49n8cdctmjrrnc332c3f4','189.236.131.215','2014-09-24','13:08:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (234,'ep4eutdf551pc87b252gtajqb5','189.236.131.215','2014-09-24','14:25:35',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (235,'uf3hea01t1l4n5ancjkl13v320','189.236.131.215','2014-09-24','14:39:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (236,'8cjsdnlkkn3uhuf41mn1f73li1','189.236.131.215','2014-09-24','17:10:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (237,'nl68dd4satjne7c0o3h5ei61i4','189.236.131.215','2014-09-25','05:15:32',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (238,'220s51lvu0hftalhr5ob74rct3','187.135.200.148','2014-09-30','07:53:22',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (239,'ge756oh3v2ptgbi1jnaggmbnj6','201.114.236.35','2014-10-06','15:37:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (240,'do3np22tm9cvhgrbumkp0771s0','201.114.236.35','2014-10-09','09:56:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (241,'tqkrf5ul3q0b5mka6ei16o4733','201.114.236.35','2014-10-22','13:22:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (242,'tnppb2h2ebdrk3ognommiohf31','189.236.130.36','2014-10-29','12:01:18',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (243,'tt3i0eh2aa18eo0913p8u5a8l2','189.236.130.36','2014-10-29','13:13:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (244,'tjhr31apgag0ic66gqjubdcgd4','189.236.130.36','2014-10-29','15:14:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (245,'hligsh7di074dk25fqnf9roj23','189.236.130.36','2014-10-29','16:58:18',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (246,'0fl3s9lfcgd0u4jq7s0pljdns1','189.236.130.36','2014-10-30','08:58:38',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (247,'51m4i1o73qc9q8fd98gpv58783','189.236.130.36','2014-11-01','08:50:17',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (248,'u08kliu589hdip10rspnn74ug4','189.236.130.36','2014-11-01','10:59:08',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (249,'sejm6iuhod44tda6vst18ekjr2','189.236.130.36','2014-11-06','09:12:05',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (250,'m3g2k8sqe3pc9qa699ovapj6h3','189.236.130.36','2014-11-07','10:15:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (251,'8ktmugim9oua3dftplcgbluh32','201.114.159.210','2014-11-08','10:18:30',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (252,'r1lnlupdncm6t4eu2hngmrcch4','187.175.17.215','2014-11-08','13:12:48',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (253,'s8atjbnmtc2d2i42rnah9v8fm5','189.236.130.36','2014-11-08','19:15:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (254,'s8atjbnmtc2d2i42rnah9v8fm5','189.236.130.36','2014-11-08','19:15:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (255,'n6a94umef335mqjfipje64j8g7','189.236.130.36','2014-11-10','11:41:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (256,'8ktmugim9oua3dftplcgbluh32','201.114.144.177','2014-11-11','12:24:11',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (257,'8ktmugim9oua3dftplcgbluh32','201.114.144.177','2014-11-11','13:46:11',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (258,'34cuif3tv9b6itugecr8bks8h5','189.236.130.36','2014-11-12','11:00:35',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (259,'mnj5epcl33ejfq93fgukm4gmh3','189.236.130.36','2014-11-12','11:09:34',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (260,'8ktmugim9oua3dftplcgbluh32','201.114.144.177','2014-11-14','14:30:17',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (261,'nf09h89pft3m1c6ruho3tk3rc6','189.236.130.36','2014-11-18','12:04:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (262,'rqvhpksl6jg055mc2d4cb2j2n2','189.236.113.119','2014-11-22','15:11:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (263,'kfpm3pctptv878co6e7kp7oin5','189.236.113.119','2014-11-25','09:35:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (264,'3gmms0bh7f02j18pn8el648vs0','189.236.113.119','2014-11-25','17:41:17',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (265,'mbep5l214hldj30h7afqfk5mo7','189.236.113.119','2014-11-27','13:01:45',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (266,'bbh8g4e5ssvml7hvrt3urjd440','189.236.113.119','2014-11-27','15:22:54',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (267,'h3b6kjo08rjomjdt49mf7ikfq5','189.236.180.8','2014-12-03','10:45:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (268,'3p68hrv99fvcna5vb8gel9b1e4','189.236.180.8','2014-12-04','12:46:34',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (269,'lge5gc5hjdqfpb638m8vj9d245','189.236.180.8','2014-12-04','18:10:38',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (270,'2kuba9oubrtgcb0n1pqprrqrc4','189.236.180.8','2014-12-08','13:34:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (271,'uqkkb7tbarhpqgiv42oo8t0rm2','189.236.180.8','2014-12-08','13:41:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (272,'refaj4nq2bf21gb2pvm8tivo80','189.236.180.8','2014-12-08','13:47:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (273,'67384g1e6n5t6glsamao0slfj6','189.236.180.8','2014-12-11','12:14:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (274,'ugvk1bi231ir0mt1n4pc0on5u6','189.236.180.8','2014-12-15','12:13:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (275,'hcemnpfrhdmb6jo83jj4b6qm56','187.143.231.34','2014-12-16','18:18:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (276,'qqal1rnilgmenvar0c6bo4mt83','187.143.231.34','2014-12-17','10:56:46',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (277,'hpvjpmmkoqniqa9au0uvhoh2j0','10.71.134.96','2014-12-23','09:06:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (278,'k7m50um1nkbiohtp0vi8te42p6','187.143.231.34','2014-12-23','12:49:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (279,'k7m50um1nkbiohtp0vi8te42p6','187.143.231.34','2014-12-23','12:49:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (280,'esr8sdd1qqig1shl3sdaib6ec2','189.236.54.9','2014-12-31','11:25:38',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (281,'iom1mq982og6h0kf5k9pr74qq5','189.236.133.237','2015-01-06','08:44:11',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (282,'6ov5a0gmiq2hdjahlg0bi74a72','187.189.46.63','2015-01-12','14:51:31',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (283,'l4hpm6bk6sb8pt2nt2067qhs67','189.236.54.69','2015-01-12','19:28:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (284,'31l9tfit61eh2ujqkq5j9gp7m7','189.236.54.69','2015-01-13','10:08:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (285,'31l9tfit61eh2ujqkq5j9gp7m7','189.236.54.69','2015-01-13','10:08:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (286,'hafjr1ld2bqbba77umod2pl5p3','189.236.54.69','2015-01-13','12:00:11',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (287,'atccju78063lbf66ejgs964hl1','189.236.54.69','2015-01-13','12:27:07',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (288,'mfneriikvhidjmfojv96jrsr42','187.189.46.63','2015-01-14','10:16:48',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (289,'g4aatasda9gfkljb0hajmghqr7','187.135.176.159','2015-01-16','10:57:00',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (290,'dku23m4tej1d06d5c88nmq5kc4','187.135.176.159','2015-01-20','11:20:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (291,'jpcb1t45kgga1dhsb8mnitt5k6','187.189.46.63','2015-01-20','17:02:48',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (292,'jpcb1t45kgga1dhsb8mnitt5k6','187.189.46.63','2015-01-20','17:13:47',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (293,'l3g63vb2uihg6n9ml5mi3he332','189.132.148.173','2015-01-21','18:45:40',16);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (294,'08pbpor5qcce2geik1vavulpg2','187.135.176.159','2015-01-22','09:28:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (295,'08pbpor5qcce2geik1vavulpg2','187.135.176.159','2015-01-22','09:28:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (296,'cv8cq09lm1ruj0e581vfv0ns40','187.135.176.159','2015-01-24','15:38:24',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (297,'9d4coj1deanu433lui9jv3cjv0','187.175.11.246','2015-02-02','09:31:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (298,'dk8j4kamiq5dkudhjraloqa9h6','187.175.11.246','2015-02-03','10:17:54',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (299,'ha8495k2tgmak6glp1vlntu475','187.175.11.246','2015-02-04','15:15:00',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (300,'7b23ts53dauhaf9kk6644b13s0','187.175.11.246','2015-02-05','11:07:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (301,'7b23ts53dauhaf9kk6644b13s0','187.175.11.246','2015-02-05','11:07:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (302,'qf1r4tisbqblt7q9kglop5l2t7','187.189.46.63','2015-02-05','14:03:06',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (303,'qf1r4tisbqblt7q9kglop5l2t7','187.189.46.63','2015-02-05','14:16:08',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (304,'lgtjcqqh1p565srekdd8m3of57','187.175.11.246','2015-02-05','15:11:38',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (305,'qf1r4tisbqblt7q9kglop5l2t7','187.189.46.63','2015-02-06','07:52:54',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (306,'qf1r4tisbqblt7q9kglop5l2t7','187.189.46.63','2015-02-06','07:56:05',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (307,'8v8b7h1ich02vmvmmt45s347i6','187.175.11.246','2015-02-06','12:50:46',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (308,'6l2aatrphj0k0093ao2ho5l0r0','187.143.110.11','2015-02-06','16:15:39',18);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (309,'1c5kbfarssrum2309qrq4f82n7','189.243.136.136','2015-02-11','08:51:29',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (310,'1c5kbfarssrum2309qrq4f82n7','189.243.136.136','2015-02-11','08:51:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (311,'0c5v9khc9ci20p8leq0h25ooc2','189.243.136.136','2015-02-11','09:06:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (312,'0c5v9khc9ci20p8leq0h25ooc2','189.243.136.136','2015-02-11','09:06:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (313,'qgcfoinkh7l6sqjnm0pv2t9125','189.243.136.136','2015-02-11','10:49:26',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (314,'ghoe83tofsf1n3vhrjm89e5g50','189.243.136.136','2015-02-18','11:44:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (315,'ghoe83tofsf1n3vhrjm89e5g50','189.243.136.136','2015-02-18','11:44:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (316,'o6qeq5mv1jvt4dbsvgau1dlo27','189.243.136.136','2015-02-18','12:07:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (317,'o6qeq5mv1jvt4dbsvgau1dlo27','189.243.136.136','2015-02-18','12:07:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (318,'qihktpu05evmq30qpvs6jqr9m1','189.243.136.136','2015-02-25','10:47:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (319,'dmmsr1qclv1pp3gau4dduc24h6','189.243.136.136','2015-02-26','12:57:44',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (320,'fm00fa5hot45n34ij2sl8p6sg7','189.243.136.136','2015-02-27','18:20:34',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (321,'t8hbebi040oorvh2o5ui6b5rg3','189.243.136.136','2015-02-27','18:36:26',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (322,'t8hbebi040oorvh2o5ui6b5rg3','189.243.136.136','2015-02-27','18:36:26',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (323,'q2rifo8iqn0htr13r2o85upjc5','189.243.136.136','2015-03-05','08:49:01',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (324,'iqgh5321tcmfbuud2r44a2vsc6','189.243.136.136','2015-03-11','12:36:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (325,'v462qarb02vfo07q38l113tee2','189.243.136.136','2015-03-17','17:06:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (326,'l8ptosoub6vlfeuf38nll38ta2','189.243.136.136','2015-03-19','08:58:14',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (327,'mbmu8ieelik24fpc8iujiibt36','189.243.136.136','2015-03-21','11:51:50',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (328,'1ohkuk8vgpdniruds8ras2ptl3','189.243.136.136','2015-03-24','10:17:33',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (329,'pg20surchidddjk55egcbl4l61','200.77.68.58','2015-03-25','22:57:20',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (330,'72r15ouehia7d8dr6ud0skmm47','189.243.136.136','2015-03-26','13:34:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (331,'35cll10qjh4kc1h7csn9blavd7','187.143.236.3','2015-04-01','18:18:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (332,'s37po9pbj0oltjrjudg1ojuic2','201.114.208.127','2015-04-06','08:54:14',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (333,'s37po9pbj0oltjrjudg1ojuic2','201.114.208.127','2015-04-06','08:56:30',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (334,'s37po9pbj0oltjrjudg1ojuic2','201.114.208.127','2015-04-06','08:56:31',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (335,'s37po9pbj0oltjrjudg1ojuic2','201.114.208.127','2015-04-06','08:56:46',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (336,'s37po9pbj0oltjrjudg1ojuic2','201.114.208.127','2015-04-06','08:56:47',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (337,'s37po9pbj0oltjrjudg1ojuic2','201.114.208.127','2015-04-06','08:57:09',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (338,'umq0ukicdjt4m9ct4ujcdp4p16','201.114.208.127','2015-04-06','09:01:11',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (339,'3r90fd8a9s1ceeju120i0t02q2','187.143.236.3','2015-04-08','08:35:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (340,'goippn2ub4p7057eui0mliad60','189.236.181.181','2015-04-09','16:33:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (341,'d02689vip1th1hsi5ng82a2c80','189.236.181.181','2015-04-10','17:34:41',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (342,'5er5hethg7annj22c7jf6vgrr1','189.236.181.181','2015-04-11','10:06:52',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (343,'8higavja4ltfkbc1r9emh228k1','189.236.181.181','2015-04-11','11:51:33',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (344,'b4jjnn8rbltb4adfnmcntqgcd0','200.77.68.58','2015-04-12','08:57:17',1);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (345,'b94ls0v72mu50r8iprvk5q3bf0','189.236.181.181','2015-04-13','14:06:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (346,'fv8896noc0orptmo0nf3n5rej4','187.135.198.207','2015-04-14','14:20:57',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (347,'fv8896noc0orptmo0nf3n5rej4','187.135.198.207','2015-04-14','14:21:31',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (348,'fv8896noc0orptmo0nf3n5rej4','187.135.198.207','2015-04-14','14:22:24',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (349,'fv8896noc0orptmo0nf3n5rej4','187.135.198.207','2015-04-14','14:23:02',22);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (350,'k99q4hhfuifaeiaq4f344kdgn2','189.236.181.181','2015-04-15','06:59:03',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (351,'7g7d9qrtkt2uds18i08mrq1852','189.236.181.181','2015-04-15','07:02:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (352,'k1s4c86vsn4jv61u47ttprspp3','189.236.181.181','2015-04-15','07:04:03',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (353,'dn1fjb4626odjkk630n7a8e4q3','189.236.181.181','2015-04-18','21:10:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (354,'d966dcqb8ip33i56csutruh2n4','189.236.181.181','2015-04-20','11:15:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (355,'jedrjnmr4eq56rkqnk63manuc0','189.236.181.181','2015-04-20','11:16:59',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (356,'6bq3oedvfkmmcu4tu1eq8c7f77','189.236.181.181','2015-04-23','08:24:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (357,'if5ldlf4v5ni1rluftrum2vt06','189.236.181.181','2015-04-23','08:31:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (358,'lj1si8a062vq2o3i6dppmq5n94','189.236.181.181','2015-04-23','11:52:35',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (359,'a0qq0fao3ijpjbh59051atqeu4','189.236.181.181','2015-04-25','09:36:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (360,'4nc1rvcjf1t9kd1e0q3ikj9756','189.236.181.181','2015-04-25','09:48:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (361,'ccdoqccd36ehtv5adoemrkq991','189.236.181.181','2015-04-28','18:26:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (362,'kj1dpd7utnmf7bprochrmb4rm4','189.236.181.181','2015-04-29','08:55:33',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (363,'kj1dpd7utnmf7bprochrmb4rm4','189.236.181.181','2015-04-29','08:55:34',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (364,'3i93t28kkvs93eb6dhm0k5htn4','189.236.181.181','2015-04-29','09:12:54',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (365,'3i93t28kkvs93eb6dhm0k5htn4','189.236.181.181','2015-04-29','09:12:54',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (366,'png92ejk9dg38lvo895aekbja7','189.236.181.181','2015-04-30','10:09:29',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (367,'i9bqf8rd8orgln2fsvlandnnj4','189.236.181.181','2015-05-06','10:06:28',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (368,'d5o3po8p3t3d59uoinksurdih5','189.236.181.181','2015-05-06','10:10:52',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (369,'r9f3obb658sa6mstiusufq9km5','189.236.181.181','2015-05-07','18:13:27',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (370,'0acacli5ku1k8khs8s80dhmla5','187.242.224.239','2015-05-08','11:38:26',6);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (371,'2jjmoe92sn6knqeksa7g2er6i4','189.236.112.194','2015-05-14','16:15:45',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (372,'jo8n3o77f9qeu6d8ogp0g83656','189.236.55.166','2015-05-16','21:13:26',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (373,'qa4852seh935ovu6k9q4cqjvh1','189.236.55.166','2015-05-16','21:16:24',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (374,'dbgm3ms98atl3v5mfudenm2h46','189.236.55.166','2015-05-20','14:26:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (375,'3pes6rco7u9que0bgnj3vithf7','189.236.55.166','2015-05-22','10:50:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (376,'5v6kbblac4tah44er30rfbulf5','189.236.55.166','2015-05-22','16:14:23',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (377,'91cg367mbkjcs91qgprtijpvi2','187.143.243.18','2015-05-24','19:21:23',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (378,'ukvsgj1o5c302c8h9hja30nqt0','187.143.243.18','2015-05-25','21:48:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (379,'tp4qmuki2svrj0g50at3jmcrt5','187.143.243.18','2015-05-26','09:44:52',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (380,'plh1rg5gsoigvdotlpnubl6510','187.143.243.18','2015-05-26','10:00:45',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (381,'7aooe956jvr8nun3guokj20qq5','187.143.243.18','2015-05-26','10:10:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (382,'7aooe956jvr8nun3guokj20qq5','187.143.243.18','2015-05-26','10:10:32',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (383,'ki28bige5afk6ho6j0jn53pi13','187.143.243.18','2015-05-26','10:13:17',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (384,'04d7da7jd6fm68f919mnls2ra6','187.143.243.18','2015-05-26','19:23:38',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (385,'1rhafm1971u2i5etb7bba3n4d6','189.236.48.129','2015-06-04','10:31:55',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (386,'4ttjvevlm1iev83nuu7ohdchv2','189.236.115.231','2015-06-10','16:09:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (387,'vbnpgmrlbaqn4h2tbr1lfaeh30','189.236.131.57','2015-06-12','08:11:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (388,'7frc7kc8icqs7fr7c0s6k3ued6','189.236.131.57','2015-06-12','11:33:24',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (389,'g31vd86tti24kl49bgqnui8kk3','189.133.11.30','2015-06-13','14:31:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (390,'sq9ncqesm2418srhpngoqhle60','189.133.11.30','2015-06-16','10:37:16',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (391,'r5o3e7cve6lr9i416i483v2il5','189.133.11.30','2015-06-18','15:03:32',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (392,'si8n8lcj2bhnmq9s7pnubmv1q7','187.143.230.75','2015-06-22','09:17:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (393,'v90khr9m69btds3dlbijhot4t3','189.236.49.46','2015-06-23','15:02:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (394,'co34vtl56c3s4kjpptgrpqu3b2','187.143.228.213','2015-06-25','10:48:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (395,'j8jtsl96pagjvernjkpq6oaa74','187.143.230.56','2015-06-26','18:29:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (396,'4ra9qkii40bkvpk948b5ree370','187.143.230.253','2015-07-02','10:14:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (397,'r59801egk96te8kn3qnjd5aii5','187.143.230.253','2015-07-02','10:20:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (398,'q15q5do0vealdoao0apgsmhct1','187.143.238.118','2015-07-05','18:42:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (399,'f7stuqfoq3n49245u188t9kk86','201.114.238.117','2015-07-07','09:20:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (400,'mtj9nqquigrp3bd3r9902n9v87','201.114.238.117','2015-07-07','10:00:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (401,'jjidk0999ook88mjidj9h46pp2','200.68.137.207','2015-07-10','07:47:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (402,'jjidk0999ook88mjidj9h46pp2','189.133.0.48','2015-07-10','15:40:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (403,'tvvl4mdtks9l6ak6mqf92p4ek2','189.133.2.251','2015-07-22','09:52:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (404,'tvvl4mdtks9l6ak6mqf92p4ek2','189.133.2.251','2015-07-22','09:54:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (405,'tvvl4mdtks9l6ak6mqf92p4ek2','189.133.2.251','2015-07-22','09:54:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (406,'tvvl4mdtks9l6ak6mqf92p4ek2','189.133.2.251','2015-07-22','09:56:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (407,'1q99p0anvepactuka83bvarmo4','189.133.2.251','2015-07-22','14:33:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (408,'gc2ckch1fotramt81ukj99cvi1','189.133.2.251','2015-07-22','14:39:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (409,'uje0scdb4nb0dqal0effrpmqu5','189.133.2.251','2015-07-23','20:49:29',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (410,'492nd15fgestmho616oi48aou6','187.143.225.13','2015-07-24','21:40:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (411,'57fv5i870fin96p3178q96pds4','187.143.225.13','2015-07-25','09:53:16',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (412,'r071m4d6ubpagk0jgr71hedfo1','187.143.225.13','2015-07-25','10:01:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (413,'57fv5i870fin96p3178q96pds4','187.143.225.13','2015-07-25','11:32:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (414,'r071m4d6ubpagk0jgr71hedfo1','187.143.225.13','2015-07-25','11:36:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (415,'lalc4ndiiglq05g6vehr6284u3','189.243.136.43','2015-07-27','08:56:27',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (416,'jto7n90vh38s37hdt1tujm5434','189.243.136.43','2015-07-27','09:40:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (417,'5e1q8jm3bodlg42qg9g6fbe486','189.132.118.39','2015-08-06','06:01:05',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (418,'q03rc1pdt16ms2s99f0g24gm76','189.132.118.39','2015-08-11','16:16:40',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (419,'i49m515jj33iqdcuuder5ihon5','189.132.118.39','2015-08-14','12:11:24',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (420,'i49m515jj33iqdcuuder5ihon5','189.132.118.39','2015-08-14','12:15:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (421,'3u0dgsr90775nb39kbgnpgj2m2','189.132.118.39','2015-08-14','12:56:05',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (422,'48lsmkmu0hnmk1j0qlakk9d6l0','189.132.118.39','2015-08-14','14:50:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (423,'i49m515jj33iqdcuuder5ihon5','189.132.118.39','2015-08-14','14:54:16',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (424,'67uaclf9deiq6bu8p0tu1ium45','189.132.118.39','2015-08-16','11:00:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (425,'693l8mrce3au3pkngidutfi9c6','189.132.146.195','2015-08-18','21:01:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (426,'9g7fp5tis7prktd60g83jhusi2','189.132.174.142','2015-08-25','13:43:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (427,'u44padcq6asimlb6vum8sqbdo4','189.132.119.35','2015-08-26','11:18:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (428,'u9vbdje72ac3bi6re6mkv7din7','189.132.218.64','2015-08-31','12:06:00',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (429,'3bnmj09c7h4kop3a8uvvd76280','189.132.218.64','2015-08-31','12:10:41',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (430,'njekuute5sjietqun92vmjhsj2','189.132.218.64','2015-08-31','12:11:11',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (431,'3hnje42tnaiaomqv477fevbos0','189.132.218.64','2015-08-31','12:16:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (432,'k6felm6ald5m1di8iuvgb0r1u1','177.231.226.248','2015-08-31','12:31:59',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (433,'njekuute5sjietqun92vmjhsj2','189.132.218.64','2015-08-31','13:01:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (434,'6597vqoaa8cgpvmartqhk7lt21','189.132.218.64','2015-08-31','21:13:54',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (435,'3bjbgafjl9ndauqf9kr5mj07p5','189.132.218.64','2015-09-01','10:20:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (436,'l3fdnsejmihrc3n0of8gjsjvb0','187.242.224.239','2015-09-04','09:14:29',6);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (437,'l3fdnsejmihrc3n0of8gjsjvb0','187.242.224.239','2015-09-04','09:15:01',6);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (438,'tg0tt986pi3k4nmqp08o2dr5b5','189.132.157.68','2015-09-10','21:46:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (439,'nsq9vrt21fr4sdg5b9ho9b0184','189.132.212.214','2015-09-21','16:31:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (440,'5tvl54s7c01mi940pjhi5gi4v7','189.132.212.214','2015-09-21','16:41:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (441,'9tq96v2ce7h668346jpsfef8c5','189.132.212.214','2015-09-22','15:16:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (442,'famav423i3gnkl2snn21j47al5','189.132.212.214','2015-09-24','17:20:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (443,'rkmnq08qu82tr8ua6r0dole781','189.132.212.214','2015-09-29','14:41:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (444,'vaki0lsq7ri7p2er7r40mn87o7','189.132.212.214','2015-09-30','17:55:14',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (445,'bctgtper4sh81v5p0566onh950','189.132.212.214','2015-09-30','17:59:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (446,'6rfp0kt1k6a4bggthmf3cctvl7','189.132.212.214','2015-10-02','10:44:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (447,'mlgslvpgj8pu3lnil81e0moef6','189.132.212.214','2015-10-02','10:51:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (448,'9jrt01bomjmi0mdu247te677q6','189.132.212.214','2015-10-03','08:46:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (449,'rd0g4k0e66ak1bmgvs6d9h8m47','189.132.212.214','2015-10-03','08:47:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (450,'k75kme0hj14g0jkencp8ac8el7','189.132.220.135','2015-10-13','09:29:10',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (451,'vluai8823knqbh4kvki1kvv253','189.132.187.190','2015-10-15','15:43:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (452,'h8r9nrve4ude68r5aehder6bg0','189.132.187.190','2015-10-17','14:48:07',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (453,'h8r9nrve4ude68r5aehder6bg0','189.132.187.190','2015-10-17','14:51:01',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (454,'dt2lnv5f4g2r0mhoes9eceq4d4','189.132.222.255','2015-10-19','11:10:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (455,'k5kk9504cchonbhi8rpnfl46g4','189.132.222.255','2015-10-21','10:21:07',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (456,'ogv26h61fcnfg2go5g0md2c512','189.132.222.255','2015-10-22','11:14:05',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (457,'cnp9ov0s7kvab089bnstu8ibr2','189.132.222.255','2015-10-22','16:46:08',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (458,'67mfgu5iobf1mpmi4knqcfd4u7','189.132.222.255','2015-10-22','16:52:07',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (459,'7k601t9v0o61t1kn6v6462d656','189.132.222.255','2015-10-22','16:54:41',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (460,'0n722neh999uoi7b9ujcpfn1v1','189.132.222.255','2015-10-22','16:59:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (461,'qlq1rpsckddutb6reh78ak0g05','189.132.222.255','2015-10-24','10:23:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (462,'k3ct9tgk6puoevoj3lgac46ug2','189.132.176.167','2015-10-29','10:20:00',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (463,'i611s0ghqk2coma2gb41r5ake6','189.132.163.100','2015-11-03','13:30:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (464,'p4hq6adpgeldajmbpbhf6ddnq1','189.132.184.204','2015-11-05','09:44:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (465,'5q6p0t5encomjjvue6d0ntj2r2','189.132.150.36','2015-11-12','08:35:27',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (466,'trb4h2m07use31b0qm80elkoc4','189.132.150.36','2015-11-12','09:32:28',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (467,'e0rfbevaolnn280jn45uqgeid7','189.132.183.165','2015-11-15','09:21:18',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (468,'74p3rk77ssgvs0176fvk8ecm85','189.132.183.165','2015-11-17','21:40:25',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (469,'blstrtmb6ha3lekd3met06e4t3','189.132.183.165','2015-11-18','22:48:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (470,'cem1pfjfj4hp1o5h343m8ocvo3','189.132.183.165','2015-11-20','12:04:32',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (471,'jvgoo4l7c0vt5o90fov6e2qoj0','189.132.207.139','2015-11-25','13:37:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (472,'u978fvap53mlqnf3m3gc3i87p5','189.132.207.139','2015-11-25','13:39:09',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (473,'gajfuvjmsqr6lailkfiuua4373','189.132.207.139','2015-11-26','11:47:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (474,'p1amict331mguaadperjlftse1','189.132.200.8','2015-11-30','16:53:26',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (475,'r9i9no6rkctfuitel6gm9ptt12','189.132.200.8','2015-12-03','11:38:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (476,'jp900gl48k135kg44hq3q7ajl0','187.242.145.160','2015-12-03','16:15:13',6);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (477,'eea6oveea37tpfb4epg1eol0e6','189.132.200.8','2015-12-08','10:23:45',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (478,'ooksv0kugouon2eqft9nlba1e6','189.132.176.111','2015-12-17','20:26:39',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (479,'ufklg658p6oblmfmh5rt5tjkm2','189.132.176.111','2015-12-22','17:27:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (480,'723glh0gnf3i33c8pvbtm2ohq1','189.132.176.111','2015-12-23','14:00:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (481,'hl2795ou3hlkseglse82e01g14','189.132.176.111','2015-12-24','15:53:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (482,'hl2795ou3hlkseglse82e01g14','189.132.176.111','2015-12-24','15:55:45',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (483,'c3f91emsh4a4pkknmalb78ueq2','189.132.124.139','2015-12-29','16:37:16',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (484,'8vjdumfg2doo7soehin6lumnf0','189.132.124.139','2015-12-29','16:40:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (485,'678n4vtslp7jcjf2836p3ic442','189.132.200.37','2016-01-05','11:12:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (486,'uu0t89cu224ckhds6q5k46vu42','189.132.200.37','2016-01-05','11:17:00',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (487,'678n4vtslp7jcjf2836p3ic442','189.132.200.37','2016-01-05','11:22:20',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (488,'vpnrbbdcmpp165ja4r9mi0f094','189.132.200.37','2016-01-05','11:32:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (489,'qrk12o9ic232ree2g6h6u9rr74','189.132.200.37','2016-01-07','10:17:16',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (490,'raq097avu96hojlhc2jh3v4qb5','189.132.200.37','2016-01-08','08:47:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (491,'ptnlgs75e41m0so86k35jg2pv7','189.132.139.45','2016-01-10','14:25:33',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (492,'g2404fsmbnr6ec53lqcedvh7g1','189.132.139.45','2016-01-11','21:18:48',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (493,'f2gf441i8nld0onrclop9u26h1','189.132.139.45','2016-01-15','10:27:01',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (494,'ouubb9jkgaajp0ioojlco0kik7','189.132.139.45','2016-01-15','13:40:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (495,'c4ocptjipub44prpdutsb28bm7','189.132.242.236','2016-01-15','14:13:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (496,'ioe05ot9db15nls1u330fpi7b1','189.132.143.80','2016-01-15','14:23:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (497,'7hjs63739tq1klvcpojv8vc1f4','189.132.138.187','2016-01-21','10:31:22',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (498,'8e5ihtai2q7me84ut4tffifc97','189.132.138.187','2016-01-21','19:09:51',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (499,'0n98tpqhocu5c5fcf64fotmbd3','189.132.138.187','2016-01-21','19:35:27',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (500,'og1bp4devodoq90hmqbbulm891','189.132.133.213','2016-02-13','15:48:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (501,'dj2rue933p9ja7oi6jicvmj0u4','189.132.133.213','2016-02-17','09:57:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (502,'dj2rue933p9ja7oi6jicvmj0u4','189.132.133.213','2016-02-17','10:01:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (503,'uclcbieqnq8tqq7c3hroa4p077','189.132.133.213','2016-02-17','10:38:12',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (504,'npauakilqhmp2r5vmchu2cen87','189.132.133.213','2016-02-19','18:41:18',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (505,'jotm5e0qvk8seefsjbo721uhn3','189.236.62.62','2016-02-22','17:33:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (506,'jotm5e0qvk8seefsjbo721uhn3','189.236.62.62','2016-02-22','17:33:47',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (507,'lp7t52pso2c0246n5e3lbo5kf4','189.132.146.101','2016-02-24','21:29:58',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (508,'h9osbkblefa3d76v0a709n6085','189.132.146.101','2016-02-24','21:48:30',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (509,'en8in0lufjfmatkjqf2c4v48l1','189.132.150.27','2016-02-26','11:22:31',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (510,'qugkgkkjeo81nqlv11e04nqir6','189.132.186.29','2016-02-29','09:34:41',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (511,'9o53noo8i9g7sg73c536nchcd1','187.188.174.25','2016-02-29','19:24:29',1);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (512,'9o53noo8i9g7sg73c536nchcd1','187.188.174.25','2016-02-29','19:24:53',1);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (513,'7mlgn9pqbu3o9kdfn9un8bouj6','189.132.151.6','2016-03-04','13:34:13',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (514,'nbq8erufrctkdbo8mbs6ura3e6','189.236.11.196','2016-03-04','14:04:06',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (515,'o79k8crfrpfp21pgfuhgh5iv30','189.236.11.196','2016-03-05','13:19:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (516,'t7v9jpnao4vsj81k72938hit72','189.236.11.196','2016-03-05','13:38:27',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (517,'cjbttolqcl2hhkkjo5sc1hccu3','189.236.11.196','2016-03-06','16:37:04',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (518,'rp6k8m1l8qivifvj6hvda6elp3','189.236.11.196','2016-03-07','17:44:53',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (519,'iuv3v022mllkiobgk9l0j6frv3','189.236.47.60','2016-03-09','17:07:33',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (520,'eaduaoidb60r3dolnpu2te4dc2','189.236.47.60','2016-03-11','11:33:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (521,'ohe56pn4df36k2luccun7itpb6','189.236.47.60','2016-03-11','15:46:15',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (522,'78hc7tn3e5o853ciglshg44tk3','189.236.47.60','2016-03-12','08:23:37',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (523,'qqstop4d5u3ikad6rfdjhhock6','177.224.34.183','2016-03-17','17:27:57',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (524,'qqstop4d5u3ikad6rfdjhhock6','177.224.34.183','2016-03-17','17:42:37',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (525,'0iifhki6oe1gv30cj4kigongk2','189.236.47.60','2016-03-17','17:57:38',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (526,'59dtseattq8ko3rfsokq18oni4','189.236.221.85','2016-03-17','21:44:12',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (527,'8lbqls806jte8km55qokcvsr04','189.132.183.29','2016-03-18','11:06:26',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (528,'8lbqls806jte8km55qokcvsr04','189.132.183.29','2016-03-18','11:06:37',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (529,'8lbqls806jte8km55qokcvsr04','189.132.183.29','2016-03-18','11:06:40',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (530,'f9vkmnfppmhdkb03ov0s72f0u4','189.236.47.60','2016-03-18','16:15:57',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (531,'ffcdivep2eh09ph55898brm3m0','201.149.249.254','2016-03-19','10:04:20',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (532,'ptj8il1cfad4g97iadigpqfdi4','189.236.221.158','2016-03-19','10:06:40',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (533,'bo4f96bc644ulrlc1io0e6mpo6','201.149.249.254','2016-03-19','10:45:02',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (534,'o9fpvj9auku6hek794er97drp2','189.236.221.158','2016-03-19','11:02:57',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (535,'f5mja7fm5ngbi2o4tuc8ue3g67','189.236.221.158','2016-03-19','11:09:22',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (536,'f5mja7fm5ngbi2o4tuc8ue3g67','189.236.221.158','2016-03-19','11:15:40',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (537,'ahcqchlp3ln865gaq0ognpsjm3','189.151.180.22','2016-03-19','12:18:02',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (538,'pdjjshu4n5e1uhkmg01mmb6i90','201.149.249.254','2016-03-19','12:28:05',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (539,'kugdcpcq47e1dv5fihh41d8933','189.132.169.35','2016-03-19','12:36:51',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (540,'5tds9s69bvvumfp011c2bvjlu4','189.236.221.158','2016-03-19','14:43:21',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (541,'5tds9s69bvvumfp011c2bvjlu4','189.236.221.158','2016-03-19','14:43:57',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (542,'5tds9s69bvvumfp011c2bvjlu4','189.236.221.158','2016-03-19','14:45:18',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (543,'i1u0cafjtf800e6i12ouibvr14','189.236.47.60','2016-03-28','17:32:21',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (544,'ovu2n9dt32ehvr0gjjtp1pblv5','189.132.184.226','2016-03-29','16:41:54',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (545,'c9olouppj1op05bkg6gva4bhj5','189.132.190.152','2016-04-01','07:55:02',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (546,'0b25p7e868dj46950t73im3b52','189.132.190.152','2016-04-01','12:06:35',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (547,'3ppidl9hg0s7shu9iqo8cqpir6','189.132.167.125','2016-04-04','13:14:56',29);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (548,'okcn9a3c5dbj97qm68vapafqf4','189.132.190.152','2016-04-04','18:29:43',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (549,'fv0lbdjcobidv4j3j6c2fv9e37','189.132.190.152','2016-04-05','10:15:18',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (550,'hnqroa795mkc2vvq5q9depquj4','189.132.190.152','2016-04-05','13:53:36',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (551,'bpnjr4itq7rqqh0jk2g6o94lp5','189.151.245.108','2016-04-05','14:23:47',30);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (552,'bpnjr4itq7rqqh0jk2g6o94lp5','189.151.245.108','2016-04-05','14:25:09',30);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (553,'4luju6hl3nj71niml2p4k129u3','189.132.190.152','2016-04-05','14:26:26',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (554,'b27o2fjffool6fg2a2in52o0n3','189.236.41.144','2016-04-09','18:24:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (555,'b27o2fjffool6fg2a2in52o0n3','189.236.41.144','2016-04-09','18:24:42',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (556,'csfuer7nvcjnpd9ms908em3c75','189.236.41.144','2016-04-14','08:02:17',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (557,'csfuer7nvcjnpd9ms908em3c75','189.236.41.144','2016-04-14','11:32:56',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (558,'vn47j5kval7ek63l7p5ei52277','200.68.137.220','2016-04-21','09:00:49',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (559,'9a06e3cvoj3pli9q4m3gba0e21','189.236.35.74','2016-05-04','15:06:17',17);
insert  into `sesiones`(`id`,`session_id`,`ip`,`fecha`,`hora`,`cliente`) values (560,'6ogki1ip5t3o3t1kepafgtopt1','189.132.163.224','2016-05-06','06:02:33',17);

/*Table structure for table `subclientes` */

CREATE TABLE `subclientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfc` varchar(100) DEFAULT NULL,
  `razon_social` varchar(200) DEFAULT NULL,
  `calle` varchar(500) DEFAULT NULL,
  `numeroExt` varchar(100) DEFAULT NULL,
  `numeroInt` varchar(100) DEFAULT NULL,
  `colonia` varchar(200) DEFAULT NULL,
  `cp` varchar(100) DEFAULT NULL,
  `municipio` varchar(200) DEFAULT NULL,
  `estado` varchar(200) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `timbres` varchar(100) DEFAULT '0',
  `idcliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

/*Data for the table `subclientes` */

insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (14,'AEP130724II4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'5121',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (13,'RMO151002KZ2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (12,'CLJ1509146B0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'88',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (10,'COH150612QJ0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'445',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (9,'GHG150612U69',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1416',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (11,'ACP151001BX1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'11258',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (15,'DKI130725827',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'22235',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (16,'CCJ151002761',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'5',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (17,'CPP151202SJ3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'11',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (18,'CCL130411G83',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'224',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (19,'TAR1307292Z0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'996',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (20,'CPC1506027WA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'3991',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (21,'PKM150612EP5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'4884',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (22,'ICS1301188X0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'34',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (23,'IWM140719G43',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2815',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (24,'CMS130719C86',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (25,'EPB1506118C1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (26,'GIJ151203KZ3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (27,'IAL1509258K7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (28,'SIM150602JQ1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'22',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (29,'DDD140115A6A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (30,'CSS1512032D7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'115',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (31,'LGS1512034A9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'39',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (32,'ISE140912QU1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'89',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (33,'MAQ150612483',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'82',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (34,'PSI150612SE2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (35,'RMA1606293D9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (36,'MAL151202DW8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'3',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (37,'DAC160705HQ9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (38,'CON151001IX8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'55',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (39,'AEAL590119AV4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (40,'CID160706SG4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (41,'DCE1607285SA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (42,'DTJ1607066I8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (43,'LCO160705P75',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (44,'AAP160706UNA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (45,'MRC160706IL5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (46,'TCO160705IZ6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (47,'SBB1607061R1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (48,'OTB160512I51',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'20',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (49,'TTR160705PV4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (50,'GPE160705BU7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (51,'DTR0808077Q1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1630',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (52,'ANK160706G90',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (53,'ARE160705N49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (54,'IPG160705I98',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (55,'MCO150611BZ5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (57,'AAA010101AAA','EMPRESA PRUEBA SA DE CV','CONOCIDO','123','1','CENTRO','29000','TUXTLA GUTIERREZ','CHIAPAS','sergio@xiontecnologias.com','15',32);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (58,'MAG090602IT9','MULTISERVICIOS EN ALIMENTOS GASTRONOMICOS DEL SURESTE, S.A. DE C.V.','PROLONGACION PERIFERICO NORTE','LOCAL 01 INTERIOR A','457','SAN FRANCISCO SABINAL','29020','TUXTLA GUTIERREZ','CHIAPAS','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (59,'TZE1506123Z6','TRANSFORMACIONES ZELAN S.A. DE C.V.','PROLONGACION PERIFERICO NORTE','LOCAL 01 INTERIOR B','457','SAN FRANCISCO SABINAL','29020','TUXTLA GUTIERREZ','CHIAPAS','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (60,'PCV160706MG8','PROYECTOS CONSULTIVOS DEL VALLE S.A. DE C.V.','AV. TECNOLOGICO','DESPACHO 412','100','OTRA NO ESPECIFICADA EN EL CATALOGO','76000','QUERETARO','QUERETARO','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (61,'SED160706KR1','SOLUCIONES EMPRESARIALES DON BOSCO, S.A. DE C.V.','AVENIDA VIVEROS','302-303','193','JARDINES DE VIRGINIA','94294','BOCA DEL RIO','VERACRUZ','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (62,'GID1506118X1','GRUPO INDUSTRIAL DECMAR S.A. DE C.V.','PROLONGACION PERIFERICO NORTE PONIENTE','LOCAL 05 INTERIOR B','457','SAN FRANCISCO SABINAL','29020','TUXTLA GUTIERREZ','CHIAPAS','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (63,'AHE160706EJ2','ACTUA HEZA S.A DE C.V','ALVARO OBREGON','','958','SEGUNDA SECCION','21100','MEXICALI','BAJA CALIFORNIA SUR','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (64,'AEC1307191S4','AUTO EXPRESS CARE CENTER S.A DE C.V.','CALLE SEPIA','','241','MONTE REAL','29026','TUXTLA GUTIERREZ','CHIAPAS','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (65,'PGO1506122K1','PETROPRODUCTORA DEL GOLFO S.A. DE C.V.','PROLONGACION PERIFERICO NORTE PONIENTE','LOCAL 04','457','SAN FRANCISCO SABINAL','29020','TUXTLA GUTIERREZ','CHIAPAS','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (66,'GBC150611K85','GRUPO BANFIEL COMERCIALIZADORA, S DE RL DE CV','5A SUR PONIENTE','LOCAL 12','671','CENTRO','29000','TUXTLA GUTIERREZ','CHIAPAS','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (67,'GHU150612FL9','GRUPO HUMBERWALD, SAPI DE CV','1A ORIENTE NORTE','DEPARTAMENTO 2','443','CENTRO','29000','TUXTLA GUTIERREZ','CHIAPAS','lorena.gonzalez@cci.mx','0',33);
insert  into `subclientes`(`id`,`rfc`,`razon_social`,`calle`,`numeroExt`,`numeroInt`,`colonia`,`cp`,`municipio`,`estado`,`email`,`timbres`,`idcliente`) values (68,'LTA160705M72','LOGISTICA Y TRANSPORTE ALHEA S.A. DE C.V.','AV. VICENTE GUERRERO','1','1498','INDEPENDENCIA','21290','MEXICALI','BAJA CALIFORNIA NORTE','lorena.gonzalez@cci.mx','0',33);

/*Table structure for table `timbres` */

CREATE TABLE `timbres` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  `CANTIDAD` int(11) DEFAULT NULL,
  `INICIO` date DEFAULT NULL,
  `FIN` date DEFAULT NULL,
  `PRECIO` decimal(10,2) DEFAULT NULL,
  `SUBTOTAL` decimal(10,2) DEFAULT NULL,
  `IVA` decimal(10,2) DEFAULT NULL,
  `TOTAL` decimal(10,2) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `timbres` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
