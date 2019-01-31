Create Procedure scwsp_ListarEmpresas
as
	Select 
	Codi_Empresa		,
	Razon_Social		,
	Ruc					,
	DIRECCION
	From 
	Tb_Empresa