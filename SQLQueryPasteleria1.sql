create database Pasteleria

use Pasteleria

create table Producto(
	idproducto	int primary key not null,
	descripcion	varchar (50) not null,
	precio	money not null,
	existencia	int not null check(existencia >= 0),
	tipo int check(tipo >= 1 and tipo <= 2)
)
go
--Productos de tipo 1

CREATE TABLE Ventas(
	id_venta INT NOT NULL PRIMARY KEY IDENTITY,
	fecha DATETIME NOT NULL,
	total MONEY NOT NULL,
);
GO

CREATE TABLE VentasE(
	id_venta INT NOT NULL PRIMARY KEY,
	fecha DATETIME NOT NULL,
	total MONEY NOT NULL,
);
GO

INSERT INTO Ventas VALUES('19/10/2017',1790);


CREATE TABLE DetalleVentas(
	id_Detalle INT PRIMARY KEY IDENTITY,
	id_Venta INT REFERENCES Ventas(id_venta),
	idproducto INT REFERENCES Producto(idproducto) NOT NULL,
	cantidad INT NOT NULL,
	subtotal MONEY NOT NULL	
);

INSERT INTO detalleVentas VALUES(1,1,2,1790);

INSERT INTO detalleVentas VALUES(1,0,3,2400)
--no se pueden insertar dos objetos con el mismo numero

--Procedimientos almacenados

ALTER PROCEDURE AgregaVentas
	@fecha DATETIME,
	@total MONEY
	
AS
 INSERT INTO Ventas VALUES(@fecha,@total); 
 

 ALTER PROCEDURE AgregaDetalle
	
	@nombre_P VARCHAR(50),
	@cantidad INT,
	@subtotal MONEY
AS
	DECLARE @id_V INT;
	SELECT @id_V = COUNT(Ventas.id_venta) FROM Ventas;
	DECLARE @id_p INT;
	SELECT @id_p = idproducto FROM Producto WHERE descripcion = @nombre_P;
	UPDATE Producto SET existencia = existencia -1 
		WHERE @nombre_P = descipcion;
	INSERT INTO detalleVentas VALUES(@id_V,@id_p,@cantidad,@subtotal);

	EXEC AgregaDetalle 'panes',2,6; 
 SELECT * FROM  Producto

 --Creando triggers :D
