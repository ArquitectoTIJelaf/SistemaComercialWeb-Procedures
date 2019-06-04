ALTER PROCEDURE scwsp_BuscarEmpresa
@Ruc_Cliente VARCHAR(11)
AS

BEGIN
	SELECT
		idruc AS Ruc_Cliente,
		'' AS Razon_Social,
		direccion AS Direccion,
		'' AS Telefono
	FROM
		Tb_ruc_Direccion_Fiscal
	WHERE
		idruc = @Ruc_Cliente

	UNION ALL

	SELECT
		Ruc_Cliente
		,Razon_Social
		,Direccion
		,Telefono
	FROM
		Tb_Ruc
	WHERE
		Ruc_Cliente = @Ruc_Cliente
END
