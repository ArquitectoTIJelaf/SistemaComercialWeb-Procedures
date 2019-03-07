Create Procedure scwsp_GrabarVentaAcompañante
@Id_Venta			Int,
@Tipo_Documento		Varchar(2),
@Numero_Documento	Varchar(15),
@NombreCompleto		Varchar(100),
@FechaNacimiento	DateTime,
@Edad				Varchar(2),
@Sexo				Varchar(1),
@Parentesco			Varchar(2),
@Id					Int Output
AS
Begin
	
	Begin Transaction
		Insert Into Tb_Venta_Acompañante(
			IDVENTA,
			TIPO_DOC,
			DNI,
			NOMBRE,
			FECHAN,
			EDAD,
			SEXO,
			PARENTESCO
		) VALUES (
			@Id_Venta,
			@Tipo_Documento,
			@Numero_Documento,
			@NombreCompleto,
			@FechaNacimiento,
			@Edad,
			@Sexo,
			@Parentesco
		)	
		Set @Id =SCOPE_IDENTITY()	
	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction

End
