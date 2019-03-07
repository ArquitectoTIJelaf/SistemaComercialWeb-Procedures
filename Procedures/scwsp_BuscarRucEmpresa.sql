ALTER PROCEDURE scwsp_BuscarRucEmpresa
@Ruc varchar(11)
AS
BEGIN
	SET NOCOUNT ON

		SELECT
			Ruc
		FROM
			Tb_Empresa
		Where
			Ruc = @Ruc

	SET NOCOUNT OFF
END
