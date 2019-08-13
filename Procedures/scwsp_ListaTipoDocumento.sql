ALTER PROCEDURE scwsp_ListaTipoDocumento
AS
SET NOCOUNT ON

BEGIN

	SELECT
		SAB_CON AS Codi_Documento,
		NOM_TIP AS Nom_Documento,
		DOM_CON AS Lon_Documento
	FROM
		TABLAS
	WHERE
		COD_TAB = '56'
		AND SAB_CON > 0
		AND SAB_CON < 8
	ORDER BY
		SAB_CON;

END;
