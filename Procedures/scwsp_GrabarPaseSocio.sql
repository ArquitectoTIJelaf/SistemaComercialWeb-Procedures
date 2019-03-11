Create Procedure scwsp_GrabarPaseSocio
@Id_Venta		Int,
@Codi_Gerente   Varchar(6),
@Codi_Socio		Varchar(6),
@Observacion	Varchar(50)		
as
Begin
	Begin Transaction
		
		Insert Into tb_Venta_Pases(
			Id_Venta		,
			Gerente			,
			Socio			,
			Obs
		)
		Values(
			@Id_Venta		,
			@Codi_Gerente	,
			@Codi_Socio		,
			@Observacion
		)

	If @@ERROR<>0
		Rollback Transaction
	Else
		Commit Transaction
End

