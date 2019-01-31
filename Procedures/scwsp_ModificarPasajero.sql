Create Procedure scwsp_ModificarPasajero
@Id_Clientes		Int				,
@Tipo_Doc_Id		Char(1)			,
@Numero_Doc			Varchar(15)		,
@Nombre_Clientes	Varchar(100)	,
@Apellido_P			Varchar(50)		,
@Apellido_M			Varchar(50)		,
@fec_nac			SmallDateTime	,
@edad				Tinyint			,
@Direccion			Varchar(100)	,
@telefono			Varchar(15)		,
@ruc_contacto 		Varchar(11)		
as
	Begin
		Begin Transaction

			Update Tb_Cliente_Pasajes
				Set
				Tipo_Doc_id		= @Tipo_Doc_Id,
				Numero_Doc		= @Numero_Doc,
				Nombre_Clientes	= @Nombre_Clientes,
				Apellido_P		= @Apellido_P,
				Apellido_M		= @Apellido_M,
				fec_nac			= @fec_nac,
				edad			= @edad,
				Direccion		= @Direccion,
				telefono		= @telefono,
				ruc_contacto 	= @ruc_contacto
			Where Id_Clientes=@Id_Clientes

		If @@ERROR<>0
			RollBack Transaction
		Else
			Commit Transaction
	End