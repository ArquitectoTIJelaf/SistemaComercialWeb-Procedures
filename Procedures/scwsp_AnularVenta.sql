ALTER PROCEDURE scwsp_AnularVenta (
	@Id_Venta INT, -- Codigo de Ventas
	@Codi_Usuario SMALLINT -- Codigo de Usario de Anulacion
)
AS

UPDATE Venta
SET INDI_ANULADO = 'T'
	,FECH_ANULACION = Convert(VARCHAR(10), getdate(), 103)
	,clav_usuario1 = @Codi_Usuario
WHERE
	Id_Venta = @Id_Venta
	and INDI_ANULADO <> 'T'

SELECT @@ROWCOUNT AS Validator;
