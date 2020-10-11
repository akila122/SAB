create proc getAllUndeliveredPackagesFromCity
@ZIP varchar(100)
as
select TransportOffer.IdTo
from TransportOffer inner join Package on TransportOffer.IdTO = Package.IdTO
where IdAddrSrc in (select IdAddr from Address where ZIP = @ZIP)
	  and Status in (1,2)
