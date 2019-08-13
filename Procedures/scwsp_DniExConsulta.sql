-- =============================================
-- Author:		Héctor Salazar
-- Create date: 23/07/2019
-- Description:	Valida si existe el DNI en consulta
-- =============================================
CREATE PROCEDURE scwsp_DniExConsulta
 @dni	VARCHAR(15)
AS
BEGIN
	
	DECLARE @res BIT = 0

	IF EXISTS(select * from tb_dni_ex where dni = @dni)
		SET @res = 1

	SELECT @res AS Response
END