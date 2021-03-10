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

grant select on PanelistView to "30001"@localhost;
