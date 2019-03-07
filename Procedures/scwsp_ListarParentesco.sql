Create Procedure scwsp_ListarParentesco
as	
	Select COD_TIP Codi_Parentesco,
	NOM_TIP Nom_Parentesco From Tablas 
	Where COD_TAB=41