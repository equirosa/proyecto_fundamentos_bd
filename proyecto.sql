--Universidad Cenfotec
--Curso: Fundamentos de Bases de Datos
--Integrantes: Alejandro Chacon, Alejandro Solano, Eduardo Quiros.

--CREAR BD
CREATE DATABASE PROYECTO;

--Dropeo de Tablas
DROP TABLE COMPANIA;
DROP TABLE ARTICULOS;
DROP TABLE TIPO_ARTICULO;
DROP TABLE ENCA_FACT;
DROP TABLE CLIENTE;
DROP TABLE DETA_FACT;
DROP TABLE HIST_CONT;

--CREAR TABLAS
CREATE TABLE COMPANNIA(
NO_CIA VARCHAR2(20) NOT NULL,
DESCRIP_CIA VARCHAR2(30) NOT NULL,
ANNO_PROCESO NUMBER(2) NOT NULL,
MES_PROCESO NUMBER(2) NOT NULL);

CREATE  TABLE TIPO_ARTICULO(
COD_TA VARCHAR2(20) NOT NULL,
DESCRIP VARCHAR2(40) NOT NULL);

CREATE TABLE ARTICULOS(
NO_CIA VARCHAR2(20) NOT NULL,
COD_ART VARCHAR2(20) NOT NULL,
COD_TA VARCHAR2(20) NOT NULL,
DESCRIPCION VARCHAR2(40) NOT NULL,
STOCK_BODEGA NUMBER(9),
ESTADO VARCHAR2(2) NOT NULL,
PRECIO_UNIT DECIMAL(9,2));

CREATE TABLE CLIENTE(
NO_CIA VARCHAR2(20) NOT NULL,
CEDULA VARCHAR2(10) NOT NULL,
NOMBRE VARCHAR2(30) NOT NULL,
AP1 VARCHAR2(30) NOT NULL,
AP2 VARCHAR2(30) NOT NULL,
DIRECCION VARCHAR2(30) NOT NULL,
TELEFONO VARCHAR2(15) NOT NULL,
FECHA_INGRESO DATE(8) NOT NULL,
PROVINCIA VARCHAR2(2) NOT NULL,
CANTON VARCHAR2(2) NOT NULL,
ESTADO VARCHAR2(1) NOT NULL);

CREATE TABLE ENCA_FACT(
NO_CIA VARCHAR2(20) NOT NULL,
NUM_FACT NUMBER(9) NOT NULL,
FECHA_FACT DATE(8) NOT NULL,
CLIENTE VARCHAR2(10) NOT NULL,
MONTO_FACT DECIMAL(9,2) NOT NULL,
ESTADO VARCHAR2(1) NOT NULL,
FORMA_PAGO VARCHAR2(1) NOT NULL);

CREATE TABLE DETA_FACT(
NO_CIA VARCHAR2(20) NOT NULL,
NUM_FACT NUMBER(9) NOT NULL,
NUM_LINEA NUMBER(9) NOT NULL,
COD_ART VARCHAR(2) NOT NULL,
CANTIDAD NUMBER(9) NOT NULL,
PRECIO_UNIT DECIMAL(9,2) NOT NULL,
TOTALXLINEA DECIMAL(9,2) NOT NULL);

CREATE TABLE HIST_CONT(
ANNO NUMBER(4) NOT NULL,
MES NUMBER(2) NOT NULL,
NUM_TOT_FACT NUMBER(9) NOT NULL,
MON_TOT_FACT DECIMAL(9,2) NOT NULL);

