-- Create Database
CREATE DATABASE GateSmartDB;
GO
USE GateSmartDB;
GO

-- =======================
-- TABLE: Societies
-- =======================
CREATE TABLE Societies (
    SocietyID INT IDENTITY(1,1) PRIMARY KEY,
    SocietyName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255),
    City NVARCHAR(100),
    ContactNumber NVARCHAR(20)
);
GO

INSERT INTO Societies (SocietyName, Address, City, ContactNumber)
VALUES 
('Bahria Town Phase 4', 'Main Boulevard, Bahria Town', 'Karachi', '03001234567'),
('Defence Housing Society', 'Khayaban-e-Ittehad', 'Karachi', '03007654321'),
('Clifton Residency', 'Street 10, Block 5', 'Karachi', '03005556666'),
('Falaknaz Dream Villas', 'Malir Cantt', 'Karachi', '03009998888'),
('Model Town Heights', 'Main Road Model Town', 'Lahore', '03007778899');
GO


-- =======================
-- TABLE: Residents
-- =======================
CREATE TABLE Residents (
    ResidentID INT IDENTITY(1,1) PRIMARY KEY,
    SocietyID INT FOREIGN KEY REFERENCES Societies(SocietyID),
    HouseNumber NVARCHAR(20),
    ResidentName NVARCHAR(100),
    ContactNumber NVARCHAR(20),
    WhatsAppNumber NVARCHAR(20),
    Email NVARCHAR(100)
);
GO

INSERT INTO Residents (SocietyID, HouseNumber, ResidentName, ContactNumber, WhatsAppNumber, Email)
VALUES 
(1, 'A-21', 'Ali Khan', '03011234567', '03011234567', 'ali.khan@gmail.com'),
(1, 'A-22', 'Fatima Ahmed', '03019876543', '03019876543', 'fatima.a@gmail.com'),
(2, 'B-10', 'Zain Malik', '03112223333', '03112223333', 'zainmalik@yahoo.com'),
(3, 'C-5', 'Sara Iqbal', '03219998888', '03219998888', 'sara.iqbal@gmail.com'),
(4, 'D-18', 'Bilal Hussain', '03334445555', '03334445555', 'bilal.hussain@hotmail.com');
GO


-- =======================
-- TABLE: Visitors
-- =======================
CREATE TABLE Visitors (
    VisitorID INT IDENTITY(1,1) PRIMARY KEY,
    VisitorName NVARCHAR(100) NOT NULL,
    CNIC NVARCHAR(20) NOT NULL,
    ContactNumber NVARCHAR(20),
    PurposeOfVisit NVARCHAR(255),
    PhotoPath NVARCHAR(255)
);
GO

INSERT INTO Visitors (VisitorName, CNIC, ContactNumber, PurposeOfVisit, PhotoPath)
VALUES 
('Ahmed Raza', '42101-1234567-1', '03009997777', 'Delivery', '/images/visitors/ahmed.jpg'),
('Imran Ali', '42101-7654321-9', '03005554444', 'Guest Visit', '/images/visitors/imran.jpg'),
('Ayesha Noor', '42101-9988776-3', '03007776666', 'Maintenance', '/images/visitors/ayesha.jpg'),
('Sana Malik', '42101-4567890-5', '03119998877', 'Package Delivery', '/images/visitors/sana.jpg'),
('Fahad Iqbal', '42101-2345678-0', '03218887777', 'Friend Visit', '/images/visitors/fahad.jpg');
GO


-- =======================
-- TABLE: Visits
-- =======================
CREATE TABLE Visits (
    VisitID INT IDENTITY(1,1) PRIMARY KEY,
    VisitorID INT FOREIGN KEY REFERENCES Visitors(VisitorID),
    ResidentID INT FOREIGN KEY REFERENCES Residents(ResidentID),
    SocietyID INT FOREIGN KEY REFERENCES Societies(SocietyID),
    CheckInTime DATETIME DEFAULT GETDATE(),
    CheckOutTime DATETIME NULL,
    QRCodePath NVARCHAR(255),
    IsCheckedOut BIT DEFAULT 0,
    Status NVARCHAR(50) DEFAULT 'Pending' -- Pending / Approved / Rejected
);
GO

INSERT INTO Visits (VisitorID, ResidentID, SocietyID, QRCodePath, IsCheckedOut, Status)
VALUES 
(1, 1, 1, '/qr/visitor1.png', 0, 'Pending'),
(2, 2, 1, '/qr/visitor2.png', 1, 'Approved'),
(3, 3, 2, '/qr/visitor3.png', 1, 'Approved'),
(4, 4, 3, '/qr/visitor4.png', 0, 'Pending'),
(5, 5, 4, '/qr/visitor5.png', 1, 'Approved');
GO


-- =======================
-- TABLE: Users (for login)
-- =======================
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(50) CHECK (Role IN ('Admin', 'Guard')),
    SocietyID INT FOREIGN KEY REFERENCES Societies(SocietyID)
);
GO

INSERT INTO Users (Username, PasswordHash, Role, SocietyID)
VALUES 
('admin1', 'admin123', 'Admin', 1),
('guard1', 'guard123', 'Guard', 1),
('admin2', 'admin321', 'Admin', 2),
('guard2', 'guard321', 'Guard', 2),
('admin3', 'secure123', 'Admin', 3);
GO
