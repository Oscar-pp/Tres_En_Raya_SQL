USE [OscarTresEnRaya]
GO
/****** Object:  UserDefinedFunction [dbo].[MostrarTablero]    Script Date: 16/05/2022 0:58:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   FUNCTION [dbo].[MostrarTablero]
(	
	-- Add the parameters for the function here
	
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT Columna1 AS '    1    ', Columna2 AS '    2    ', Columna3 AS '    3    ' FROM Tablero
)
