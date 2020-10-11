create proc deleteStockroomFromCity
@ZIP varchar(100)
as

begin

	declare @IdAddr integer
	set @IdAddr = -1

	select @IdAddr =  IdAddr
	from Stockroom
	where IdAddr in (select IdAddr from Address where ZIP = @ZIP)

	if @IdAddr = -1
		return -1

	if	exists(select * from InStockroom where IdAddr = @IdAddr) or
		exists(select * from Vehicle where IdAddrParkedAt = @IdAddr)
		
	return -1

	delete from Stockroom
	where IdAddr = @IdAddr

	return @IdAddr

end