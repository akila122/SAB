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