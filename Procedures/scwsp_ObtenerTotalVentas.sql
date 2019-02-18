Alter Procedure scwsp_ObtenerTotalVentas
@Codi_Programacion		Int,
@Codi_Origen			SmallInt,
@Codi_Destino			SmallInt
as
SET NOCOUNT ON
	Begin
		Select Count(1) CantidadVenta From VENTA 
		Where CODI_PROGRAMACION=@Codi_Programacion
		and cod_origen=@Codi_Origen
		and CODI_SUBRUTA=@Codi_Destino
		and INDI_ANULADO='F'
		and NUME_ASIENTO > 0 -- Gerardo
	End
