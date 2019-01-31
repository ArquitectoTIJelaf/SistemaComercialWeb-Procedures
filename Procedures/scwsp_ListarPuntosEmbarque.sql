Create Procedure scwsp_ListarPuntosEmbarque
@Codi_Origen		SmallInt,      
@Codi_Destino		SmallInt,      
@Codi_Servicio		SmallInt,      
@Codi_Empresa		TinyInt,      
@Codi_PuntoVenta	SmallInt,  
@Hora				varchar(10)  
as      
set nocount on      
begin      
SELECT DISTINCT      
 cod_paso as Codi_puntoVenta ,
 (select descripcion from tb_oficinas o where o.Codi_Sucursal=cod_paso) as Embarque,
 hora_PASO Hora_Embarque,
 case when right(Tb_Puntos.hora,2)='PM' then 
case when right(Tb_Puntos.hora,2)=right(Tb_Puntos_Det.hora_paso,2) then case when cast(Tb_Puntos.hora as datetime)<=cast(Tb_Puntos_Det.hora_paso as datetime) then 0 else 1 end else 1 end 
else
case when right(Tb_Puntos.hora,2)=right(Tb_Puntos_Det.hora_paso,2) then case when cast(Tb_Puntos.hora as datetime)<=cast(Tb_Puntos_Det.hora_paso as datetime) then 0 else 1 end else 0 end 
end
Nro_Dias
FROM       
dbo.Tb_Puntos_Det INNER JOIN      
dbo.Tb_Puntos ON dbo.Tb_Puntos_Det.id_Puntos = dbo.Tb_Puntos.id_Puntos INNER JOIN      
dbo.Tb_Ruta_Maestro ON dbo.Tb_Puntos.nro_ruta = dbo.Tb_Ruta_Maestro.NRO_RUTA  AND       
dbo.Tb_Ruta_Maestro.CODI_SUCURSAL = @Codi_Origen AND       
dbo.Tb_Ruta_Maestro.CODI_DESTINO = @Codi_Destino AND       
dbo.Tb_Ruta_Maestro.CODI_SERVICIO = @Codi_Servicio AND       
dbo.Tb_Puntos.cod_empresa = @Codi_Empresa AND       
dbo.Tb_Puntos.cod_pventa = @Codi_PuntoVenta AND       
dbo.Tb_Puntos.hora = @Hora AND      
Tb_Puntos_Det.tipo='1'      
end
