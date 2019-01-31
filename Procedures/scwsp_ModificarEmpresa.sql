Create Procedure scwsp_ModificarEmpresa
@Ruc_Cliente	Varchar(11),
@Razon_Social	Varchar(50),
@Direccion		Varchar(50),
@Telefono		Varchar(15)
as		
	Begin
		Begin Transaction    			

			Update Tb_Ruc 
			Set 
				Razon_Social	=	Upper(@Razon_Social),
				Direccion		=	@Direccion,
				Telefono		=	@Telefono
			Where Ruc_Cliente	=	@Ruc_Cliente
		
		If @@Error<>0
			RollBack Transaction               
		Else
			Commit Transaction
	End