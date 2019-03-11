ALter Procedure scwsp_ListarAsientosOcupados
@Codi_Programacion		Int,
@Fecha_Programacion		SmallDateTime,
@Nro_Viaje				Int,
@Codi_Origen			SmallInt,
@Codi_DEstino			SmallInt
as
	
	If @Codi_Programacion=0
		Begin

			--Tabla Asiento con Nro Viaje
			Select
			NUME_ASIENTO, 0 Tipo_Documento,'' Numero_Documento,'' Ruc_Contacto,
			'01/01/1990' Fecha_Viaje,'01/01/1990' Fecha_Venta,'' Nacionalidad,0 Precio_Venta, '' Recoge_En,
			0 Color,'AB' FLAG_VENTA,'' Sigla, 0 Codi_Origen, 0 Codi_Destino	 From ASIENTO 
			Where CODI_PROGRAMACION=@Nro_Viaje and t_ruta='V' and fecha=@Fecha_Programacion
		End
	Else
		Begin

			--Tabla Venta
			Select v.NUME_ASIENTO,v.TIPO_DOC Tipo_Documento,v.DNI Numero_Documento,v.NIT_CLIENTE Ruc_Contacto,
			vd.Fecha_Viaje,v.FECH_VENTA Fecha_Venta,vd.Nacionalidad,v.PREC_VENTA Precio_Venta,v.RECO_VENTA Recoge_En,
			cd.Color, FLAG_VENTA,pv.Sigla, v.cod_origen Codi_Origen, v.CODI_SUBRUTA Codi_Destino From Venta v
			Inner Join VENTA_DERIVADA vd on v.id_venta=vd.id_venta
			Inner Join Tb_Colores_Destino cd on v.CODI_SUBRUTA=cd.Codi_destino and vd.Servicio=cd.codi_Servicio
			Inner Join Tb_PuntoVenta pv on v.Punto_Venta=pv.Codi_puntoVenta
			Where v.CODI_PROGRAMACION=@Codi_Programacion 
			and v.INDI_ANULADO='F' and v.FLAG_VENTA<>'O'
			and v.per_autoriza='1' 
			Union

			--Tabla Asiento con Programacion
			Select
			NUME_ASIENTO, 0 Tipo_Documento,'' Numero_Documento,'' Ruc_Contacto,
			'01/01/1990' Fecha_Viaje,'01/01/1990' Fecha_Venta,'' Nacionalidad,0 Precio_Venta, '' Recoge_En,
			0 Color,'' FLAG_VENTA,'' Sigla, 0 Codi_Origen, 0 Codi_Destino From ASIENTO 
			Where CODI_PROGRAMACION=@Codi_Programacion and t_ruta='P'
			Union
			
			----Tabla Asiento con Nro Viaje
			Select
			NUME_ASIENTO, 0 Tipo_Documento,'' Numero_Documento,'' Ruc_Contacto,
			'01/01/1990' Fecha_Viaje,'01/01/1990' Fecha_Venta,'' Nacionalidad,0 Precio_Venta, '' Recoge_En,
			0 Color,'' FLAG_VENTA,'' Sigla, 0 Codi_Origen, 0 Codi_Destino From ASIENTO 
			Where CODI_PROGRAMACION=@Nro_Viaje and t_ruta='V' and fecha=@Fecha_Programacion
		End

