USE [OscarTresEnRaya]
GO
/****** Object:  StoredProcedure [dbo].[InicializarTablero]    Script Date: 16/05/2022 1:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Oscar P.P.>
-- Create date: <15/05/2022>
-- Description:	<Inicializamos los valores de la tabla a NULL>
-- =============================================

ALTER PROCEDURE [dbo].[InicializarTablero] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Tablero VALUES	(NULL, NULL, NULL),
								(NULL, NULL, NULL),
								(NULL, NULL, NULL)

END
