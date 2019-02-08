--sp_help auditoria
CREATE Procedure scwsp_GrabarAuditoria 
@Fecha				SmallDateTime,  
@Hora				Varchar(15),  
@Codi_Usuario		SmallInt,  
@Nom_Usuario		varchar(50),  
@Tabla				varchar(30),  
@Tipo_Movimiento			varchar(30),  
@Boleto				varchar(15),  
@Nume_Asiento			varchar(10),  
@Codi_Oficina			varchar(30),  
@Codi_PuntoVenta			varchar(30),  
@Pasajero			varchar(50),  
@Fecha_Viaje		datetime,  
@Hora_Viaje			varchar(30),  
@destino_pasajero	varchar(30),  
@precio				real,  
@obs1				varchar(100),  
@obs2				varchar(100),  
@obs3				varchar(100),  
@obs4				varchar(100),  
@obs5				varchar(100)  
as  
set nocount on  
begin  
insert into auditoria   
(fecha, hora, codi_usuario, nom_usuario, tabla, tipo_mov, boleto, asiento, sucursal, puntoventa, pasajero, fecha_viaje, hora_viaje, destino_pasajero, precio, obs1, obs2, obs3, obs4, obs5)  
values  
(@fecha,@hora,@codi_usuario,@nom_usuario,@tabla,@tipo_mov,@boleto,@asiento,@sucursal,@puntoventa,@pasajero,@fecha_viaje,@hora_viaje,@destino_pasajero,@precio,@obs1,@obs2,@obs3,@obs4,@obs5)  
end
