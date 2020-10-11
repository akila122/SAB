create proc changeFuelType
@VehicleId varchar(100),
@FuelType integer

as

begin
	
	if not( @VehicleId in (select VehicleId from Vehicle))
		return -1
	if not (@fuelType in (0,1,2))
		return -1
	if isnull((select IdAddrParkedAt from Vehicle where VehicleId = @VehicleId),0) = 0
		return -1
	if exists(select * from Courier where VehicleId = @VehicleId)
		return -1

	update Vehicle set FuelType = @FuelType
	where VehicleId = @VehicleId

end
