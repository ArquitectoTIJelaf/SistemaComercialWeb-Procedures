Create Procedure scwsp_BuscarItinerarios
@Codi_Origen	SmallInt,  
@Codi_Destino	SmallInt,  
@Codi_Ruta		SmallInt,    
@Hora			varchar(7) 
as    
SET NOCOUNT ON    
begin    
	Declare @Tiempo Int
	Set @Tiempo=0
	
	If @Hora<>'00:00AM'
		Begin
			Set @Tiempo=-10
		End

	SELECT TOP 200 
	dbo.Tb_Maestro_Programacion.NRO_VIAJE, 
	dbo.Tb_Maestro_Programacion.CODI_EMPRESA,     
	dbo.Tb_Empresa.Razon_Social,
	dbo.Tb_Maestro_Programacion.NRO_RUTA, 
	dbo.Tb_Ruta_Maestro.CODI_SUCURSAL, 
	suc.Descripcion Nom_Sucursal,
	dbo.Tb_Ruta_Maestro.CODI_DESTINO Codi_Ruta,   
	rut.Descripcion Nom_Ruta,  
	dbo.Tb_Ruta_Maestro.CODI_SERVICIO, 
	dbo.Tb_Servicio.descripcion Nom_Servicio,
	dbo.Tb_Maestro_Programacion.CODI_SUCURSAL AS Codi_PuntoVenta, 
	pv.Descripcion Nom_PuntoVenta,    
	dbo.Tb_Maestro_Programacion.HORA Hora_Programacion, 
	--dbo.Tb_Maestro_Programacion.TIPO_B, 
	--dbo.Tb_Maestro_Programacion.TIPO_C,     
	--dbo.Tb_Maestro_Programacion.TIPO_W, 
	--dbo.Tb_Maestro_Programacion.TIPO_V, 
	--dbo.Tb_Maestro_Programacion.TIPO_R,     
	--dbo.Tb_Maestro_Programacion.TIPO_T,
	dbo.Tb_Maestro_Programacion.st_opcional, 
	--dbo.Tb_Maestro_Programacion.TIPO_S, 
	--dbo.Tb_Maestro_Programacion.TIPO_E,     
	dbo.Tb_Ruta_Intermedio.CODI_SUCURSAL AS Codi_Origen, 
	ori.Descripcion Nom_Origen,
	dst.CODI_SUCURSAL Codi_Destino,
	dest.Descripcion Nom_Destino,
	dbo.Tb_Ruta_Intermedio.HORA_PASO Hora_Partida,     
	dbo.Tb_Ruta_Intermedio.NRO_RUTA_INT,
	dbo.Tb_Ruta_Intermedio.DIAS--
	----dbo.Tb_Maestro_Programacion.tr,
	----dbo.Tb_Maestro_Programacion.dias as d_v,
	----dbo.Tb_Maestro_Programacion.viaje     
	FROM     
	dbo.Tb_Ruta_Maestro WITH(nolock)    
	INNER JOIN  dbo.Tb_Maestro_Programacion WITH(nolock) ON dbo.Tb_Ruta_Maestro.NRO_RUTA  = dbo.Tb_Maestro_Programacion.NRO_RUTA   	
	INNER JOIN dbo.Tb_Ruta_Intermedio  WITH(nolock) ON dbo.Tb_Maestro_Programacion.NRO_VIAJE = dbo.Tb_Ruta_Intermedio.NRO_VIAJE    
	INNER JOIN dbo.Tb_Ruta_Intermedio dst WITH(nolock) ON dbo.Tb_Maestro_Programacion.NRO_VIAJE = dst.NRO_VIAJE 
	Inner Join dbo.Tb_Empresa on Tb_Maestro_Programacion.CODI_EMPRESA=dbo.Tb_Empresa.Codi_Empresa 
	Inner Join dbo.Tb_Servicio on Tb_Ruta_Maestro.CODI_SERVICIO=dbo.Tb_Servicio.Codi_Servicio
	Inner Join dbo.Tb_Oficinas suc on dbo.Tb_Ruta_Maestro.CODI_SUCURSAL=suc.Codi_Sucursal
	Inner Join dbo.Tb_Oficinas rut on dbo.Tb_Ruta_Maestro.CODI_DESTINO=rut.Codi_Sucursal
	Inner Join dbo.Tb_Oficinas ori on dbo.Tb_Ruta_Intermedio.CODI_SUCURSAL=ori.Codi_Sucursal
	Inner Join dbo.Tb_Oficinas dest on dst.CODI_SUCURSAL=dest.Codi_Sucursal
	Inner Join dbo.Tb_PuntoVenta pv on pv.Codi_puntoVenta=dbo.Tb_Maestro_Programacion.CODI_SUCURSAL
	and Tb_Maestro_Programacion.TIPO_E='1'  	  
	AND  Tb_Ruta_Intermedio.VER='1' 
	and (dbo.Tb_Ruta_Maestro.CODI_DESTINO=@Codi_Ruta or @Codi_Ruta =0)    
	and (dbo.Tb_Ruta_Maestro.CODI_DESTINO<>@Codi_Origen) 
	and (dbo.Tb_Ruta_Maestro.CODI_DESTINO<>79) 	
	AND  (dbo.Tb_Ruta_Intermedio.CODI_SUCURSAL=@Codi_Origen or @Codi_Origen=0 )
	and (dst.CODI_SUCURSAL=@Codi_Destino  or @Codi_Destino =0)   
	and CONVERT(DATETIME,Tb_Ruta_Intermedio.HORA_PASO,300)>=CONVERT(DATETIME,dateadd(mi,@Tiempo,@Hora ),300)
	
	--and dbo.Tb_Maestro_Programacion.TIPO_S = 0 -- Gerardo
	and dbo.Tb_Maestro_Programacion.TR = 0 -- Gerardo
	and dbo.Tb_Maestro_Programacion.TIPO_B = 1 -- Gerardo
	
	ORDER BY   
	DATEPART(HOUR,Tb_Ruta_Intermedio.HORA_PASO),  
	DATEPART(MINUTE,Tb_Ruta_Intermedio.HORA_PASO),  
	dbo.Tb_Maestro_Programacion.NRO_VIAJE,   
	dbo.Tb_Maestro_Programacion.CODI_EMPRESA,         
	dbo.Tb_Maestro_Programacion.NRO_RUTA,   
	dbo.Tb_Ruta_Maestro.CODI_SUCURSAL,   
	dbo.Tb_Ruta_Maestro.CODI_DESTINO,         
	dbo.Tb_Ruta_Maestro.CODI_SERVICIO,   
	dbo.Tb_Maestro_Programacion.CODI_SUCURSAL ,   
	dbo.Tb_Maestro_Programacion.TIPO_B,   
	dbo.Tb_Maestro_Programacion.TIPO_C,         
	dbo.Tb_Maestro_Programacion.TIPO_W,   
	dbo.Tb_Maestro_Programacion.TIPO_V,   
	dbo.Tb_Maestro_Programacion.TIPO_R,         
	dbo.Tb_Maestro_Programacion.TIPO_T,  
	dbo.Tb_Maestro_Programacion.st_opcional,   
	dbo.Tb_Maestro_Programacion.TIPO_S,   
	dbo.Tb_Maestro_Programacion.TIPO_E,         
	dbo.Tb_Ruta_Intermedio.CODI_SUCURSAL ,   
	dbo.Tb_Ruta_Intermedio.HORA_PASO,         
	dbo.Tb_Ruta_Intermedio.NRO_RUTA_INT,  
	dbo.Tb_Ruta_Intermedio.DIAS,  
	Tb_Maestro_Programacion.tr,  
	Tb_Maestro_Programacion.dias ,  
	Tb_Maestro_Programacion.viaje  

end 
