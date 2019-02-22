Create Procedure scwsp_BuscarPasajero
@Tipo_Doc_Id		Char(1),
@Numero_Doc			Varchar(15)
as
	Select 
		Id_Clientes		, 
		Tipo_Doc_id		,
		Numero_Doc		,
		Nombre_Clientes	,
		Apellido_P		,
		Apellido_M		,
		fec_nac			,
		edad			,
		Direccion		,
		telefono		,
		ruc_contacto	,
		sexo
	From Tb_Cliente_Pasajes
	Where 
		Tipo_Doc_id=@Tipo_Doc_Id and 
		Numero_Doc=@Numero_Doc
