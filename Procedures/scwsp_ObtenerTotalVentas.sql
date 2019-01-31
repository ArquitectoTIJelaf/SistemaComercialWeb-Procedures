Create Procedure scwsp_ObtenerTotalVentas
@Codi_Programacion		Int
as
SET NOCOUNT ON
	Begin
		Select Count(1) CantidadVenta From VENTA Where CODI_PROGRAMACION=@Codi_Programacion
		and INDI_ANULADO='F'
	End