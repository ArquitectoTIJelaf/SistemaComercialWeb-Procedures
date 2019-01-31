Create Procedure scwsp_GrabarEmpresa
@Ruc_Cliente	Varchar(11),
@Razon_Social	Varchar(50),
@Direccion		Varchar(50),
@Telefono		Varchar(15)
as		
	Begin
	  Begin Transaction   			
			INSERT INTO Tb_Ruc(
				Ruc_Cliente		,
				Razon_Social	,
				Direccion		,
				Telefono
			)
			VALUES(
				@Ruc_Cliente		,
				Upper(@Razon_Social),
				@Direccion			,
				@Telefono			
			)

		If @@Error<>0
			RollBack Transaction                
		Else
			Commit Transaction
	End
