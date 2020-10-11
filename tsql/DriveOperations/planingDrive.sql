-- 1 HOME-PICK 2 MAG-PICK 3 DELIVER 4 RIDE-PICK

create proc planingDrive
@Username varchar(100)
as

begin

	if not(@Username in (select Username from Courier) )
		return -1
	if exists(select * from Courier where Username = @Username and IsDriving = 1)
		return -2
	if exists(select * from Transport where Username = @Username and Phase = 0)
		return -3

	--RIDE MUST BE TAKEN

	declare @myCity integer
	select @myCity = ZIP
	from Address where IdAddr = (select IdAddr from UserType where Username = @Username)

	declare @myRide varchar(100)

	select @myRide = VehicleId
	from Vehicle where IdAddrParkedAt in (
	select IdAddr from Address where ZIP = @myCity
	)
	and not(exists(select * from Courier where Courier.VehicleId = Vehicle.VehicleId))

	if isnull(@myRide,'') = ''
		return -4

	update Courier set
	VehicleId = @myRide,
	IsDriving = 1
	where @Username = Username

	declare @startPoint integer
	select @startPoint = IdAddrParkedAt
	from Vehicle where VehicleId = @myRide



	declare @currWeight decimal(10,3)
	set @currWeight = 0

	declare @maxWeight decimal(10,3)
	select @maxWeight = Capacity
	from Vehicle
	where VehicleId = @myRide

	
	declare @IdTransport integer
	insert into Transport(VehicleId,Username,TS,Distance,Phase,Price)
	values (@myRide,@Username,CURRENT_TIMESTAMP,0,0,0)
	set @IdTransport = SCOPE_IDENTITY()


	declare @currPoint integer
	set @currPoint = @startPoint

	print 'Passs'

	--PHASE : Hometown pickup

	declare @inVehicle table (id integer,dis decimal(10,3))
	
	declare @iter cursor

	set @iter = cursor for 
				select Package.IdTo,Weight
				from Package 
				inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
				where Status = 1
				and IdAddrAt in (select IdAddr from Address where ZIP = @myCity)
				and not(Package.IdTo in (select IdTO from TransportPlan))
				order by TimeAccepted asc
	
	
	declare @iIdTo integer
	declare @iWeight decimal(10,3)
	
	open @iter
	fetch next from @iter
	into @iIdTo,@iWeight

	while @@FETCH_STATUS = 0
	begin

		if @currWeight + @iWeight > @maxWeight
			break

		select @currPoint = IdAddrSrc from TransportOffer where IdTO = @iIdTo

		insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,1)
		insert into @inVehicle values (@iIdTO,0)
		set @currWeight += @iWeight

		fetch next from @iter
		into @iIdTo,@iWeight
	
	end

	close @iter
	deallocate @iter

	--PHASE : Stockroom pickup
	--Thread safety!!!

	set @iter = cursor for 
				select Package.IdTo,Weight
				from Package 
				inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
				where exists (select * from InStockroom 
									   where InStockroom.IdTO = Package.IdTO
									   and InStockroom.IdAddr = @startPoint
							)
				and not(Package.IdTo in (select IdTO from TransportPlan))
				order by TimeAccepted asc




	open @iter
	fetch next from @iter
	into @iIdTo,@iWeight

	while @@FETCH_STATUS = 0
	begin

		if @currWeight + @iWeight > @maxWeight
			break

		set @currPoint = @startPoint
	
		insert into @inVehicle values (@iIdTO,0)
		insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,2)
		set @currWeight += @iWeight

		fetch next from @iter
		into @iIdTo,@iWeight
	
	end

	close @iter
	deallocate @iter




	declare @currCity integer
	set @currCity = @myCity

	--PHASE: Deliver and Pick

	while exists(select * from @inVehicle)
		begin
			
			update @inVehicle
			set dis =

			(
				sqrt(
				power((
					select x from Address where IdAddr = @currPoint
				)-(
					select x from TransportOffer inner join Address on TransportOffer.IdAddrDst = Address.IdAddr
							 where IdTO = id 
				),2)

				+

				power((
					select y from Address where IdAddr = @currPoint
				)-(
					select y from TransportOffer inner join Address on TransportOffer.IdAddrDst = Address.IdAddr
							 where IdTO = id 
				),2)
				)
			)



			declare @minFit integer
			select @minFit = id from @inVehicle where dis = (select min(dis) from @inVehicle)

			
			delete from @inVehicle
			where id = @minFit

			--Put action
			insert into TransportPlan(IdTO,IdTransport,Type) values (@minFit,@IdTransport,3)
			set @currWeight -= (select Weight from TransportOffer where IdTO = @minFit)



			declare @nextStop integer
			select @nextStop = IdAddrDst from TransportOffer where IdTO = @minFit

			declare @nextCity integer
			select @nextCity = ZIP from Address where IdAddr = @nextStop

			declare @cntr integer

			select @cntr = count(*) from @inVehicle


			--Check for any pickups
			if @currCity != @myCity and @nextCity != @currCity
				begin
				
				
			
					set @iter = cursor for 
					select Package.IdTo,Weight
					from Package 
					inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
					where Status = 1
					and IdAddrAt in (select IdAddr from Address where ZIP = @currCity)
					and not(Package.IdTo in (select IdTO from TransportPlan))
					order by TimeAccepted asc

					open @iter
					fetch next from @iter
					into @iIdTo,@iWeight

					while @@FETCH_STATUS = 0
					begin

						if @currWeight + @iWeight > @maxWeight
							break
					
						insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,4)
						set @currWeight += @iWeight


						fetch next from @iter
						into @iIdTo,@iWeight
	
					end

					close @iter
					deallocate @iter
					

					declare @currStock integer
					select @currStock = IdAddr
					from Stockroom
					where IdAddr in (select IdAddr from Address where ZIP = @currCity)

					if isnull(@currStock,1) != 1
					begin
						
						set @iter = cursor for 
						select Package.IdTo,Weight
						from Package 
						inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
						where Package.IdTO in (select IdTO from InStockroom where InStockroom.IdAddr = @currStock)
						and not(Package.IdTo in (select IdTO from TransportPlan))
						order by TimeAccepted asc

						open @iter
						fetch next from @iter
						into @iIdTo,@iWeight

						while @@FETCH_STATUS = 0
						begin

							if @currWeight + @iWeight > @maxWeight
								break
					
							insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,5)
							set @currWeight += @iWeight


							fetch next from @iter
							into @iIdTo,@iWeight
	
						end

						close @iter
						deallocate @iter
					end
				end
				set @currCity = @nextCity
				set @currPoint = @nextStop
		end

		if @currCity != @myCity 
		begin

					
			
					set @iter = cursor for 
					select Package.IdTo,Weight
					from Package 
					inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
					where Status = 1
					and IdAddrAt in (select IdAddr from Address where ZIP = @currCity)
					and not(Package.IdTo in (select IdTO from TransportPlan))
					order by TimeAccepted asc

					open @iter
					fetch next from @iter
					into @iIdTo,@iWeight

					while @@FETCH_STATUS = 0
					begin
						


						if @currWeight + @iWeight > @maxWeight
							break
				

						insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,4)
						set @currWeight += @iWeight


						fetch next from @iter
						into @iIdTo,@iWeight
	
					end

					close @iter
					deallocate @iter

					select @currStock = IdAddr
					from Stockroom
					where IdAddr in (select IdAddr from Address where ZIP = @currCity)

					if isnull(@currStock,1) != 1
					begin
						
						set @iter = cursor for 
						select Package.IdTo,Weight
						from Package 
						inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
						where Package.IdTO in (select IdTO from InStockroom where InStockroom.IdAddr = @currStock)
						and not(Package.IdTo in (select IdTO from TransportPlan))
						order by TimeAccepted asc

						open @iter
						fetch next from @iter
						into @iIdTo,@iWeight

						while @@FETCH_STATUS = 0
						begin

							if @currWeight + @iWeight > @maxWeight
								break
					
							insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,5)
							set @currWeight += @iWeight


							fetch next from @iter
							into @iIdTo,@iWeight
	
						end

						close @iter
						deallocate @iter
					end
				end

end