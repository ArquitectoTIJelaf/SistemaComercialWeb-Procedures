Alter Procedure scwsp_BuscarVentaxBoleto
@Tipo				Varchar(1),
@Serie_Boleto		SmallInt,
@Nume_Boleto		Int,
@Codi_Empresa		TinyInt
as
	Select v.Id_Venta, v.NOMBRE,v.cod_Origen Codi_Origen, ori.Descripcion Nom_Origen,
	v.CODI_SUBRUTA Codi_Destino, des.Descripcion Nom_Destino,
	ser.descripcion Nom_Servicio,vd.Fecha_Viaje,vd.Hora_Viaje,
	v.NUME_ASIENTO From Venta v
	Inner Join VENTA_DERIVADA vd on v.id_venta=vd.id_venta
	Inner Join Tb_Oficinas ori on v.cod_origen=ori.Codi_Sucursal
	Inner Join Tb_Oficinas des on v.CODI_SUBRUTA=des.Codi_Sucursal
	Inner Join Tb_Servicio ser on vd.Servicio=ser.Codi_Servicio
	Where v.SERIE_BOLETO=@Serie_Boleto and v.NUME_BOLETO=@Nume_Boleto and 
	v.tipo=@Tipo and v.CODI_EMPRESA=@Codi_Empresa and v.INDI_ANULADO='F'
	and v.FLAG_VENTA<>'X' and v.FLAG_VENTA<>'R'
