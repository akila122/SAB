create proc nextStop
@Username varchar(100)
as
begin
	
	if not(exists(select * from Transport where Username = @Username and Phase = 0))
		return -3

	declare @IdTransport integer
	select @IdTransport = IdTransport
	from Transport where Username = @Username
	and Phase = 0

	declare @VehicleId varchar(100)
	select @VehicleId = VehicleId
	from Courier where Username = @Username

	declare @IdStockroom integer
	select @IdStockroom =  IdAddrParkedAt
	from Vehicle where VehicleId = @VehicleId

	declare @IdTP integer
	declare @Type integer
	declare @IdTO integer

	select top 1 @IdTP = IdTP,@Type = Type,@IdTO = IdTO
	from TransportPlan
	where IdTransport = @IdTransport and Type != -1
	order by IdTP asc

	declare @IdAddrAt integer
	select @IdAddrAt = IdAddr from Vehicle
	where VehicleId = @VehicleId

	declare @IdAddrTo integer
	declare @dis decimal(10,3)

	if @Type = 1 begin --HomePick

		
		select @IdAddrTo = IdAddrSrc from TransportOffer
		where IdTO = @IdTO


		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport

		update Package  set
		Status = 2
		where IdTO = @IdTO

		insert into InVehicle values (@VehicleId,@IdTO)

		update Package
		set IdAddrAt = @IdAddrTo
		where IdTO in (select IdTo from InVehicle where VehicleId = @VehicleId)

			
		update TransportPlan
		set Type = -1
		where IdTP = @IdTP

		return -2

	end

	else if @Type = 2 begin -- MagPick
	
		select @IdAddrTo = @IdStockroom
		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)
				
				update Vehicle
				set IdAddr = @IdAddrTo
				where VehicleId = @VehicleId

				update Transport set
				Distance = Distance + @dis
				where IdTransport = @IdTransport


				declare @iter cursor
				declare @iIdTO integer
				declare @iIdTP integer
				
				set @iter = cursor for select IdTP,IdTO
				from TransportPlan
				where Type = 2 and IdTransport = @IdTransport
				order by IdTP asc
				
				open @iter
				fetch next from @iter
				into @iIdTP,@iIdTO

				while @@FETCH_STATUS = 0
				begin
				
				

					delete from InStockroom
					where IdAddr = @IdStockroom
					and IdTO = @iIdTO

					insert into InVehicle values (@VehicleId,@iIdTO)
			
					update TransportPlan
					set Type = -1
					where IdTP = @iIdTP

					fetch next from @iter
					into @iIdTP,@iIdTO

				end

				close @iter
				deallocate @iter

				
				update Package
				set IdAddrAt = @IdAddrTo
				where IdTO in (select IdTo from InVehicle where VehicleId = @VehicleId)

				return -2

	end


	else if @Type = 3 begin --Deliver

	
		select @IdAddrTo = IdAddrDst from TransportOffer
		where IdTO = @IdTO


		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport

		update Package  set
		Status = 3
		where IdTO = @IdTO

		update Package
		set IdAddrAt = @IdAddrTo
		where IdTO in (select IdTo from InVehicle where VehicleId = @VehicleId)

		delete from InVehicle where  VehicleId = @VehicleId and IdTO = @IdTO

		update TransportPlan
		set Type = -1
		where IdTP = @IdTP

		update Courier set JobCount = JobCount + 1
		where Username = @Username

		update Transport set Price = Price + (select Price from Package where IdTO = @IdTO)

		return @IdTO

	end

	else if @Type = 4 begin --RidePick

	select @IdAddrTo = IdAddrSrc from TransportOffer
		where IdTO = @IdTO


		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport

		update Package  set
		Status = 2
		where IdTO = @IdTO

		insert into InVehicle values (@VehicleId,@IdTO)

		update Package
		set IdAddrAt = @IdAddrTo
		where IdTO in (select IdTo from InVehicle where VehicleId = @VehicleId)

		update TransportPlan
		set Type = -1
		where IdTP = @IdTP


		return -2

	end

	else if @Type = 5 begin --RideMag
		

		select @IdAddrTo = Stockroom.IdAddr
		from Stockroom inner join Address on Address.IdAddr = Stockroom.IdAddr
		where ZIP = 
		(select ZIP from Address where IdAddr = @IdAddrAt)

		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport

		declare @iType integer

		set @iter = cursor for select IdTO,Type from TransportPlan
		where IdTransport = @IdTransport and Type != -1
		order by IdTP asc

		open @iter
		fetch next from @iter
		into @iIdTO,@iType

		while @@FETCH_STATUS = 0 and @iType = 5
		begin
				
	
			delete from InStockroom
			where IdTo = @iIdTO

			insert into InVehicle values (@VehicleId,@iIdTO)
			
			update TransportPlan set Type = -1
			where IdTO = @iIdTO
	

			fetch next from @iter
			into @iIdTO,@iType

		end

		close @iter
		deallocate @iter

		return -2


	end

	else begin

	select @IdAddrTo = @IdStockroom


		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport


		
		set @iter = cursor for select IdTO from InVehicle
		where VehicleId = @VehicleId

		open @iter
		fetch next from @iter
		into @iIdTO

		while @@FETCH_STATUS = 0
		begin
				
	
			delete from InVehicle
			where IdTo = @iIdTO

			insert into InStockroom values (@IdStockroom,@iIdTO)
			
			update Package set IdAddrAt = @IdAddrTo where IdTo = @iIdTO

			fetch next from @iter
			into @iIdTO

		end

		close @iter
		deallocate @iter


		declare @fuelPrice decimal (10,3)
		select @fuelPrice = Price from FuelPrice
		where FuelPriceId = (select FuelType from Vehicle where VehicleId = @VehicleId)

		declare @distance decimal(10,3)
		select @distance = Distance from Transport where IdTransport = @IdTransport

		declare @consumption decimal(10,3)
		select @consumption = Consumption from Vehicle where VehicleId = @VehicleId

		declare @sumPrice decimal(10,3)
		select @sumPrice = Price from Transport where IdTransport = @IdTransport
		
		update Transport set Phase = 1
		where IdTransport = @IdTransport

		delete from TransportPlan
		where IdTransport = @IdTransport

		update Courier
		set JobProfit = JobProfit + @sumPrice - @fuelPrice * @distance * @consumption,
			VehicleId = null,
			IsDriving = 0
		where Username = @Username

		return -1

	end

end
