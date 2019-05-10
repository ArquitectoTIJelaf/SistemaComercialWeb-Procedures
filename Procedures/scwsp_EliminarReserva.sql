Alter procedure scwsp_EliminarReserva
@IdVenta		Int
As
  Begin Transaction
		delete from VENTA where id_venta = @IdVenta;
		Select @@ROWCOUNT as Validator;

 If @@Error<>0
	RollBack Transaction;
 Else
	Commit Transaction;
