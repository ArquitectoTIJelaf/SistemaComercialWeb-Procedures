CREATE PROCEDURE scwsp_BloquearAsientobyProgramacion
@Codi_Programacion 		int,
@Nume_Asiento			varchar(2),
@Costo					Numeric(9,2),
@Fecha_Programacion		smalldatetime,
@Codi_Terminal			Varchar(3)
as
  Begin Transaction      


		insert into Asiento  
		(
			CODI_PROGRAMACION,
			NUME_ASIENTO,
			Costo,
			CODI_TERMINAL,
			IdCID,
			Id_Users, 
			TypeApp_Id,
			t_Ruta,
			Fecha
		) 
		values
		(
			@Codi_Programacion,
			@Nume_Asiento,
			@Costo,
			@Codi_Terminal,
			'',
			0,
			1,
			'P',
			@Fecha_Programacion
		)
		Declare		@IDS			Numeric(18)	
		Set @IDS=scope_identity()		
		select @IDS as Resultado

 If @@Error<>0
        RollBack Transaction                
 Else
     Commit Transaction
