Create Procedure scwsp_ListarTarjetaCredito
as	
	Select COD_TIP Cod_TarjetaCredito,
	NOM_TIP Nom_TarjetaCredito From Tablas 
	Where COD_TAB=64