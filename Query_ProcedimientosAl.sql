use Pasteleria

CREATE PROCEDURE altaProducto2


   @idproducto int,
   @descripcion varchar(50),
   @existencia int,
   @precio money,
   @tipo int,
   @respuesta varchar(35) output

AS

	declare @contador int
	select @contador = count(*) from Producto where descripcion = @descripcion
	if @contador >= 1
	   begin
	     print 'No se puede almacenar, porque ya existe'
		 set @respuesta = 'No se puede almacenar, porque ya existe'
	   end
	else
	   begin 
	      insert into Producto values(@idproducto,@descripcion,@existencia,@precio,@tipo)
		  set @respuesta = 'Producto almacenado'
	   end 
go

print 'Producto almacenado'


--invocar el procedimiento
  exec altaProducto 9,'leche4',20,16.0,2

--solo recibe datos y no regresa
--validara que no se pueda meter un dato duplicado
