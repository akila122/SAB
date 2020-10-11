use TransportCompany

insert into City
values ('Negotin',19300),('Nis',18000),('Beograd',11000),('Novi Sad',21000)

insert into Address
values 
	('CentarNis',0,3,1,18000),('PeriferijaNis',0,4,3,18000),
	('CentarNegotin',0,5,3,19300),('PeriferijaNegotin',0,6,4,19300),
	('CentarBeograd',0,3,6,11000),('PeriferijaBeograd',0,3,7,11000),
	('CentarNoviSad',0,4,9,21000),('PeriferijaNoviSad',0,5,10,21000)

insert into Stockroom
values
	((select IdAddr from Address where Street = 'CentarNoviSad')),
	((select IdAddr from Address where Street = 'CentarNis'))

insert into UserType
values
	('u1','pass','Pera','Peric',(select IdAddr from Address where Street = 'CentarNoviSad')),
	('u2','pass','Milica','Nikolic',(select IdAddr from Address where Street = 'CentarNis')),
	('u3','pass','Nikola','Nikolic',(select IdAddr from Address where Street = 'CentarNegotin'))

insert into Courier
values
	('u1',null,0,0,0,'lic1'),
	('u2',null,0,0,0,'lic2')

insert into Admin
values
	('u3')

insert into Vehicle
values
	('v1',0,10,100,null,null),
	('v2',1,11,150,null,null),
	('v3',2,8,90,null,null)