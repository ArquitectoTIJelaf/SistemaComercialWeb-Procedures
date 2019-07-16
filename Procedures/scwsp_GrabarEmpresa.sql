Alter PROCEDURE scwsp_GrabarEmpresa (
	@Ruc_Cliente VARCHAR(11)
	,@Razon_Social VARCHAR(100)
	,@Direccion VARCHAR(200)
	,@Telefono VARCHAR(15)
	)
AS
BEGIN
	BEGIN TRANSACTION

	INSERT INTO Tb_Ruc (
		Ruc_Cliente
		,Razon_Social
		,Direccion
		,Telefono
		)
	VALUES (
		@Ruc_Cliente
		,Upper(@Razon_Social)
		,@Direccion
		,@Telefono
		)

	IF @@Error <> 0
		ROLLBACK TRANSACTION
	ELSE
		COMMIT TRANSACTION
END
