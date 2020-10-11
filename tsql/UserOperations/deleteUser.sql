create proc deleteUser
@Username varchar(100)
as

begin

	begin try

		delete from UserType
		where Username = @Username

	end try

	begin catch

		print error_message()
		return -1

	end catch

end