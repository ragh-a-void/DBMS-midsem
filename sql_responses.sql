-- Question 5 Queries 
-- part A
SELECT 
    *
FROM
    Album
WHERE
    AlbumNo IN (SELECT 
            AlbumNo
        FROM
            Downloadable
        WHERE
            YEAR(DateOfRelease) = 2020)
        AND AlbumType = 'Audio';
        
-- part B

-- With TheGroups(C, MemberNo) as (Select count(*) as C, MemberNo from Roles group by MemberNo having C>1 ) 
-- Select * from candidate where CandidateNo in TheGroups.MemberNo;
SELECT 
    *
FROM
    Candidate
WHERE
    CandidateNo IN (SELECT DISTINCT
            A.MemberNo
        FROM
            Roles A INNER JOIN
            Roles B
        ON
            A.MemberNo = B.MemberNo
                AND NOT (A.MusicGroupID = B.MusicGroupID));

-- part C

SELECT 
    *
FROM
    Candidate
WHERE
    CandidateNo IN (SELECT 
            MemberNo
        FROM
            Roles
        WHERE
            MemberNo NOT IN (SELECT DISTINCT
                    A.MemberNo
                FROM
                    Roles A INNER JOIN
                    Roles B
                ON
                    A.MemberNo = B.MemberNo
                        AND NOT (A.MusicGroupID = B.MusicGroupID))
                AND MusicGroupID IN (SELECT 
                    MusicGroupID
                FROM
                    MusicGroup
                WHERE
                    Type = 'pop'));

-- part D

SELECT 
    *
FROM
    candidate
WHERE
    candidateNo IN (SELECT 
            A.CandidateNo
        FROM
            Submission A INNER JOIN
            Submission B
        ON
            A.CandidateNo = B.CandidateNo
                AND NOT (A.SubmissionType = B.SubmissionType));

-- part E

With NewTable(MediaForm,count)
as (Select AdvertisementSeen, count(*) from submission
 INNER JOIN Candidate ON Candidate.CandidateNo = submission.CandidateNo
 group by AdvertisementSeen) Select max(count)as "Number of entries", MediaForm from NewTable ;
SELECT 
    AdvertisementSeen, COUNT(*)
FROM
    submission
        INNER JOIN
    Candidate ON Candidate.CandidateNo = submission.CandidateNo
GROUP BY AdvertisementSeen;

-- Question 6 (b) -1 To display number of candidates citiwise: 

CREATE TABLE stats_state AS (SELECT COUNT(*) AS “Amount”, state FROM
    Candidate
        INNER JOIN
    Submission ON Submission.CandidateNo = Candidate.CandidateNo
GROUP BY state);

-- Question 6 (b) -2 To display number of candidates AlbumTypeWise:
 
CREATE TABLE stats_Album AS SELECT COUNT(*) AS “Amount”, SubmissionType FROM
    Submission
GROUP BY SubmissionType;

-- Question 6 (b) -3 To display number of candidates Age_Interval Wise: 

CREATE TABLE stats_Age AS SELECT COUNT(*) AS Amount,
    CASE
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 7 AND 14 THEN '7-14'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 15 AND 20 THEN '15-20'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 21 AND 25 THEN '21-25'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 26 AND 30 THEN '26-30'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 31 AND 40 THEN '31-40'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 41 AND 100 THEN '41-100'
    END AS Age_Interval FROM
    Candidate
        INNER JOIN
    Submission ON Submission.CandidateNo = Candidate.CandidateNo
GROUP BY Age_Interval ;

-- Question 6 (b)
Create table statistics as (Select State, SubmissionType, 
CASE
	WHEN DATE_FORMAT(now(), '%Y') - DATE_FORMAT(dob, '%Y')BETWEEN 6 AND 14 THEN '6-14'
    WHEN DATE_FORMAT(now(), '%Y') - DATE_FORMAT(dob, '%Y')BETWEEN 15 AND 20 THEN '15-20'
    WHEN DATE_FORMAT(now(), '%Y') - DATE_FORMAT(dob, '%Y')BETWEEN 21 AND 25 THEN '21-25'
    WHEN DATE_FORMAT(now(), '%Y') - DATE_FORMAT(dob, '%Y')BETWEEN 26 AND 30 THEN '26-30'
    WHEN DATE_FORMAT(now(), '%Y') - DATE_FORMAT(dob, '%Y')BETWEEN 31 AND 40 THEN '31-40'
    WHEN DATE_FORMAT(now(), '%Y') - DATE_FORMAT(dob, '%Y')BETWEEN 41 AND 100 THEN '41-100'
END as Age_Interval, Count(*) as "Count"  from Candidate INNER JOIN Submission  ON Candidate.CandidateNo= Submission.CandidateNo group by State,SubmissionType,Age_Interval) ;

-- Question 6 (c) 
CREATE TABLE Zones (
    State VARCHAR(50),
    Zone ENUM('North', 'South', 'East', 'West')
);

CREATE TABLE zone_stats AS (SELECT Zones.Zone,
    SubmissionType,
    CASE
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 6 AND 14 THEN '6-14'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 15 AND 20 THEN '15-20'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 21 AND 25 THEN '21-25'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 26 AND 30 THEN '26-30'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 31 AND 40 THEN '31-40'
        WHEN DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(dob, '%Y') BETWEEN 41 AND 100 THEN '41-100'
    END AS Age_Interval,
    COUNT(*) AS Count FROM
    Candidate
        INNER JOIN
    Submission ON Candidate.CandidateNo = Submission.CandidateNo
        INNER JOIN
    Zones ON Candidate.State = Zones.State
GROUP BY Zone , SubmissionType , Age_Interval);