-- =============================================
-- Author:		H�ctor Salazar
-- Create date: 29/08/2019
-- Description:	Obtiene N�mero de Manifiesto
-- =============================================
CREATE PROCEDURE scwsp_ObtenerManifiestoProgramacion 
 @Codi_Programacion INT,
 @Codi_Sucursal		SMALLINT
AS
BEGIN
	SELECT TOP 1
	 p.Nume_Manifiesto	AS 	Nume_Manifiesto
	FROM Tb_Manifiesto_Programacion p WITH (NOLOCK)
	WHERE 
	 Codi_Programacion = @Codi_Programacion AND
	 Codi_Sucursal = @Codi_Sucursal AND
	 rublo = 'P'
END