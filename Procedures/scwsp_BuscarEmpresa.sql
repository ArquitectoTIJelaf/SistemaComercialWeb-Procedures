Create Procedure scwsp_BuscarEmpresa
@Ruc_Cliente	Varchar(11)
as		
	Begin		
		Select  
			Ruc_Cliente		,
			Razon_Social	,
			Direccion		,
			Telefono		
		From 
			Tb_Ruc 
		Where Ruc_Cliente	=	@Ruc_Cliente
	End