  CREATE Procedure Usp_Tb_Programacion_Venta_UPDATE_CNT
  @Prog   int,  
  @NewProg  int,  
  @SUC   int,  
  @NEWSUC   int  
  as  
  SET NOCOUNT ON  begin   
  UPDATE TB_VIAJE_PROGRAMACION 
  SET N_ASIENTO=n_asiento+1
  --(select  isnull(count(1),0) from venta where codi_programacion=@prog and indi_anulado='F' and flag_venta<>'R' and flag_venta<>'O' and flag_venta<>'X' and flag_venta<>'B' )
   WHERE CODI_PROGRAMACION=@PROG   
  --UPDATE TBPROGRAMACION SET TOTALVENTA=(select  isnull( count(   codi_programacion),0) from venta where codi_programacion=@NEWprog and indi_anulado='F' and flag_venta<>'R' and flag_venta<>'O' and flag_venta<>'X' and flag_venta<>'B' ) 
  --WHERE CODI_PROGRAMACION=@NEWPROG   
  end 