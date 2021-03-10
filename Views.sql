CREATE VIEW PanelistView 
AS 
SELECT * FROM panellist, submission
WHERE panellist.CandidateNo=convert(left(CURRENT_USER(),INSTR(current_user(), '@')-1), decimal);
