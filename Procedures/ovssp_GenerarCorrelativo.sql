Create Procedure ovssp_GenerarCorrelativo
@Codi_Empresa		Tinyint,
@Codi_Documento		Varchar(2),
@Codi_Sucursal		SmallInt,
@Codi_PuntoVenta	SmallInt,
@Codi_Terminal		SmallInt,
@Tipo				Varchar(1)
as

	Select Codi_Documento, Serie,Numero from Tb_Correlativo_Documento
	Where Codi_Empresa=@Codi_Empresa and Codi_Documento=@Codi_Documento 
	and Codi_Sucursal=@Codi_Sucursal and Codi_PuntoVenta=@Codi_PuntoVenta 
	and Terminal=@Codi_Terminal and Tipo=@Tipo

