create proc acceptAnOffer
@IdTO integer
as

begin

	if not(@IdTO in (select IdTo from TransportOffer))
		return -1
	if (select Status from Package where @IdTO = IdTO) != 0
		return -1

	update Package
	set Status = 1,TimeAccepted = CURRENT_TIMESTAMP
	where IdTo = @IdTO

end