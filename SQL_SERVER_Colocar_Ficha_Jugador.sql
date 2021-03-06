USE [OscarTresEnRaya]
GO
/****** Object:  StoredProcedure [dbo].[ColocarFichaJugador]    Script Date: 16/05/2022 1:09:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ColocarFichaJugador]

	@Fila int,
	@Columna int,
	@Jugador int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FichaJugador1 CHAR(1) = 'X',
			@FichaJugador2 CHAR(1) = 'O',
			@FichaPlayer char(1)


	-- Elegimos el valor X o O según el jugador que sea			 
	SET @FichaPlayer = ( SELECT	CASE 
									WHEN @Jugador = 1 THEN @FichaJugador1
									WHEN @Jugador = 2 THEN @FichaJugador2
								END )

	
	IF @Columna = 1 UPDATE Tablero SET Columna1 = @FichaPlayer 
		WHERE @Fila = Fila 
		AND Columna1 IS NULL; 
		

	IF @Columna = 2 UPDATE Tablero SET Columna2 = @FichaPlayer 
		WHERE @Fila = Fila 
		AND   Columna2 IS NULL;

	IF @Columna = 3 UPDATE Tablero SET Columna3 = @FichaPlayer 
		WHERE @Fila = Fila 
		AND   Columna3 IS NULL;

END
