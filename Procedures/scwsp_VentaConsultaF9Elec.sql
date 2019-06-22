-- =============================================
-- Author:		Héctor Salazar
-- Create date: 22/06/2019
-- Description:	Datos de la Venta por Empresa y Número
-- =============================================
CREATE PROCEDURE scwsp_VentaConsultaF9Elec
 @serie		INT,
 @numero	INT,
 @empresa	INT,
 @tipo		VARCHAR(1)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT     
	 P.Fech_programacion	AS Fech_programacion
	,V.tipo                 AS tipo
	,V.SERIE_BOLETO         AS SERIE_BOLETO
	,V.NUME_BOLETO			AS NUME_BOLETO					
	,V.CODI_EMPRESA         AS CODI_EMPRESA
	,V.CODI_SUCURSAL        AS CODI_SUCURSAL
	,V.CODI_PROGRAMACION    AS CODI_PROGRAMACION
	,V.CODI_SUBRUTA         AS CODI_SUBRUTA
	,V.CODI_Cliente         AS CODI_Cliente
	,V.NIT_CLIENTE          AS NIT_CLIENTE
	,V.PREC_VENTA           AS PREC_VENTA
	,V.NUME_ASIENTO         AS NUME_ASIENTO
	,V.FLAG_VENTA           AS FLAG_VENTA
	,V.FECH_VENTA           AS FECH_VENTA
	,V.RECO_VENTA           AS RECO_VENTA
	,V.CLAV_USUARIO         AS CLAV_USUARIO
	,V.INDI_ANULADO         AS INDI_ANULADO
	,V.FECH_ANULACION       AS FECH_ANULACION
	,V.DNI                  AS DNI
	,V.EDAD                 AS EDAD
	,V.TELEFONO             AS TELEFONO
	,V.NOMBRE               AS NOMBRE
	,V.CODI_ESCA            AS CODI_ESCA
	,V.Punto_Venta          AS Punto_Venta
	,V.TIPO_DOC             AS TIPO_DOC
	,V.cod_origen           AS cod_origen
	,V.per_autoriza         AS per_autoriza
	,V.clav_usuario1        AS clav_usuario1
	,V.ESTADO_ASIENTO       AS ESTADO_ASIENTO
	,V.SEXO                 AS SEXO
	,V.tipo_pago            AS tipo_pago
	,V.SUC_VENTA            AS SUC_VENTA
	,V.id_venta             AS id_venta
	,V.vale_remoto          AS vale_remoto
	,V.Id_VentaWeb          AS Id_VentaWeb					
	,V.imp_manifiesto       AS imp_manifiesto
	,V.TIPO_V               AS TIPO_V
	,P.Codi_ruta            AS Codi_ruta
	,P.Hora_programacion    AS Hora_programacion
	,P.Codi_Servicio        AS Codi_Servicio
	FROM VENTA V WITH(NOLOCK)
	INNER JOIN Tb_Programacion P ON V.CODI_PROGRAMACION = P.Codi_Programacion
	WHERE  
	 V.SERIE_BOLETO	= @SERIE	AND
	 V.NUME_BOLETO	= @numero	AND
	 V.codi_empresa	= @empresa	AND
	 V.tipo			= @tipo

	SET NOCOUNT OFF;
END
GO