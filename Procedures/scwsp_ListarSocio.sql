Create Procedure scwsp_ListarSocio
as
	Select
	COD_TIP Codi_Socio,
	NOM_TIP Nom_Socio 
	from TABLAS
	Where COD_TAB=26