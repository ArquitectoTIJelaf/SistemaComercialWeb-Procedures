-- =============================================
-- Author:		Héctor Salazar
-- Create date: 12/07/2019
-- Description:	Lista Modificación en Reintegro
-- =============================================
CREATE PROCEDURE scwsp_ModificacionConsultar
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	 id_correlativo AS CODIGO,
	 descripcion	AS descripcion 
	FROM Tb_Modificacion WITH(NOLOCK)

	SET NOCOUNT OFF;
END
GO