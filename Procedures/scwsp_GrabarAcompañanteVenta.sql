Create Procedure scwsp_GrabarAcompañanteVenta
@IDVENTA		Int,
@TIPO_DOC		Varchar(2),
@DNI			Varchar(15),
@NOMBRE			Varchar(100),
@FECHAN			DateTime,
@EDAD			Varchar(2),
@SEXO			Varchar(1),
@PARENTESCO		Varchar(2)
AS
SET NOCOUNT ON
BEGIN
	Begin Transaction
		Insert Into TB_VENTA_ACOMPAÑANTE
			(
				IDVENTA			,
				TIPO_DOC		,
				DNI				,
				NOMBRE			,
				FECHAN			,
				EDAD			,
				SEXO			,
				PARENTESCO
			) 
		Values 
			(
				@IDVENTA		,
				@TIPO_DOC		,
				@DNI			,
				@NOMBRE			,
				@FECHAN			,
				@EDAD			,
				@SEXO			,
				@PARENTESCO	
			)	
			
	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction

END
