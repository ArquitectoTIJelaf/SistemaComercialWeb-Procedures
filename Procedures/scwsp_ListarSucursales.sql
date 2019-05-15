ALTER PROCEDURE scwsp_ListarSucursales
AS
BEGIN
	SET NOCOUNT ON

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
