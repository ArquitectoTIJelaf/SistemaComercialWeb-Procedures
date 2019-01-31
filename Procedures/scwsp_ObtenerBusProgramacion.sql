Create Procedure scwsp_ObtenerBusProgramacion
@Codi_Programacion		int
as
Begin
	select p.Codi_bus,b.Plan_bus,b.Nume_Pasajeros,b.Plac_bus from Tb_Programacion p with(nolock)
	Inner Join Tb_Bus b on p.Codi_Bus=b.Codi_Bus
	Where Codi_Programacion=@Codi_Programacion 
End