--CREAR CONSTRAINTS
----PRIMARY KEYS
ALTER TABLE COMPANNIA ADD CONSTRAINT PK_COMPANNIA PRIMARY KEY(COD_CIA);
ALTER TABLE TIPO_ARTICULO ADD CONSTRAINT PK_TIPO_ARTICULO PRIMARY KEY(COD_TA);
ALTER TABLE ARTICULOS ADD CONSTRAINT PK_ARTICULOS PRIMARY KEY(COD_ART);
ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE PRIMARY KEY(CEDULA);
ALTER TABLE ENCA_FACT ADD CONSTRAINT PK_ENCA_FACT PRIMARY KEY(NUM_FACT);
ALTER TABLE DETA_FACT ADD CONSTRAINT PK_DETA_FACT_NUM_FACT PRIMARY KEY(NUM_FACT);
ALTER TABLE DETA_FACT ADD CONSTRAINT PK_DETA_FACT_NUM_LINEA PRIMARY KEY(NUM_LINEA);
ALTER TABLE HIST_CONT ADD CONSTRAINT PK_HIST_CONT_ANNO PRIMARY KEY(ANNO);
ALTER TABLE HIST_CONT ADD CONSTRAINT PK_HIST_CONT_MES PRIMARY KEY(MES);
----FOREIGN KEYS
ALTER TABLE ARTICULOS ADD CONSTRAINT FK_COMPANNIA FOREIGN KEY (NO_CIA) REFERENCES COMPANNIA(NO_CIA) ON DELETE CASCADE;
ALTER TABLE ARTICULOS ADD CONSTRAINT FK_TIPO_ARTICULO FOREIGN KEY (COD_TA) REFERENCES TIPO_ARTICULO(COD_TA) ON DELETE CASCADE;
ALTER TABLE CLIENTE ADD CONSTRAINT FK_COMPANNIA FOREIGN KEY (NO_CIA) REFERENCES COMPANNIA(NO_CIA) ON DELETE CASCADE;
ALTER TABLE ENCA_FACT ADD CONSTRAINT FK_COMPANNIA FOREIGN KEY (NO_CIA) REFERENCES COMPANNIA(NO_CIA) ON DELETE CASCADE;
ALTER TABLE ENCA_FACT ADD CONSTRAINT FK_CLIENTE FOREIGN KEY (CLIENTE) REFERENCES CLIENTE(CEDULA) ON DELETE CASCADE;
ALTER TABLE DETA_FACT ADD CONSTRAINT FK_COMPANNIA FOREIGN KEY (NO_CIA) REFERENCES COMPANNIA(NO_CIA) ON DELETE CASCADE;
ALTER TABLE DETA_FACT ADD CONSTRAINT FK_ARTICULOS FOREIGN KEY (COD_ART) REFERENCES ARTICULOS(COD_ART) ON DELETE CASCADE;
----CHECKS
ALTER TABLE ARTICULOS ADD CONSTRAINT CK_ARTICULOS_ESTADO CHECK(ESTADO IN('A','I','a','i'));
ALTER TABLE CLIENTE ADD CONSTRAINT CK_CLIENTE_ESTADO CHECK(ESTADO IN('A','I','C','a','i','c'));
ALTER TABLE ENCA_FACT ADD CONSTRAINT CK_ENCA_FACT_ESTADO CHECK(ESTADO IN('A','I','a','i'));
ALTER TABLE ENCA_FACT ADD CONSTRAINT CK_ENCA_FACT_FORMA_PAGO CHECK(ESTADO IN('1','2'));

--CREAR SINONIMOS
CREATE SYNONYM SYN_COMPANNIA FOR COMPANNIA;
CREATE SYNONYM SYN_TIPO_ARTICULO FOR TIPO_ARTICULO;
CREATE SYNONYM SYN_ARTICULOS FOR ARTICULOS;
CREATE SYNONYM SYN_CLIENTE FOR CLIENTE;
CREATE SYNONYM SYN_ENCA_FACT FOR ENCA_FACT;
CREATE SYNONYM SYN_DETA_FACT FOR DETA_FACT;
CREATE SYNONYM SYN_HIST_CONT FOR HIST_CONT;

--CREAR SECUENCIAS
CREATE SEQUENCE SEQ_COMPANNIA INCREMENT BY 1 START WITH 0 MAXVALUE 99999999999999999999;
CREATE SEQUENCE SEQ_TIPO_ARTICULO INCREMENT BY 1 START WITH 0 MAXVALUE 9999999999999999999;

--INSERTS
----COMPANNIA
INSERT INTO COMPANNIA VALUES(SEQ_COMPANNIA.NEXTVAL,'ACME',19,04);
INSERT INTO COMPANNIA VALUES(SEQ_COMPANNIA.NEXTVAL,'OFICINA CENTRAL',18,02);
INSERT INTO COMPANNIA VALUES(SEQ_COMPANNIA.NEXTVAL,'AMPM',17,06);
INSERT INTO COMPANNIA VALUES(SEQ_COMPANNIA.NEXTVAL,'METRO GOLDWYN MEYER',02,03);
INSERT INTO COMPANNIA VALUES(SEQ_COMPANNIA.NEXTVAL,'UBISOFT',15,01);
COMMIT;
----TIPO_ARTICULO
INSERT INTO TIPO_ARTICULO VALUES(SEQ_TIPO_ARTICULO.NEXTVAL,'Switch');
INSERT INTO TIPO_ARTICULO VALUES(SEQ_TIPO_ARTICULO.NEXTVAL,'XBOXTWOX');
INSERT INTO TIPO_ARTICULO VALUES(SEQ_TIPO_ARTICULO.NEXTVAL,'PC');
INSERT INTO TIPO_ARTICULO VALUES(SEQ_TIPO_ARTICULO.NEXTVAL,'PS4');
INSERT INTO TIPO_ARTICULO VALUES(SEQ_TIPO_ARTICULO.NEXTVAL,'N64');
----ENCA_FACT
INSERT INTO ENCA_FACT VALUES('01','01',TO_DATE('4/04/2018','DD/MM/YY'),'01','38000.99','A','1');
INSERT INTO ENCA_FACT VALUES('02','02',TO_DATE('4/04/2018','DD/MM/YY'),'01','40000.99','A','2');
INSERT INTO ENCA_FACT VALUES('02','03',TO_DATE('4/04/2018','DD/MM/YY'),'01','50000.00','A','2');
INSERT INTO ENCA_FACT VALUES('01','04',TO_DATE('4/04/2018','DD/MM/YY'),'01','49000.99','A','2');
INSERT INTO ENCA_FACT VALUES('01','05',TO_DATE('4/04/2018','DD/MM/YY'),'01','4000.99','A','2');
COMMIT;
----ARTICULOS
 INSERT INTO ARTICULOS VALUES('01','01','1','Shin Megami Tensei IV','50','A','38000.99');
