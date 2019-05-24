ALTER PROCEDURE scwsp_BuscarVentaxId
@Id_venta INT
AS
SELECT
	v.CODI_EMPRESA
	,v.PREC_VENTA AS Precio_Venta
	,p.Codi_ruta
	,vd.Fecha_Viaje
	,v.SERIE_BOLETO
	,v.NUME_BOLETO
	,v.FECH_VENTA AS Fecha_Venta
	,v.Tipo
	,c.idtabla -- Para Crédito: IdPrecio
FROM
	VENTA v
	INNER JOIN VENTA_DERIVADA vd ON v.id_venta = vd.id_venta
	INNER JOIN Tb_Programacion p ON v.CODI_PROGRAMACION = p.Codi_Programacion
	LEFT JOIN Tb_BoletoxContrato bc ON v.id_venta = bc.Id_Venta
	LEFT JOIN tb_Control c ON bc.IdRegistro = c.Idboletocontrato
WHERE
	v.id_venta = @Id_venta
	AND v.INDI_ANULADO = 'F'
	AND v.FLAG_VENTA <> 'X'
