
CREATE Database TransportCompany

go

use TransportCompany

CREATE TABLE [Address]
( 
	[Street]             varchar(100)  NOT NULL ,
	[Number]             char(100)  NOT NULL ,
	[x]                  integer  NOT NULL ,
	[y]                  integer  NOT NULL ,
	[IdAddr]             integer  IDENTITY ( 0,1 )  NOT NULL ,
	[ZIP]                integer  NOT NULL 
)
go

ALTER TABLE [Address]
	ADD CONSTRAINT [XPKAddress] PRIMARY KEY  CLUSTERED ([IdAddr] ASC)
go

CREATE TABLE [Admin]
( 
	[Username]           varchar(100)  NOT NULL 
)
go

ALTER TABLE [Admin]
	ADD CONSTRAINT [XPKAdmin] PRIMARY KEY  CLUSTERED ([Username] ASC)
go

CREATE TABLE [City]
( 
	[Name]               varchar(100)  NOT NULL ,
	[ZIP]                integer  NOT NULL 
)
go

ALTER TABLE [City]
	ADD CONSTRAINT [XPKCity] PRIMARY KEY  CLUSTERED ([ZIP] ASC)
go

CREATE TABLE [Courier]
( 
	[Username]           varchar(100)  NOT NULL ,
	[VehicleId]          varchar(100)  NULL ,
	[JobCount]           integer  NOT NULL ,
	[JobProfit]          decimal(10,3)  NOT NULL ,
	[IsDriving]          integer  NOT NULL 
	CONSTRAINT [IsDriving]
		CHECK  ( [IsDriving]=0 OR [IsDriving]=1 ),
	[License]            varchar(100)  NOT NULL 
)
go

ALTER TABLE [Courier]
	ADD CONSTRAINT [XPKCourier] PRIMARY KEY  CLUSTERED ([Username] ASC)
go

ALTER TABLE [Courier]
	ADD CONSTRAINT [XAK1Courier] UNIQUE ([License]  ASC)
go

CREATE TABLE [FuelPrice]
( 
	[Price]              decimal(10,3)  NOT NULL ,
	[FuelPriceId]        integer  IDENTITY ( 0,1 )  NOT NULL 
	CONSTRAINT [FuelType_1725093332]
		CHECK  ( [FuelPriceId]=0 OR [FuelPriceId]=1 OR [FuelPriceId]=2 )
)
go

ALTER TABLE [FuelPrice]
	ADD CONSTRAINT [XPKFuelPrice] PRIMARY KEY  CLUSTERED ([FuelPriceId] ASC)
go

CREATE TABLE [InStockroom]
( 
	[IdAddr]             integer  NOT NULL ,
	[IdTO]               integer  NOT NULL 
)
go

ALTER TABLE [InStockroom]
	ADD CONSTRAINT [XPKInStockroom] PRIMARY KEY  CLUSTERED ([IdAddr] ASC,[IdTO] ASC)
go

CREATE TABLE [InVehicle]
( 
	[VehicleId]          varchar(100)  NOT NULL ,
	[IdTO]               integer  NOT NULL 
)
go

ALTER TABLE [InVehicle]
	ADD CONSTRAINT [XPKInVehicle] PRIMARY KEY  CLUSTERED ([VehicleId] ASC,[IdTO] ASC)
go

CREATE TABLE [Package]
( 
	[IdTO]               integer  NOT NULL ,
	[Status]             integer  NOT NULL 
	CONSTRAINT [OfferStatus]
		CHECK  ( [Status]=0 OR [Status]=1 OR [Status]=2 OR [Status]=3 OR [Status]=4 ),
	[Price]              decimal(10,3)  NOT NULL ,
	[TimeCreated]        datetime  NOT NULL ,
	[TimeAccepted]       datetime  NULL ,
	[IdAddrAt]           integer  NULL 
)
go

ALTER TABLE [Package]
	ADD CONSTRAINT [XPKTransportOffer] PRIMARY KEY  CLUSTERED ([IdTO] ASC)
go

CREATE TABLE [PromoteRequest]
( 
	[UsernameUser]       varchar(100)  NOT NULL ,
	[License]            varchar(100)  NOT NULL 
)
go

ALTER TABLE [PromoteRequest]
	ADD CONSTRAINT [XPKPromoteRequest] PRIMARY KEY  CLUSTERED ([UsernameUser] ASC)
go

CREATE TABLE [Stockroom]
( 
	[IdAddr]             integer  NOT NULL 
)
go

ALTER TABLE [Stockroom]
	ADD CONSTRAINT [XPKStockroom] PRIMARY KEY  CLUSTERED ([IdAddr] ASC)
go

CREATE TABLE [Transport]
( 
	[VehicleId]          varchar(100)  NOT NULL ,
	[Username]           varchar(100)  NOT NULL ,
	[TS]                 datetime  NOT NULL ,
	[IdTransport]        integer  IDENTITY ( 0,1 )  NOT NULL ,
	[Distance]           decimal(10,3)  NULL ,
	[Phase]              integer  NOT NULL ,
	[Price]              decimal(10,3)  NOT NULL 
)
go

ALTER TABLE [Transport]
	ADD CONSTRAINT [XPKTransport] PRIMARY KEY  CLUSTERED ([IdTransport] ASC)
