Alter Procedure scwsp_GrabarVenta
-- Venta
@Serie_Boleto			SmallInt,
@Nume_Boleto			Int,
@Codi_Empresa			TinyInt,
@Codi_Oficina			SmallInt,
@Codi_PuntoVenta		SmallInt,
@Codi_Origen			SmallInt,
@Codi_Destino			SmallInt,
@Codi_Programacion		Int,
@Ruc_Cliente			Varchar(11),
@Nume_Asiento			TinyInt,
@Flag_Venta				Varchar(2),
@Precio_Venta			Real,
@Nombre					Varchar(100),
@Edad					TinyInt,
@Telefono				Varchar(15),
@Reco_Venta				Varchar(50),
@Codi_Usuario			SmallInt,
@Dni					Varchar(15),
@Tipo_Documento			Char(2),	--	Tipo Documento	: DNI / Pasaporte / Carnet de Extranjería
@Codi_Documento			Varchar(2), --	Tipo Documento	: Factura / Boleta Venta
@Tipo					Char(1),
@Sexo					Char(1),
@Tipo_Pago				Char(2),
@Precio_Normal			Real,
@ESTADO_ASIENTO			Varchar(2),

-- VENTA DERIVADA
@Fecha_Viaje			SmallDateTime,
@Hora_Viaje				Varchar(10),
@Nacionalidad			Varchar(30),
@Codi_Servicio			TinyInt,
@Codi_Embarque			SmallInt,
@Codi_Arribo			SmallInt,
@Hora_Embarque			Varchar(7),
@Nivel_Asiento			TinyInt,
@Codi_Terminal			SmallInt,
@Credito				Decimal(15,2),

-- Venta Fecha Abierta
@Codi_Ruta				SmallInt,
@ValidateFechaAbierta	bit,

-- Tb_BoletoxContrato
@IdContrato				int,
@NroSolicitud			varchar(30),
@IdAreaContrato			int,
@Flg_Ida				varchar(1),	-- '1': Check Ida, '0': Sin check
@Fecha_Cita				dateTime,
@Id_hospital			int,
@IdTabla				int,		-- idServicioContrato

@Id_Venta				Int Output

As

Begin Transaction

