Alter procedure scwsp_LiberarAsiento
@Ids		Int
As
	Begin Transaction  
		Delete from ASIENTO where IDS =@Ids
	If @@Error<>0
		RollBack Transaction                
	Else
		Commit Transaction
