create proc getCouriersWithStatus
@Status integer

as

begin

	select Username from Courier
	where isDriving = @Status

end