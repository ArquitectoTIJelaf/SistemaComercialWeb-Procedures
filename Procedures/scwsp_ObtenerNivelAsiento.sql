Create Procedure scwsp_ObtenerNivelAsiento
@Codi_Bus			Varchar(5),
@Nume_Asiento		Int
as
	Begin
		select Nivel from Tb_AsientoNivel 
		Where Codi_Bus=@Codi_Bus and Nume_Asiento=@Nume_Asiento
	End


