create proc deleteStockroom
@IdAddr integer
as

begin

	if not(@IdAddr in (select IdAddr from Stockroom))
	return -1

	if	exists(select * from Package where IdAddrAt = @IdAddr) or
		exists(select * from Vehicle where IdAddrParkedAt = @IdAddr)
		
	return -1

	delete from Stockroom
	where IdAddr = @IdAddr


end