INSERT INTO ARTICULOS VALUES('02','02','1','Earthbound 4','30','A','40000.99');
INSERT INTO ARTICULOS VALUES('02','03','3','Half Life 3','1','A','50000.00');
INSERT INTO ARTICULOS VALUES('01','04','4','Sillent Hills 2','20','A','49000.99');
INSERT INTO ARTICULOS VALUES('01','05','5','Sonichu 64','200','A','4000.99');
COMMIT;
----CLEINTES
INSERT INTO CLIENTE VALUES('02','117380781','ACME','acme','acme','San jose','60680808',TO_DATE('1/09/08','DD/MM/YY'));
INSERT INTO CLIENTE VALUES('01','117380782','Alfred','Venegas','Pirul','Pozos','60680808',TO_DATE('4/04/17','DD/MM/YY'));
INSERT INTO CLIENTE VALUES('01','117380783','Albert','Oconitrillo','Mendoza','Pozos','60680808',TO_DATE('4/04/17','DD/MM/YY'));
INSERT INTO CLIENTE VALUES('01','117380784','Allan','Bosnia','Miranda','Pozos','60680808',TO_DATE('4/04/17','DD/MM/YY'));
INSERT INTO CLIENTE VALUES('01','117380785','Alvarito','Oreamundo','Chinchilla','Pozos','60680808',TO_DATE('4/04/17','DD/MM/YY'));
COMMIT;
----DETA_FACT
INSERT INTO DETA_FACT VALUES('01','01','01','01','01','38000.99','38000.99');
INSERT INTO DETA_FACT VALUES('02','02','02','02','01','40000.99','40000.99');
INSERT INTO DETA_FACT VALUES('02','03','03','03','01','50000.00','50000.00');
INSERT INTO DETA_FACT VALUES('01','04','04','04','01','49000.99','49000.99');
INSERT INTO DETA_FACT VALUES('01','05','05','05','01','9.99','4000.99');
COMMIT;
----HIST_CONT
INSERT INTO HIST_CONT VALUES('2017','05','05','20.95');
INSERT INTO HIST_CONT VALUES('2016','06','05','20.95‬');
INSERT INTO HIST_CONT VALUES('2015','07','05','20.95');
INSERT INTO HIST_CONT VALUES('2014','08','05','20.95');
COMMIT;

--CUMPLIMIENTO CON PARTE III
--1.
--2.
DELETE FROM ENCA_FACT AS EF
WHERE EF.ESTADO IN ('I','i') AND
(SELECT CL.NOMBRE
	FROM CLIENTE AS CL
	     WHERE CL.CEDULA=EF.CLIENTE
	     	   AND CL.NOMBRE='ACME'
		   AND CL.PROVINCIA='SAN JOSE'
		   AND CL.ESTADO IN ('A','a')
		   AND (TO_DATE('01/09/08','DD/MM/YY') < CL.FECHA_INGRESO < TO_DATE('31/03/09','DD/MM/YY'))
		   AND SELECT DESCRIP_CIA
		       FROM COMPANNIA AS COMP
		       	    WHERE COMP.NO_CIA=CL.NO_CIA
			    	  AND COMP.DESCRIP_CIA='OFICINA CENTRAL')
				  AND (SELECT PRECIO_UNIT FROM DETA_FACT AS DET WHERE DET.NUM_FACT=EF.NUM_FACT AND EF.PRECIO_UNIT<=50000));


--SECCION TRIGGERS
--1
CREATE OR REPLACE TRIGGER TRIGGER1
 BEFORE INSERT ON ENCA_FACT
 FOR EACH ROW
 DECLARE
 CL ENCA_FACT.CLIENTE%TYPE := :NEW CLIENTE;
 EST CLIENTE.ESTADO%TYPE;
 BEGIN
 SELECT ESTADO, CEDULA INTO EST FROM CLIENTE WHERE CEDULA = CL;
 IF EST = 'i' OR EST = 'I'
 THEN
  RAISE_APPLICATION_ERROR (-20000, 'El cliente no esta activo');
 END IF;
 END;
