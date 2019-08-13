-- =============================================
-- Author:		Héctor Salazar
-- Create date: 06/08/2019
-- Description:	Datos Necesario para Anular Reintegro
-- =============================================
CREATE PROCEDURE scwsp_VentaReintegroConsultaAnulEle
 @ser	varchar(3), 
 @bol	varchar(7),        
 @emp	varchar(2),
 @tipo	varchar(1)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
	 id_venta			AS id_venta
	 ,codi_esca			AS codi_esca
	 ,Codi_Sucursal		AS Codi_Sucursal
	 ,PREC_VENTA		AS PREC_VENTA
	 ,tipo_pago			AS tipo_pago
	 ,clav_usuario		AS clav_usuario
	 ,tipo				AS tipo
	 ,NIT_CLIENTE		AS NIT_CLIENTE
	 ,CODI_SUBRUTA		AS CODI_SUBRUTA
	 ,SERIE_BOLETO		AS SERIE_BOLETO
	 ,NUME_BOLETO		AS NUME_BOLETO
	 ,CODI_EMPRESA		AS CODI_EMPRESA
	 ,FECH_VENTA		AS FECH_VENTA
	FROM VENTA           
	WHERE 
	 serie_boleto	= @ser	AND 
	 Nume_boleto	= @bol	AND 
	 tipo			= @tipo AND 
	 codi_Empresa	= @emp	AND 
	 indi_anulado	= 'F'	AND
	 (flag_venta = 'O' or flag_venta = '1')          
	 
	SET NOCOUNT OFF;
END
