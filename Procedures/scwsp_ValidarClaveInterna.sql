ALTER PROCEDURE scwsp_ValidarClaveInterna
(
	@Codi_Oficina SMALLINT
	,@Password VARCHAR(30)
	,@Codi_Tipo SMALLINT
)
AS
SELECT codigo
	,oficina
	,pwd
	,cod_tipo
FROM
	Tb_Claves_Internas
WHERE
	Oficina = @Codi_Oficina
	AND Pwd = @Password
	AND Cast(Cod_Tipo AS SMALLINT) = @Codi_Tipo