go

CREATE TABLE [TransportOffer]
( 
	[Username]           varchar(100)  NOT NULL ,
	[IdAddrSrc]          integer  NOT NULL ,
	[IdAddrDst]          integer  NOT NULL ,
	[IdTO]               integer  IDENTITY ( 0,1 )  NOT NULL ,
	[PackageType]        integer  NOT NULL 
	CONSTRAINT [PackageType_1886413906]
		CHECK  ( [PackageType]=0 OR [PackageType]=1 OR [PackageType]=2 OR [PackageType]=4 OR [PackageType]=3 ),
	[Weight]             decimal(10,3)  NOT NULL 
)
go

ALTER TABLE [TransportOffer]
	ADD CONSTRAINT [XPKTransportRequest] PRIMARY KEY  CLUSTERED ([IdTO] ASC)
go

CREATE TABLE [TransportPlan]
( 
	[IdTO]               integer  NOT NULL ,
	[IdTransport]        integer  NOT NULL ,
	[IdTP]               integer  IDENTITY ( 0,1 )  NOT NULL ,
	[Type]               integer  NOT NULL 
)
go

ALTER TABLE [TransportPlan]
	ADD CONSTRAINT [XPKTransportPlan] PRIMARY KEY  CLUSTERED ([IdTP] ASC)
go

CREATE TABLE [TransportStartPrice]
( 
	[Price]              decimal(10,3)  NULL ,
	[TransportStartPriceId] integer  IDENTITY ( 0,1 )  NOT NULL 
	CONSTRAINT [PackageType_246332890]
		CHECK  ( [TransportStartPriceId]=0 OR [TransportStartPriceId]=1 OR [TransportStartPriceId]=2 OR [TransportStartPriceId]=4 OR [TransportStartPriceId]=3 )
)
go

ALTER TABLE [TransportStartPrice]
	ADD CONSTRAINT [XPKTransportStartPrice] PRIMARY KEY  CLUSTERED ([TransportStartPriceId] ASC)
go

CREATE TABLE [TransportStepPrice]
( 
	[TransportStepPriceId] integer  IDENTITY ( 0,1 )  NOT NULL ,
	[Price]              decimal(10,3)  NULL 
)
go

ALTER TABLE [TransportStepPrice]
	ADD CONSTRAINT [XPKTransportStepPrice] PRIMARY KEY  CLUSTERED ([TransportStepPriceId] ASC)
go

CREATE TABLE [UserType]
( 
	[Username]           varchar(100)  NOT NULL ,
	[Password]           varchar(100)  NOT NULL ,
	[Name]               varchar(100)  NOT NULL ,
	[Surname]            varchar(100)  NOT NULL ,
	[IdAddr]             integer  NOT NULL 
)
go

ALTER TABLE [UserType]
	ADD CONSTRAINT [XPKUserSupertype] PRIMARY KEY  CLUSTERED ([Username] ASC)
go

CREATE TABLE [Vehicle]
( 
	[VehicleId]          varchar(100)  NOT NULL ,
	[FuelType]           integer  NOT NULL 
	CONSTRAINT [FuelType]
		CHECK  ( [FuelType]=0 OR [FuelType]=1 OR [FuelType]=2 ),
	[Consumption]        decimal(10,3)  NOT NULL ,
	[Capacity]           decimal(10,3)  NOT NULL ,
	[IdAddrParkedAt]     integer  NULL ,
	[IdAddr]             integer  NULL 
)
go

ALTER TABLE [Vehicle]
	ADD CONSTRAINT [XPKVehicle] PRIMARY KEY  CLUSTERED ([VehicleId] ASC)
go


