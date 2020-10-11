create proc deleteCourier
@Username varchar(100)
as

begin

	
	if(not(@Username in (select @Username from Courier)))
		return -1

	declare @ret integer
	return exec deleteUser @Username

end