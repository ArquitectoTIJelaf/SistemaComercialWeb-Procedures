Create Procedure scwsp_ListarPuntosVenta
as
	Select 
	Codi_Sucursal		,
	Codi_puntoVenta		,
	Descripcion			
	From 
	Tb_PuntoVenta