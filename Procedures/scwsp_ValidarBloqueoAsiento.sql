Alter Procedure scwsp_ValidarBloqueoAsiento
@Codi_Programacion 		Int,
@Nro_Viaje 				Int,
@Codi_Origen			SmallInt,
@Codi_Destino			SmallInt,
@Nume_Asiento			Varchar(2),
@Fecha_Programacion		SmallDatetime
As

Begin

	--Declare @Codi_Programacion 		Int = 0;
	--Declare @Nro_Viaje 				Int = 514;
	--Declare @Codi_Origen			SmallInt = 6;
	--Declare @Codi_Destino			SmallInt = 1;
	--Declare @Nume_Asiento			Varchar(2) = '33';
	--Declare @Fecha_Programacion		SmallDatetime = '08/08/2019';

	Set NoCount On

	Declare @Validator bit = 0;

	Select Top 1
		@Validator = 1
	From
		Asiento
	Where
		CODI_PROGRAMACION = CASE WHEN @Codi_Programacion > 0 THEN @Codi_Programacion ELSE @Nro_Viaje END
		and NUME_ASIENTO = Cast(@Nume_Asiento as tinyint)
		and t_ruta = CASE WHEN @Codi_Programacion > 0 THEN 'P' ELSE 'V' END
		and Fecha = @Fecha_Programacion;
	
	If(@Validator <= 0)
	Begin
		-- Tabla bloqueo_asientos --------------------------
		With bloqueo_asientos02 as (
			Select
				RIGHT(asientos_ocupados, LEN(asientos_ocupados) - 2) as Asientos,
				SUBSTRING(asientos_ocupados,1,2) as Nume_Asiento,
				codi_origen as Codi_Origen,
				codi_destino as Codi_Destino
			From
				bloqueo_asientos
			Where
				codi_programacion =  CASE WHEN @Codi_Programacion > 0 THEN @Codi_Programacion ELSE @Nro_Viaje END
				and TIPO = CASE WHEN @Codi_Programacion > 0 THEN 'P' ELSE 'V' END
				and fecha = @Fecha_Programacion
				and LEN(asientos_ocupados) <> 0

			UNION ALL
			
			Select
				RIGHT(Asientos, LEN(Asientos) - 2) as Asientos,
				SUBSTRING(Asientos,1,2) as Nume_Asiento,
				Codi_Origen,
				Codi_Destino
			From
				bloqueo_asientos02
			Where
				LEN(Asientos) <> 0
		)

		Select Top 1
			@Validator = 1
		From
			bloqueo_asientos02
		Where
			NUME_ASIENTO = Cast(@Nume_Asiento as int)
			and Codi_Origen = @Codi_Origen
			and Codi_Destino = @Codi_Destino;


		If(@Validator <= 0 and @Codi_Programacion > 0)
		Begin
			Select Top 1
				@Validator = 1
			From
				VENTA
			Where
				CODI_PROGRAMACION = @Codi_Programacion
				and NUME_ASIENTO = @Nume_Asiento 
				and cod_origen = @Codi_Origen
				and CODI_SUBRUTA = @Codi_Destino
				and INDI_ANULADO = 'F'
		End;
	End;

	Select @Validator as 'Validator';
End;
