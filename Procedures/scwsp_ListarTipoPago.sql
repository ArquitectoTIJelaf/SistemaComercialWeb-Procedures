Create Procedure scwsp_ListarTipoPago
as	
	Select COD_TIP Codi_Tipo_Pago,
	NOM_TIP Nom_Tipo_Pago From Tablas 
	Where COD_TAB=40