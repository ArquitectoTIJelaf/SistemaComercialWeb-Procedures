Create Procedure scwsp_ValidarSaldoPaseCortesia
@Codi_Socio		Varchar(2),
@Mes			Varchar(2),
@Anno			Varchar(4)
as
	Select top 1 1 From boletos_x_socio 
	Where cod_socio=@Codi_Socio
	and mes=@Mes
	and anno=@Anno
	and saldo>0
