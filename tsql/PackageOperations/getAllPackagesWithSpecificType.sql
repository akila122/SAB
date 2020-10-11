create proc getAllPackagesWithSpecificType
@Type integer
as select IdTO from TransportOffer
where PackageType = @Type
