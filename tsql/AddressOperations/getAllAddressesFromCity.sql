create proc getAllAddressesFromCity
@ZIP integer
as

Begin
	
	SET NOCOUNT ON
	
	if NOT(@ZIP in (select ZIP from City))
		return -1

	select IdAddr from Address
	where ZIP = @ZIP

End