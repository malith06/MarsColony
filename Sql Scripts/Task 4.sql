--Number of colonists per job
SELECT 
    j.JobID,
    j.JobName,
    COUNT(cj.MarsID) AS ColonistCount
FROM Job AS j
LEFT JOIN ColonistJob AS cj ON cj.JobID = j.JobID
GROUP BY j.JobID, j.JobName
ORDER BY ColonistCount DESC, j.JobName;





--Upcoming trips with jet and pilot assignments
SELECT
    t.TripID,
    t.LaunchDate,
    t.ReturnDate,
    e.JetCode,
    e.EngineType,
    (p.FirstName + ' ' + p.LastName) AS PilotName,
    p.Designation
FROM Trip AS t
JOIN EJet AS e      ON e.JetCode = t.JetCode
JOIN PilotEJet AS pe ON pe.JetCode = e.JetCode
JOIN Pilot AS p      ON p.PilotID = pe.PilotID
ORDER BY t.LaunchDate, e.JetCode, PilotName;


--Trips with jets and pilot assignments
SELECT
    t.TripID,
    t.LaunchDate,
    t.ReturnDate,
    e.JetCode,
    e.EngineType,
    COALESCE(p.FirstName,'') + ' ' + COALESCE(p.LastName,'') AS PilotName
FROM dbo.Trip AS t
JOIN dbo.EJet      AS e  ON e.JetCode  = t.JetCode
JOIN dbo.PilotEJet AS pe ON pe.JetCode = e.JetCode
JOIN dbo.Pilot     AS p  ON p.PilotID  = pe.PilotID
ORDER BY t.LaunchDate, e.JetCode, PilotName;


