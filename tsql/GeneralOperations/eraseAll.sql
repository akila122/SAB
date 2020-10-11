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