ALTER TABLE [Address]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([ZIP]) REFERENCES [City]([ZIP])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Admin]
	ADD CONSTRAINT [R_13] FOREIGN KEY ([Username]) REFERENCES [UserType]([Username])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Courier]
	ADD CONSTRAINT [R_16] FOREIGN KEY ([Username]) REFERENCES [UserType]([Username])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [Courier]
	ADD CONSTRAINT [R_19] FOREIGN KEY ([VehicleId]) REFERENCES [Vehicle]([VehicleId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [InStockroom]
	ADD CONSTRAINT [R_48] FOREIGN KEY ([IdAddr]) REFERENCES [Stockroom]([IdAddr])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [InStockroom]
	ADD CONSTRAINT [R_49] FOREIGN KEY ([IdTO]) REFERENCES [Package]([IdTO])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [InVehicle]
	ADD CONSTRAINT [R_46] FOREIGN KEY ([VehicleId]) REFERENCES [Vehicle]([VehicleId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [InVehicle]
	ADD CONSTRAINT [R_47] FOREIGN KEY ([IdTO]) REFERENCES [Package]([IdTO])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Package]
	ADD CONSTRAINT [R_25] FOREIGN KEY ([IdTO]) REFERENCES [TransportOffer]([IdTO])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Package]
	ADD CONSTRAINT [R_26] FOREIGN KEY ([IdAddrAt]) REFERENCES [Address]([IdAddr])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [PromoteRequest]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([UsernameUser]) REFERENCES [UserType]([Username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Stockroom]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([IdAddr]) REFERENCES [Address]([IdAddr])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Transport]
	ADD CONSTRAINT [R_21] FOREIGN KEY ([Username]) REFERENCES [Courier]([Username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Transport]
	ADD CONSTRAINT [R_20] FOREIGN KEY ([VehicleId]) REFERENCES [Vehicle]([VehicleId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [TransportOffer]
	ADD CONSTRAINT [R_22] FOREIGN KEY ([Username]) REFERENCES [UserType]([Username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [TransportOffer]
	ADD CONSTRAINT [R_23] FOREIGN KEY ([IdAddrSrc]) REFERENCES [Address]([IdAddr])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [TransportOffer]
	ADD CONSTRAINT [R_24] FOREIGN KEY ([IdAddrDst]) REFERENCES [Address]([IdAddr])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [TransportPlan]
	ADD CONSTRAINT [R_29] FOREIGN KEY ([IdTO]) REFERENCES [Package]([IdTO])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [TransportPlan]
	ADD CONSTRAINT [R_38] FOREIGN KEY ([IdTransport]) REFERENCES [Transport]([IdTransport])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [UserType]
	ADD CONSTRAINT [R_45] FOREIGN KEY ([IdAddr]) REFERENCES [Address]([IdAddr])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Vehicle]
	ADD CONSTRAINT [R_37] FOREIGN KEY ([IdAddrParkedAt]) REFERENCES [Stockroom]([IdAddr])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Vehicle]
	ADD CONSTRAINT [R_40] FOREIGN KEY ([IdAddr]) REFERENCES [Address]([IdAddr])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

go

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

go

create proc initPrices
as
Begin

	Insert into FuelPrice
	Values (15),(32),(36)

	Insert into TransportStartPrice
	Values (115),(175),(250),(350)

	Insert into TransportStepPrice
	Values (0),(100),(100),(500)

End

go

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
go
create proc deleteAddressByNameNumber
@Street varchar(100),
@Number integer
as

Begin
	
	Delete from Address
	where Street = @Street AND Number = Number 
	return @@ROWCOUNT

End
go
create proc deleteAllAddressesFromCity
@ZIP integer
as

Begin
	
	Delete from Address
	where ZIP = @ZIP
	return @@ROWCOUNT

End
go
create proc getAllAddresses
as

Begin
	SET NOCOUNT ON
	select IdAddr from Address

End
go
create proc getAllAddressesFromCity
@ZIP integer
as

Begin
	
	SET NOCOUNT ON
	
	if NOT(@ZIP in (select ZIP from City))
		return -1

	select IdAddr from Address
	where ZIP = @ZIP

End
go
create proc insertAddress
@Street varchar(100),
@Number integer,
@CityZIP integer,
@X integer,
@Y integer
as

Begin
	begin try
		Insert into Address (Street,Number,x,y,ZIP)
		Values (@Street,@Number,@X,@Y,@CityZIP)
		return SCOPE_IDENTITY()
	end try
	begin catch
		PRINT error_message()
		return -1
	end catch
End
go
create proc deleteCityByName
@Name varchar(100)
as

Begin
	
	Delete from City
	where Name = @Name
	return @@ROWCOUNT

End
go
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
go
create proc getAllCities
as

Begin

	select ZIP
	from City

End
go
create proc insertCity
@Name varchar(100),
@CityZIP integer
as

Begin
	begin try
		Insert into City
		Values (@Name,@CityZIP)
		return @CityZIP
	end try
	begin catch
		PRINT ERROR_MESSAGE()
		return -1
	end catch
End
go

create proc deleteUser
@Username varchar(100)
as

begin

	begin try

		delete from UserType
		where Username = @Username

	end try

	begin catch

		print error_message()
		return -1

	end catch

end

go

create proc deleteCourier
@Username varchar(100)
as

begin

	
	if(not(@Username in (select @Username from Courier)))
		return -1

	declare @ret integer
	return exec deleteUser @Username

end
go
create proc getAllCouriers
as select Username from Courier order by JobProfit desc
go
create proc getAverageCourierProfit

@numberOfDeliveries integer

as

begin
	if @numberOfDeliveries < 0
		select avg(JobProfit) from Courier
	else
		select avg(JobProfit) from Courier where JobCount = @numberOfDeliveries
end
go
create proc getCouriersWithStatus
@Status integer

as

begin

	select Username from Courier
	where isDriving = @Status

end
go
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
go
create proc changeDriverLicenceNumberInCourierRequest
@Username varchar(100),
@License varchar(100)
as

begin


	if not(@Username  in (select UsernameUser from PromoteRequest))
		return -1

	begin try

		update PromoteRequest
		set License = @License
		where UsernameUser = @Username

	
	end try

	begin catch

		print error_message()
		return -1

	end catch

end
go
create proc deleteCourierRequest
@Username varchar(100)

as

begin


	if not(@Username in (select UsernameUser from PromoteRequest))
		return -1

	begin try

		delete from PromoteRequest
		where UsernameUser = @Username
	
	end try

	begin catch

		print error_message()
		return -1

	end catch

end
go
create proc getAllCourierRequests
as select UsernameUser from PromoteRequest
go
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
go
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
go
create proc getPackagesInVehicle
@Username varchar(100)
as

	select IdTO from InVehicle
	where VehicleId = (select VehicleId from Courier where Username = @Username)
	
go
create proc nextStop
@Username varchar(100)
as
begin
	
	if not(exists(select * from Transport where Username = @Username and Phase = 0))
		return -3

	declare @IdTransport integer
	select @IdTransport = IdTransport
	from Transport where Username = @Username
	and Phase = 0

	declare @VehicleId varchar(100)
	select @VehicleId = VehicleId
	from Courier where Username = @Username

	declare @IdStockroom integer
	select @IdStockroom =  IdAddrParkedAt
	from Vehicle where VehicleId = @VehicleId

	declare @IdTP integer
	declare @Type integer
	declare @IdTO integer

	select top 1 @IdTP = IdTP,@Type = Type,@IdTO = IdTO
	from TransportPlan
	where IdTransport = @IdTransport and Type != -1
	order by IdTP asc

	declare @IdAddrAt integer
	select @IdAddrAt = IdAddr from Vehicle
	where VehicleId = @VehicleId

	declare @IdAddrTo integer
	declare @dis decimal(10,3)

	if @Type = 1 begin --HomePick

		
		select @IdAddrTo = IdAddrSrc from TransportOffer
		where IdTO = @IdTO


		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport

		update Package  set
		Status = 2
		where IdTO = @IdTO

		insert into InVehicle values (@VehicleId,@IdTO)

		update Package
		set IdAddrAt = @IdAddrTo
		where IdTO in (select IdTo from InVehicle where VehicleId = @VehicleId)

			
		update TransportPlan
		set Type = -1
		where IdTP = @IdTP

		return -2

	end

	else if @Type = 2 begin -- MagPick
	
		select @IdAddrTo = @IdStockroom
		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)
				
				update Vehicle
				set IdAddr = @IdAddrTo
				where VehicleId = @VehicleId

				update Transport set
				Distance = Distance + @dis
				where IdTransport = @IdTransport


				declare @iter cursor
				declare @iIdTO integer
				declare @iIdTP integer
				
				set @iter = cursor for select IdTP,IdTO
				from TransportPlan
				where Type = 2 and IdTransport = @IdTransport
				order by IdTP asc
				
				open @iter
				fetch next from @iter
				into @iIdTP,@iIdTO

				while @@FETCH_STATUS = 0
				begin
				
				

					delete from InStockroom
					where IdAddr = @IdStockroom
					and IdTO = @iIdTO

					insert into InVehicle values (@VehicleId,@iIdTO)
			
					update TransportPlan
					set Type = -1
					where IdTP = @iIdTP

					fetch next from @iter
					into @iIdTP,@iIdTO

				end

				close @iter
				deallocate @iter

				
				update Package
				set IdAddrAt = @IdAddrTo
				where IdTO in (select IdTo from InVehicle where VehicleId = @VehicleId)

				return -2

	end


	else if @Type = 3 begin --Deliver

	
		select @IdAddrTo = IdAddrDst from TransportOffer
		where IdTO = @IdTO


		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport

		update Package  set
		Status = 3
		where IdTO = @IdTO

		update Package
		set IdAddrAt = @IdAddrTo
		where IdTO in (select IdTo from InVehicle where VehicleId = @VehicleId)

		delete from InVehicle where  VehicleId = @VehicleId and IdTO = @IdTO

		update TransportPlan
		set Type = -1
		where IdTP = @IdTP

		update Courier set JobCount = JobCount + 1
		where Username = @Username

		update Transport set Price = Price + (select Price from Package where IdTO = @IdTO)

		return @IdTO

	end

	else if @Type = 4 begin --RidePick

	select @IdAddrTo = IdAddrSrc from TransportOffer
		where IdTO = @IdTO


		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport

		update Package  set
		Status = 2
		where IdTO = @IdTO

		insert into InVehicle values (@VehicleId,@IdTO)

		update Package
		set IdAddrAt = @IdAddrTo
		where IdTO in (select IdTo from InVehicle where VehicleId = @VehicleId)

		update TransportPlan
		set Type = -1
		where IdTP = @IdTP


		return -2

	end

	else if @Type = 5 begin --RideMag
		

		select @IdAddrTo = Stockroom.IdAddr
		from Stockroom inner join Address on Address.IdAddr = Stockroom.IdAddr
		where ZIP = 
		(select ZIP from Address where IdAddr = @IdAddrAt)

		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport

		declare @iType integer

		set @iter = cursor for select IdTO,Type from TransportPlan
		where IdTransport = @IdTransport and Type != -1
		order by IdTP asc

		open @iter
		fetch next from @iter
		into @iIdTO,@iType

		while @@FETCH_STATUS = 0 and @iType = 5
		begin
				
	
			delete from InStockroom
			where IdTo = @iIdTO

			insert into InVehicle values (@VehicleId,@iIdTO)
			
			update TransportPlan set Type = -1
			where IdTO = @iIdTO
	

			fetch next from @iter
			into @iIdTO,@iType

		end

		close @iter
		deallocate @iter

		return -2


	end

	else begin

	select @IdAddrTo = @IdStockroom


		set @dis = sqrt(
				power((
					select x from Address where IdAddr = @IdAddrAt
				)-(
					select x from Address where IdAddr = @IdAddrTo
				),2)

				+

				power((
					select y from Address where IdAddr = @IdAddrAt
				)-(
					select y from Address where IdAddr = @IdAddrTo
				),2)
				)

		update Vehicle
		set IdAddr = @IdAddrTo
		where VehicleId = @VehicleId

		update Transport set
		Distance = Distance + @dis
		where IdTransport = @IdTransport


		
		set @iter = cursor for select IdTO from InVehicle
		where VehicleId = @VehicleId

		open @iter
		fetch next from @iter
		into @iIdTO

		while @@FETCH_STATUS = 0
		begin
				
	
			delete from InVehicle
			where IdTo = @iIdTO

			insert into InStockroom values (@IdStockroom,@iIdTO)
			
			update Package set IdAddrAt = @IdAddrTo where IdTo = @iIdTO

			fetch next from @iter
			into @iIdTO

		end

		close @iter
		deallocate @iter


		declare @fuelPrice decimal (10,3)
		select @fuelPrice = Price from FuelPrice
		where FuelPriceId = (select FuelType from Vehicle where VehicleId = @VehicleId)

		declare @distance decimal(10,3)
		select @distance = Distance from Transport where IdTransport = @IdTransport

		declare @consumption decimal(10,3)
		select @consumption = Consumption from Vehicle where VehicleId = @VehicleId

		declare @sumPrice decimal(10,3)
		select @sumPrice = Price from Transport where IdTransport = @IdTransport
		
		update Transport set Phase = 1
		where IdTransport = @IdTransport

		delete from TransportPlan
		where IdTransport = @IdTransport

		update Courier
		set JobProfit = JobProfit + @sumPrice - @fuelPrice * @distance * @consumption,
			VehicleId = null,
			IsDriving = 0
		where Username = @Username

		return -1

	end

end
go
-- 1 HOME-PICK 2 MAG-PICK 3 DELIVER 4 RIDE-PICK

create proc planingDrive
@Username varchar(100)
as

begin

	if not(@Username in (select Username from Courier) )
		return -1
	if exists(select * from Courier where Username = @Username and IsDriving = 1)
		return -2
	if exists(select * from Transport where Username = @Username and Phase = 0)
		return -3

	--RIDE MUST BE TAKEN

	declare @myCity integer
	select @myCity = ZIP
	from Address where IdAddr = (select IdAddr from UserType where Username = @Username)

	declare @myRide varchar(100)

	select @myRide = VehicleId
	from Vehicle where IdAddrParkedAt in (
	select IdAddr from Address where ZIP = @myCity
	)
	and not(exists(select * from Courier where Courier.VehicleId = Vehicle.VehicleId))

	if isnull(@myRide,'') = ''
		return -4

	update Courier set
	VehicleId = @myRide,
	IsDriving = 1
	where @Username = Username

	declare @startPoint integer
	select @startPoint = IdAddrParkedAt
	from Vehicle where VehicleId = @myRide



	declare @currWeight decimal(10,3)
	set @currWeight = 0

	declare @maxWeight decimal(10,3)
	select @maxWeight = Capacity
	from Vehicle
	where VehicleId = @myRide

	
	declare @IdTransport integer
	insert into Transport(VehicleId,Username,TS,Distance,Phase,Price)
	values (@myRide,@Username,CURRENT_TIMESTAMP,0,0,0)
	set @IdTransport = SCOPE_IDENTITY()


	declare @currPoint integer
	set @currPoint = @startPoint

	print 'Passs'

	--PHASE : Hometown pickup

	declare @inVehicle table (id integer,dis decimal(10,3))
	
	declare @iter cursor

	set @iter = cursor for 
				select Package.IdTo,Weight
				from Package 
				inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
				where Status = 1
				and IdAddrAt in (select IdAddr from Address where ZIP = @myCity)
				and not(Package.IdTo in (select IdTO from TransportPlan))
				order by TimeAccepted asc
	
	
	declare @iIdTo integer
	declare @iWeight decimal(10,3)
	
	open @iter
	fetch next from @iter
	into @iIdTo,@iWeight

	while @@FETCH_STATUS = 0
	begin

		if @currWeight + @iWeight > @maxWeight
			break

		select @currPoint = IdAddrSrc from TransportOffer where IdTO = @iIdTo

		insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,1)
		insert into @inVehicle values (@iIdTO,0)
		set @currWeight += @iWeight

		fetch next from @iter
		into @iIdTo,@iWeight
	
	end

	close @iter
	deallocate @iter

	--PHASE : Stockroom pickup
	--Thread safety!!!

	set @iter = cursor for 
				select Package.IdTo,Weight
				from Package 
				inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
				where exists (select * from InStockroom 
									   where InStockroom.IdTO = Package.IdTO
									   and InStockroom.IdAddr = @startPoint
							)
				and not(Package.IdTo in (select IdTO from TransportPlan))
				order by TimeAccepted asc




	open @iter
	fetch next from @iter
	into @iIdTo,@iWeight

	while @@FETCH_STATUS = 0
	begin

		if @currWeight + @iWeight > @maxWeight
			break

		set @currPoint = @startPoint
	
		insert into @inVehicle values (@iIdTO,0)
		insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,2)
		set @currWeight += @iWeight

		fetch next from @iter
		into @iIdTo,@iWeight
	
	end

	close @iter
	deallocate @iter




	declare @currCity integer
	set @currCity = @myCity

	--PHASE: Deliver and Pick

	while exists(select * from @inVehicle)
		begin
			
			update @inVehicle
			set dis =

			(
				sqrt(
				power((
					select x from Address where IdAddr = @currPoint
				)-(
					select x from TransportOffer inner join Address on TransportOffer.IdAddrDst = Address.IdAddr
							 where IdTO = id 
				),2)

				+

				power((
					select y from Address where IdAddr = @currPoint
				)-(
					select y from TransportOffer inner join Address on TransportOffer.IdAddrDst = Address.IdAddr
							 where IdTO = id 
				),2)
				)
			)



			declare @minFit integer
			select @minFit = id from @inVehicle where dis = (select min(dis) from @inVehicle)

			
			delete from @inVehicle
			where id = @minFit

			--Put action
			insert into TransportPlan(IdTO,IdTransport,Type) values (@minFit,@IdTransport,3)
			set @currWeight -= (select Weight from TransportOffer where IdTO = @minFit)



			declare @nextStop integer
			select @nextStop = IdAddrDst from TransportOffer where IdTO = @minFit

			declare @nextCity integer
			select @nextCity = ZIP from Address where IdAddr = @nextStop

			declare @cntr integer

			select @cntr = count(*) from @inVehicle


			--Check for any pickups
			if @currCity != @myCity and @nextCity != @currCity
				begin
				
				
			
					set @iter = cursor for 
					select Package.IdTo,Weight
					from Package 
					inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
					where Status = 1
					and IdAddrAt in (select IdAddr from Address where ZIP = @currCity)
					and not(Package.IdTo in (select IdTO from TransportPlan))
					order by TimeAccepted asc

					open @iter
					fetch next from @iter
					into @iIdTo,@iWeight

					while @@FETCH_STATUS = 0
					begin

						if @currWeight + @iWeight > @maxWeight
							break
					
						insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,4)
						set @currWeight += @iWeight


						fetch next from @iter
						into @iIdTo,@iWeight
	
					end

					close @iter
					deallocate @iter
					

					declare @currStock integer
					select @currStock = IdAddr
					from Stockroom
					where IdAddr in (select IdAddr from Address where ZIP = @currCity)

					if isnull(@currStock,1) != 1
					begin
						
						set @iter = cursor for 
						select Package.IdTo,Weight
						from Package 
						inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
						where Package.IdTO in (select IdTO from InStockroom where InStockroom.IdAddr = @currStock)
						and not(Package.IdTo in (select IdTO from TransportPlan))
						order by TimeAccepted asc

						open @iter
						fetch next from @iter
						into @iIdTo,@iWeight

						while @@FETCH_STATUS = 0
						begin

							if @currWeight + @iWeight > @maxWeight
								break
					
							insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,5)
							set @currWeight += @iWeight


							fetch next from @iter
							into @iIdTo,@iWeight
	
						end

						close @iter
						deallocate @iter
					end
				end
				set @currCity = @nextCity
				set @currPoint = @nextStop
		end

		if @currCity != @myCity 
		begin

					
			
					set @iter = cursor for 
					select Package.IdTo,Weight
					from Package 
					inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
					where Status = 1
					and IdAddrAt in (select IdAddr from Address where ZIP = @currCity)
					and not(Package.IdTo in (select IdTO from TransportPlan))
					order by TimeAccepted asc

					open @iter
					fetch next from @iter
					into @iIdTo,@iWeight

					while @@FETCH_STATUS = 0
					begin
						


						if @currWeight + @iWeight > @maxWeight
							break
				

						insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,4)
						set @currWeight += @iWeight


						fetch next from @iter
						into @iIdTo,@iWeight
	
					end

					close @iter
					deallocate @iter

					select @currStock = IdAddr
					from Stockroom
					where IdAddr in (select IdAddr from Address where ZIP = @currCity)

					if isnull(@currStock,1) != 1
					begin
						
						set @iter = cursor for 
						select Package.IdTo,Weight
						from Package 
						inner join TransportOffer on Package.IdTO = TransportOffer.IdTO
						where Package.IdTO in (select IdTO from InStockroom where InStockroom.IdAddr = @currStock)
						and not(Package.IdTo in (select IdTO from TransportPlan))
						order by TimeAccepted asc

						open @iter
						fetch next from @iter
						into @iIdTo,@iWeight

						while @@FETCH_STATUS = 0
						begin

							if @currWeight + @iWeight > @maxWeight
								break
					
							insert into TransportPlan(IdTO,IdTransport,Type) values (@iIdTo,@IdTransport,5)
							set @currWeight += @iWeight


							fetch next from @iter
							into @iIdTo,@iWeight
	
						end

						close @iter
						deallocate @iter
					end
				end

