create proc getDeliveryStatus
@IdTO integer
as

begin

	if not (@IdTO in (select IdTO from TransportOffer))
		return -1
	return(select Status from Package where IdTO = @IdTO)

end