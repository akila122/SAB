create proc deleteAddressByNameNumber
@Street varchar(100),
@Number integer
as

Begin
	
	Delete from Address
	where Street = @Street AND Number = Number 
	return @@ROWCOUNT

End