end

go
create proc eraseAll
as

begin


	delete from InVehicle
	delete from InStockroom
	delete from TransportPlan
	delete from Transport
	delete from Package
	delete from TransportOffer
	delete from Vehicle
	delete from Stockroom
	delete from PromoteRequest
	delete from UserType
	delete from Address
	delete from City

end

go
create proc rejectAnOffer
@IdTO integer
as

begin

	if not(@IdTO in (select IdTo from TransportOffer))
		return -1
	if (select Status from Package where @IdTO = IdTO) != 0
		return -1

	update Package
	set status = 4
	where IdTo = @IdTO

end
go
create proc insertPackage
@IdAddrFrom integer,
@IdAddrTo integer,
@Username varchar(100),
@Type integer,
@Weight decimal(10,3)

as

begin

	if 
		not(@IdAddrFrom in (select IdAddr from Address))
		OR not(@IdAddrTo in (select IdAddr from Address))
		OR @IdAddrFrom = @IdAddrTo
		OR not(@Username in (select Username from UserType))
		OR not(@Type in (0,1,2,3))
		OR @Weight <= 0
	
	return -1


	insert into TransportOffer(Username,IdAddrSrc,IdAddrDst,PackageType,Weight)
	values(@Username,@IdAddrFrom,@IdAddrTo,@Type,@Weight)
	return scope_identity() 

