-----------------Actividad 1-----------------
-- Eliminar y crear la base de datos db_SalesClothes
DROP DATABASE db_SalesClothes;
CREATE DATABASE db_SalesClothes;
USE db_SalesClothes;

-- Configurar el idioma español el motor de base de datos.
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

-- Configurar el formato de fecha en dmy (día, mes y año) en el motor de base de datos.
SET DATEFORMAT dmy
GO

-- Crear la tabla client 
CREATE TABLE client
(
	/* Se realizo el id autoincrementable desde aqui porque daba error al relacionarlas tablas usando la otra forma*/
	id int identity(1,1), 
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80),
	cell_phone char(9),
	birthdate date,
	active bit
	CONSTRAINT client_pk PRIMARY KEY (id)
);

-- Restricciones para la tabla client:

-- El campo type_document sólo puede admitir datos como DNI ó CNE
/* Eliminar columna type_document */
ALTER TABLE client
	DROP COLUMN type_document
GO

/* Agregar restricción para tipo documento */
ALTER TABLE client
	ADD type_document char(3)
	CONSTRAINT type_document_client 
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

-- El campo number_document sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.
/* Eliminar columna number_document de tabla client */
ALTER TABLE client
	DROP COLUMN number_document
GO

/* El número de documento sólo debe permitir dígitos de 0 - 9 */
ALTER TABLE client
	ADD number_document char(9)
	CONSTRAINT number_document_client
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

-- El campo email sólo permite correos electrónicos válidos, por ejemplo: mario@gmail.com
/* Eliminar columna email de tabla client */
ALTER TABLE client
	DROP COLUMN email
GO

/* Agregar columna email */
ALTER TABLE client
	ADD email varchar(80)
	CONSTRAINT email_client
	CHECK(email LIKE '%@%._%')
GO

-- El campo cell_phone acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.
/* Eliminar columna celular */
ALTER TABLE client
	DROP COLUMN cell_phone
GO

/* Validar que el celular esté conformado por 9 números */
ALTER TABLE client
	ADD cell_phone char(9)
	CONSTRAINT cellphone_client
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

-- El campo birthdate sólo permite la fecha de nacimiento de clientes mayores de edad.
/* Eliminar columna fecha de nacimiento */
ALTER TABLE client
	DROP COLUMN birthdate
GO

/* Sólo debe permitir el registro de clientes mayores de edad */
ALTER TABLE client
	ADD  birthdate date
	CONSTRAINT birthdate_client
	CHECK((YEAR(GETDATE())- YEAR(birthdate )) >= 18)
GO

-- El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.
/* Eliminar columna active de tabla client */
ALTER TABLE client
	DROP COLUMN active
GO

/* El valor predeterminado será activo al registrar clientes */
ALTER TABLE client
	ADD active bit DEFAULT (1)
GO

-- Crear la tabla seller
CREATE TABLE seller
(
	id int identity(1,1),
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	salary decimal(8,2),
	cell_phone char(9), 
	email varchar(80),
	active bit
	CONSTRAINT seller_pk PRIMARY KEY (id)
);

-- Restricciones para la tabla seller:

-- El campo type_document sólo puede admitir datos como DNI ó CNE
/* El tipo de documento puede ser DNI ó CNE */
ALTER TABLE seller
	DROP COLUMN type_document
GO

/* Agregar restricción para tipo documento */
ALTER TABLE seller
	ADD type_document char(3)
	CONSTRAINT type_document_seller 
	CHECK(type_document ='DNI' OR type_document ='CNE')
GO

-- El campo number_document sólo permite dígitos entre 0 a 9, y serán 8 cuando es DNI y 9 cuando sea CNE.
/* Eliminar columna number_document de tabla seller */
ALTER TABLE seller
	DROP COLUMN number_document
GO

/* El número de documento sólo debe permitir dígitos de 0 - 9 */
ALTER TABLE seller
	ADD number_document char(9)
	CONSTRAINT number_document_seller
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

-- El campo salary tiene como valor predeterminado 1025
/* Eliminar columna salary de tabla seller */
ALTER TABLE seller
	DROP COLUMN salary
GO

/* El campo salary tiene como valor predeterminado 1025 */
ALTER TABLE seller
	ADD salary decimal(8,2) DEFAULT(1025)
GO

-- El campo cell_phone acepta solamente 9 dígitos numéricos, por ejemplo: 997158238.
/* Eliminar columna celular en la tabla seller */
ALTER TABLE seller
	DROP COLUMN cell_phone
GO

/* Validar que el celular esté conformado por 9 números */
ALTER TABLE seller
	ADD cell_phone char(9)
	CONSTRAINT cellphone_seller
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

-- El campo email sólo permite correos electrónicos válidos, por ejemplo: roxana@gmail.com
/* Eliminar columna email de tabla client */
ALTER TABLE seller
	DROP COLUMN email
GO

/* Agregar columna email */
ALTER TABLE seller
	ADD email varchar(80)
	CONSTRAINT email_seller
	CHECK(email LIKE '%@%._%')
GO

-- El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.
/* Eliminar columna active de tabla client */
ALTER TABLE seller
	DROP COLUMN active
GO

/* El valor predeterminado será activo al registrar clientes */
ALTER TABLE seller
	ADD active bit DEFAULT (1)
GO

-- Crear la tabla clothes
CREATE TABLE clothes
(
	id int identity(1,1),
	descriptions varchar(60),
	brand varchar(60),
	amount int,
	size varchar(10),
	price decimal(8,2),
	active bit
	CONSTRAINT clothes_pk PRIMARY KEY (id)
);

-- El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.
/* Quitar columna active en tabla clothes*/
ALTER TABLE clothes
	DROP COLUMN active
GO

/* Agregar columna active */
ALTER TABLE clothes
	ADD active bit default(1)
GO

-- Crear tabla sale
CREATE TABLE sale
(
	id int identity(1,1),
	date_time datetime,
	seller_id int,
	client_id int,
	active bit,
	CONSTRAINT sale_pk PRIMARY KEY (id)
);

-- El campo date_time debe tener como valor predeterminado la fecha y hora del servidor.
/* Quitar columna data_time en la tabla sale*/
ALTER TABLE sale
	DROP COLUMN date_time
GO

/* El campo date_time debe tener como valor predeterminado la fecha y hora del servidor. */
ALTER TABLE sale
	ADD date_time datetime default GETDATE()
GO

-- El campo active tendrá como valor predeterminado 1, que significa que el cliente está activo.
/* Eliminar columna active en tabla sale */
ALTER TABLE sale
	DROP COLUMN active
GO

/* El campo active tendrá como valor predeterminado 1 */
ALTER TABLE sale
	ADD active bit default(1)
GO

--Crear tabla sale_detail
CREATE TABLE sale_detail
(
	id int identity(1,1),
	sale_id int,
	clothes_id int,
	amount int,
	CONSTRAINT sale_detail_pk PRIMARY KEY (id)
);

-- Crear las relaciones entre las tablas
/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
GO

/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_seller FOREIGN KEY (seller_id)
	REFERENCES seller (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Relacionar tabla sale_detail con tabla sale */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_sale FOREIGN KEY (sale_id)
	REFERENCES sale (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Relacionar tabla sale_detail con tabla clothes */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (clothes_id)
	REFERENCES clotHes (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO