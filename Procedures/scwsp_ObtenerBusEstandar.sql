Alter Procedure scwsp_ObtenerBusEstandar
@Codi_Empresa		Tinyint,
@Codi_Sucursal		Smallint,
@Codi_Destino		Smallint,
@Codi_Servicio		Smallint,
@Hora				Varchar(7)
as

select bus as Codi_bus,b.Plan_bus,b.Nume_Pasajeros,b.Plac_bus from Tb_Bus_Estandar be with(nolock)
Inner Join Tb_Bus b on be.bus=b.Codi_Bus
Where 
be.Codi_Empresa=@Codi_Empresa and 
(be.Sucursal=@Codi_Sucursal or @Codi_Sucursal=0) and 
(be.Servicio=@Codi_Servicio or @Codi_Servicio=0) and 
(be.hora=@HOra or @HOra='') and 
(be.Destino=@Codi_Destino or @Codi_Destino=0)

