Create Procedure scwsp_ValidarUsuario
@Codi_Usuario		SmallInt,
@Pws				Varchar(30)
as
	Select 
	Codi_Usuario	,
	Codi_Empresa	,
	Codi_Sucursal	,
	Codi_puntoVenta	,
	Pws				,
	Nivel 
	From 
	Tb_Usuario
	Where Codi_Usuario=@Codi_Usuario and Pws=@Pws