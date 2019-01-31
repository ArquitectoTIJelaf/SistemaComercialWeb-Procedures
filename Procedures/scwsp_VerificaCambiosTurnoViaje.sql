CREATE PROCEDURE scwsp_VerificaCambiosTurnoViaje
@Nro_Viaje			INT,
@FechaProgramacion	smalldatetime
as
SET NOCOUNT ON
begin
	SELECT 
	Tb_Viaje_Historial.Codi_Servicio,
	Tb_servicio.Descripcion as Servicio,
	Codi_Empresa from Tb_Viaje_Historial
	Inner Join Tb_servicio on Tb_Viaje_Historial.Codi_servicio=Tb_servicio.Codi_servicio 
	Where Nro_Viaje=@Nro_Viaje and Fecha=@FechaProgramacion 
End