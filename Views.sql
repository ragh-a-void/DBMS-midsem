-- CREATE VIEW PanelistView 
-- AS 
-- SELECT * FROM panellist, submission
-- WHERE panellist.CandidateNo=convert(left(CURRENT_USER(),INSTR(current_user(), '@')-1), decimal);

create user "30001"@localhost identified by "12345";

select substring_index(user(), '@', 1);

CREATE VIEW PanelistView 
AS 
SELECT * FROM panellist, submission
WHERE panellist.PanellistNo= substring_index(user(), '@', 1);
drop view PanelistView;

create view Contestant as 
with short(num, CategorySelectedFor) as (select candidate.candidateNo, shortlisted.category from candidate left join shortlisted on candidate.candidateNo=shortlisted.candidateNo)
select 
S.CandidateNo, S.Duration, S.SubmissionDate, S.SubmissionType,  C.firstName, C.LastName, C.DOB, C.PriorExperience, C.Email, C.AdvertisementSeen, Short.CategorySelectedFor 
from Candidate as C 
inner join submission as S 
on C.CandidateNo=S.CandidateNo 
inner join short
on S.CandidateNo=Short.num
where S.CandidateNo=substring_index(user(), '@', 1);

create view MemView
as with temp(mgid) as 
(select roles.musicgroupid from roles where roles.MemberNo=substring_index(user(), '@', 1)) 
select m.musicgroupid, m.moderatorno, m.type, r.Albumno, r.MemberNo, r.RolePlayed, album.Albumname, album.albumtype, album.approvalDate, album.URL 
from MusicGroup as m 
inner join roles as r 
on m.musicgroupid=r.musicgroupid and m.musicgroupid in (select mgid from temp) 
inner join Album on r.AlbumNo=Album.AlbumNo;

grant select on PanelistView to "30001"@localhost;
