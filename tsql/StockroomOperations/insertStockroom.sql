create proc insertStockroom
@IdAddr integer
as

begin


	if not(@IdAddr in (select IdAddr from Address))
		return -1
	
	if exists(
	select Stockroom.IdAddr 
	from Stockroom inner join Address on Stockroom.IdAddr = Address.IdAddr
	where ZIP = (select ZIP from Address where IdAddr = @IdAddr)
	)
		return -1

	begin try
		insert into Stockroom
		values (@IdAddr)
		return @IdAddr
	end try
	begin catch
		print error_message()
		return -1
	end catch


end