create proc getCurrentLocationOfPackage
@IdTO integer
as

begin

	if not (@IdTO in (select IdTO from TransportOffer))
		return -1

	if exists(select* from InVehicle where @IdTO = IdTO)
		return -1


	if exists(
	select TransportOffer.IdTo
	from TransportOffer inner join Package on TransportOffer.IdTO = Package.IdTO
	where IdAddrAt = IdAddrSrc or IdAddrAt = IdAddrDst or 
		  exists(select * from InStockroom where IdTO = TransportOffer.IdTO)
	  
	  )

	return (select IdAddrAt from Package where IdTO = @IdTO)

end