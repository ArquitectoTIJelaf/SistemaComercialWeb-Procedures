Alter proc scwsp_Tb_Venta_Reintegro_Consulta_Anul_Ele -- scwsp_Tb_Venta_Reintegro_Consulta_Anul_Ele '326','0000663', 1, 'F'
@ser  varchar(3),
@bol  varchar(7),
@emp  varchar(2),
@tipo varchar(1)
As
Begin
	Set nocount on

	Select
		id_venta, codi_esca, Codi_Sucursal, PREC_VENTA, tipo_pago, clav_usuario, tipo, NIT_CLIENTE, FECH_VENTA, CODI_EMPRESA,
		SUC_VENTA, NOMBRE, TIPO_DOC, DNI, EDAD, TELEFONO
	From
		VENTA
	Where
		serie_boleto = @ser
		and Nume_boleto = @bol
		and tipo = @tipo
		and codi_Empresa = @emp
		and (flag_venta = 'O' or flag_venta = '1')
		and indi_anulado = 'F'
		and CODI_PROGRAMACION > 0
End;
