create proc declareAdmin
@userName varchar(100)
as

begin

		if not(@userName in (select userName from UserType))
			return -1
		else if @userName in (select userName from Admin)
			return 1
		else insert into Admin values(@userName)
	
end