Alter Procedure scwsp_GrabarVenta
---Venta
@Serie_Boleto				SmallInt,
@Nume_Boleto				Int,
@Codi_Empresa				TinyInt,
@Codi_Oficina				SmallInt,
@Codi_PuntoVenta			SmallInt,
@Codi_Origen				SmallInt,
@Codi_Destino				SmallInt,
@Codi_Programacion			Int,
@Ruc_Cliente				Varchar(11),
@Nume_Asiento				TinyInt,
@Flag_Venta					Varchar(2),
@Precio_Venta				Real,
@Nombre						Varchar(100),
@Edad						TinyInt,
@Telefono					Varchar(15),
@Codi_Usuario				SmallInt,
@Dni						Varchar(15),
@Tipo_Documento				Char(2),--Tipo Documento DNI/Pasaporte/Carnet de Extranjeria
@Codi_Documento				Varchar(2),--Tipo Documento Factura/Bolera Venta
@Tipo						Char(1),
@Sexo						Char(1),
@Tipo_Pago					Char(2),

---VENTA DERIVADA
@Fecha_Viaje				SmallDateTime,
@Hora_Viaje					Varchar(10),
@Nacionalidad				Varchar(30),
@Codi_Servicio				TinyInt,
@Codi_Embarque				SmallInt,
@Codi_Arribo				SmallInt,
@Hora_Embarque				Varchar(7),
@Nivel_Asiento				TinyInt,
@Codi_Terminal				SmallInt,
@Credito				Decimal(15,2),
@Id_Venta					Int Output
as

Begin Transaction

Begin Try
		DECLARE @Hora_Venta AS VARCHAR(20),@POSICION INT 
		Declare @Porcentaje_IGV				Real
		SELECT @Porcentaje_IGV=cast(Cod_Emp as Real) FROM tablas Where Nom_tab='IGV' and Cod_Tip='03'
		SET @Hora_Venta=convert(varchar,GetDate(),108)
		Set @POSICION=0
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
			SEXO , 
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
			@Precio_Venta,
			@Ruc_Cliente,
			@Precio_Venta,
			@Nume_Asiento,
			@Flag_Venta,
			Convert(Varchar(10),getdate(),103),
			'',--@Reco_Venta,
			@Codi_Usuario,
			'F',
			'01/01/1900'  ,
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
			'N',
			@Sexo,
			@Tipo_Pago, 
			@Codi_Oficina,--@Suc_Venta, 
			'',--@Vale_Remoto,
			'N',
			@Credito
		)

		Set @Id_Venta=SCOPE_IDENTITY()

		--No permite registrar bloqueo de asientos
		If @Flag_Venta<>'X'
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
						RIGHT('00'+LTRIM(@Serie_Boleto),3)+'-'+right('000000'+LTRIM(@Nume_Boleto),7),
						@Fecha_Viaje,
						@Hora_Viaje,
						@Nacionalidad,
						@Codi_Servicio,
						@Porcentaje_IGV,
						((@Precio_Venta*@Porcentaje_IGV)/100),
						((@Precio_Venta*(100-@Porcentaje_IGV))/100),
						@Codi_Embarque,
						@Codi_Arribo,
						@Hora_Embarque,
						@Nivel_Asiento,
						0,
						@Tipo,
						@Hora_Venta
					)  				
			End
		Set @POSICION=2

		--If @Flag_Venta = '1'
		--	Begin
		--		--sp_help Tb_BoletoxContrato
		--		Declare @Id_BoletoxContrato	Int
				
		--		Insert Into Tb_BoletoxContrato
		--			(
		--				idContrato,
		--				nume_boleto,
		--				st,
		--				nume_solicitud,
		--				idareacontrato,
		--				idliquidacion,
		--				fecha_emision,
		--				fecha_viaje,
		--				precio,
		--				HoraViaje,
		--				ID_VENTA,
		--				Flg_Ida,
		--				FECHA_CITA,
		--				ID_HOSPITAL,
		--				TIPO
		--			)
		--		Values
		--		(
		--			@IdContrato,
		--			RIGHT('00'+LTRIM(@Serie_Boleto),3)+'-'+right('000000'+LTRIM(@Nume_Boleto),7),
		--			'0',
		--			@NroSolicitud,
		--			@IdAreaContrato,
		--			0,
		--			convert(varchar,getdate(),103),
		--			@Fecha_Viaje,
		--			@Precio_Venta,
		--			@Hora_Viaje,
		--			@ID_VENTA,
		--			@Flg_Ida,
		--			@Fecha_Cita,
		--			@Id_hospital,
		--			@tipo
		--		)
		--		set @Id_BoletoxContrato=ident_current('Tb_BoletoxContrato')	
		--		Insert Into tb_Control
		--			(
		--				tipoSave,
		--				Idboletocontrato,
		--				Idtabla
		--			)
		--		Values
		--			(
		--				@TipoSave,
		--				@Id_BoletoxContrato,
		--				@IdTabla
		--			)
		--	End
		Set @POSICION=3
		If Not (@Flag_Venta='X' or @Flag_Venta='R' or @Flag_Venta='9')
			Begin
				Declare @Tipo_Elect Varchar(1)
				IF @Tipo<>'M' 
					BEGIN 
						SET @Tipo_Elect='E' 
					END 
				ELSE 
					BEGIN 
						SET @Tipo_Elect='M' 
					END

				DECLARE @auxCodigoBF_Interno VARCHAR(2);
				SET @auxCodigoBF_Interno =
					CASE @Codi_Documento
						WHEN '01' THEN '17'
						WHEN '03' THEN '16'
					END;
				
				Update Tb_Correlativo_Documento
				Set 
					Numero=Numero+1
				Where	Codi_Empresa=@Codi_Empresa and 
						Codi_Sucursal=@Codi_Oficina and
						Codi_PuntoVenta=@Codi_PuntoVenta and
						Terminal=@Codi_Terminal and
						Codi_Documento=@auxCodigoBF_Interno and
						Serie=@Serie_Boleto and
						Tipo=@Tipo_Elect
			End
		Set @POSICION=4
		Commit Transaction
End Try
Begin Catch
	RollBack Transaction		
	Insert Into TB_HISTORICO_ERROR
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
		ERROR_NUMBER() AS errNumber,
		ERROR_SEVERITY() AS errSeverity,
		ERROR_STATE() AS errState  ,
		ERROR_PROCEDURE() AS errProcedure ,
		ERROR_LINE() AS errLine  ,
		ERROR_MESSAGE() AS errMessage ,
		'16', 
		@POSICION

		SET @Id_Venta=-1

End Catch
