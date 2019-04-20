Alter Procedure scwsp_PostergarVenta
@Id_Venta				Int,
@Codi_programacion		Int,
@Nume_Asiento			TinyInt,
@Codi_Servicio			SmallInt,
@Fecha_Viaje			Varchar(10),
@Hora_Viaje				Varchar(10)
as
	Begin Transaction

		Update Venta
		Set CODI_PROGRAMACION	=@Codi_programacion,
			NUME_ASIENTO		=@Nume_Asiento		
		Where Id_Venta=@Id_Venta

		Update Venta_Derivada
		Set Servicio	=@Codi_Servicio,
			Fecha_Viaje	=@Fecha_Viaje,
			Hora_Viaje	=@Hora_Viaje		
		Where Id_Venta=@Id_Venta

		Delete From Tb_Datos_FechaAbierta 
		Where id_Venta=@Id_Venta


	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction
