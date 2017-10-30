use Pasteleria

create table Gastos(
	--agrega id´s automaticamente
	idGasto int not null primary key identity,
	fecha datetime,
	idProducto int references Producto(idproducto),
	Monto money not null,
	cantidad int not null check(cantidad > 0)	
)




insert into Gastos values('12/05/2017',1,2500,4)
insert into Gastos values('12/05/2017',3,2500,4)

select * from Gastos

create procedure AgregaGasto
	@fecha datetime,
	@producto varchar(50),
	@cantidad int,
	@monto money,
	@respuesta varchar(30) output
as

	declare @idProducto int 
	select @idproducto = idproducto from Producto where descripcion = @producto
	insert into gastos values (@fecha,@idProducto,@monto,@cantidad)
	set @respuesta = 'Gasto almacenado'


--forma Larga
--consultas tradicionales
select Gastos.idGasto, Gastos.fecha,Producto.descripcion,Gastos.Monto,Gastos.cantidad
from Gastos,Producto where Gastos.idProducto=Producto.idproducto

--forma Corta, puede ir p,as o g

select g.idGasto, g.fecha,p.descripcion,g.Monto,g.cantidad
from Gastos as g,Producto p where g.idProducto=p.idproducto


--consultas ocupando combinación (join)
--join
--inner join
--full join
--left join tabla con mayor peso
--rigth join

select g.idGasto, g.fecha,p.descripcion,g.Monto,g.cantidad
from Gastos as g join Producto p on g.idProducto = p.idproducto