ALTER procedure scwsp_EliminarReserva
@IdVenta		Int
as
  Begin Transaction  
		delete from VENTA where id_venta = @IdVenta
 If @@Error<>0
        RollBack Transaction                
    Else
       Commit TRANSACTION