end
go
create proc getPriceOfDelivery
@IdTO integer
as

begin

	if not (@IdTO in (select IdTO from TransportOffer))
		return -1
	select Price from Package where IdTO = @IdTO

end
go
create proc getDeliveryStatus
@IdTO integer
as

begin

	if not (@IdTO in (select IdTO from TransportOffer))
		return -1
	return(select Status from Package where IdTO = @IdTO)

end
go
create proc getCurrentLocationOfPackage
@IdTO integer
as

begin

	if not (@IdTO in (select IdTO from TransportOffer))
		return -1

	if exists(select* from InVehicle where @IdTO = IdTO)
		return -1


	if exists(
	select TransportOffer.IdTo
	from TransportOffer inner join Package on TransportOffer.IdTO = Package.IdTO
	where IdAddrAt = IdAddrSrc or IdAddrAt = IdAddrDst or 
		  exists(select * from InStockroom where IdTO = TransportOffer.IdTO)
	  
	  )

	return (select IdAddrAt from Package where IdTO = @IdTO)

end
go
create proc getAllUndeliveredPackagesFromCity
@ZIP varchar(100)
as
select TransportOffer.IdTo
from TransportOffer inner join Package on TransportOffer.IdTO = Package.IdTO
where IdAddrSrc in (select IdAddr from Address where ZIP = @ZIP)
	  and Status in (1,2)

