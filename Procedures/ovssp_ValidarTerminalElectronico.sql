Create Procedure ovssp_ValidarTerminalElectronico
@Codi_Empresa		TinyInt,
@Codi_Sucursal		SmallInt,
@Codi_PuntoVenta	SmallInt,
@Codi_Terminal		Int
as
select Tipo,Imp from Tb_Terminal_Control_Pasaje
Where Empresa=@Codi_Empresa and
Sucursal=@Codi_Sucursal		and
Pventa=@Codi_PuntoVenta		and
Terminal=@Codi_Terminal