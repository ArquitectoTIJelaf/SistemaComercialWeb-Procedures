Create Procedure scwsp_GrabarViajeProgramacion
@Nro_Viaje			Int,
@Codi_programacion	Int,
@Fecha_Programacion	smalldatetime,
@Codi_Bus			VarChar(4)
as
	Begin Transaction 
		Insert Into Tb_Viaje_Programacion (
			Nro_Viaje			,
			Codi_programacion	,
			Fecha				,
			N_Asiento			,
			St					,
			Codi_Bus
		)
		Values(
			@Nro_Viaje			,
			@Codi_programacion	,
			@Fecha_Programacion	,
			0					,
			'1'					,
			@Codi_Bus
		)
	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction
