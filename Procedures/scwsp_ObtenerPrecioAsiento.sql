Create procedure scwsp_ObtenerPrecioAsiento
@Cod_Origen		SmallInt,
@Cod_Destino	SmallInt,
@Hora			varchar(10),
@Fecha			varchar(10),
@Cod_Servicio	SmallInt,
@Cod_Empresa	Tinyint,
@Nivel			varchar(1)
as

SET NOCOUNT ON	



		SELECT top 1 Tb_Precio_Fecha.Precio_Nor,Tb_Precio_Fecha.Precio_Min,Tb_Precio_Fecha.Precio_Max 
		FROM dbo.Tb_Precio_Fecha with (nolock)
		INNER JOIN dbo.Tb_Servicio_Fecha ON dbo.Tb_Precio_Fecha.Id_Precios_Fecha = dbo.Tb_Servicio_Fecha.Id_Precios_Fecha 
		INNER JOIN dbo.Tb_Precios ON dbo.Tb_Servicio_Fecha.Id_precio = dbo.Tb_Precios.Id_precio 
		where Tb_Precios.CODI_sUCURSAL=@Cod_Origen and Tb_Precios.codi_subruta=@Cod_Destino and Tb_Servicio_Fecha.Codi_servicio=@Cod_Servicio 
		and Tb_Precio_Fecha.fecha<=@fecha and Tb_Precio_Fecha.hora=@Hora and (Tb_Precio_Fecha.nivel=@Nivel OR Tb_Precio_Fecha.nivel='G') 
		and Tb_Precios.codi_empresa=@Cod_Empresa and Tb_precio_Fecha.Id_canal=3 and tb_precio_fecha.Id_Nacionalidad=3 
		order by fecha desc

