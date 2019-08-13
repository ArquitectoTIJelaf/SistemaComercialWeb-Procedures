-- =============================================
-- Author:		H�ctor Salazar
-- Create date: 06/08/2019
-- Description:	Elimina Boleto x Contrato (Cr�dito)
-- =============================================
CREATE PROCEDURE scwsp_EliminarBoletoxContrato
 @Id_Venta	INT
AS
BEGIN

	DELETE FROM Tb_BoletoxContrato WHERE Id_Venta = @Id_Venta

	SELECT @@ROWCOUNT AS Validator;
END
GO