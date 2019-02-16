
Create procedure scwsp_ListaTipoDocumento
as
Set NoCount On

	SELECT IdTypeDoc as Codi_Documento,NameTypeDoc as Nom_Documento,
	LOngTypeDoc Lon_Documento from vw_TypeDoc
	Where IdTypeDoc<>0


