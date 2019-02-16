Create Procedure scwsp_ValidarLiquidacionVentas
@Codi_Usuario	SmallInt,
@Fecha			SmallDateTime
as
set nocount on
begin
	select Top 1 1 from Tb_LiquidacionVentas
	where 
	cajero=@Codi_Usuario and
	fecha_liq=@Fecha
end
