SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Héctor Salazar
-- Create date: 23/07/2019
-- Description:	Autocomplete Usuarios de tb_control_Pwd
-- Dependency:	SET QUOTED_IDENTIFIER OFF
-- =============================================
CREATE PROCEDURE scwsp_UsuarioControlPwdAutocomplete
 @value VARCHAR(30)
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @DynamicQuery NVARCHAR(MAX);

	SET @DynamicQuery = "
	SELECT
	 CP.USUARIO AS USUARIO, 
	 U.Login	AS nomb_usuario
	FROM tb_control_Pwd CP WITH(NOLOCK)
	 INNER JOIN Tb_Usuario U ON CP.USUARIO = U.Codi_Usuario
	WHERE "	+
	CASE ISNUMERIC(@value)
		WHEN 0
			THEN " U.Login LIKE '%" + @value + "%'"
		WHEN 1
			THEN " CP.USUARIO LIKE '" + @value + "%'"
	END +
	" ORDER BY U.Login ASC OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY";

	EXECUTE sp_executesql @DynamicQuery

	SET NOCOUNT OFF;
END
GO