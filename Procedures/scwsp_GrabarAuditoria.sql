Alter Procedure scwsp_GrabarAuditoria
@Codi_Usuario		SmallInt,
@Nom_Usuario		Varchar(50),
@Tabla				Varchar(40),
@Tipo_Movimiento	Varchar(60),
@Boleto				Varchar(20),
@Nume_Asiento		Varchar(4),
@Nom_Oficina		Varchar(40),
@Nom_PuntoVenta		Varchar(40),
@Pasajero			Varchar(40),
@Fecha_Viaje		DateTime,
@Hora_Viaje			Varchar(30),
@Nom_Destino		Varchar(40),
@Precio				Real,
@Obs1				Varchar(200),
@Obs2				Varchar(200),
@Obs3				Varchar(200),
@Obs4				Varchar(200),
@Obs5				Varchar(200)
As
Set nocount on

Begin
	insert into auditoria
		(
			fecha				,
			hora				,
			codi_usuario		,
			nom_usuario			,
			tabla				,
			tipo_mov			,
			boleto				,
			asiento				,
			sucursal			,
			puntoventa			,
			pasajero			,
			fecha_viaje			,
			hora_viaje			,
			destino_pasajero	,
			precio				,
			obs1				,
			obs2				,
			obs3				,
			obs4				,
			obs5
		)
	values
	(
			Convert(Varchar(10),getdate(),103),
			Convert(Varchar(10),getdate(),108),
			@Codi_Usuario		,
			@Nom_Usuario		,
			@Tabla				,
			@Tipo_Movimiento	,
			@Boleto				,
			@Nume_Asiento		,
			@Nom_Oficina		,
			@Nom_PuntoVenta	,
			@Pasajero			,
			@Fecha_Viaje		,
			@Hora_Viaje			,
			@Nom_Destino		,
			@Precio				,
			@Obs1				,
			@Obs2				,
			@Obs3				,
			@Obs4				,
			@Obs5
	)
end
