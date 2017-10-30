USE Pasteleria;

--commit : validacion de transacción
--Insertar : (sql)Inserted
/*
insertado para hacer referencia al nuevo campo que se insrta
rollback transaccion para cancelar la insercion
*/

/*Borrar
Registro pasa  a memoria
deleted*/

/*Update
 selecciona, lo saca e inserta uno nuevo*/

 CREATE PROCEDURE AltaVenta
	@total INT,
	@producto VARCHAR(509),
	@cantidad INT,
	@subtotal MONEY,
	@numProd INT
AS

	DECLARE @idVenta INT, @idProducto INT;
	IF(@numProd = 1)
		BEGIN
			SELECT @idVenta = MAX(id_venta) FROM Ventas;
			IF(@idVenta IS NULL)	
				BEGIN
					SET @idVenta = 1;
				END
			ELSE
				BEGIN
					SET @idVenta = @idVenta+1;
				END
			INSERT INTO Ventas VALUES(@idVenta,GETDATE(),@total);
			SELECT @idProducto=idproducto FROM Producto WHERE descripcion = @producto;
			INSERT INTO DetalleVentas VALUES(@idVenta,@idProducto,@cantidad,@subtotal); 
		END
	ELSE
		BEGIN
			INSERT INTO VentasE VALUES(@idVenta,GETDATE(),@total);
			SELECT @idProducto=idproducto FROM Producto WHERE descripcion = @producto;
			INSERT INTO DetalleVentas VALUES(@idVenta,@idProducto,@cantidad,@subtotal);
		END


CREATE PROCEDURE AltaVenta20
	@total INT,
	@producto VARCHAR(509),
	@cantidad INT,
	@subtotal MONEY,
	@numProd INT
AS

	DECLARE @idVenta INT, @idProducto INT;
	IF(@numProd = 1)
		BEGIN
			SELECT @idVenta = MAX(id_venta) FROM Ventas;
					SET @idVenta = @idVenta+1;
			INSERT INTO VentasE VALUES(@idVenta,GETDATE(),@total);
			SELECT @idProducto=idproducto FROM Producto WHERE descripcion = @producto;
			INSERT INTO DetalleVentas VALUES(@idVenta,@idProducto,@cantidad,@subtotal); 
		END
	ELSE
		BEGIN
			INSERT INTO VentasE VALUES(@idVenta,GETDATE(),@total);
			SELECT @idProducto=idproducto FROM Producto WHERE descripcion = @producto;
			INSERT INTO DetalleVentas VALUES(@idVenta,@idProducto,@cantidad,@subtotal);
		END


--Creando Trigger

CREATE TRIGGER actualizaExistenciaP
	ON DetalleVentas
	FOR insert
	AS
	DECLARE @idproducto INT, @cant INT;
		--cantidad es de detalleVenta
		SELECT @idproducto = idproducto, @cant = cantidad
		FROM inserted
		--Variable id, del producto...
		UPDATE Producto SET existencia = existencia - @cant
			WHERE idproducto = @idproducto
		GO

		--traer la parte de ventas y la proxima clase, traer la parte de pedidos....

	SELECT * FROM DetalleVentas