Create Procedure scwsp_ListarSaldoBoletosCortesia
@Codi_Socio		Varchar(2),
@Anno			Varchar(4),
@Mes			Varchar(2)		
as
Select 
Total Total_Boletos, 
libres Boletos_Libres,
valor Boletos_Precio
from boletos_x_socio
Where cod_socio=@Codi_Socio
and mes=@Mes
and anno=@Anno