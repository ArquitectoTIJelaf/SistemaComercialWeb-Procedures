Create Procedure scwsp_GrabarPagoDelivery
@Id_Venta			Int,
@Codi_Zona			Varchar(3),
@Direccion			Varchar(50),
@Observacion		Varchar(50)
as
Begin
	Begin Transaction

		Insert Into Tb_Delivery(
			Id_Venta		,
			Codi_Distrito	,
			Direccion		,
			Observacion
		)Values(
			@Id_Venta		 ,
			@Codi_Zona		 ,
			@Direccion		 ,
			@Observacion		
		)

	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction
End
