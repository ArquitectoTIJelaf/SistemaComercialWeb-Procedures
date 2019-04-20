Alter Procedure scwsp_AnularVenta
@Id_Venta		Int,--Codigo de Ventas
@Codi_Usuario	SmallInt--Codigo de Usario de Anulacion
as
	Update Venta
	Set INDI_ANULADO='T',
		FECH_ANULACION=Convert(Varchar(10),getdate(),103),
		clav_usuario1=@Codi_Usuario
	Where Id_Venta=@Id_Venta
