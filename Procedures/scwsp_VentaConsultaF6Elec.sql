SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Héctor Salazar
-- Create date: 28/06/2019
-- Description:	Lista Ventas con Fecha Abierta
-- Dependency:	SET QUOTED_IDENTIFIER OFF
-- =============================================
-- Author:		Gerardo Gómez
-- Modify date: 17/09/2019
-- Description:	ADD: (V.FLAG_VENTA NOT IN ('R', 'X', 'O')) AND (V.INDI_ANULADO = 'F')
-- =============================================
ALTER PROCEDURE scwsp_VentaConsultaF6Elec
 @nombre		VARCHAR(30),
 @dni			VARCHAR(15),
 @fecha			VARCHAR(10),
 @serie			INT,
 @nume			INT,
 @tipo			VARCHAR(1),
 @empresa		INT,
 @subruta		INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE 
	 @SQL			NVARCHAR(4000),
	 @PARAMETROS	NVARCHAR(4000),
	 @CND			NVARCHAR(4000) = ""

	IF @nombre <> ""	SET @CND = @CND + " AND V.nombre LIKE '%' + @nombre"
	IF @dni <> ""		SET @CND = @CND + " AND V.dni = @dni"
	IF @fecha <> ""		SET @CND = @CND + " AND V.fech_venta = @fecha"
	IF @serie <> 0		SET @CND = @CND + " AND V.serie_boleto = @serie"
	IF @nume <> 0		SET @CND = @CND + " AND V.nume_boleto = @nume"
	IF @tipo <> ""		SET @CND = @CND + " AND V.tipo = @tipo"
	IF @empresa <> 0	SET @CND = @CND + " AND V.CODI_EMPRESA = @empresa"
	IF @Subruta <> 0	SET @CND = @CND + " AND V.codi_subruta = @subruta"
	
	SET @SQL=" 
	SELECT TOP 15 
	 V.NOMBRE			AS NOMBRE,
	 V.tipo				AS tipo, 
	 V.serie_BOLETO		AS serie_BOLETO,
	 V.NUME_BOLETO		AS NUME_BOLETO, 
	 V.FECH_VENTA		AS FECH_VENTA, 
	 V.PREC_VENTA		AS PREC_VENTA, 
	 V.CODI_SUCURSAL	AS CODI_SUCURSAL, 
	 V.CODI_SUBRUTA		AS CODI_SUBRUTA,
	 V.CODI_SUBRUTA		AS codi_ruta,
	 V.COD_ORIGEN		AS COD_ORIGEN,
	 V.CODI_EMPRESA		AS CODI_EMPRESA,
	 V.id_venta			AS id_venta,
	 V.st_remoto		AS st_remoto,
	 D.Servicio			AS codi_servicio,
	 V.DNI				AS DNI,
	 V.TIPO_DOC			AS TIPO_DOC,
	 V.CODI_ESCA		AS CODI_ESCA
	FROM VENTA V WITH(NOLOCK)
	 INNER JOIN VENTA_DERIVADA D ON V.id_venta = D.id_venta
	WHERE  (V.CODI_PROGRAMACION = 0) AND (V.FLAG_VENTA NOT IN ('R', 'X', 'O')) AND (V.INDI_ANULADO = 'F')" + @CND +"	  
	ORDER BY fech_venta"
	--PRINT @SQL
	SET @PARAMETROS ="	 @nombre	VARCHAR(30),
						 @dni		VARCHAR(15),
						 @fecha		VARCHAR(10),
						 @serie		INT,
						 @nume		INT,
						 @tipo		VARCHAR(1),
						 @empresa	INT,
						 @subruta	INT"
	
	EXEC SP_EXECUTESQL @SQL, @PARAMETROS, @nombre, @dni, @fecha ,@serie , @nume, @tipo, @empresa, @subruta

	SET NOCOUNT OFF;
END
