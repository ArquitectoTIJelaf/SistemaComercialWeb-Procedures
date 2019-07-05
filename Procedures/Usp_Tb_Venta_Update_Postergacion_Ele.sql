CREATE procedure Usp_Tb_Venta_Update_Postergacion_Ele
@Numero_reint varchar(15),
@programacion varchar(10),
@origen varchar(3),
@id_Venta numeric(15),
@asiento varchar(2),
@ruta varchar(3),
@servicio varchar(2),
@TipoDoc varchar(1)
as
SET NOCOUNT ON
begin
declare @id numeric(18),@corr varchar(12),@subruta varchar(3),@prog int,@emp int,@Numero_reint2 VARCHAR(15)
set @corr=''
select @corr=isnull(correlativo,'') from tb_venta_alterna where id_venta=@id_Venta
if @corr<>''
BEGIN
	if @programacion='0'
	BEGIN
		update venta set codi_programacion='0' ,nume_asiento=@asiento where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr)
		update tb_venta_alterna	set codi_programacion_alt='0' where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr)
		
		update venta set codi_programacion='0' where id_venta in(
		select id_venta from venta v1 where exists(select 1 from venta v2 where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr) 
		and v1.tipo=left(isnull(v2.codi_esca,''),1) and v1.SERIE_BOLETO=substring(isnull(v2.codi_esca,''),2,3) and v1.NUME_BOLETO=substring(v2.codi_esca,6,7)))
		
		insert into Tb_Datos_FechaAbierta(id_Venta,codi_ruta,codi_servicio)
		select id_venta,@ruta,@servicio from tb_venta_alterna where correlativo=@corr

		insert into Tb_Datos_FechaAbierta(id_Venta,codi_ruta,codi_servicio)
		select id_venta,@ruta,@servicio from venta v1 where exists(select 1 from venta v2 where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr) 
		and v1.tipo=left(isnull(v2.codi_esca,''),1) and v1.SERIE_BOLETO=substring(isnull(v2.codi_esca,''),2,3) and v1.NUME_BOLETO=substring(v2.codi_esca,6,7))
	END
	else
	BEGIN
		update venta set codi_programacion=@programacion,nume_asiento=@asiento where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr)
		update tb_venta_alterna set codi_programacion_alt=@programacion where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr)
		delete Tb_Datos_FechaAbierta where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr)
		delete Tb_Datos_FechaAbierta where id_venta in(
		select id_venta from venta v1 where exists(select 1 from venta v2 where id_venta in(select id_venta from tb_venta_alterna where correlativo=@corr) 
		and v1.tipo=left(isnull(v2.codi_esca,''),1) and v1.SERIE_BOLETO=substring(isnull(v2.codi_esca,''),2,3) and v1.NUME_BOLETO=substring(v2.codi_esca,6,7)))

		declare xcursor cursor for
		select id_venta,codi_ruta from vw_venta_general where correlativo=@corr --codi_programacion=@programacion
		open xcursor
		fetch next from xcursor into @id,@subruta
			while @@fetch_status=0
				begin
					select @prog=prog_alterna from tb_prog_alt where prog_general=@programacion and destino=@subruta
					if @prog<>'0'
						begin
							print 'entro ' +@subruta 
							update tb_venta_alterna
							set codi_programacion_alt=@prog 
							where id_venta=convert(numeric(18),@id)
						end
					fetch next from xcursor into @id,@subruta
				end
		close xcursor
		deallocate xcursor
	END
END
else
BEGIN
	PRINT '1'
	PRINT LTRIM(@id_venta)
	update venta set codi_programacion=@programacion ,nume_asiento=@asiento where id_venta=convert(numeric,@id_venta)
	
	set @Numero_reint2=''
	PRINT @id
	select @Numero_reint2=isnull(codi_esca,''),@emp=CODI_EMPRESA from venta where id_venta=convert(numeric,@id_venta)
	PRINT @Numero_reint2
	if @Numero_reint2<>'' 
	begin
		update venta set codi_programacion=@programacion ,cod_origen=@origen where serie_boleto=substring(@Numero_reint2,2,3) and 
		nume_boleto=substring(@Numero_reint2,6,7) and CODI_EMPRESA=@emp and tipo=left(@Numero_reint2,1) and flag_venta='O'
	end
	if @programacion='0'
	begin
		insert into Tb_Datos_FechaAbierta(id_Venta,codi_ruta,codi_servicio)values(@id_venta,@ruta,@servicio)
		if @Numero_reint2<>'' 
		begin 
			set @id=0
			select @id=id_venta from venta where serie_boleto=substring(@Numero_reint2,2,3) and 
			nume_boleto=substring(@Numero_reint2,6,7) and CODI_EMPRESA=@emp and tipo=left(@Numero_reint2,1) and flag_venta='O'
			insert into Tb_Datos_FechaAbierta(id_Venta,codi_ruta,codi_servicio)values(@id,@ruta,@servicio)
		end
	end
	else
	begin
		delete Tb_Datos_FechaAbierta where id_venta=convert(numeric,@id_venta)
		if @Numero_reint2<>'' 
			begin
				set @id=0
				select @id=id_venta from venta where serie_boleto=substring(@Numero_reint2,2,3) and 
				nume_boleto=substring(@Numero_reint2,6,7) and CODI_EMPRESA=@emp and tipo=left(@Numero_reint2,1) and flag_venta='O'
				delete Tb_Datos_FechaAbierta where id_venta=convert(numeric,@id) 
			end
		end
	end
END