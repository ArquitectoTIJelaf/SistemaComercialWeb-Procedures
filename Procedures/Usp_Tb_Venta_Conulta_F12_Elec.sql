create procedure [dbo].[Usp_Tb_Venta_Conulta_F12_Elec]
@serie	 int,
@numero  int,
@Empresa int,
@Tipo varchar(1)
as
set nocount on
begin
SELECT     
dbo.VENTA.SERIE_BOLETO, dbo.VENTA.NUME_BOLETO, dbo.VENTA.CODI_EMPRESA, dbo.VENTA.TIPO_DOC, dbo.VENTA.CODI_ESCA, 
dbo.VENTA.FLAG_VENTA, dbo.VENTA.INDI_ANULADO, dbo.VENTA.id_venta, dbo.VENTA.DNI, dbo.VENTA.NOMBRE, dbo.VENTA.NIT_CLIENTE, 
dbo.VENTA.NUME_ASIENTO, dbo.VENTA.PREC_VENTA, dbo.VENTA.CODI_SUBRUTA, dbo.VENTA_DERIVADA.Fecha_Viaje, 
dbo.VENTA_DERIVADA.Hora_Viaje,dbo.VENTA.CODI_PROGRAMACION,dbo.VENTA.COD_ORIGEN,isnull(sube_en,0) sube_en,isnull(baja_en,0) baja_en
,isnull(EDAD,'') EDAD,isnull(TELEFONO,'') TELEFONO ,isnull(nacionalidad,'') nacionalidad,dbo.VENTA.TIPO
FROM         
dbo.VENTA INNER JOIN
dbo.VENTA_DERIVADA ON dbo.VENTA.id_venta = dbo.VENTA_DERIVADA.id_venta
where 
venta.serie_boleto=@serie and
venta.nume_boleto=@numero and 
venta.codi_empresa=@Empresa and VENTA.tipo=@Tipo
end
