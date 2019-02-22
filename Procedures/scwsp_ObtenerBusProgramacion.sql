Alter Procedure scwsp_ObtenerBusProgramacion
@Codi_Programacion		int
as
Begin
	select p.Codi_bus,b.Plan_bus,b.Nume_Pasajeros,b.Plac_bus,
	p.Codi_Chofer,ch.nomb_Chofer Nombre_Chofer,p.Codi_Copiloto,
	co.nomb_Chofer Nombre_Copiloto from Tb_Programacion p with(nolock)
	Inner Join Tb_Bus b on p.Codi_Bus=b.Codi_Bus
	Inner Join Tb_Chofer ch on p.Codi_Chofer=ch.Codi_Chofer
	Inner Join Tb_Chofer co on p.Codi_Copiloto=co.Codi_Chofer
	Where Codi_Programacion=@Codi_Programacion 
End