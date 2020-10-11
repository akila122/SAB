create proc grantRequest
@Username varchar(100)
as

begin

	if not(@Username in (select UsernameUser from PromoteRequest))
		return -1

	begin try
	insert into Courier values (@Username,null,0,0,0,(select License from PromoteRequest where UsernameUser = @Username))
	delete from PromoteRequest where UsernameUser = @Username
	end try

	begin catch
		print error_message()
		return -1
	end catch
end

