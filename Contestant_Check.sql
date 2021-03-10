set role all;
use midsem;
select * from contestant_info;
select * from submssion_info;
select distinct CategorySelectedfor from Contestant;
update contestant_info set  Firstname="Aarohi" ;
update Contestant set CategorySelectedfor ="Audio";
select SelectedforMember from Contestant;