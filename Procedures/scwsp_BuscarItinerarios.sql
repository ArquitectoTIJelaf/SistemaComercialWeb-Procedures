SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE scwsp_BuscarItinerarios
@Codi_Origen	SmallInt,
@Codi_Destino	SmallInt,
@Codi_Ruta		SmallInt,
@Hora			varchar(7),
@Codi_Servicio	SmallInt
AS

SET NOCOUNT ON
BEGIN
	
	--SET QUOTED_IDENTIFIER OFF
	--GO

	--DECLARE @Codi_Origen	SmallInt	= 6;

	--DECLARE @Codi_Destino	SmallInt	= 25;
	--DECLARE @Codi_Ruta		SmallInt	= 0;
	--DECLARE @Hora			varchar(7)	= '';
	--DECLARE @Codi_Servicio	SmallInt	= 0;

	DECLARE @Tiempo Int
	SET @Tiempo = 10

	IF @Hora <> '00:00AM'
	BEGIN
		SET @Tiempo = -10
	END;


	DECLARE @DynamicQuery NVARCHAR(MAX);

	SET @DynamicQuery = "
	SELECT " +
		CASE
			WHEN (@Codi_Destino = 0 OR @Codi_Ruta = 0) AND @Hora = '' THEN
				""
			ELSE
				"TOP 150"
		END
		+ "
		*
	FROM (
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
			INNER JOIN Tb_Maestro_Programacion WITH(nolock)		ON Tb_Ruta_Maestro.NRO_RUTA = Tb_Maestro_Programacion.NRO_RUTA
			INNER JOIN Tb_Ruta_Intermedio WITH(nolock)			ON Tb_Maestro_Programacion.NRO_VIAJE = Tb_Ruta_Intermedio.NRO_VIAJE
			INNER JOIN Tb_Ruta_Intermedio AS dst WITH(nolock)	ON Tb_Maestro_Programacion.NRO_VIAJE = dst.NRO_VIAJE
			INNER JOIN Tb_Empresa								ON Tb_Maestro_Programacion.CODI_EMPRESA = Tb_Empresa.Codi_Empresa
			INNER JOIN Tb_Servicio								ON Tb_Ruta_Maestro.CODI_SERVICIO = Tb_Servicio.Codi_Servicio
			INNER JOIN Tb_Oficinas AS suc						ON Tb_Ruta_Maestro.CODI_SUCURSAL = suc.Codi_Sucursal
			INNER JOIN Tb_Oficinas AS rut						ON Tb_Ruta_Maestro.CODI_DESTINO = rut.Codi_Sucursal
			INNER JOIN Tb_Oficinas AS ori						ON Tb_Ruta_Intermedio.CODI_SUCURSAL = ori.Codi_Sucursal
			INNER JOIN Tb_PuntoVenta AS pv						ON Tb_Maestro_Programacion.CODI_SUCURSAL = pv.Codi_puntoVenta
				AND Tb_Maestro_Programacion.TIPO_E = '1'
				AND Tb_Ruta_Intermedio.VER = '1'
				" +
				CASE
					WHEN @Codi_Ruta != 0 THEN
						"AND Tb_Ruta_Maestro.CODI_DESTINO = " + LTRIM(@Codi_Ruta)
					ELSE
						""
				END
				+ "
				AND Tb_Ruta_Maestro.CODI_DESTINO <> " + LTRIM(@Codi_Origen) + "
				" +
				CASE
					WHEN @Codi_Servicio != 0 THEN
						"AND Tb_Ruta_Maestro.CODI_SERVICIO = " + LTRIM(@Codi_Servicio)
					ELSE
						""
				END
				+ "
				" +
				CASE
					WHEN @Codi_Origen != 0 THEN
						"AND Tb_Ruta_Intermedio.CODI_SUCURSAL = " + LTRIM(@Codi_Origen)
					ELSE


						""
				END
				+ "
				" +
				CASE
					WHEN @Codi_Destino != 0 THEN
						"AND dst.CODI_SUCURSAL = " + LTRIM(@Codi_Destino)
					ELSE
						""
				END
				+ "
				AND CONVERT(DATETIME, Tb_Ruta_Intermedio.HORA_PASO, 300) >= CONVERT(DATETIME, DATEADD(mi, " + LTRIM(@Tiempo) + ", '" + @Hora + "'), 300)
				AND Tb_Maestro_Programacion.TR != 1 -- Gerardo
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
		SUBCONSULTA.DIAS;";

	EXECUTE sp_executesql @DynamicQuery;
	--SELECT @DynamicQuery;

END;
