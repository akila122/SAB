create proc getAcceptanceTime
@IdTO integer
as

begin

	if not (@IdTO in (select IdTO from TransportOffer))
		return -1
	if (select Status from Package where IdTO = @IdTO)  in (0,4) 
		return -1

	select TimeAccepted from Package where IdTO = @IdTO

end