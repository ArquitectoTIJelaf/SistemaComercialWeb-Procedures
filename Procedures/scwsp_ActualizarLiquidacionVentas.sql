Create Procedure scwsp_ActualizarLiquidacionVentas
@NRO_LIQ	Int,
@Hora		VarChar(7)
as
	begin
		Begin Transaction

			Update Tb_LiquidacionVentas 
			Set ult_turno=@Hora
			where NRO_LIQ=@NRO_LIQ

		If @@ERROR<>0
			RollBack Transaction
		Else
			Commit Transaction

	end

