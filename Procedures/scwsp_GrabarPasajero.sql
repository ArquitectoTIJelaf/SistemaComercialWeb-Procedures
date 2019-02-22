Create Procedure scwsp_GrabarPasajero
@Tipo_Doc_Id		Char(1)			,
@Numero_Doc			Varchar(15)		,
@Nombre_Clientes	Varchar(100)	,
@Apellido_P			Varchar(50)		,
@Apellido_M			Varchar(50)		,
@fec_nac			SmallDateTime	,
@edad				Tinyint			,
@Direccion			Varchar(100)	,
@telefono			Varchar(15)		,
@ruc_contacto 		Varchar(11)		,
@Id_Clientes		Int	Output
as
	Begin
		Begin Transaction
			Insert Into Tb_Cliente_Pasajes(
				Tipo_Doc_id		,
				Numero_Doc		,
				Nombre_Clientes	,
				Apellido_P		,
				Apellido_M		,
				fec_nac			,
				edad			,
				Direccion		,
				telefono		,
				ruc_contacto 
			)
			Values(
				@Tipo_Doc_Id	 ,
				@Numero_Doc		 ,
				@Nombre_Clientes ,
				@Apellido_P		 ,
				@Apellido_M		 ,
				@fec_nac		 ,
				@edad			 ,
				@Direccion		 ,
				@telefono		 ,
				@ruc_contacto 			
			)

			Set @Id_Clientes=SCOPE_IDENTITY()

		If @@ERROR<>0
			RollBack Transaction
		Else
			Commit Transaction
	End