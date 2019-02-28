Create Procedure scwsp_BuscarCorrelativo
@Codi_Empresa		TinyInt,
@Codi_Documento		Varchar(2),
@Codi_Sucursal		SmallInt,
@Codi_PuntoVenta	SmallInt,
@Terminal			Char(3),
@Tipo				Char(1)
as
Select Serie,Numero from Tb_Correlativo_Documento 
Where 
Codi_Empresa=		@Codi_Empresa		and
Codi_Documento=		@Codi_Documento		and
Codi_Sucursal=		@Codi_Sucursal		and
Codi_PuntoVenta=	@Codi_PuntoVenta	and
Terminal=			@Terminal			and
Tipo=@Tipo