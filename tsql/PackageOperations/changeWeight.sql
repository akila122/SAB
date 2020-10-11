create proc changeWeight
@IdTO integer,
@Weight decimal(10,3)

as


begin

	if not(@IdTO in (select IdTO from TransportOffer))
		return -1

	if (select Status from Package where @IdTO = IdTO) != 0
		return -1

	

	update TransportOffer
	set Weight = @Weight
	where IdTO = @IdTO



end