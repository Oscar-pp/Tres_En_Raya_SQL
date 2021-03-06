USE [OscarTresEnRaya]
GO
/****** Object:  UserDefinedFunction [dbo].[ComprobarGanador]    Script Date: 16/05/2022 1:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   FUNCTION [dbo].[ComprobarGanador]
(
	@jugador INT
)
RETURNS VARCHAR(23)
AS
BEGIN

	-- Declare the return variable here
	DECLARE 
		@result CHAR(2) = 'CN' -- Continuan jugando
			
														
	-- Comprueba en vertical.
	
	IF (SELECT Columna1 FROM TABLERO 
			GROUP BY Columna1
			HAVING COUNT(*) = 3 ) IN ('O','X')
	SET @result = 'G'+ CAST(@jugador AS CHAR(1));

	IF (SELECT Columna2 FROM TABLERO 
			GROUP BY Columna2
			HAVING COUNT(*) = 3 ) IN ('O','X')
	SET @result = 'G'+ CAST(@jugador AS CHAR(1));   

	IF (SELECT Columna3 FROM TABLERO 
			GROUP BY Columna3
			HAVING COUNT(*) = 3 ) IN ('O','X')
	SET @result = 'G'+ CAST(@jugador AS CHAR(1));   
	
	
	-- Comprueba en horizontal

	IF  ((SELECT concat(columna1, columna2, columna3) FROM Tablero WHERE FILA = 1) IN ('OOO','XXX'))
		SET @result = 'G'+ CAST(@jugador AS CHAR(1));   

	IF  ((SELECT concat(columna1, columna2, columna3) FROM Tablero WHERE FILA = 2) IN ('OOO','XXX'))
		SET @result = 'G'+ CAST(@jugador AS CHAR(1));   

	IF  ((SELECT concat(columna1, columna2, columna3) FROM Tablero WHERE FILA = 3) IN ('OOO','XXX'))
		SET @result = 'G'+ CAST(@jugador AS CHAR(1));   

	
	-- Comprueba diagonal

	IF ((SELECT DISTINCT CONCAT((SELECT Columna1 FROM Tablero WHERE Fila = 1),
				(SELECT Columna2 FROM Tablero WHERE Fila = 2),
				(SELECT Columna3 FROM Tablero WHERE Fila = 3)) FROM Tablero) IN ('OOO','XXX'))
		SET @result = 'G'+ CAST(@jugador AS CHAR(1));   
		

	IF ((SELECT DISTINCT CONCAT( (SELECT Columna3 FROM Tablero WHERE Fila = 1),
						(SELECT Columna2 FROM Tablero WHERE Fila = 2),
						(SELECT Columna1 FROM Tablero WHERE Fila = 3)) FROM Tablero) IN ('OOO','XXX'))
		SET @result = 'G'+ CAST(@jugador AS CHAR(1));   

	-- Return the result of the function
	RETURN @result;

END
