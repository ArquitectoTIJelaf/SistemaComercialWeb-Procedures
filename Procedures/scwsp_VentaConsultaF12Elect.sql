-- =============================================
-- Author:		Héctor Salazar
-- Create date: 20/07/2019
-- Description:	Lista datos del cliente del boleto
-- =============================================
ALTER PROCEDURE scwsp_VentaConsultaF12Elect
@serie		INT,
@numero		INT,
@Empresa	INT,
@Tipo		VARCHAR(1)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT     
	V.SERIE_BOLETO				AS SERIE_BOLETO
	,V.NUME_BOLETO				AS NUME_BOLETO 
	,V.CODI_EMPRESA				AS CODI_EMPRESA 
	,V.TIPO_DOC					AS TIPO_DOC 
	,V.CODI_ESCA				AS CODI_ESCA 
	,V.FLAG_VENTA				AS FLAG_VENTA 
	,V.INDI_ANULADO				AS INDI_ANULADO 
	,V.id_venta					AS id_venta 
	,V.DNI						AS DNI 
	,V.NOMBRE					AS NOMBRE 
	,V.NIT_CLIENTE				AS NIT_CLIENTE 
	,V.NUME_ASIENTO				AS NUME_ASIENTO 
	,V.PREC_VENTA				AS PREC_VENTA 
	,V.CODI_SUBRUTA				AS CODI_SUBRUTA 
	,VD.Fecha_Viaje				AS Fecha_Viaje 
	,VD.Hora_Viaje				AS Hora_Viaje
	,V.CODI_PROGRAMACION		AS CODI_PROGRAMACION
	,V.COD_ORIGEN				AS COD_ORIGEN
	,isnull(sube_en,0)			AS sube_en
	,isnull(baja_en,0)			AS baja_en
	,isnull(V.EDAD,'')			AS EDAD
	,isnull(V.TELEFONO,'')		AS TELEFONO 
	,isnull(nacionalidad,'')	AS nacionalidad
	,V.TIPO						AS TIPO
	,V.Punto_Venta				AS Punto_Venta
	,VD.Servicio				AS Servicio
	,V.FECH_VENTA				AS FECH_VENTA
	,V.tipo_pago				AS tipo_pago
	,isnull(TPT.Codi_Tarjeta,'') AS Codi_Tarjeta
	,isnull(TPT.Nume_tarjeta,'') AS Nume_tarjeta
	FROM VENTA V WITH(NOLOCK)
	 INNER JOIN VENTA_DERIVADA VD ON V.id_venta = VD.id_venta
	 LEFT JOIN Tb_PagoTarjetaVenta TPT ON V.id_venta = TPT.Id_Venta
	WHERE 
	 V.serie_boleto	=@serie AND
	 V.nume_boleto	=@numero AND 
	 V.codi_empresa	=@Empresa AND 
	 V.tipo			=@Tipo AND
	 V.FLAG_VENTA <> '7'

	SET NOCOUNT OFF;
END