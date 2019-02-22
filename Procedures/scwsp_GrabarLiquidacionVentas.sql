Create Procedure scwsp_GrabarLiquidacionVentas
@NRO_LIQ			int,
@Codi_Empresa		TinyInt,
@Codi_Sucursal		SmallInt,
--@Codi_Oficina		SmallInt,
@Codi_PuntoVenta	SmallInt,
@Codi_Usuario		SmallInt,--Codigo de Cajero
@IMP_TUR			NUMERIC(16,2)
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
					@Codi_Sucursal	,
					@Codi_PuntoVenta,
					@Codi_Usuario	,
					1				,
					Convert(Varchar(10),getdate(),108)		,
					Convert(Varchar(10),getdate(),103)		,
					Convert(Varchar(10),getdate(),103)		,
					Convert(Varchar(10),getdate(),103)		,
					0	,
					''	,
					@IMP_TUR		,
					0		,
					Convert(Varchar(10),getdate(),108)		,
					0		,
					'Cierre Parcial'			,
					Convert(Varchar(10),getdate(),108)
				)
	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction

end