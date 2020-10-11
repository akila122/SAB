create proc deleteCityByName
@Name varchar(100)
as

Begin
	
	Delete from City
	where Name = @Name
	return @@ROWCOUNT

End