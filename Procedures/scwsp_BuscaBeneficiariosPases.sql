Create Procedure scwsp_BuscaBeneficiariosPases 
@Codi_Socio		Varchar(2)
as
	Select 
		Nombre_Pariente  Nombre_Beneficiario,
		tipo_doc Tipo_Documento,
		t.NOM_TIP Documento,
		numero_doc	Numero_Documento,
		Sexo
		from parientes_socio ps
		Inner Join TABLAS t on ps.tipo_doc=t.COD_TIP and t.COD_TAB=56
	Where
		cod_socio=@Codi_Socio