go
create proc getAllUndeliveredPackages
as select IdTO from Package where Status in (1,2)
go
create proc getAllPackagesWithSpecificType
@Type integer
as select IdTO from TransportOffer
where PackageType = @Type
go
create proc getAllPackagesCurrentlyAtCity
@ZIP varchar(100)
as
select TransportOffer.IdTo
from TransportOffer inner join Package on TransportOffer.IdTO = Package.IdTO
where IdAddrAt in (select IdAddr from Address where ZIP = @ZIP)
	  and (
	 IdAddrAt = IdAddrSrc and not(exists(select * from InVehicle where IdTO = TransportOffer.IdTO))
	 or IdAddrAt = IdAddrDst and not(exists(select * from InVehicle where IdTO = TransportOffer.IdTO))
	 or exists(select * from InStockroom where IdTO = TransportOffer.IdTO)
	  )
	  
go

create proc getAllPackages
as select IdTO from TransportOffer
go
create proc getAcceptanceTime
@IdTO integer
as

begin

	if not (@IdTO in (select IdTO from TransportOffer))
		return -1
	if (select Status from Package where IdTO = @IdTO)  in (0,4) 
		return -1

	select TimeAccepted from Package where IdTO = @IdTO

end
go
create proc deletePackage
@IdTO integer

