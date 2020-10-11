create proc changeType
@IdTO integer,
@PackageType integer

as


begin
	
	if not(@IdTO in (select IdTO from TransportOffer))
		return -1

	if (select Status from Package where @IdTO = IdTO) != 0
		return -1

	if not(@PackageType in (0,1,2,3))
		return -1

	update TransportOffer
	set PackageType = @PackageType
	where IdTO = @IdTO



end