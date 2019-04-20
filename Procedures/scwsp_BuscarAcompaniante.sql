ALTER PROCEDURE scwsp_BuscarAcompaniante
@IDVENTA		Int
AS
BEGIN
	select top 1 * from TB_VENTA_ACOMPAÑANTE where IDVENTA = @IDVENTA
END;
