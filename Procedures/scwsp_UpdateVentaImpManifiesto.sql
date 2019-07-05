-- =============================================
-- Author:		Héctor Salazar
-- Create date: 05/07/2019
-- Description:	Actualiza el importe de manifiesto de X a 0
-- =============================================
CREATE PROCEDURE scwsp_UpdateVentaImpManifiesto
 @Id_Venta INT
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRANSACTION 
	BEGIN TRY	

		UPDATE VENTA
		SET imp_manifiesto = '0'
		WHERE 
		 id_venta = @Id_Venta AND
		 imp_manifiesto = 'X'

		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH
	 
		ROLLBACK TRANSACTION 
	END CATCH

	SET NOCOUNT OFF;
END
GO