Create Procedure ovssp_GrabarVenta
@Fecha_Viaje			smalldatetime, 
@Hora_Viaje				varchar(10),
@Codi_Origen			smallint, 
@Codi_Destino			smallint,
@Serie_Boleto			int,
@Nume_Boleto			int,
@Codi_Servicio			tinyint,
@Dni					Varchar(15),
@Edad					tinyint,
@Nume_Asiento			Varchar(3),
@Codi_Programacion		int,
@Nombres				Varchar(100),
@Costo					Real,
@Nit_Cliente			Varchar(11),
@Codi_Documento			Varchar(2),--Tipo de Comprobante Interno de Pago
@Cod_tipo				Varchar(2),--Tipo Documento de Pasajero
@Telefono				Varchar(15),
@Sexo					char(1),
@Cod_Cliente			real,
@Per_Autoriza			char(1),
@RecogeId				smallint, 
@SubeId					smallint,
@Hora_Embarque			varchar(7),
@BajaId					smallint,
@Flag_Venta				varchar(2),
@Vale_Remoto			varchar(1),
@Codi_Empresa			tinyint,
@Codi_Sucursal			SmallInt,
@Codi_PuntoVenta		SmallInt,
@Codi_Usuario			SmallInt,
@Tipo					Varchar(2),
@Suc_Venta				SmallInt,
@Numero					Int Output
as
	Begin Transaction

		declare @IGV					Tinyint
		declare @Tipo_Doc				Varchar(2)
		Declare @TipoVenta				Varchar(1)
		Declare @Id_Venta				Int		
		--Equivalencia Tipo Documento Pasajero
		SELECT     @Tipo_Doc=COD_TIP FROM         dbo.TABLAS
		WHERE     (COD_TAB = '56') AND (SAB_CON < 8) and SAB_CON=@Cod_tipo

		--Hallar Por centaje de IGV
		SELECT @IGV=cast(Cod_Emp as tinyint) FROM tablas Where Nom_tab='IGV' and Cod_Tip='03'

		--Determinar el tipo de Venta
		if @Tipo='B' or @Tipo='F'
			Begin
				Set @TipoVenta='E'
			End
		Else
			Begin
				Set @TipoVenta='M'
			End
		
		--Obtener Correlativo
		Select @Nume_Boleto=cast(Numero as Int) From Tb_Correlativo_Documento
		Where Codi_Empresa=@Codi_Empresa and Codi_Documento=@Codi_Documento and 
		Codi_Sucursal=@Codi_Sucursal and Codi_PuntoVenta=@Codi_PuntoVenta and 
		Serie=@Serie_Boleto and Tipo=@TipoVenta

		insert into venta(
			DNI							, EDAD						, NUME_ASIENTO							, CODI_PROGRAMACION		, 
			CODI_SUBRUTA				, COD_ORIGEN				, NOMBRE								, PREC_VENTA				, 
			NIT_CLIENTE					, Serie_Boleto				, NUME_BOLETO							, CODI_SUCURSAL				, 
			CODI_EMPRESA				, FLAG_VENTA				, FECH_VENTA							, PUNTO_VENTA				, 
			TIPO_DOC					, TIPO						, INDI_ANULADO							, CODI_CLIENTE				, 
			RECO_VENTA					, CLAV_USUARIO				, FECH_ANULACION						, TELEFONO					, 
			CODI_ESCA					, PER_AUTORIZA				, CLAV_USUARIO1							, SEXO						,
			ESTADO_ASIENTO				, tipo_pago					, SUC_VENTA								, Id_VentaWeb				,
			Vale_Remoto
		)
		Values
		(

			@Dni						, @Edad						, @Nume_Asiento							, @Codi_Programacion		, 
			@Codi_Destino				, @Codi_Origen				, upper(@Nombres)						, @Costo					, 
			@Nit_Cliente				, @Serie_Boleto				, @Nume_Boleto							, @Codi_Sucursal			, 
			@Codi_Empresa				, @Flag_Venta				, convert(varchar(10), getdate(),103)	, @Codi_PuntoVenta			, 
			@Tipo_Doc					, @Tipo						, 'F'									, @Cod_Cliente				, 
			''							, @Codi_Usuario				, '1900-01-01 00:00:00.000'				, @Telefono					, 
			''							, @Per_Autoriza				, ''									, @Sexo						, 
			'N'							, '01'						, @Suc_Venta							, 0							,
			'' 
		)
		set @Id_venta=scope_identity()		

		INSERT INTO VENTA_DERIVADA
		(
			Id_venta,
			Nume_Boleto,
			Fecha_Viaje,
			Hora_Viaje,
			SErvicio,
			Porcentaje,
			Tota_Ruta1,
			Tota_Ruta2,
			Nacionalidad,
			Recoje_En,
			Sube_En,
			Hora_Embarque_Web,
			baja_en,
			Comision_web,
			proveedor_tar
		)
		values
		( 
			@Id_venta,
			(Right(('00'+@Serie_Boleto),3) + '-' + Right(('00'+@Nume_Boleto),7)),
			@Fecha_Viaje,
			@Hora_Viaje,
			@Codi_Servicio,
			@IGV,
			((@Costo*@IGV)/100),
			((@Costo*(100-@IGV))/100),
			'',
			@RecogeId,
			@SubeId,
			@Hora_Embarque,
			@BajaId,
			0,
			0
		)

		Set @Numero=@Nume_Boleto

		Update Tb_Correlativo_Documento
		Set Numero=Numero+1
		Where Codi_Empresa=@Codi_Empresa and Codi_Documento=@Codi_Documento and 
		Codi_Sucursal=@Codi_Sucursal and Codi_PuntoVenta=@Codi_PuntoVenta and 
		Serie=@Serie_Boleto and Tipo=@TipoVenta

	If @@Error<>0
		Begin
	    	RollBack Transaction
		End
	Else
		Begin
	    	Commit Transaction
		End