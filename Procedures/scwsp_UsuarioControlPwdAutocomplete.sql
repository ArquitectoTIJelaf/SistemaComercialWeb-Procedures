SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Héctor Salazar
-- Create date: 23/07/2019
-- Description:	Autocomplete Usuarios de tb_control_Pwd
-- Dependency:	SET QUOTED_IDENTIFIER OFF
-- =============================================
-- Author:		Gerardo Gómez
-- Create date: 19/09/2019
-- Description:	ADD: ORDER BY WITH CASE
-- Dependency:	SET QUOTED_IDENTIFIER OFF
-- =============================================
ALTER PROCEDURE scwsp_UsuarioControlPwdAutocomplete
@value VARCHAR(30)
AS
BEGIN
	
	SET NOCOUNT ON;

	--DECLARE @value VARCHAR(30) = '1';

	DECLARE @DynamicQuery NVARCHAR(MAX);

	SET @DynamicQuery = "
	SELECT TOP 10
		*
	FROM (
		SELECT
			CP.USUARIO AS USUARIO, 
			U.Login	AS nomb_usuario
		FROM
			tb_control_Pwd CP WITH(NOLOCK)
			INNER JOIN Tb_Usuario U ON CP.USUARIO = U.Codi_Usuario
		WHERE
		" +
		CASE ISNUMERIC(@value)
			WHEN 0
				THEN " U.Login LIKE '%" + @value + "%'"
			WHEN 1
				THEN " CP.USUARIO LIKE '" + @value + "%'"
		END +
		"
	) SUB
	ORDER BY
		" +
			CASE ISNUMERIC(@value)
				WHEN 0
					THEN "SUB.nomb_usuario;"	
				WHEN 1
					THEN "SUB.USUARIO;"
			END;

	EXECUTE sp_executesql @DynamicQuery
	--select @DynamicQuery;

	SET NOCOUNT OFF;

END;
