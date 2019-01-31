Create Procedure scwsp_BuscarProgramacionViaje
@Nro_Viaje			Int,
@Fecha_Programacion	Smalldatetime
as
begin

	select codi_programacion from tb_viaje_programacion
	where nro_viaje=@Nro_Viaje and fecha=@fecha_Programacion
end


