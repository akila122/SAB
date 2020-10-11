create proc changeCapacity
@VehicleId varchar(100),
@Capcity decimal(10,3)

as

begin
	
	if not( @VehicleId in (select VehicleId from Vehicle))
		return -1
	if isnull((select IdAddrParkedAt from Vehicle where VehicleId = @VehicleId),0) = 0
		return -1
	if exists(select * from Courier where VehicleId = @VehicleId)
		return -1

	update Vehicle set Capacity = @Capcity
	where VehicleId = @VehicleId

end
