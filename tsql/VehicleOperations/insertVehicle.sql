create proc insertVehicle
@License varchar(100),
@FuelType integer,
@Consumption decimal(10,3),
@Capacity decimal(10,3)
as
begin
	begin try

		insert into Vehicle
		values (@License,@FuelType,@Consumption,@Capacity,null,null)

	end try

	begin catch

		print error_message()
		return -1

	end catch

end