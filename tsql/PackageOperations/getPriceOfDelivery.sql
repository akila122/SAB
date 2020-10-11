create proc getPriceOfDelivery
@IdTO integer
as

begin

	if not (@IdTO in (select IdTO from TransportOffer))
		return -1
	select Price from Package where IdTO = @IdTO

end