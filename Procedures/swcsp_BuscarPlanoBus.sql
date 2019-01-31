Create Procedure swcsp_BuscarPlanoBus
@Codi_Plano		Varchar(4)
as
Select Codigo,Tipo,Indice from dbo.Tb_PlanoBus 
where codigo=@Codi_Plano
ORDER BY Indice 
