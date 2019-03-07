Create Procedure scwsp_ListarGerente
as
	Select
	COD_TIP Codi_Gerente,
	NOM_TIP Nom_Gerente 
	from TABLAS
	Where COD_TAB=13