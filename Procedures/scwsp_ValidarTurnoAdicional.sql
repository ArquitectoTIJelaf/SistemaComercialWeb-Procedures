Create Procedure scwsp_ValidarTurnoAdicional
@Nro_Viaje		int,
@Fecha_Programacion			smalldatetime

as

Set Nocount on

	Begin

		Select Top 1 1 from Tb_Fecha_Eventual Where Nro_viaje=@Nro_Viaje and Fecha=@Fecha_Programacion
		union

		select nro_viaje from Tb_Calendarios_Dias_Viaje 

		where Lunes=1 and  DATENAME(dw,@Fecha_Programacion)='Lunes' AND Nro_viaje=@Nro_Viaje

		or Martes=1 and  DATENAME(dw,@Fecha_Programacion)='Martes'  AND Nro_viaje=@Nro_Viaje

		or Miercoles=1 and  DATENAME(dw,@Fecha_Programacion)='Miercoles'  AND Nro_viaje=@Nro_Viaje

		or Jueves=1 and  DATENAME(dw,@Fecha_Programacion)='Jueves'  AND Nro_viaje=@Nro_Viaje

		or Viernes=1 and  DATENAME(dw,@Fecha_Programacion)='Viernes'  AND Nro_viaje=@Nro_Viaje

		or Sabado=1 and  DATENAME(dw,@Fecha_Programacion)='Sabado'  AND Nro_viaje=@Nro_Viaje
	End