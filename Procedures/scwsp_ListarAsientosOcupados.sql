Alter Procedure scwsp_ListarAsientosOcupados
@Codi_Programacion		Int,
@Fecha_Programacion		SmallDateTime,
@Nro_Viaje				Int,
@Codi_Origen			SmallInt,
@Codi_Destino			SmallInt
as
	
	Declare @Codi_Sucursal			SmallInt
	Declare @Codi_Ruta				SmallInt
	Declare @Codi_Servicio			TinyInt
	Declare @Codi_Empresa			TinyInt
	Declare @Turno					Varchar(10)


	Select @Codi_Empresa= mp.Codi_Empresa,@Codi_Sucursal=rm.Codi_Sucursal,
	@Codi_Ruta=rm.CODI_DESTINO,@Codi_Servicio=rm.Codi_Servicio,@Turno=mp.HORA 
	From Tb_Maestro_Programacion mp
	Inner Join Tb_Ruta_Maestro rm on mp.NRO_RUTA=rm.NRO_RUTA
	Where mp.NRO_VIAJE=@Nro_Viaje

	If @Codi_Programacion=0
		Begin

			--Tabla Tb_AsientosBloqueados
			Select
			Asientos NUME_ASIENTO, 0 Tipo_Documento,'' Numero_Documento,'' Ruc_Contacto,
			'01/01/1990' Fecha_Viaje,'01/01/1990' Fecha_Venta,'' Nacionalidad,0 Precio_Venta, '' Recoge_En,
			0 Color,'' FLAG_VENTA From Tb_AsientosBloqueados 
			Where cod_OrigenP=@Codi_Origen and Cod_DestinoP=@Codi_Destino
			and Cod_OrigenB=@Codi_Sucursal and Cod_DestinoB=@Codi_Ruta 
			and Cod_Servicio=@Codi_Servicio and cod_empresa=@Codi_Empresa
			and horario=@Turno
			Union
			--Tabla Asiento con Nro Viaje
			Select
			NUME_ASIENTO, 0 Tipo_Documento,'' Numero_Documento,'' Ruc_Contacto,
			'01/01/1990' Fecha_Viaje,'01/01/1990' Fecha_Venta,'' Nacionalidad,0 Precio_Venta, '' Recoge_En,
			0 Color,'' FLAG_VENTA From ASIENTO 
			Where CODI_PROGRAMACION=@Nro_Viaje and t_ruta='V' and fecha=@Fecha_Programacion
		End
	Else
		Begin
			--Tabla Venta
			Select v.NUME_ASIENTO,v.TIPO_DOC Tipo_Documento,v.DNI Numero_Documento,v.NIT_CLIENTE Ruc_Contacto,
			vd.Fecha_Viaje,v.FECH_VENTA Fecha_Venta,vd.Nacionalidad,v.PREC_VENTA Precio_Venta,v.RECO_VENTA Recoge_En,
			cd.Color,v.FLAG_VENTA From Venta v
			Inner Join VENTA_DERIVADA vd on v.id_venta=vd.id_venta
			Inner Join Tb_Colores_Destino cd on v.CODI_SUBRUTA=cd.Codi_destino and vd.Servicio=cd.codi_Servicio
			Where v.CODI_PROGRAMACION=@Codi_Programacion and v.cod_origen=@Codi_Origen and v.CODI_SUBRUTA=@Codi_Destino
			Union
	
			--Tabla Tb_AsientosBloqueados
			Select
			Asientos NUME_ASIENTO, 0 Tipo_Documento,'' Numero_Documento,'' Ruc_Contacto,
			'01/01/1990' Fecha_Viaje,'01/01/1990' Fecha_Venta,'' Nacionalidad,0 Precio_Venta, '' Recoge_En,
			0 Color,'' FLAG_VENTA From Tb_AsientosBloqueados 
			Where cod_OrigenP=@Codi_Origen and Cod_DestinoP=@Codi_Destino
			and Cod_OrigenB=@Codi_Sucursal and Cod_DestinoB=@Codi_Ruta 
			and Cod_Servicio=@Codi_Servicio and cod_empresa=@Codi_Empresa
			and horario=@Turno
			Union
	
			--Tabla Asiento con Programacion
			Select
			NUME_ASIENTO, 0 Tipo_Documento,'' Numero_Documento,'' Ruc_Contacto,
			'01/01/1990' Fecha_Viaje,'01/01/1990' Fecha_Venta,'' Nacionalidad,0 Precio_Venta, '' Recoge_En,
			0 Color,'' FLAG_VENTA From ASIENTO 
			Where CODI_PROGRAMACION=@Codi_Programacion and t_ruta='P'
			Union
			--Tabla Asiento con Nro Viaje
			Select
			NUME_ASIENTO, 0 Tipo_Documento,'' Numero_Documento,'' Ruc_Contacto,
			'01/01/1990' Fecha_Viaje,'01/01/1990' Fecha_Venta,'' Nacionalidad,0 Precio_Venta, '' Recoge_En,
			0 Color,'' FLAG_VENTA From ASIENTO 
			Where CODI_PROGRAMACION=@Nro_Viaje and t_ruta='V' and fecha=@Fecha_Programacion
		End

