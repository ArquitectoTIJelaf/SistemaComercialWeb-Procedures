create procedure scwsp_ValidarCajaTarjetaCredito
@Nume_Caja			Varchar(7),
@Codi_Empresa		TinyInt,
@Codi_Sucursal		SmallInt,
@Codi_PuntoVenta	SmallInt
as
set nocount on
Begin	
	SELECT Nume_Caja,Conc_Caja From Caja 
	Where NUME_CAJA=@Nume_Caja and 
	Codi_Sucursal=@Codi_Sucursal and
	punto_venta=@Codi_PuntoVenta and
	Codi_Empresa=@Codi_Empresa  
End