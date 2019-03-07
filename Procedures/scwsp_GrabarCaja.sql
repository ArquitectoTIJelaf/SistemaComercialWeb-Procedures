Create Procedure scwsp_GrabarCaja  
@Nume_Caja			char(7),    
@Codi_Empresa		TinyInt,    
@Codi_Sucursal		SmallInt,      
@Boleto				Varchar(15),     
@Monto				Real, 
@Codi_Usuario		SmallInt,
@Recibe				varchar(50),
@Codi_Destino		varchar(4), 
@Fecha_Viaje		SmallDateTime,
@Hora_Viaje			varchar(7),
@Codi_PuntoVenta	SmallInt,  --Codigo Punto Venta 
@Id_Venta			Int  ,  --Codigo de Venta
@Origen				Varchar(2),
@Modulo				Varchar(2), 
@Tipo				Varchar(2), --B=Boleta Venta,F=Factura 
@IdCaja				Int Output
as   
	Begin    
		Begin Transaction
			Declare @Nom_Uusario		Varchar(30)
			Declare @Nume_Boleto		Varchar(20)
			if @Tipo='B' or @Tipo='F'
				Begin
					Set @Nume_Boleto=@Tipo+@Boleto
				End
			Select @Nom_Uusario=Login From Tb_Usuario
			Where Codi_Usuario=@Codi_Usuario
			INSERT INTO CAJA(
				NUME_CAJA,
				CODI_EMPRESA,
				CODI_SUCURSAL,
				FECH_CAJA,
				TIPO_VALE,
				NUME_BOLETO,
				AUTO_CAJA,
				CODI_BUS,
				CODI_CHOFER,
				CODI_GASTO,
				CONC_CAJA,
				MONT_CAJA,
				CLAV_USUARIO,
				INDI_ANULADO,
				TIPO_DESCUENTO,
				TIPO_DOC,
				TIPO_GASTO,
				LIQUI,
				DIFERENCIA,
				RECIBE,
				DESTINO,
				FECHA_V,
				HORA_V,
				PUNTO_VENTA,
				VOUCHER,
				ASIENTO,
				RUC,
				ID_VENTA,
				origen,
				modulo,
				tipo
				)    
			VALUES(
				@NUME_CAJA,
				@Codi_Empresa,
				@Codi_Sucursal,
				Convert(Varchar(10),getdate(),103),
				'S',
				@Boleto,
				@Nom_Uusario,
				'',
				'',
				'',
				@Nume_Boleto,
				@Monto,
				@Codi_Usuario,
				'F',
				'',
				'XX',
				'P',
				0,
				0,
				@Recibe,
				@Codi_Destino,
				@Fecha_Viaje,
				@Hora_Viaje,
				@Codi_PuntoVenta,
				'PA',
				'',
				'N',
				@Id_Venta,
				@Origen,
				@Modulo,
				@Tipo
			)    
		SET @IdCaja= scope_identity()  

		If @@ERROR<>0
			RollBack Transaction
		Else
			Commit Transaction  
	End 