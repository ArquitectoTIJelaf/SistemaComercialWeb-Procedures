-- =============================================
-- Author:		Héctor Salazar
-- Create date: 02/08/2019
-- Description:	Código de Empresa por P.Venta y Servicio
--				por ejecución de panel de control
-- =============================================
CREATE PROCEDURE scwsp_ConsultaEmpresa_PVentaYServicio
 @PuntoVenta	INT,
 @CodiServicio	INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodiEmpresa INT = (Select codi_empresa from tb_empresa_correlativo where Codi_Pvta = @PuntoVenta and codi_servicio = @CodiServicio and estado = '1')

	IF @CodiEmpresa = 0
	BEGIN
	 SET @CodiEmpresa = (Select codi_empresa from tb_empresa_correlativo where Codi_Pvta = @PuntoVenta and codi_servicio='-1' and estado = '1')
	END

	SELECT @CodiEmpresa AS CodiEmpresa

	SET NOCOUNT OFF;
END
GO