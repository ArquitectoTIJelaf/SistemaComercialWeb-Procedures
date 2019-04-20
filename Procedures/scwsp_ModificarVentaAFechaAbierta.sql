Create Procedure scwsp_ModificarVentaAFechaAbierta
@Id_Venta					Int,
@Codi_Servicio				TinyInt,
@Codi_Ruta					SmallInt
as

Begin Transaction
		Update VENTA
		Set
			CODI_PROGRAMACION=0
		Where 	Id_Venta=@Id_Venta

		Insert Into Tb_Datos_FechaAbierta(
			Id_Venta,
			codi_ruta,
			codi_servicio
		)
		Values(
			@Id_Venta,
			@Codi_Ruta,
			@Codi_Servicio
		)

		If @@ERROR<>0
			RollBack Transaction
		Else
			Commit Transaction
