create proc parkVehicle
@VehicleId varchar(100),
@IdAddr integer

as


begin


	if not(@VehicleId in (select VehicleId from Vehicle))
		return -1
	if exists(select * from Courier where VehicleId = @VehicleId)
		return -1
	if not(@IdAddr in (select IdAddr from Stockroom))
		return -1

	update Vehicle
	set IdAddrParkedAt = @IdAddr,IdAddr = @IdAddr
	where VehicleId = @VehicleId


end