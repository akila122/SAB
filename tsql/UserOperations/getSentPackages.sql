create proc getSentPackages
@userName varchar(100)
as
begin

	if not(@userName in (select Username from UserType))
		return -1
	else return (
		select count(*)
		from TransportOffer join Package on TransportOffer.IdTO = Package.IdTO
		where Username = @userName and not(Status in (0,4)) 
		)
end