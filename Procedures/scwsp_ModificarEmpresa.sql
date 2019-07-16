Alter PROCEDURE scwsp_ModificarEmpresa (
	@Ruc_Cliente VARCHAR(11)
	,@Razon_Social VARCHAR(100)
	,@Direccion VARCHAR(200)
	,@Telefono VARCHAR(15)
	)
AS
BEGIN
	BEGIN TRANSACTION

	UPDATE Tb_Ruc
	SET Razon_Social = Upper(@Razon_Social)
		,Direccion = @Direccion
		,Telefono = @Telefono
	WHERE Ruc_Cliente = @Ruc_Cliente

	IF @@Error <> 0
		ROLLBACK TRANSACTION
	ELSE
		COMMIT TRANSACTION
END
