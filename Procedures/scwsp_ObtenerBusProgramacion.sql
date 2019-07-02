-- =============================================
-- Author:		Williams Morales
-- Create date: 24/01/2019
-- Description:	Obtiene datos del Bus Programado 
--				por Código de Programación
-- =============================================
-- Author:		Héctor Salazar
-- Create date: 02/07/2019
-- Description:	Add Char Activo
-- =============================================
ALTER PROCEDURE scwsp_ObtenerBusProgramacion 
 @Codi_Programacion INT
AS
BEGIN
	SELECT 
	 p.Codi_bus			AS Codi_bus
	 ,b.Plan_bus		AS Plan_bus
	 ,b.Nume_Pasajeros	AS Nume_Pasajeros
	 ,b.Plac_bus		AS Plac_bus
	 ,p.Codi_Chofer		AS Codi_Chofer
	 ,ch.nomb_Chofer	AS Nombre_Chofer
	 ,p.Codi_Copiloto	AS Codi_Copiloto
	 ,co.nomb_Chofer	AS Nombre_Copiloto
	 ,case isnull(p.Activo,'') 
	   when 1 then '1'
	   else '' end		AS Activo
	FROM Tb_Programacion p WITH (NOLOCK)
	 INNER JOIN Tb_Bus b		ON p.Codi_Bus = b.Codi_Bus
	 INNER JOIN Tb_Chofer ch	ON p.Codi_Chofer = ch.Codi_Chofer
	 INNER JOIN Tb_Chofer co	ON p.Codi_Copiloto = co.Codi_Chofer
	WHERE 
	 Codi_Programacion = @Codi_Programacion
END