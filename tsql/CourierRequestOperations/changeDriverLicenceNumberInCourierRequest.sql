create proc changeDriverLicenceNumberInCourierRequest
@Username varchar(100),
@License varchar(100)
as

begin


	if not(@Username  in (select UsernameUser from PromoteRequest))
		return -1

	begin try

		update PromoteRequest
		set License = @License
		where UsernameUser = @Username

	
	end try

	begin catch

		print error_message()
		return -1

	end catch

end