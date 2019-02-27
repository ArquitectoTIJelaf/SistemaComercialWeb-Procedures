Create Procedure scwsp_GenerarCorrelativoAuxiliar
@Tabla			VarChar(40),
@Oficina		VarChar(50),
@Correlativo	Varchar(6) Output
AS
Begin
	Begin Transaction
		Set @Correlativo=''

		Select @Correlativo=CORRELATIVO From Tb_Correlativo_Auxiliares
		Where TABLA=@Tabla and
		OFICINA=@Oficina

		If @Correlativo=''
			Begin
				Insert Into TB_CORRELATIVO_AUXILIARES(tabla,correlativo,oficina)
				values(@tabla,'1',@oficina)
				set @Correlativo= 1
			End
		
		Update TB_CORRELATIVO_AUXILIARES 
		set correlativo=correlativo+1 
		Where TABLA=@Tabla and
		OFICINA=@Oficina

	If @@ERROR<>0
		RollBack Transaction
	Else
		Commit Transaction
End