Begin Try
	Declare @Porcentaje_IGV real = 0;
	Select @Porcentaje_IGV = cast(Cod_Emp as real) From tablas Where COD_TAB='06' AND COD_TIP = @Codi_Documento;

	Declare @tota_ruta1 real = (@Precio_Venta / (1 + (@Porcentaje_IGV / 100)));
	Declare @Hora_Venta as varchar(20) = convert(varchar, GetDate(), 108);

	Declare @POSICION int = 0;

	INSERT INTO VENTA
	(
		SERIE_BOLETO,
		NUME_BOLETO,
		CODI_EMPRESA,
		CODI_SUCURSAL,
		CODI_PROGRAMACION,
		CODI_SUBRUTA,
		CODI_Cliente,
		NIT_CLIENTE,
		PREC_VENTA,
		NUME_ASIENTO,
		FLAG_VENTA,
		FECH_VENTA,
		RECO_VENTA,
		CLAV_USUARIO,
		INDI_ANULADO,
		FECH_ANULACION,
		DNI,
		EDAD,
		TELEFONO,
		NOMBRE,
		CODI_ESCA,
		Punto_Venta,
		TIPO_DOC,
		cod_origen,
		tipo,
		per_autoriza,
		ESTADO_ASIENTO,
		SEXO,
		Tipo_Pago,
		SUC_VENTA,
		Vale_Remoto,
		TIPO_V,
		credito
	)
	VALUES
	(
		@Serie_Boleto, 
		@NUME_BOLETO,
		@CODI_EMPRESA,
		@Codi_Oficina,
		@Codi_Programacion,
		@Codi_Destino,
		@Precio_Normal,
		@Ruc_Cliente,
		@Precio_Venta,
		@Nume_Asiento,
		@Flag_Venta,
		Convert(Varchar(10),getdate(),103),
		@Reco_Venta,
		@Codi_Usuario,
		'F',
		'01/01/1900',
		@Dni,
		@Edad,
		@Telefono,
		@Nombre,
		'',
		@Codi_PuntoVenta,
		@Tipo_Documento,
		@Codi_Origen,
		@Tipo, 
		'1',  
		@ESTADO_ASIENTO,
		@Sexo,
		@Tipo_Pago, 
		@Codi_Oficina,	-- @Suc_Venta,
		'',				-- @Vale_Remoto,
		'N',
		@Credito
	);

	Set @Id_Venta = SCOPE_IDENTITY();

	-- No permite registrar bloqueo de asientos
	If (@Flag_Venta <> 'X')
	Begin
		INSERT INTO VENTA_DERIVADA
		(
			ID_VENTA,
			NUME_BOLETO,
			FECHA_VIAJE,
			HORA_VIAJE,
			nacionalidad,
			servicio,
			porcentaje,
			tota_ruta1,
			tota_ruta2,
			sube_en,
			baja_en,
			hora_embarque_web,
			nivel_asi,
			ID_ORDEN_SERVICIO,
			TIPO,
			HORA_VENTA
		)
		VALUES
		(
			@ID_VENTA,
			RIGHT('000' + CAST(@Serie_Boleto AS varchar), 3) + '-' + RIGHT('0000000' + CAST(@Nume_Boleto AS varchar), 7),
			@Fecha_Viaje,
			@Hora_Viaje,
			@Nacionalidad,
			@Codi_Servicio,
			@Porcentaje_IGV,
			@tota_ruta1,
			(@Precio_Venta - @tota_ruta1),
			@Codi_Embarque,
			@Codi_Arribo,
			@Hora_Embarque,
			@Nivel_Asiento,
			0,
			@Tipo,
			@Hora_Venta
		);

		If (@ValidateFechaAbierta = 1)
		Begin
			INSERT INTO Tb_Datos_FechaAbierta
			(
				Id_Venta,
				codi_ruta,
				codi_servicio
			)
			VALUES
			(
				@Id_Venta,
				@Codi_Ruta,
				@Codi_Servicio
			);
		End;
	End;

	Set @POSICION = 2;

	If (@Flag_Venta = '1')
	Begin
		Declare @Id_BoletoxContrato	Int;
		
		INSERT INTO Tb_BoletoxContrato
		(
			idContrato,
			nume_boleto,
			st,
			nume_solicitud,
			idareacontrato,
			idliquidacion,
			fecha_emision,
			fecha_viaje,
			precio,
			HoraViaje,
			ID_VENTA,
			Flg_Ida,
			FECHA_CITA,
			ID_HOSPITAL,
			TIPO
		)
		VALUES
		(
			@IdContrato,
			RIGHT('000' + CAST(@Serie_Boleto AS varchar), 3) + '-' + RIGHT('0000000' + CAST(@Nume_Boleto AS varchar), 7),
			'0',
			@NroSolicitud,
			@IdAreaContrato,
			0,
			convert(varchar,getdate(),103),
			@Fecha_Viaje,
			@Precio_Venta,
			@Hora_Viaje,
			@ID_VENTA,
			@Flg_Ida,
			@Fecha_Cita,
			@Id_hospital,
			@tipo
		);
	
		Set @Id_BoletoxContrato = ident_current('Tb_BoletoxContrato');
	
		INSERT INTO tb_Control
		(
			tipoSave,
			Idboletocontrato,
			Idtabla
		)
		VALUES
		(
			'1',
			@Id_BoletoxContrato,
			@IdTabla
		);
	End;
	
	Set @POSICION = 3;

	If Not (@Flag_Venta = 'X' or @Flag_Venta = 'R' or @Flag_Venta = '9')
	Begin
		Declare @Tipo_Elect varchar(1);

		If @Tipo <> 'M' 
		Begin 
			Set @Tipo_Elect = 'E';
		End;
		Else
		Begin
			Set @Tipo_Elect = 'M';
		End;
		
		Update Tb_Correlativo_Documento
		Set 
			Numero = Numero + 1
		Where	Codi_Empresa = @Codi_Empresa and
				Codi_Sucursal = @Codi_Oficina and
				Codi_PuntoVenta = @Codi_PuntoVenta and
				Codi_Documento = @Codi_Documento and
				Serie = @Serie_Boleto and
				Tipo = @Tipo_Elect and
				RIGHT('000' + RTRIM(Terminal), 3) = RIGHT('000' + RTRIM(@Codi_Terminal), 3);
	End;

	Set @POSICION = 4;

	Commit Transaction;
End Try

Begin Catch
	RollBack Transaction;	

	INSERT INTO TB_HISTORICO_ERROR
	(
		Modulo,
		tipo,
		serie,
		numero,
		errNumber,
		errSeverity,
		errState,
		errProcedure,
		errLine,
		errMessage,
		CODI_DOCUMENTO,
		POSICION
	)
	SELECT 
		'P',
		@Tipo,
		@Serie_Boleto,
		@Nume_Boleto, 
		ERROR_NUMBER() as errNumber,
		ERROR_SEVERITY() as errSeverity,
		ERROR_STATE() as errState,
		ERROR_PROCEDURE() as errProcedure,
		ERROR_LINE() as errLine,
		ERROR_MESSAGE() as errMessage,
		'16', 
		@POSICION;

	Set @Id_Venta = -1;

End Catch;
