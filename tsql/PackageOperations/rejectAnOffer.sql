create proc rejectAnOffer
@IdTO integer
as

begin

	if not(@IdTO in (select IdTo from TransportOffer))
		return -1
	if (select Status from Package where @IdTO = IdTO) != 0
		return -1

	update Package
	set status = 4
	where IdTo = @IdTO

end