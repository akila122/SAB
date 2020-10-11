create proc getAllUndeliveredPackages
as select IdTO from Package where Status in (1,2)