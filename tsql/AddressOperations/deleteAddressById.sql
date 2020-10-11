create proc deleteAddressById
@IdAddr integer
as

Begin
	
	if not(@IdAddr in (select IdAddr from Address))
		return -1

	begin try
		Delete from Address
		where @IdAddr = IdAddr
		return 0
	end try

	begin catch
		
		print error_message()
		return -1

	end catch


End