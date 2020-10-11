create proc insertAddress
@Street varchar(100),
@Number integer,
@CityZIP integer,
@X integer,
@Y integer
as

Begin
	begin try
		Insert into Address (Street,Number,x,y,ZIP)
		Values (@Street,@Number,@X,@Y,@CityZIP)
		return SCOPE_IDENTITY()
	end try
	begin catch
		PRINT error_message()
		return -1
	end catch
End