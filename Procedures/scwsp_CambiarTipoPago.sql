-- =============================================
-- Author:		Héctor Salazar
-- Create date: 09/09/2019
-- Description:	RESTAR_AL_VALE_TC, Tb_venta_Delete_Tarjeta,
--				Tb_Venta_Update_Tipo_Pago
-- =============================================
CREATE PROCEDURE scwsp_CambiarTipoPago
 @Id_Venta		INT,
 @NewTipoPago	VARCHAR(2),
 @OldTipoPago	VARCHAR(2),
 @cc			NUMERIC(15,2),
 @emp			CHAR(2)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE 
	 @total			REAL,
	 @Vale			VARCHAR(30),
	 @nume			CHAR(7),
	 @suc			CHAR(3),
	 @pventa		CHAR(3),
	 @NUME_CAJA		VARCHAR(7),
	 @CONC_CAJA		VARCHAR(150),
	 @NewConc		VARCHAR(30)

	DECLARE @tb_temp1 TABLE(total REAL, Vale VARCHAR(30)) 

	DECLARE @tb_tempAux1 TABLE(NUME_CAJA VARCHAR(7), CONC_CAJA VARCHAR(150))

	BEGIN TRY
		BEGIN TRAN

		IF(@NewTipoPago = '01' OR @NewTipoPago = '02' OR @NewTipoPago = '04')
		BEGIN
			IF(@OldTipoPago = '03')
			BEGIN
				/*Seteo de Total y Vale de Caja*/				
				INSERT INTO @tb_temp1 EXEC Usp_Tb_venta_Consulta_Tarjeta @Id_Venta
				SELECT @total = total, @Vale = Vale FROM @tb_temp1

				/*Seteo de Numero de Caja, Sucursal y Punto de Venta*/
				SET @nume = (select SUBSTRING(@Vale, 7, 7))
				SET @suc = (select SUBSTRING(@Vale, 1, 3))
				SET @pventa = (select SUBSTRING(@Vale, 4, 3))

				/*Consulta Numero de Caja y Concatenado*/				 
				INSERT INTO @tb_tempAux1 EXEC Usp_Tb_Caja_Consulta_Tarjeta @nume, @suc, @pventa, @emp
				SELECT @NUME_CAJA = NUME_CAJA, @CONC_CAJA = CONC_CAJA FROM @tb_tempAux1

				IF(@NUME_CAJA <> NULL AND @CONC_CAJA <> NULL)
				BEGIN
					IF(@CONC_CAJA = (select CONCAT (tipo,FORMAT(SERIE_BOLETO,'000'),'-',FORMAT(NUME_BOLETO,'0000000')) from VENTA where id_venta = @Id_Venta))
					BEGIN
						/*Actualiza Caja con Indi_Anulado = 'T'*/
						EXEC Usp_Tb_Caja_Anula_Tarjeta @nume, @suc, @pventa, @emp
					END
					ELSE
					BEGIN
						/*TODO: Verificar con el código de cliente servidor*/
						SET @NewConc = @CONC_CAJA
						/*Actualiza Monto de Caja y Concatenado*/
						EXEC Usp_Tb_Caja_Update_Tarjeta @nume, @suc, @pventa, @emp, @total, @NewConc
					END
				END

				/*Elimina de TB_PAGOTARJETAVENTA*/
				EXEC Usp_Tb_venta_Delete_Tarjeta @Id_Venta

				/*Actualiza el Tipo de Pago y Crédito de Venta*/
				EXEC Usp_Tb_venta_Update_TPago @Id_Venta, @NewTipoPago, @cc
			END
			ELSE
			BEGIN
				IF(@OldTipoPago = '01' OR @OldTipoPago = '02' OR @OldTipoPago = '04')
				BEGIN
					/*Actualiza el Tipo de Pago y Crédito de Venta*/
					EXEC Usp_Tb_venta_Update_TPago @Id_Venta, @NewTipoPago, @cc
				END
			END
		END
		ELSE
		BEGIN
			IF(@NewTipoPago = '03')
			BEGIN				
				/*Seteo de Total y Vale de Caja*/
				INSERT INTO @tb_temp1 EXEC Usp_Tb_venta_Consulta_Tarjeta @Id_Venta
				SELECT @total = total, @Vale = Vale FROM @tb_temp1

				/*Seteo de Numero de Caja, Sucursal y Punto de Venta*/
				SET @nume = (select SUBSTRING(@Vale, 7, 7))
				SET @suc = (select SUBSTRING(@Vale, 1, 3))
				SET @pventa = (select SUBSTRING(@Vale, 4, 3))

				IF(@OldTipoPago = '03')
				BEGIN
					/*Consulta Numero de Caja y Concatenado*/ 
					INSERT INTO @tb_tempAux1 EXEC Usp_Tb_Caja_Consulta_Tarjeta @nume, @suc, @pventa, @emp
					SELECT @NUME_CAJA = NUME_CAJA, @CONC_CAJA = CONC_CAJA FROM @tb_tempAux1

					IF(@NUME_CAJA <> NULL AND @CONC_CAJA <> NULL)
					BEGIN
						IF(@CONC_CAJA = (select CONCAT (tipo,FORMAT(SERIE_BOLETO,'000'),'-',FORMAT(NUME_BOLETO,'0000000')) from VENTA where id_venta = @Id_Venta))
						BEGIN
							/*Actualiza Caja con Indi_Anulado = 'T'*/
							EXEC Usp_Tb_Caja_Anula_Tarjeta @nume, @suc, @pventa, @emp
						END
						ELSE
						BEGIN
							/*TODO: Verificar con el código de cliente servidor*/
							SET @NewConc = @CONC_CAJA
							/*Actualiza Monto de Caja y Concatenado*/
							EXEC Usp_Tb_Caja_Update_Tarjeta @nume, @suc, @pventa, @emp, @total, @NewConc
						END
					END
				END
				ELSE
				BEGIN
					/*Actualiza el Tipo de Pago y Crédito de Venta*/
					EXEC Usp_Tb_venta_Update_TPago @Id_Venta, @NewTipoPago, @cc
				END
				/*TODO: Else con TipoPago 44 y Flag '' no considerado*/

				/*Elimina de TB_PAGOTARJETAVENTA*/
				EXEC Usp_Tb_venta_Delete_Tarjeta @Id_Venta
			END
		END

		SELECT NUME_CAJA, CONC_CAJA FROM @tb_tempAux1


		IF (@@TRANCOUNT > 0)
			COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT 'Linea: ' + CAST(ERROR_LINE() AS VARCHAR(10)) + ', Store: ' + ERROR_PROCEDURE() + ', Mensaje: ' + ERROR_MESSAGE()
		ROLLBACK TRAN
	END CATCH		
	SET NOCOUNT OFF;
END
GO