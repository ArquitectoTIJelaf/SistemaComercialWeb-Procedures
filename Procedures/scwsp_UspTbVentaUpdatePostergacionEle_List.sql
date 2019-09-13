-- =============================================
-- Author:		Héctor Salazar
-- Create date: 20/08/2019
-- Description:	Si es Flag_Venta R (Reserva): actualiza codi_programacion
--				Sino: Actualiza en VENTA (original y reintegro) y Fecha Abierta
-- =============================================
CREATE PROCEDURE scwsp_UspTbVentaUpdatePostergacionEle_List
 @Lista		XML
AS
BEGIN

	SET NOCOUNT ON;

	--Variables del antiguo procedure
	DECLARE 
	 @id				NUMERIC(18),
	 @corr				VARCHAR(12),
	 @subruta			VARCHAR(3),
	 @prog				INT,
	 @emp				INT,
	 @vl_Numero_reint2	VARCHAR(15)

	--Detalle Cursor
	DECLARE 
	 @vl_Numero_reint	VARCHAR(15),
	 @vl_programacion	VARCHAR(10),
	 @vl_origen			VARCHAR(3),
	 @vl_id_Venta		NUMERIC(15),
	 @vl_asiento		VARCHAR(2),
	 @vl_ruta			VARCHAR(3),
	 @vl_servicio		VARCHAR(2),
	 @vl_TipoDoc		VARCHAR(1),
	 @vl_FechaViaje		VARCHAR(10),
	 @vl_HoraViaje		VARCHAR(10),
	 @vl_FlagVenta		VARCHAR(2)

	/*Estructura de Detalle de Liquidación en Temporal*/
	DECLARE @temp_Lista	TABLE(
	 Numero_reint		VARCHAR(15),
	 programacion		VARCHAR(10),
	 origen				VARCHAR(3),
	 id_Venta			NUMERIC(15),
	 asiento			VARCHAR(2),
	 ruta				VARCHAR(3),
	 servicio			VARCHAR(2),
	 TipoDoc			VARCHAR(1),
	 Boleto				VARCHAR(12),
	 Pasajero			VARCHAR(100),
	 FechaViaje			VARCHAR(10),
	 HoraViaje			VARCHAR(10),
	 FlagVenta			VARCHAR(2)
	);
	
	BEGIN TRY
		BEGIN TRAN

			/*Inserción en el Temporal*/
			INSERT @temp_Lista (Numero_reint, programacion, origen, id_Venta, asiento, ruta, servicio, TipoDoc, Boleto, Pasajero, FechaViaje, HoraViaje, FlagVenta)
			SELECT 
			 M.Item.query('./NumeroReintegro').value('.','VARCHAR(15)'),
			 M.Item.query('./CodiProgramacion').value('.','VARCHAR(10)'),
			 M.Item.query('./Origen').value('.','VARCHAR(3)'),
			 M.Item.query('./IdVenta').value('.','NUMERIC(15)'),	
			 M.Item.query('./NumeAsiento').value('.','VARCHAR(2)'),	
			 M.Item.query('./Ruta').value('.','VARCHAR(3)'),
			 M.Item.query('./CodiServicio').value('.','VARCHAR(2)'),
			 M.Item.query('./TipoDoc').value('.','VARCHAR(1)'),
			 M.Item.query('./Boleto').value('.','VARCHAR(12)'),
			 M.Item.query('./Pasajero').value('.','VARCHAR(100)'),
			 M.Item.query('./FechaViaje').value('.','VARCHAR(10)'),
			 M.Item.query('./HoraViaje').value('.','VARCHAR(10)'),
			 M.Item.query('./FlagVenta').value('.','VARCHAR(2)')
			FROM @Lista.nodes('/PaseLoteList/FiltroPaseLote') AS M(Item);

			/* Cursor para insertar detalles*/
			DECLARE cTempList CURSOR FOR
			SELECT Numero_reint, programacion, origen, id_Venta, asiento, ruta, servicio, TipoDoc, FechaViaje, HoraViaje, FlagVenta
			FROM @temp_Lista
			OPEN cTempList
			FETCH cTempList INTO  @vl_Numero_reint, @vl_programacion, @vl_origen, @vl_id_Venta, @vl_asiento, @vl_ruta, @vl_servicio, @vl_TipoDoc, @vl_FechaViaje, @vl_HoraViaje, @vl_FlagVenta
			WHILE (@@FETCH_STATUS = 0 )
			BEGIN
				SET @corr = '';
				SET @vl_Numero_reint2 = '';

				IF NOT EXISTS(select * from venta where CODI_PROGRAMACION = @vl_programacion and 
					NUME_ASIENTO = @vl_asiento and CODI_SUBRUTA = @vl_ruta and cod_origen = @vl_origen and INDI_ANULADO = 'F'
					and CODI_PROGRAMACION <> 0 and NUME_ASIENTO <> 0)
				BEGIN
					IF(@vl_FlagVenta = 'R')
					BEGIN
						UPDATE venta SET codi_programacion = @vl_programacion WHERE id_venta = @vl_id_Venta
					END
					ELSE
					BEGIN
				
						SELECT @corr = ISNULL(correlativo,'') FROM tb_venta_alterna WHERE id_venta = @vl_id_Venta

						IF @corr <> ''
						BEGIN
							IF @vl_programacion = '0'
							BEGIN
								UPDATE venta 
								SET 
								 codi_programacion	= '0',
								 nume_asiento		= @vl_asiento 
								WHERE id_venta IN (select id_venta from tb_venta_alterna where correlativo = @corr)

								UPDATE tb_venta_alterna	
								SET 
								 codi_programacion_alt = '0' 
								WHERE id_venta IN (select id_venta from tb_venta_alterna where correlativo = @corr)
		
								UPDATE venta 
								SET 
								 codi_programacion = '0' 
								WHERE id_venta IN (select id_venta from venta v1 
													where exists(select 1 from venta v2 where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr) and 
													 v1.tipo=left(isnull(v2.codi_esca,''),1) and v1.SERIE_BOLETO=substring(isnull(v2.codi_esca,''),2,3) and v1.NUME_BOLETO=substring(v2.codi_esca,6,7)))
		
								INSERT INTO Tb_Datos_FechaAbierta(id_Venta, codi_ruta, codi_servicio)
								SELECT id_venta,@vl_ruta,@vl_servicio FROM tb_venta_alterna WHERE correlativo = @corr

								INSERT INTO Tb_Datos_FechaAbierta(id_Venta, codi_ruta, codi_servicio)
								SELECT id_venta,@vl_ruta,@vl_servicio FROM venta v1 WHERE exists(select 1 from venta v2 where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr) and 
																					v1.tipo=left(isnull(v2.codi_esca,''),1) and v1.SERIE_BOLETO=substring(isnull(v2.codi_esca,''),2,3) and v1.NUME_BOLETO=substring(v2.codi_esca,6,7))
							END
							ELSE
							BEGIN
								UPDATE venta 
								SET 
								 codi_programacion=@vl_programacion,
								 nume_asiento=@vl_asiento 
								WHERE id_venta IN (select id_venta from tb_venta_alterna where correlativo = @corr)

								UPDATE tb_venta_alterna 
								SET codi_programacion_alt = @vl_programacion 
								WHERE id_venta IN (select id_venta from tb_venta_alterna where correlativo = @corr)

								DELETE Tb_Datos_FechaAbierta WHERE id_venta IN (select id_venta from tb_venta_alterna where correlativo = @corr)

								DELETE Tb_Datos_FechaAbierta 
								WHERE 
								 id_venta IN (select id_venta from venta v1 where exists(select 1 from venta v2 where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr) and 
								 v1.tipo=left(isnull(v2.codi_esca,''),1) and v1.SERIE_BOLETO=substring(isnull(v2.codi_esca,''),2,3) and v1.NUME_BOLETO=substring(v2.codi_esca,6,7)))

								DECLARE xcursor CURSOR FOR
								SELECT id_venta,codi_ruta FROM vw_venta_general WHERE correlativo = @corr --codi_programacion = @vl_programacion
								OPEN xcursor
								FETCH NEXT FROM xcursor INTO @id, @subruta
									WHILE @@fetch_status=0
										BEGIN
											SELECT @prog = prog_alterna FROM tb_prog_alt WHERE prog_general = @vl_programacion AND destino = @subruta

											IF @prog<>'0'
											BEGIN
												UPDATE tb_venta_alterna
												SET codi_programacion_alt=@prog 
												WHERE id_venta = convert(numeric(18),@id)
											END
											FETCH NEXT FROM xcursor INTO @id, @subruta
										END
								CLOSE xcursor
								DEALLOCATE xcursor
							END
						END
						ELSE
						BEGIN
							PRINT '1'
							PRINT LTRIM(@vl_id_Venta)

							UPDATE venta SET 
							 codi_programacion	= @vl_programacion,
							 nume_asiento		= @vl_asiento 
							WHERE id_venta = convert(numeric,@vl_id_Venta)
	
							PRINT @id

							SELECT 
							 @vl_Numero_reint2=isnull(codi_esca,''),
							 @emp=CODI_EMPRESA 
							FROM venta 
							WHERE id_venta = convert(numeric,@vl_id_Venta)

							PRINT @vl_Numero_reint2

							IF @vl_Numero_reint2 <> '' 
							BEGIN
								UPDATE venta 
								SET 
								 codi_programacion=@vl_programacion
								WHERE 
								 serie_boleto	= substring(@vl_Numero_reint2,2,3) AND 
								 nume_boleto	= substring(@vl_Numero_reint2,6,7) AND 
								 CODI_EMPRESA	= @emp AND 
								 tipo			= left(@vl_Numero_reint2,1) AND 
								 flag_venta		= 'O'
							END
							IF @vl_programacion = '0'
							BEGIN
								INSERT INTO Tb_Datos_FechaAbierta(id_Venta, codi_ruta, codi_servicio)
								VALUES(@vl_id_Venta, @vl_ruta, @vl_servicio)

								IF @vl_Numero_reint2 <> '' 
								BEGIN 
									SET @id = 0

									SELECT @id = id_venta 
									FROM venta 
									WHERE 
									 serie_boleto	= substring(@vl_Numero_reint2,2,3) AND 
									 nume_boleto	= substring(@vl_Numero_reint2,6,7) AND 
									 CODI_EMPRESA	= @emp AND 
									 tipo			= left(@vl_Numero_reint2,1) AND 
									 flag_venta		= 'O'

									INSERT INTO Tb_Datos_FechaAbierta(id_Venta, codi_ruta, codi_servicio)
									VALUES(@id, @vl_ruta, @vl_servicio)
								END
							END
							ELSE
							BEGIN
								DELETE Tb_Datos_FechaAbierta WHERE id_venta = convert(numeric,@vl_id_Venta)

								IF @vl_Numero_reint2<>'' 
								BEGIN
									SET @id=0

									SELECT @id = id_venta 
									FROM venta 
									WHERE 
									 serie_boleto	= substring(@vl_Numero_reint2,2,3) AND 
									 nume_boleto	= substring(@vl_Numero_reint2,6,7) AND 
									 CODI_EMPRESA	= @emp AND 
									 tipo			= left(@vl_Numero_reint2,1) AND 
									 flag_venta		= 'O'

									DELETE Tb_Datos_FechaAbierta WHERE id_venta = convert(numeric,@id) 
								END
							END
						END

						UPDATE venta_derivada 
						SET 
						 fecha_viaje	= @vl_FechaViaje,
						 hora_viaje		= @vl_HoraViaje,
						 servicio		= @vl_servicio
						WHERE id_venta	= @vl_id_Venta	
					END
				END
				ELSE
				BEGIN
					DELETE FROM @temp_Lista WHERE id_Venta = @vl_id_Venta
				END

				FETCH cTempList INTO @vl_Numero_reint, @vl_programacion, @vl_origen, @vl_id_Venta, @vl_asiento, @vl_ruta, @vl_servicio, @vl_TipoDoc, @vl_FechaViaje, @vl_HoraViaje, @vl_FlagVenta
			END
			CLOSE cTempList
			DEALLOCATE cTempList

			SELECT 
			 Boleto			AS Boleto, 
			 asiento		AS NumeAsiento,
			 Pasajero		AS Pasajero,
			 FechaViaje		AS FechaViaje,
			 HoraViaje		AS HoraViaje,
			 id_Venta		AS IdVenta,
			 programacion	AS CodiProgramacion
			FROM @temp_Lista

		IF (@@TRANCOUNT > 0)
			COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		INSERT INTO TB_HISTORICO_ERROR (Modulo,tipo,serie,numero,errNumber,errSeverity,errState,errProcedure,errLine,errMessage,CODI_DOCUMENTO,POSICION)
		SELECT 'P','','','',ERROR_NUMBER() AS errNumber,ERROR_SEVERITY() AS errSeverity,ERROR_STATE() AS errState
		,ERROR_PROCEDURE() AS errProcedure,ERROR_LINE() AS errLine,ERROR_MESSAGE() AS errMessage , '', 0
	END CATCH		

	SET NOCOUNT OFF;
END

