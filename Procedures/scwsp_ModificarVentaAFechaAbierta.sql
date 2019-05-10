Alter Procedure scwsp_ModificarVentaAFechaAbierta
@Id_Venta					Int,
@Codi_Servicio				TinyInt,
@Codi_Ruta					SmallInt
As
Begin Transaction
	
	Declare @validator tinyint;

	Update VENTA
	Set
		CODI_PROGRAMACION = 0
	Where
		Id_Venta = @Id_Venta
		and CODI_PROGRAMACION <> 0
	
	Set @validator = @@ROWCOUNT;

	If(@validator > 0)
	Begin
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

		Set @validator = @@ROWCOUNT;
	End;
	
	Select @validator as Validator;

If @@ERROR<>0
	RollBack Transaction
Else
	Commit Transaction
