create proc getStoockroomFromCity
@ZIP integer
as 
begin

	if not(@ZIP in (select ZIP from City))
		return -1


	declare @IdAddr integer
	set @IdAddr = -1


	select @IdAddr = Address.IdAddr
	from Stockroom inner join Address on Stockroom.IdAddr = Address.IdAddr
	where ZIP = @ZIP

	return @IdAddr

end