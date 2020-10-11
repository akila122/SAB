create proc deleteVehicle
@VehicleId varchar(100)
as
begin

	if not( @VehicleId in (select VehicleId from Vehicle))
		return -1

	delete from Vehicle
	where VehicleId = @VehicleId
	return @@ROWCOUNT


end