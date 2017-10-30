use Pasteleria
go

CREATE TABLE Color1(
	id_Color INT IDENTITY PRIMARY KEY,
	descripcion VARCHAR(50)
);

CREATE TABLE Relleno1(
	id_Relleno INT IDENTITY PRIMARY KEY,
	descripcion VARCHAR(50)
);

CREATE TABLE Pedidos(
	id_Pedido INT IDENTITY PRIMARY KEY,
	fecha DATETIME NOT NULL,
	tipo_Pastel CHAR(1) CHECK(tipo_Pastel IN('E','L','A')) NOT NULL,
	kilos INT NOT NULL,
	sabor CHAR(1) CHECK(sabor IN('C','V')) NOT NULL,
	id_Color INT FOREIGN KEY REFERENCES Color(id_Color) NOT NULL,
	id_Relleni INT FOREIGN KEY REFERENCES Relleno(id_Relleno) NOT NULL,
	felicidades VARCHAR(100) NOT NULL,
	id_Figura VARCHAR(255) NOT NULL,
	fechaEntrega DATETIME NOT NULL,
	hora INT CHECK(hora >= 9 AND hora <= 21) NOT NULL,
	importe MONEY NOT NULL,
	cuenta MONEY NOT NULL,
	total MONEY NOT NULL
);
/*Procedimiento para guardar pedidos*/

CREATE PROCEDURE AltaPedidos
	@fecha DATETIME,
	@tipo_Pastel CHAR(1),
	@kilos INT,
	@sabor CHAR(1),
	@felicidades VARCHAR(100),
	@id_Figura VARCHAR(150),
	@fechaEntrega DATETIME,
	@hora INT,
	@importe MONEY,
	@cuenta MONEY,
	@total MONEY,
	@descripcion_Color VARCHAR(50),
	@descripcion_Relleno VARCHAR(50)
AS
	DECLARE @idColor INT, @idRelleno INT;
	INSERT INTO Color1 VALUES(@descripcion_Color);
	INSERT INTO Relleno1 VALUES(@descripcion_Relleno);
	SELECT @idColor = COUNT(*) FROM Color1 WHERE @descripcion_Color = descripcion;
	SELECT @idRelleno = COUNT(*) FROM Relleno1 WHERE @descripcion_Relleno = descripcion;
	INSERT INTO Pedidos VALUES(@fecha,@tipo_Pastel,@kilos,@sabor,@idColor,@idRelleno,@felicidades,@id_Figura,
		@fechaEntrega,@hora,@importe,@cuenta,@total);
		    
--color y relleno, dinamicos