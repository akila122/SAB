create proc insertCourier

@Username varchar(100),
@License varchar(100)

as 

begin
	begin try
		insert into Courier values (@Username,null,0,0,0,@License)
	end try
	begin catch
		print error_message()
		return -1
	end catch
end