create trigger TR_TransportOffer
on TransportOffer
after Insert,Update
as
begin

	
	Declare @Iter Cursor
	Declare @IdTo integer
	Declare @PackageType integer
	Declare @Weight decimal(10,3)
	Declare @IdAddrSrc integer
	Declare @IdAddrDst integer


	set @Iter = cursor for select IdTo,PackageType,Weight,IdAddrSrc,IdAddrDst
				from inserted

	open @Iter
	fetch next from @Iter
	into @IdTo,@PackageType,@Weight,@IdAddrSrc,@IdAddrDst

	while @@FETCH_STATUS = 0

	begin
		
		declare @Start decimal(10,3)
		declare @Step decimal(10,3)

		select @Start = Price
		from TransportStartPrice
		where TransportStartPriceId = @PackageType

		select @Step = Price
		from TransportStepPrice
		where TransportStepPriceId = @PackageType

		declare @x1 integer
		declare @x2 integer
		declare @y1 integer
		declare @y2 integer

		select @x1 = X,@y1 = Y
		from Address where IdAddr = @IdAddrSrc
		select @x2 = X,@y2 = Y
		from Address where IdAddr = @IdAddrDst


		declare @Price decimal(10,3)
		
		set @Price = sqrt(power(@x1-@x2,2)+power(@y1-@y2,2))

		set @Price *= @Start + @Weight * @Step



		if exists(select * from deleted)
			update Package
			set Price = @Price
			where IdTO = @IdTo
		else 
			insert into Package(IdTo,Status,Price,TimeCreated,TimeAccepted,IdAddrAt)
			values (@IdTo,0,@Price,CURRENT_TIMESTAMP,null,@IdAddrSrc)

		fetch next from @Iter
		into @IdTo,@PackageType,@Weight,@IdAddrSrc,@IdAddrDst

	end

	close @Iter
	deallocate @Iter


end

