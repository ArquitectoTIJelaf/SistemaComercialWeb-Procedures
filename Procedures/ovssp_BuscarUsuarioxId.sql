Create Procedure ovssp_BuscarUsuarioxId
@Codi_Usuario			SmallInt
as
select Codi_Usuario,Codi_Sucursal,Codi_puntoVenta,
Terminal Codi_Terminal From Tb_Usuario
Where Codi_Usuario=@Codi_Usuario