as 

begin

	if not(@IdTO in (select IdTO from TransportOffer))
		return -1

	if exists(select * from InVehicle where @IdTO = IdTO)
		delete from InVehicle where IdTO = @IdTO
	if exists(select * from InStockroom where @IdTO = IdTO)
		delete from InStockroom where IdTO = @IdTO
	if exists(select * from TransportPlan where @IdTO = IdTO)
		delete from TransportPlan where IdTO = @IdTO



	delete from Package
	where IdTO = @IdTO

	delete from TransportOffer
	where IdTO = @IdTO

end
go
create proc changeWeight
@IdTO integer,
@Weight decimal(10,3)

as


begin

	if not(@IdTO in (select IdTO from TransportOffer))
		return -1

	if (select Status from Package where @IdTO = IdTO) != 0
		return -1
		
	update TransportOffer
	set Weight = @Weight
	where IdTO = @IdTO
end

go
create proc changeType
@IdTO integer,
@PackageType integer

as


begin
	
	if not(@IdTO in (select IdTO from TransportOffer))
		return -1

	if (select Status from Package where @IdTO = IdTO) != 0
		return -1

	if not(@PackageType in (0,1,2,3))
		return -1

	update TransportOffer
	set PackageType = @PackageType
	where IdTO = @IdTO



end

go

create proc acceptAnOffer
@IdTO integer
as

begin

	if not(@IdTO in (select IdTo from TransportOffer))
		return -1
	if (select Status from Package where @IdTO = IdTO) != 0
		return -1

	update Package
	set Status = 1,TimeAccepted = CURRENT_TIMESTAMP
	where IdTo = @IdTO

end

go

create proc insertStockroom
@IdAddr integer
as

