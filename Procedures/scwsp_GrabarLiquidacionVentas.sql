Create Procedure scwsp_GrabarLiquidacionVentas
@NRO_LIQ			int,
@Codi_Empresa		TinyInt,
@Codi_Sucursal		SmallInt,
@Codi_Oficina		SmallInt,
@Codi_PuntoVenta	SmallInt,
@Codi_Usuario		SmallInt,--Codigo de Cajero
@TURNO				INT,
@HORA_APER			VARCHAR(7),
@FECHA_SIS			SMALLDATETIME,
@FECHA_LIQ			SMALLDATETIME,
@FECHA_CON			SMALLDATETIME,
@CLAV_RECIVIDOR		INT,
@HORA_RECIBIDOR		VARCHAR(7),
@IMP_TUR			NUMERIC(16,2),
@IMP_CAJA			NUMERIC(16,2),
@HORA_CIE			VARCHAR(7),
@NRO_VOU			INT,
@OBS				VARCHAR(100)
as
begin
	Begin Transaction
			insert into Tb_LiquidacionVentas
				(
					NRO_LIQ,
					EMPRESA,
					SUCURSAL,
					SUC_VENTA,
					PUNTO_VENTA,
					CAJERO,
					TURNO,
					HORA_APER,
					FECHA_SIS,
					FECHA_LIQ,
					FECHA_CON,
					CLAV_RECIVIDOR,
					HORA_RECIBIDOR,
					IMP_TUR,
					IMP_CAJA,
					HORA_CIE,
					NRO_VOU,
					OBS,
					ult_turno
				)
			values
				(
					@NRO_LIQ		,
					@Codi_Empresa	,
					@Codi_Sucursal	,
					@Codi_Oficina	,
					@Codi_PuntoVenta,
					@Codi_Usuario	,
					@TURNO			,
					@HORA_APER		,
					@FECHA_SIS		,
					@FECHA_LIQ		,
					@FECHA_CON		,
					@CLAV_RECIVIDOR	,
					@HORA_RECIBIDOR	,
					@IMP_TUR		,
					@IMP_CAJA		,
					@HORA_CIE		,
					@NRO_VOU		,
					@OBS			,
					@HORA_APER
				)
	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction

end