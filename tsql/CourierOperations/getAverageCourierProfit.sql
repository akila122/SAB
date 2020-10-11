create proc getAverageCourierProfit

@numberOfDeliveries integer

as

begin
	if @numberOfDeliveries < 0
		select avg(JobProfit) from Courier
	else
		select avg(JobProfit) from Courier where JobCount = @numberOfDeliveries
end