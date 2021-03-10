set role all;
use midsem;
select * from Visitor_view ;
update Visitor_view set Likes =Likes+1 where AlbumName="eu turpis.";