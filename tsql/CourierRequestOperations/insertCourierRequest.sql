create proc insertCourierRequest
@Username varchar(100),
@License varchar(100)
as

begin

	begin try
	if exists(select * from PromoteRequest where @License = License)
		return -1
	if exists(select * from Courier where @Username = Username)
		return -1
	insert into PromoteRequest values (@Username,@License)
	end try
	begin catch
		print error_message()
		return -1
	end catch

end