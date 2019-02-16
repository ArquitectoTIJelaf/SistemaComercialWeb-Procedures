Alter Procedure scwsp_BuscarPlanoBus
@Codi_Plano		Varchar(4)
as
	Declare @Cantidad	Int
	Declare @Index Int
	Declare @Tb_PlanoBus Table(
		Codigo	varchar(3),
		Tipo	VarChar(2),
		Indice	Int
	)
	Select @Cantidad=Max(Indice) From  dbo.Tb_PlanoBus 
	where codigo=@Codi_Plano
	If(@Cantidad%5<>0)
		Begin
			select @Cantidad=@Cantidad+(5-@Cantidad%5)
		End
	
	--select @Cantidad
	Set @Index=1
	While(@Index<=@Cantidad)
		Begin
			If Exists(	Select Top 1 1  From  dbo.Tb_PlanoBus where codigo=@Codi_Plano and indice=@Index)
				Begin
						Insert Into @Tb_PlanoBus(Codigo, Tipo, Indice)
						Select Codigo,tipo,indice  
						From  dbo.Tb_PlanoBus 
						where codigo=@Codi_Plano and indice=@Index
				End
			Else
				Begin
						Insert Into @Tb_PlanoBus(Codigo, Tipo, Indice)
						Values(@Codi_Plano, 'VA', @Index)
				End
			Print cast(@index as int)
			Set @Index=@Index+1
		End

		Select Codigo, Tipo, Indice From @Tb_PlanoBus

