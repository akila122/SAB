create proc getAllPackagesCurrentlyAtCity
@ZIP varchar(100)
as
select TransportOffer.IdTo
from TransportOffer inner join Package on TransportOffer.IdTO = Package.IdTO
where IdAddrAt in (select IdAddr from Address where ZIP = @ZIP)
	  and (
	 IdAddrAt = IdAddrSrc and not(exists(select * from InVehicle where IdTO = TransportOffer.IdTO))
	 or IdAddrAt = IdAddrDst and not(exists(select * from InVehicle where IdTO = TransportOffer.IdTO))
	 or exists(select * from InStockroom where IdTO = TransportOffer.IdTO)
	  )
	  
