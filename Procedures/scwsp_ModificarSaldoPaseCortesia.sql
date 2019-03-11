Create Procedure scwsp_ModificarSaldoPaseCortesia
@Codi_Socio		Varchar(2),
@Mes			Varchar(2),
@Anno			Varchar(4)
as
	Update boletos_x_socio 
	Set saldo=saldo-1
	Where cod_socio=@Codi_Socio
	and mes=@Mes
	and anno=@Anno
	and saldo>0
