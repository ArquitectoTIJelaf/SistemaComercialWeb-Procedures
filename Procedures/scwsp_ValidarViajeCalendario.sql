Create procedure scwsp_ValidarViajeCalendario
@Nro_Viaje				Int,
@Fecha_Programacion		SmallDatetime
as
set nocount on
	begin

		select 1 from tb_viaje_Calendario
		where
		NRO_VIAJE=@Nro_Viaje AND FECHA=@Fecha_Programacion  AND ST=1
		union
		select 1 from tb_viaje_Calendario	
		where 
		NRO_VIAJE=@Nro_Viaje AND FECHA<=@Fecha_Programacion AND ST='X'

	end