begin


	if not(@IdAddr in (select IdAddr from Address))
		return -1
	
	if exists(
	select Stockroom.IdAddr 
	from Stockroom inner join Address on Stockroom.IdAddr = Address.IdAddr
	where ZIP = (select ZIP from Address where IdAddr = @IdAddr)
	)
		return -1

	begin try
		insert into Stockroom
		values (@IdAddr)
		return @IdAddr
	end try
	begin catch
		print error_message()
		return -1
	end catch


end

go

create proc getStoockroomFromCity
@ZIP integer
as 
begin

	if not(@ZIP in (select ZIP from City))
		return -1


	declare @IdAddr integer
	set @IdAddr = -1


	select @IdAddr = Address.IdAddr
	from Stockroom inner join Address on Stockroom.IdAddr = Address.IdAddr
	where ZIP = @ZIP

	return @IdAddr

end

go
create proc getAllStockrooms
as select IdAddr from Stockroom
go
create proc deleteStockroomFromCity
@ZIP varchar(100)
as

begin

	declare @IdAddr integer
	set @IdAddr = -1

	select @IdAddr =  IdAddr
	from Stockroom
	where IdAddr in (select IdAddr from Address where ZIP = @ZIP)

	if @IdAddr = -1
		return -1

	if	exists(select * from InStockroom where IdAddr = @IdAddr) or
		exists(select * from Vehicle where IdAddrParkedAt = @IdAddr)
		
	return -1

	delete from Stockroom
	where IdAddr = @IdAddr

	return @IdAddr

end
go

create proc deleteStockroom
@IdAddr integer
as

begin

	if not(@IdAddr in (select IdAddr from Stockroom))
	return -1

	if	exists(select * from Package where IdAddrAt = @IdAddr) or
		exists(select * from Vehicle where IdAddrParkedAt = @IdAddr)
		
	return -1

	delete from Stockroom
	where IdAddr = @IdAddr


end

go

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

go

create proc insertUser
@Username varchar(100),
@Password varchar(100),
@Name varchar(100),
@Surname varchar(100),
@IdAddr integer
as
Begin
	begin try
		Insert into UserType(Username,Password,Name,Surname,IdAddr)
		Values (@Username,@Password,@Name,@Surname,@IdAddr)
		return 0
	end try
	begin catch
		PRINT error_message()
		return -1
	end catch
End

go
create proc getSentPackages
@userName varchar(100)
as
begin

	if not(@userName in (select Username from UserType))
		return -1
	else return (
		select count(*)
		from TransportOffer join Package on TransportOffer.IdTO = Package.IdTO
		where Username = @userName and not(Status in (0,4)) 
		)
end

go

create proc getAllUsers
as
begin
	select Username from UserType
end

go


create proc parkVehicle
@VehicleId varchar(100),
@IdAddr integer

as


begin


	if not(@VehicleId in (select VehicleId from Vehicle))
		return -1
	if exists(select * from Courier where VehicleId = @VehicleId)
		return -1
	if not(@IdAddr in (select IdAddr from Stockroom))
		return -1

	update Vehicle
	set IdAddrParkedAt = @IdAddr,IdAddr = @IdAddr
	where VehicleId = @VehicleId


end

go

create proc insertVehicle
@License varchar(100),
@FuelType integer,
@Consumption decimal(10,3),
@Capacity decimal(10,3)
as
begin
	begin try

		insert into Vehicle
		values (@License,@FuelType,@Consumption,@Capacity,null,null)

	end try

	begin catch

		print error_message()
		return -1

	end catch

end

go

create proc getAllVehicles
as select VehicleId from Vehicle

go
create proc deleteVehicle
@VehicleId varchar(100)
as
begin

	if not( @VehicleId in (select VehicleId from Vehicle))
		return -1

	delete from Vehicle
	where VehicleId = @VehicleId
	return @@ROWCOUNT


end

go

create proc changeFuelType
@VehicleId varchar(100),
@FuelType integer

as

begin
	
	if not( @VehicleId in (select VehicleId from Vehicle))
		return -1
	if not (@fuelType in (0,1,2))
		return -1
	if isnull((select IdAddrParkedAt from Vehicle where VehicleId = @VehicleId),0) = 0
		return -1
	if exists(select * from Courier where VehicleId = @VehicleId)
		return -1

	update Vehicle set FuelType = @FuelType
	where VehicleId = @VehicleId

end

go

create proc changeConsumption
@VehicleId varchar(100),
@Consumption decimal(10,3)

as

begin
	
	if not( @VehicleId in (select VehicleId from Vehicle))
		return -1
	if exists(select * from Courier where VehicleId = @VehicleId)
		return -1
	if isnull((select IdAddrParkedAt from Vehicle where VehicleId = @VehicleId),0) = 0
		return -1

	update Vehicle set Consumption = @Consumption
	where VehicleId = @VehicleId

end

go
create proc changeCapacity
@VehicleId varchar(100),
@Capcity decimal(10,3)

as

begin
	
	if not( @VehicleId in (select VehicleId from Vehicle))
		return -1
	if isnull((select IdAddrParkedAt from Vehicle where VehicleId = @VehicleId),0) = 0
		return -1
	if exists(select * from Courier where VehicleId = @VehicleId)
		return -1

	update Vehicle set Capacity = @Capcity
	where VehicleId = @VehicleId

end

execute initPrices







