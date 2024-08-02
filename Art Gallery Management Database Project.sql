-- Create the database
CREATE DATABASE ArtGalleryManagementDB;

-- Use the created database
USE ArtGalleryManagementDB;

-- Create the Artist table
CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Birthplace VARCHAR(100),
    Age INT,
    StyleOfArt VARCHAR(50)
);

-- Create the Artwork table
CREATE TABLE Artwork (
    ArtworkID INT PRIMARY KEY,
    Title VARCHAR(255),
    YearCreated INT,
    KindOfArt VARCHAR(255),
    Price DECIMAL(15, 2), -- DECIMAL with 15 digits total, 2 digits after the decimal point
    ArtistID INT,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
);


INSERT INTO Artist (ArtistID, Name, Birthplace, Age, StyleOfArt)
VALUES
    (1, 'Vincent van Gogh', 'Zundert, Netherlands', 37, 'Post-Impressionism'),
    (2, 'Pablo Picasso', 'Malaga, Spain', 91, 'Cubism'),
    (3, 'Frida Kahlo', 'Coyoacán, Mexico', 47, 'Surrealism');
    
    INSERT INTO Artwork (ArtworkID, Title, YearCreated, KindOfArt, Price, ArtistID)
VALUES
    (1, 'Starry Night', 1889, 'Oil Painting', 100000000, 1),
    (2, 'Guernica', 1937, 'Oil Painting', 200000000, 2),
    (3, 'The Two Fridas', 1939, 'Oil Painting', 50000000, 3);
    
SELECT * FROM Artist;

SELECT * FROM Artwork;

SELECT * FROM Artwork
WHERE ArtistID = 1;

SELECT a.Name, a.Birthplace, a.Age, a.StyleOfArt
FROM Artist a
JOIN Artwork art ON a.ArtistID = art.ArtistID
WHERE art.ArtworkID = 1;

SELECT * FROM Artwork
WHERE YearCreated > 1930;

UPDATE Artwork
SET Price = 150000000
WHERE ArtworkID = 1;

DELETE FROM Artwork
WHERE ArtworkID = 1;

SELECT a.Name AS ArtistName, art.Title AS ArtworkTitle
FROM Artist a
JOIN Artwork art ON a.ArtistID = art.ArtistID;

SELECT a.Name AS ArtistName, COUNT(art.ArtworkID) AS NumberOfArtworks
FROM Artist a
JOIN Artwork art ON a.ArtistID = art.ArtistID
GROUP BY a.Name;

ALTER TABLE Artwork
MODIFY Price DECIMAL(15, 2);

ALTER TABLE Artwork
MODIFY Price BIGINT;

SELECT * FROM Artwork
WHERE ArtistID = 1;

SELECT * FROM Artwork
ORDER BY Price DESC
LIMIT 1;

UPDATE Artwork
SET Price = 150000000
WHERE ArtworkID = 1;

SELECT DISTINCT a.Name
FROM Artist a
JOIN Artwork art ON a.ArtistID = art.ArtistID
WHERE art.Price > 100000000;








