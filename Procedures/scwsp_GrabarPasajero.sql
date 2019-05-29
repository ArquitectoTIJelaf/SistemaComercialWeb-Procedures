ALTER PROCEDURE scwsp_GrabarPasajero (
	@Tipo_Doc_Id CHAR(1)
	,@Numero_Doc VARCHAR(15)
	,@Nombre_Clientes VARCHAR(100)
	,@Apellido_P VARCHAR(50)
	,@Apellido_M VARCHAR(50)
	,@fec_nac SMALLDATETIME
	,@edad TINYINT
	,@Direccion VARCHAR(100)
	,@telefono VARCHAR(15)
	,@ruc_contacto VARCHAR(11)
	,@Id_Clientes INT OUTPUT
	,@sexo CHAR(1)
)
AS
BEGIN
	BEGIN TRANSACTION

	IF NOT EXISTS (SELECT TOP 1 1 FROM Tb_Cliente_Pasajes WHERE Tipo_Doc_id = @Tipo_Doc_Id AND Numero_Doc = @Numero_Doc)
	BEGIN
		INSERT INTO Tb_Cliente_Pasajes (
		Tipo_Doc_id
		,Numero_Doc
		,Nombre_Clientes
		,Apellido_P
		,Apellido_M
		,fec_nac
		,edad
		,Direccion
		,telefono
		,ruc_contacto
		,sexo
		)
	VALUES (
		@Tipo_Doc_Id
		,@Numero_Doc
		,@Nombre_Clientes
		,@Apellido_P
		,@Apellido_M
		,@fec_nac
		,@edad
		,@Direccion
		,@telefono
		,@ruc_contacto
		,@sexo
		)
	END;

	SET @Id_Clientes = SCOPE_IDENTITY()

	IF @@ERROR <> 0
		ROLLBACK TRANSACTION
	ELSE
		COMMIT TRANSACTION
END
