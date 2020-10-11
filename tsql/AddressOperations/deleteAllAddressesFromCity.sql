create proc deleteAllAddressesFromCity
@ZIP integer
as

Begin
	
	Delete from Address
	where ZIP = @ZIP
	return @@ROWCOUNT

End