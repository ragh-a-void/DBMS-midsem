set role all;
use midsem;
select * from submissions;
select * from panelist_info;
update panelist_info set FirstName="Hari" where panellistno=30001;