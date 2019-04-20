Create Procedure ovssp_BuscarDatosViajeRuta
@Nro_Viaje			Int
as
select distinct rm.CODI_SUCURSAL,rm.CODI_DESTINO Codi_Ruta,
rm.CODI_SERVICIO,mp.CODI_EMPRESA from Tb_Maestro_Programacion mp
Inner Join Tb_Ruta_Maestro rm on mp.NRO_RUTA=rm.NRO_RUTA
where mp.NRO_VIAJE=@Nro_Viaje