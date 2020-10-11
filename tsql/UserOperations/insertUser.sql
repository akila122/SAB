create proc insertUser
@Username varchar(100),
@Password varchar(100),
@Name varchar(100),
@Surname varchar(100),
@IdAddr integer
as
Begin
	begin try
		Insert into UserType(Username,Password,Name,Surname,IdAddr)
		Values (@Username,@Password,@Name,@Surname,@IdAddr)
		return 0
	end try
	begin catch
		PRINT error_message()
		return -1
	end catch
End