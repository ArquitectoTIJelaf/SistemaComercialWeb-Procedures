Create Procedure scwsp_ObtenerOrdenOficinaRuta
@Nro_Viaje		Int,
@Codi_Origen	SmallInt,
@Codi_Destino	SmallInt
as
Set NoCount On
begin
select orden from dbo.TB_RUTA_INTERMEDIO where 
(codi_sucursal=@Codi_Origen or codi_sucursal=@Codi_Destino)
AND nro_viaje=@Nro_Viaje ORDER BY CONVERT(INT,ORDEN)
end