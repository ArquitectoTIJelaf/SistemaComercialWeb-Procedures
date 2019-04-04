ALTER PROCEDURE scwsp_ValidarUsuario
@Codi_Usuario		SmallInt
AS
	SELECT
		U.Codi_Usuario	,
		U.Login,
		U.Codi_Empresa	,
		U.Codi_Sucursal	,
		U.Codi_puntoVenta	,
		U.Pws				,
		U.Nivel,
		O.Descripcion Nom_Sucursal,
		PV.Descripcion Nom_PuntoVenta,
		U.Terminal
	FROM 
		Tb_Usuario U
		LEFT JOIN Tb_Oficinas O
			ON U.Codi_Sucursal = O.Codi_Sucursal
		LEFT JOIN Tb_PuntoVenta PV
			ON U.Codi_Sucursal =PV.Codi_Sucursal
			AND U.Codi_puntoVenta = PV.Codi_puntoVenta
	WHERE
		Codi_Usuario = @Codi_Usuario
