create proc insertPackage
@IdAddrFrom integer,
@IdAddrTo integer,
@Username varchar(100),
@Type integer,
@Weight decimal(10,3)

as

begin

	if 
		not(@IdAddrFrom in (select IdAddr from Address))
		OR not(@IdAddrTo in (select IdAddr from Address))
		OR @IdAddrFrom = @IdAddrTo
		OR not(@Username in (select Username from UserType))
		OR not(@Type in (0,1,2,3))
		OR @Weight <= 0
	
	return -1


	insert into TransportOffer(Username,IdAddrSrc,IdAddrDst,PackageType,Weight)
	values(@Username,@IdAddrFrom,@IdAddrTo,@Type,@Weight)
	return scope_identity() 

end