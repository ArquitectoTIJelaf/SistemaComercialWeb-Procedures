Alter Procedure scwsp_ObtenerBusEstandar
@Codi_Empresa		Tinyint,
@Codi_Sucursal		Smallint,
@Codi_Destino		Smallint,
@Codi_Servicio		Smallint,
@Hora				Varchar(7)
as

select bus as Codi_bus,b.Plan_bus,b.Nume_Pasajeros,b.Plac_bus from Tb_Bus_Estandar be with(nolock)
Inner Join Tb_Bus b on be.bus=b.Codi_Bus
Where be.Codi_Empresa=@Codi_Empresa and be.Sucursal=@Codi_Sucursal
and be.Servicio=@Codi_Servicio and be.hora=@HOra and be.Destino=@Codi_Destino

