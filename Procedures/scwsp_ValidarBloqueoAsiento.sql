Alter Procedure scwsp_ValidarBloqueoAsiento
@Codi_Programacion 		Int,
@Nro_Viaje 				Int,
@Codi_Origen			SmallInt,
@Codi_Destino			SmallInt,
@Nume_Asiento			Varchar(2),
@Fecha_Programacion		SmallDatetime
As

Set NoCount On
	
	-- Tabla Tb_AsientosBloqueados
	Declare @Codi_Sucursal			SmallInt = 0;
	Declare @Codi_Ruta				SmallInt = 0;
	Declare @Codi_Servicio			TinyInt = 0;
	Declare @Codi_Empresa			TinyInt = 0;
	Declare @Turno					Varchar(10) = '';

	Select 
		@Codi_Empresa= mp.Codi_Empresa,
		@Codi_Sucursal=rm.Codi_Sucursal,
		@Codi_Ruta=rm.CODI_DESTINO,
		@Codi_Servicio=rm.Codi_Servicio,
		@Turno=mp.HORA 
	From
		Tb_Maestro_Programacion mp
		Inner Join Tb_Ruta_Maestro rm
		on mp.NRO_RUTA=rm.NRO_RUTA
	Where
		mp.NRO_VIAJE=@Nro_Viaje
	
	Declare @Asientos				Varchar(100)
	Declare @Codi_OrigenP			SmallInt
	Declare @Codi_DestinoP			SmallInt
	
	Declare @NumeroBloque			Int
	Declare @CantBloques			Int
	Declare @Tabla					Table (Nume_Asiento Int, Codi_Origen SmallInt, Codi_Destino SmallInt)
	
	DECLARE AsientoBloqInfo CURSOR FOR 
		Select
			Asientos,cod_OrigenP,Cod_DestinoP
		From
			Tb_AsientosBloqueados 
		Where
			Cod_OrigenB=@Codi_Sucursal
			and Cod_DestinoB=@Codi_Ruta 
			and Cod_Servicio=@Codi_Servicio
			and cod_empresa=@Codi_Empresa
			and horario=@Turno
	OPEN AsientoBloqInfo
	FETCH NEXT FROM AsientoBloqInfo INTO @Asientos, @Codi_OrigenP, @Codi_DestinoP
	WHILE @@fetch_status = 0
	BEGIN
		Set @CantBloques = Len(@Asientos)
		Set @NumeroBloque = 1
		While (@NumeroBloque < @CantBloques)
			Begin
				Insert Into @Tabla(Nume_Asiento, Codi_Origen, Codi_Destino)
				Values(cast(SUBSTRING(@Asientos, @NumeroBloque, 2)as Int),@Codi_OrigenP, @Codi_DestinoP)
				Set @NumeroBloque = @NumeroBloque + 2
			End
		FETCH NEXT FROM AsientoBloqInfo INTO @Asientos, @Codi_OrigenP, @Codi_DestinoP
	END
	CLOSE AsientoBloqInfo
	DEALLOCATE AsientoBloqInfo

	If @Codi_Programacion > 0
		Begin
			SELECT Top 1 1 FROM Asiento 
			where
				CODI_PROGRAMACION=@Codi_Programacion
				and NUME_ASIENTO=@Nume_Asiento
				and t_ruta='P'

			UNION

			SELECT Top 1 1 FROM VENTA 
			where
				CODI_PROGRAMACION=@Codi_Programacion
				and NUME_ASIENTO=@Nume_Asiento 
				and cod_origen=@Codi_Origen
				and CODI_SUBRUTA=@Codi_Destino
				and INDI_ANULADO='F'

			UNION

			SELECT Top 1 1 FROM @Tabla
			where
				NUME_ASIENTO= Cast(@Nume_Asiento as int)
				and Codi_Origen=@Codi_Origen
				and Codi_Destino=@Codi_Destino
		End
	Else
		Begin
			SELECT Top 1 1 FROM Asiento 
			where
				CODI_PROGRAMACION=@Nro_Viaje
				and NUME_ASIENTO=@Nume_Asiento
				and t_ruta='V'
				and Fecha=@Fecha_Programacion

			UNION

			SELECT Top 1 1 FROM @Tabla
			where
				NUME_ASIENTO= Cast(@Nume_Asiento as int)
				and Codi_Origen=@Codi_Origen
				and Codi_Destino=@Codi_Destino
		End
