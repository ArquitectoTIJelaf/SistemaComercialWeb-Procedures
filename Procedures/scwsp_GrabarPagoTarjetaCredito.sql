Create Procedure scwsp_GrabarPagoTarjetaCredito
@Id_Venta				Int,
@Boleto					Varchar(15),
@Codi_TarjetaCredito	Varchar(4),
@Nume_TarjetaCredito	Varchar(40),
@Vale					Varchar(30),
@IdCaja					Int,
@Tipo					Varchar(1)
as  
Begin  
	Begin Transaction
		Insert Into Tb_PagoTarjetaVenta(
			nume_bol,
			id_venta,
			codi_tarjeta,
			nume_tarjeta,
			vale,
			idCaja,
			Tipo
		)  
		Values(
			@Boleto,
			@Id_Venta,
			@Codi_TarjetaCredito,
			@Nume_TarjetaCredito,
			@Vale,
			@IdCaja,
			@Tipo
		)
	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction
   
End
