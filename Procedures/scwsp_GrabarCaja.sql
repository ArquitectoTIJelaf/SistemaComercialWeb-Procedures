Alter PROCEDURE scwsp_GrabarCaja
 @Nume_Caja CHAR(7)
,@Codi_Empresa TINYINT
,@Codi_Sucursal SMALLINT
,@FECH_CAJA SMALLDATETIME
,@Boleto VARCHAR(15)
,@Monto REAL
,@Codi_Usuario SMALLINT
,@Recibe VARCHAR(50)
,@Codi_Destino VARCHAR(4)
,@Fecha_Viaje SMALLDATETIME
,@Hora_Viaje VARCHAR(7)
,@Codi_PuntoVenta SMALLINT
,@Id_Venta INT
,@Origen VARCHAR(2)
,@Modulo VARCHAR(2)
,@Tipo VARCHAR(2)

,@Nom_Usario varchar(30)
,@CONC_CAJA VARCHAR(20)
,@TIPO_VALE char(1)
,@CODI_BUS varchar(5)
,@CODI_CHOFER varchar(5)
,@CODI_GASTO varchar(3)
,@INDI_ANULADO char(1)
,@TIPO_DESCUENTO varchar(5)
,@TIPO_DOC char(2)
,@TIPO_GASTO varchar(2)
,@LIQUI smallmoney
,@DIFERENCIA smallmoney
,@VOUCHER varchar(15)
,@ASIENTO varchar(10)
,@RUC varchar(11)

,@IdCaja INT OUTPUT
AS
BEGIN
	BEGIN TRANSACTION

	INSERT INTO CAJA (
		NUME_CAJA
		,CODI_EMPRESA
		,CODI_SUCURSAL
		,FECH_CAJA
		,TIPO_VALE
		,NUME_BOLETO
		,AUTO_CAJA
		,CODI_BUS
		,CODI_CHOFER
		,CODI_GASTO
		,CONC_CAJA
		,MONT_CAJA
		,CLAV_USUARIO
		,INDI_ANULADO
		,TIPO_DESCUENTO
		,TIPO_DOC
		,TIPO_GASTO
		,LIQUI
		,DIFERENCIA
		,RECIBE
		,DESTINO
		,FECHA_V
		,HORA_V
		,PUNTO_VENTA
		,VOUCHER
		,ASIENTO
		,RUC
		,ID_VENTA
		,origen
		,modulo
		,tipo
	)
	VALUES (
		@NUME_CAJA
		,@Codi_Empresa
		,@Codi_Sucursal
		,@FECH_CAJA
		,@TIPO_VALE
		,@Boleto
		,@Nom_Usario
		,@CODI_BUS
		,@CODI_CHOFER
		,@CODI_GASTO
		,@CONC_CAJA
		,@Monto
		,@Codi_Usuario
		,@INDI_ANULADO
		,@TIPO_DESCUENTO
		,@TIPO_DOC
		,@TIPO_GASTO
		,@LIQUI
		,@DIFERENCIA
		,@Recibe
		,@Codi_Destino
		,@Fecha_Viaje
		,@Hora_Viaje
		,@Codi_PuntoVenta
		,@VOUCHER
		,@ASIENTO
		,@RUC
		,@Id_Venta
		,@Origen
		,@Modulo
		,@Tipo
	);

	SET @IdCaja = scope_identity();

	IF @@ERROR <> 0
		ROLLBACK TRANSACTION
	ELSE
		COMMIT TRANSACTION
END
