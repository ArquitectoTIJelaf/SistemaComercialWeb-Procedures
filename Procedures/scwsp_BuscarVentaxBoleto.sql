Alter Procedure scwsp_BuscarVentaxBoleto
@Tipo				Varchar(1),
@Serie_Boleto		SmallInt,
@Nume_Boleto		Int,
@Codi_Empresa		TinyInt
As

Set nocount on;

Begin

	--DECLARE @Tipo				Varchar(1)	= 'F';
	--DECLARE @Serie_Boleto		SmallInt	= 505;
	--DECLARE @Nume_Boleto		Int			= 532;
	--DECLARE @Codi_Empresa		TinyInt		= 1;

	Select Top 1
	v.Id_Venta,
	v.NOMBRE,
	v.cod_Origen Codi_Origen,
	v.CODI_SUBRUTA Codi_Destino,
	vd.Fecha_Viaje,
	vd.Hora_Viaje,
	v.NUME_ASIENTO,
	vd.Servicio as Codi_Servicio,
	v.CODI_PROGRAMACION,
	v.Punto_Venta Codi_PuntoVenta,
	p.Fech_programacion,
	p.Codi_Servicio as Codi_Servicio_programacion,
	v.FLAG_VENTA,
	v.TIPO_DOC,
	v.DNI,
	v.imp_manifiesto,
	ISNULL(p.Activo, '') as Cierre,
	an.Nivel as NivelAsiento,
	P.Codi_ruta,
	v.PREC_VENTA
	From 
		Venta v
		Inner Join VENTA_DERIVADA vd
			on v.id_venta = vd.id_venta
		Left Join Tb_Programacion p
			on v.CODI_PROGRAMACION = p.Codi_Programacion
		Left Join tb_asientonivel an
			on p.Codi_Bus = an.Codi_Bus
			and v.NUME_ASIENTO = an.Nume_Asiento
	Where
		v.tipo = @Tipo
		and v.SERIE_BOLETO = @Serie_Boleto
		and v.NUME_BOLETO = @Nume_Boleto
		and v.CODI_EMPRESA = @Codi_Empresa
		and v.CODI_PROGRAMACION > 0
		and v.INDI_ANULADO = 'F'
		and v.FLAG_VENTA not in ('X', 'R', 'O');
End;
