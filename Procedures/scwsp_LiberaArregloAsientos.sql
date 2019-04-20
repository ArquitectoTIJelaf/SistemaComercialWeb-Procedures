Alter procedure scwsp_LiberaArregloAsientos
@Xml		xml
As
	Begin Transaction  
		delete from ASIENTO
		where
			IDS IN (
				SELECT
					M.item.value('.','int')
				FROM @Xml.nodes('/xmlLiberaArregloAsientos/int') AS M(item)
			)

	If @@Error<>0
		RollBack Transaction                
    Else
		Commit Transaction
