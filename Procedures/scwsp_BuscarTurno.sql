Alter Procedure scwsp_BuscarTurno
@Codi_Empresa		TinyInt,
@Codi_PuntoVenta	SmallInt,
@Codi_Origen		SmallInt,
@Codi_Destino		SmallInt,
@Codi_Sucursal		SmallInt,
@Codi_Ruta			SmallInt,
@Codi_Servicio		TinyInt,
@Hora				varchar(7)
As
SET NOCOUNT ON

Begin
	DECLARE @Tiempo Int

	SELECT TOP 1
		dbo.Tb_Maestro_Programacion.NRO_VIAJE,
		dbo.Tb_Maestro_Programacion.CODI_EMPRESA,
		dbo.Tb_Empresa.Razon_Social,
		dbo.Tb_Maestro_Programacion.NRO_RUTA,
		dbo.Tb_Ruta_Maestro.CODI_SUCURSAL,
		suc.Descripcion Nom_Sucursal,
		dbo.Tb_Ruta_Maestro.CODI_DESTINO Codi_Ruta,
		rut.Descripcion Nom_Ruta,
		dbo.Tb_Ruta_Maestro.CODI_SERVICIO,
		dbo.Tb_Servicio.descripcion Nom_Servicio,
		dbo.Tb_Maestro_Programacion.CODI_SUCURSAL AS Codi_PuntoVenta,
		pv.Descripcion Nom_PuntoVenta,  
		dbo.Tb_Maestro_Programacion.HORA Hora_Programacion,
		--dbo.Tb_Maestro_Programacion.TIPO_B,
		--dbo.Tb_Maestro_Programacion.TIPO_C,
		--dbo.Tb_Maestro_Programacion.TIPO_W,
		--dbo.Tb_Maestro_Programacion.TIPO_V,
		--dbo.Tb_Maestro_Programacion.TIPO_R,
		--dbo.Tb_Maestro_Programacion.TIPO_T,
		dbo.Tb_Maestro_Programacion.st_opcional,
		--dbo.Tb_Maestro_Programacion.TIPO_S,
		--dbo.Tb_Maestro_Programacion.TIPO_E,
		dbo.Tb_Ruta_Intermedio.CODI_SUCURSAL AS Codi_Origen,
		ori.Descripcion Nom_Origen,
		dst.CODI_SUCURSAL Codi_Destino,
		dest.Descripcion Nom_Destino,
		dbo.Tb_Ruta_Intermedio.HORA_PASO Hora_Partida,
		dbo.Tb_Ruta_Intermedio.NRO_RUTA_INT,
		dbo.Tb_Ruta_Intermedio.DIAS,
		----dbo.Tb_Maestro_Programacion.tr,
		----dbo.Tb_Maestro_Programacion.dias as d_v,
		----dbo.Tb_Maestro_Programacion.viaje

		dbo.Tb_Servicio.DESC_SERVICIO
	FROM
		dbo.Tb_Ruta_Maestro WITH(nolock)
		INNER JOIN  dbo.Tb_Maestro_Programacion WITH(nolock) ON dbo.Tb_Ruta_Maestro.NRO_RUTA  = dbo.Tb_Maestro_Programacion.NRO_RUTA
		INNER JOIN dbo.Tb_Ruta_Intermedio  WITH(nolock) ON dbo.Tb_Maestro_Programacion.NRO_VIAJE = dbo.Tb_Ruta_Intermedio.NRO_VIAJE
		INNER JOIN dbo.Tb_Ruta_Intermedio dst WITH(nolock) ON dbo.Tb_Maestro_Programacion.NRO_VIAJE = dst.NRO_VIAJE
		Inner Join dbo.Tb_Empresa on Tb_Maestro_Programacion.CODI_EMPRESA=dbo.Tb_Empresa.Codi_Empresa
		Inner Join dbo.Tb_Servicio on Tb_Ruta_Maestro.CODI_SERVICIO=dbo.Tb_Servicio.Codi_Servicio
		Inner Join dbo.Tb_Oficinas suc on dbo.Tb_Ruta_Maestro.CODI_SUCURSAL=suc.Codi_Sucursal
		Inner Join dbo.Tb_Oficinas rut on dbo.Tb_Ruta_Maestro.CODI_DESTINO=rut.Codi_Sucursal
		Inner Join dbo.Tb_Oficinas ori on dbo.Tb_Ruta_Intermedio.CODI_SUCURSAL=ori.Codi_Sucursal
		Inner Join dbo.Tb_Oficinas dest on dst.CODI_SUCURSAL=dest.Codi_Sucursal
		Inner Join dbo.Tb_PuntoVenta pv on pv.Codi_puntoVenta=dbo.Tb_Maestro_Programacion.CODI_SUCURSAL
		and Tb_Maestro_Programacion.TIPO_E='1'
		AND  Tb_Ruta_Intermedio.VER='1'
		and dbo.Tb_Ruta_Maestro.CODI_DESTINO=@Codi_Ruta
		and dbo.Tb_Ruta_Maestro.CODI_SUCURSAL=@Codi_Sucursal
		and dbo.Tb_Ruta_Maestro.CODI_SERVICIO=@Codi_Servicio
		and dbo.Tb_Ruta_Maestro.CODI_DESTINO<>@Codi_Origen
		and dbo.Tb_Ruta_Maestro.CODI_DESTINO<>79
		AND dbo.Tb_Ruta_Intermedio.CODI_SUCURSAL=@Codi_Origen
		and dst.CODI_SUCURSAL=@Codi_Destino
		and dbo.Tb_Maestro_Programacion.CODI_SUCURSAL=@Codi_PuntoVenta
		and dbo.Tb_Maestro_Programacion.CODI_EMPRESA=@Codi_Empresa
		and Tb_Ruta_Intermedio.HORA_PASO=@Hora
End
