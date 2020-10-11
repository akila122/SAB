create proc getPackagesInVehicle
@Username varchar(100)
as

	select IdTO from InVehicle
	where VehicleId = (select VehicleId from Courier where Username = @Username)