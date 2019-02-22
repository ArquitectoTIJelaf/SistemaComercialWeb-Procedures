Create Procedure scwsp_ValidarBloqueoAsiento
@Codi_Programacion 		Int,
@Nro_Viaje 				Int,
@Codi_Origen			SmallInt,
@Codi_Destino			SmallInt,
@Nume_Asiento			Varchar(2),
@Fecha_Programacion		SmallDatetime
as
Set NoCount On

	Declare @Codi_Sucursal			SmallInt
	Declare @Codi_Ruta				SmallInt
	Declare @Codi_Servicio			TinyInt
	Declare @Codi_Empresa			TinyInt
	Declare @Turno					Varchar(10)

	Set @Codi_Sucursal	= 0
	Set @Codi_Ruta		= 0
	Set @Codi_Servicio	= 0
	Set @Codi_Empresa	= 0
	Set @Turno			= ''

	Select @Codi_Empresa= mp.Codi_Empresa,@Codi_Sucursal=rm.Codi_Sucursal,
	@Codi_Ruta=rm.CODI_DESTINO,@Codi_Servicio=rm.Codi_Servicio,@Turno=mp.HORA 
	From Tb_Maestro_Programacion mp
	Inner Join Tb_Ruta_Maestro rm on mp.NRO_RUTA=rm.NRO_RUTA
	Where mp.NRO_VIAJE=@Nro_Viaje

	If @Codi_Programacion>0
		Begin
			SELECT Top 1 1 FROM Asiento 
			where CODI_PROGRAMACION=@Codi_Programacion AND NUME_ASIENTO=@Nume_Asiento and t_ruta='P'
			Union
			SELECT Top 1 1 FROM VENTA 
			where CODI_PROGRAMACION=@Codi_Programacion AND NUME_ASIENTO=@Nume_Asiento 
			and cod_origen=@Codi_Origen and CODI_SUBRUTA=@Codi_Destino
			and INDI_ANULADO='F'
			Union
			Select Top 1 1 From Tb_AsientosBloqueados 
			Where cod_OrigenP=@Codi_Origen and Cod_DestinoP=@Codi_Destino
			and Cod_OrigenB=@Codi_Sucursal and Cod_DestinoB=@Codi_Ruta 
			and Cod_Servicio=@Codi_Servicio and cod_empresa=@Codi_Empresa
			and horario=@Turno
		End
	Else
		Begin
			SELECT Top 1 1 FROM Asiento 
			where CODI_PROGRAMACION=@Nro_Viaje AND NUME_ASIENTO=@Nume_Asiento and t_ruta='V'
			and Fecha=@Fecha_Programacion
			Union
			Select Top 1 1 From Tb_AsientosBloqueados 
			Where cod_OrigenP=@Codi_Origen and Cod_DestinoP=@Codi_Destino
			and Cod_OrigenB=@Codi_Sucursal and Cod_DestinoB=@Codi_Ruta 
			and Cod_Servicio=@Codi_Servicio and cod_empresa=@Codi_Empresa
			and horario=@Turno
		End
	
