-- =============================================
-- Author:		<Oscar P.P.>
-- Create date: <15/05/2022>
-- Description:	<Gestión principal de la partida de tres en raya automáticamente>
-- =============================================

/*
		INFORMACIÓN, CREACIÓN DE TABLA E INSERTACIÓN DE DATOS DE INICIO

-- Creamos e inicializamos el Tablero a NULL


	EXEC dbo.InicializarTablero


-- ComprobarGanador --> Si alguien ha ganado con su 
-- movimiento o no ha ganado ninguno
-- Pasamos como valor el número del Jugador (X = 1, O = 2)

	SELECT dbo.ComprobarGanador(2)


-- MOSTRAMOS LA TABLA
--

	SELECT * FROM MostrarTablero();


-- ColocarFichaJugador  Fila(1,2,3), columna(1,2,3) , jugador(1 o 2)
-- Controlamos que en la posición que vamos a insertar sea NULL y que no exista ya una ficha

	EXEC ColocarFichaJugador 1,2,2

	*/

--	************************************ PARTIDAS ***************************************
USE OscarTresEnRaya;


DROP TABLE IF EXISTS Tablero;

CREATE TABLE Tablero
(
	Fila INT IDENTITY(1,1),
	Columna1 CHAR(1),
	Columna2 CHAR(1),
	Columna3 CHAR(1)
)

DROP TABLE IF EXISTS #Virtual

CREATE TABLE #Virtual
(
	idVirtual INT IDENTITY(1,1),
	fila INT,
	columna INT
)

DECLARE @end CHAR(2) = '',
		@F INT, -- Fila (1 to 3)
		@C INT, -- Columna (1 to 3)
		@J INT,	-- Jugador (1 -> X , 2 -> O)
		@Comprobacion INT = 0,
		@casillasRellenadas INT = 1

SET @J = RAND()*(3-1)+1;
exec dbo.InicializarTablero;

-- Jugamos hasta que:
-- G1 - Jugador 1 Gana (X)
-- G2 - Jugador 2 Gana (O)
-- NG - Fin partida No hay ganador
WHILE @end NOT IN ('G1', 'G2', 'NG')
BEGIN
	SET @F = RAND()*(4-1)+1;					
	SET @C = RAND()*(4-1)+1;

	IF (CONCAT(@f,@c) NOT IN (SELECT CONCAT(fila,columna) FROM #Virtual)) 
	BEGIN
		SET @casillasRellenadas = @casillasRellenadas + 1
		INSERT INTO #Virtual (fila, columna) VALUES (@F,@C)
		exec ColocarFichaJugador @F, @C, @J
		SET @end = (SELECT dbo.ComprobarGanador(@J))
		SET @J = 3 - @J; --	(Jugador Click-Clack .. 1 o 2);
	END

	-- Comprobamos que la tabla no esté completa sin ganador
	IF @casillasRellenadas = 10 and @end NOT IN('G1', 'G2') 
	BEGIN
		PRINT 'EMPATADO';
		SET @end = 'NG';
	END
	IF @end = 'G1' PRINT 'EL JUGADOR 1 HA GANADO';
	IF @end = 'G2' PRINT 'EL JUGADOR 2 HA GANADO';
	SELECT CONCAT('Jugador ', @J,' - Fila: ' , @F , ' - Columna: ' , @C , ' ' , @end) AS 'Jugada';
	SELECT * FROM MostrarTablero();
END



