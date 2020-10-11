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