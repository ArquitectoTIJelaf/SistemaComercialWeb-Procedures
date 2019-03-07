Create Procedure scwsp_GrabarProgramacion
@Codi_programacion		Int,
@Codi_Empresa			Tinyint,
@Codi_sucursal			Smallint,
@Codi_Ruta				Smallint,
@Codi_bus				Varchar(5),
@Fecha_Programacion		Smalldatetime,
@Hora_Programacion		Varchar(10),
@Codi_servicio			Tinyint
as

  Begin Transaction   

	

	insert into Tb_Programacion(
		codi_programacion		,
		codi_Empresa			,
		codi_sucursal			,
		codi_ruta				,
		codi_bus				,
		fech_programacion		,
		hora_programacion		,
		codi_servicio			,
		CODI_chofer				,
		codi_copiloto			,
		codi_terramoza
	)
	values
	(
		@Codi_programacion		,
		@codi_Empresa			,
		@Codi_sucursal			,
		@Codi_Ruta				,
		@codi_bus				,
		@Fecha_Programacion		,
		@Hora_Programacion		,
		@codi_servicio			,
		'00000'					,
		'00000'					,
		'00000'
	)



	If @@Error<>0
		RollBack Transaction               
	Else
		Commit Transaction