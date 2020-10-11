create proc deleteCityByZip
@ZIP integer
as

Begin
	

	if not(@ZIP in (select ZIP from City))
		return -1

	begin try
	Delete from City
	where ZIP = @ZIP
	return 0
	end try

	begin catch
		
		print error_message()
		return -1

	end catch



End