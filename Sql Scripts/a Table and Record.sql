USE MarsColonyDB;
GO

-- Colonist
CREATE TABLE Colonist (
  MarsID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  MiddleName VARCHAR(50) NULL,
  LastName VARCHAR(50) NOT NULL,
  DOB DATE,
  Gender CHAR(1),
  Address VARCHAR(150),
  CivilStatus VARCHAR(20),
  FamilyCount INT
);

-- ColonistContact
CREATE TABLE ColonistContact (
  ContactID INT IDENTITY(1,1) PRIMARY KEY,
  MarsID INT NOT NULL,
  ContactNo VARCHAR(30) NOT NULL,
  FOREIGN KEY (MarsID) REFERENCES Colonist(MarsID)
);

-- Dependent
CREATE TABLE Dependent (
  DepID INT PRIMARY KEY,
  MarsID INT NOT NULL,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  DOB DATE,
  Gender CHAR(1),
  Relationship VARCHAR(50),
  FOREIGN KEY (MarsID) REFERENCES Colonist(MarsID)
);

-- Job
CREATE TABLE Job (
  JobID INT PRIMARY KEY,
  JobName VARCHAR(50)
);

-- ColonistJob (junction Colonist ↔ Job)
CREATE TABLE ColonistJob (
  MarsID INT NOT NULL,
  JobID INT NOT NULL,
  PRIMARY KEY (MarsID, JobID),
  FOREIGN KEY (MarsID) REFERENCES Colonist(MarsID),
  FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- House
CREATE TABLE House (
  ColonyLotNum INT PRIMARY KEY,
  Rooms INT,
  SquareFeet DECIMAL(8,2)
);

-- ConsistHouse (junction Colonist ↔ House)
CREATE TABLE ConsistHouse (
  MarsID INT NOT NULL,
  ColonyLotNum INT NOT NULL,
  PRIMARY KEY (MarsID, ColonyLotNum),
  FOREIGN KEY (MarsID) REFERENCES Colonist(MarsID),
  FOREIGN KEY (ColonyLotNum) REFERENCES House(ColonyLotNum)
);

-- EJet
CREATE TABLE EJet (
  JetCode VARCHAR(10) PRIMARY KEY,
  EngineType VARCHAR(50),
  Power VARCHAR(50),
  YearMade INT,
  Seats INT,
  Weight DECIMAL(12,2),
  PowerSource VARCHAR(50)
);

-- Trip
CREATE TABLE Trip (
  TripID INT PRIMARY KEY,
  JetCode VARCHAR(10) NOT NULL,
  LaunchDate DATE,
  ReturnDate DATE,
  FOREIGN KEY (JetCode) REFERENCES EJet(JetCode)
);

-- Pilot
CREATE TABLE Pilot (
  PilotID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  DOB DATE,
  SpaceHours INT,
  Designation VARCHAR(50)
);

-- PilotEJet (junction Pilot ↔ EJet)
CREATE TABLE PilotEJet (
  PilotID INT NOT NULL,
  JetCode VARCHAR(10) NOT NULL,
  PRIMARY KEY (PilotID, JetCode),
  FOREIGN KEY (PilotID) REFERENCES Pilot(PilotID),
  FOREIGN KEY (JetCode) REFERENCES EJet(JetCode)
);

-- Qualification
CREATE TABLE Qualification (
  QualID INT PRIMARY KEY,
  QualName VARCHAR(100),
  Description VARCHAR(255)
);

-- PilotQualification (junction Pilot ↔ Qualification)
CREATE TABLE PilotQualification (
  PilotID INT NOT NULL,
  QualID INT NOT NULL,
  PRIMARY KEY (PilotID, QualID),
  FOREIGN KEY (PilotID) REFERENCES Pilot(PilotID),
  FOREIGN KEY (QualID) REFERENCES Qualification(QualID)
);



-- Colonist 
INSERT INTO Colonist VALUES
(1, 'John', NULL, 'Smith', '1990-05-10', 'M', 'Earth Colony A1', 'Single', 0),
(2, 'Alice', 'M.', 'Brown', '1988-07-15', 'F', 'Earth Colony A2', 'Married', 2),
(3, 'Mark', NULL, 'Taylor', '1995-03-20', 'M', 'Mars Colony B1', 'Single', 0),
(4, 'Emma', NULL, 'Johnson', '1992-09-08', 'F', 'Mars Colony B2', 'Married', 1),
(5, 'David', 'P.', 'Lee', '1987-11-30', 'M', 'Mars Colony C1', 'Married', 3);

-- ColonistContact
INSERT INTO ColonistContact(MarsID, ContactNo) VALUES
(1, '0771234567'),
(1, '0719876543'),
(2, '0751112233'),
(3, '0762223344'),
(4, '0783334455');

-- Dependent
INSERT INTO Dependent VALUES
(101, 2, 'Mia', 'Brown', '2015-05-01', 'F', 'Daughter'),
(102, 2, 'Lucas', 'Brown', '2018-09-10', 'M', 'Son'),
(103, 4, 'Ella', 'Johnson', '2016-03-22', 'F', 'Daughter'),
(104, 5, 'Noah', 'Lee', '2012-07-17', 'M', 'Son'),
(105, 5, 'Sophia', 'Lee', '2019-12-05', 'F', 'Daughter');

-- Job 
INSERT INTO Job VALUES
(1, 'Engineer'),
(2, 'Doctor'),
(3, 'Farmer'),
(4, 'Technician'),
(5, 'Scientist');

-- ColonistJob 
INSERT INTO ColonistJob VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- House
INSERT INTO House VALUES
(201, 3, 1200.50),
(202, 4, 1500.00),
(203, 2, 950.75),
(204, 5, 1800.25),
(205, 3, 1100.00);

-- ConsistHouse 
INSERT INTO ConsistHouse VALUES
(1, 201),
(2, 202),
(3, 203),
(4, 204),
(5, 205);

-- EJet 
INSERT INTO EJet VALUES
('EJ001', 'Nuclear', '2000KW', 2050, 100, 25000.50, 'Fusion'),
('EJ002', 'Electric', '1500KW', 2048, 80, 20000.00, 'Battery'),
('EJ003', 'Plasma', '1800KW', 2049, 90, 22000.00, 'Plasma Cell'),
('EJ004', 'Hybrid', '2200KW', 2051, 120, 27000.00, 'Fusion+Battery'),
('EJ005', 'Ion', '1600KW', 2047, 75, 19000.00, 'Ion Drive');

-- Trip 
INSERT INTO Trip VALUES
(301, 'EJ001', '2055-01-10', '2055-02-20'),
(302, 'EJ002', '2055-03-05', '2055-04-10'),
(303, 'EJ003', '2055-05-15', '2055-06-25'),
(304, 'EJ004', '2055-07-01', '2055-08-12'),
(305, 'EJ005', '2055-09-18', '2055-10-30');

-- Pilot
INSERT INTO Pilot VALUES
(401, 'Neil', 'Armstrong', '1985-08-05', 2000, 'Captain'),
(402, 'Buzz', 'Aldrin', '1987-01-20', 1800, 'Commander'),
(403, 'Sally', 'Ride', '1990-05-26', 1500, 'Lieutenant'),
(404, 'Yuri', 'Gagarin', '1989-03-09', 1700, 'Senior Pilot'),
(405, 'Valentina', 'Tereshkova', '1992-12-10', 1600, 'Pilot');

-- PilotEJet 
INSERT INTO PilotEJet VALUES
(401, 'EJ001'),
(402, 'EJ002'),
(403, 'EJ003'),
(404, 'EJ004'),
(405, 'EJ005');

-- Qualification 
INSERT INTO Qualification VALUES
(501, 'Astro Navigation', 'Advanced space navigation skills'),
(502, 'Jet Engineering', 'Knowledge of jet systems'),
(503, 'Medical Training', 'Emergency medical handling'),
(504, 'Combat Training', 'Defense and combat readiness'),
(505, 'Space Research', 'Specialization in zero-gravity research');

-- PilotQualification 
INSERT INTO PilotQualification VALUES
(401, 501),
(402, 502),
(403, 503),
(404, 504),
(405, 505);