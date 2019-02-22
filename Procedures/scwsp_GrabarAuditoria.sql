Create Procedure scwsp_GrabarAuditoria 
@Codi_Usuario		SmallInt,  
@Nom_Usuario		Varchar(50),  
@Tabla				Varchar(30),  
@Tipo_Movimiento	Varchar(30),  
@Boleto				Varchar(15),  
@Nume_Asiento		Varchar(10),  
@Nom_Oficina		Varchar(30),  
@Nom_PuntoVenta		Varchar(30),  
@Pasajero			Varchar(50),  
@Fecha_Viaje		DateTime,  
@Hora_Viaje			Varchar(30),  
@Nom_Destino		Varchar(30),  
@Precio				Real,  
@Obs1				Varchar(100),  
@Obs2				Varchar(100),  
@Obs3				Varchar(100),  
@Obs4				Varchar(100),  
@Obs5				Varchar(100)  
as  
set nocount on  
begin  
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
			Convert(Varchar(10),getdate(),103)		,
			Convert(Varchar(10),getdate(),108)		,
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
