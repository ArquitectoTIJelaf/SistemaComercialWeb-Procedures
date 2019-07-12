Alter PROCEDURE scwsp_BuscarVentaxId
@Id_venta INT
AS
SELECT
	v.CODI_EMPRESA
	,v.SERIE_BOLETO
	,v.NUME_BOLETO
	,c.idtabla -- Para Crédito: IdPrecio
	,v.per_autoriza
	,v.FECH_ANULACION
FROM
	VENTA v
	LEFT JOIN Tb_BoletoxContrato bc ON v.id_venta = bc.Id_Venta
	LEFT JOIN tb_Control c ON bc.IdRegistro = c.Idboletocontrato
WHERE
	v.id_venta = @Id_venta
	AND v.INDI_ANULADO = 'F'
	AND v.FLAG_VENTA <> 'X'
