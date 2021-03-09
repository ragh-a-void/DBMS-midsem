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
GROUP BY AdvertisementSeen