Alter PROCEDURE scwsp_ListarPuntosVenta

AS
BEGIN
	SET NOCOUNT ON

	SELECT
		Codi_puntoVenta,
		Descripcion,
		Codi_Sucursal
	FROM
		Tb_PuntoVenta
	ORDER BY
		Codi_puntoVenta

	SET NOCOUNT OFF
END
