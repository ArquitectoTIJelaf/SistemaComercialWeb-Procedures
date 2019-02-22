Create Procedure scwsp_ListaDestinosRuta
@Nro_Viaje			Int,
@Codi_Sucursal		SmallInt
as
	Select ofi.Codi_Sucursal,ofi.Descripcion Nom_Oficina,
	ofi.Sigla,cd.Color From Tb_Ruta_Maestro rm
	Inner Join Tb_Maestro_Programacion mp on rm.NRO_RUTA=mp.NRO_RUTA
	Inner Join Tb_Ruta_Intermedio ri on mp.NRO_VIAJE=ri.NRO_VIAJE
	Inner Join Tb_Colores_Destino cd on cd.Codi_destino=ri.CODI_SUCURSAL 
	and cd.codi_Servicio=rm.CODI_SERVICIO
	Inner Join Tb_Oficinas ofi on ri.CODI_SUCURSAL=ofi.Codi_Sucursal
	Where mp.NRO_VIAJE= @Nro_Viaje and ri.CODI_SUCURSAL<>@Codi_Sucursal
	Order by cast(ri.ORDEN as tinyint) 