Create procedure scwsp_LiberarAsiento
@Ids		Int
as
  Begin Transaction  
		delete from ASIENTO where IDS =@Ids
 If @@Error<>0
        RollBack Transaction                
    Else
       Commit TRANSACTION


