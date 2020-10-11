create proc insertCity
@Name varchar(100),
@CityZIP integer
as

Begin
	begin try
		Insert into City
		Values (@Name,@CityZIP)
		return @CityZIP
	end try
	begin catch
		PRINT ERROR_MESSAGE()
		return -1
	end catch
End