ALTER PROCEDURE scwsp_ListarSucursales
AS

SET NOCOUNT ON;

BEGIN
	
	SELECT
		Codi_Sucursal
		,Descripcion
	FROM
		Tb_Oficinas
	WHERE
		Sucursal = 'S'
	ORDER BY
		Codi_Sucursal

	SET NOCOUNT OFF
END
