Alter PROCEDURE scwsp_BuscarItinerarios
@Codi_Origen	SmallInt,
@Codi_Destino	SmallInt,
@Codi_Ruta		SmallInt,
@Hora			varchar(7)
AS
SET NOCOUNT ON
BEGIN

	--DECLARE @Codi_Origen	SmallInt	= 6;
	--DECLARE @Codi_Destino	SmallInt	= 2;
	--DECLARE @Codi_Ruta		SmallInt	= 2;
	--DECLARE @Hora			varchar(7)	= '';

	DECLARE @Tiempo Int
	SET @Tiempo = 10

	IF @Hora <> '00:00AM'
		BEGIN
			SET @Tiempo = -10
		END

	SELECT TOP 200 * FROM (
		SELECT DISTINCT
			Tb_Maestro_Programacion.NRO_VIAJE,
			Tb_Maestro_Programacion.CODI_EMPRESA,
			Tb_Empresa.Razon_Social,
			Tb_Maestro_Programacion.NRO_RUTA,
			Tb_Ruta_Maestro.CODI_SUCURSAL,
			suc.Descripcion AS Nom_Sucursal,
			Tb_Ruta_Maestro.CODI_DESTINO AS Codi_Ruta,
			rut.Descripcion AS Nom_Ruta,
			Tb_Ruta_Maestro.CODI_SERVICIO,
			Tb_Servicio.descripcion AS Nom_Servicio,
			Tb_Maestro_Programacion.CODI_SUCURSAL AS Codi_PuntoVenta,
			pv.Descripcion AS Nom_PuntoVenta,
			Tb_Maestro_Programacion.HORA AS Hora_Programacion,
			Tb_Maestro_Programacion.st_opcional,
			Tb_Ruta_Intermedio.CODI_SUCURSAL AS Codi_Origen,
			ori.Descripcion AS Nom_Origen,
			'' AS Codi_Destino,
			'' AS Nom_Destino,
			Tb_Ruta_Intermedio.HORA_PASO AS Hora_Partida,
			Tb_Ruta_Intermedio.NRO_RUTA_INT,
			Tb_Ruta_Intermedio.DIAS
		FROM
			Tb_Ruta_Maestro WITH(nolock)
			INNER JOIN Tb_Maestro_Programacion WITH(nolock) ON Tb_Ruta_Maestro.NRO_RUTA = Tb_Maestro_Programacion.NRO_RUTA
			INNER JOIN Tb_Ruta_Intermedio WITH(nolock) ON Tb_Maestro_Programacion.NRO_VIAJE = Tb_Ruta_Intermedio.NRO_VIAJE
	INNER JOIN Tb_Ruta_Intermedio AS dst WITH(nolock) ON Tb_Maestro_Programacion.NRO_VIAJE = dst.NRO_VIAJE
			INNER JOIN Tb_Empresa ON Tb_Maestro_Programacion.CODI_EMPRESA = Tb_Empresa.Codi_Empresa
			INNER JOIN Tb_Servicio ON Tb_Ruta_Maestro.CODI_SERVICIO = Tb_Servicio.Codi_Servicio
			INNER JOIN Tb_Oficinas AS suc ON Tb_Ruta_Maestro.CODI_SUCURSAL = suc.Codi_Sucursal
			INNER JOIN Tb_Oficinas AS rut ON Tb_Ruta_Maestro.CODI_DESTINO = rut.Codi_Sucursal
			INNER JOIN Tb_Oficinas AS ori ON Tb_Ruta_Intermedio.CODI_SUCURSAL = ori.Codi_Sucursal
			INNER JOIN Tb_PuntoVenta AS pv ON pv.Codi_puntoVenta = Tb_Maestro_Programacion.CODI_SUCURSAL
			AND Tb_Maestro_Programacion.TIPO_E = '1'
			AND Tb_Ruta_Intermedio.VER = '1'
			AND (Tb_Ruta_Maestro.CODI_DESTINO = @Codi_Ruta OR @Codi_Ruta = 0)
			AND (Tb_Ruta_Maestro.CODI_DESTINO <> @Codi_Origen)
			AND (Tb_Ruta_Maestro.CODI_DESTINO <> 79)
			AND (Tb_Ruta_Intermedio.CODI_SUCURSAL = @Codi_Origen OR @Codi_Origen = 0)
	AND (dst.CODI_SUCURSAL = @Codi_Destino OR @Codi_Destino = 0)
			AND CONVERT(DATETIME, Tb_Ruta_Intermedio.HORA_PASO, 300) >= CONVERT(DATETIME, DATEADD(mi, @Tiempo, @Hora), 300)
			AND Tb_Maestro_Programacion.TR = 0 -- Gerardo
			AND Tb_Maestro_Programacion.TIPO_B = 1 -- Gerardo
	) SUBCONSULTA
	ORDER BY
			DATEPART(HOUR, SUBCONSULTA.Hora_Partida),
			DATEPART(MINUTE, SUBCONSULTA.Hora_Partida),
			SUBCONSULTA.NRO_VIAJE,
			SUBCONSULTA.CODI_EMPRESA,
			SUBCONSULTA.NRO_RUTA,
			SUBCONSULTA.CODI_SUCURSAL,
			SUBCONSULTA.Codi_Ruta,
			SUBCONSULTA.CODI_SERVICIO,
			SUBCONSULTA.Codi_PuntoVenta,
			SUBCONSULTA.st_opcional,
			SUBCONSULTA.Codi_Origen,
			SUBCONSULTA.Hora_Partida,
			SUBCONSULTA.NRO_RUTA_INT,
			SUBCONSULTA.DIAS

			--DESC OFFSET 0 ROWS -- Gerardo
			--FETCH NEXT 200 ROWS ONLY -- Gerardo
END
