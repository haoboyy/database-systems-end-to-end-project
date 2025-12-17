------------------------------------------------------------
-- EasyPair Logical Schema - CREATE TABLE Statements
------------------------------------------------------------

------------------------------------------------------------
-- 1. Client
------------------------------------------------------------
CREATE TABLE Client (
    ClientID        INT PRIMARY KEY,
    Name            VARCHAR(255),
    Email           VARCHAR(255),
    Organization    VARCHAR(255),
    CreatedDate     DATETIME
);

------------------------------------------------------------
-- 2. ServiceProvider
------------------------------------------------------------
CREATE TABLE ServiceProvider (
    ProviderID        INT PRIMARY KEY,
    Name              VARCHAR(255),
    Email             VARCHAR(255),
    ExperienceLevel   VARCHAR(50),
    BioTextID         INT,
    FOREIGN KEY (BioTextID) REFERENCES UnstructuredText(TextID)
);

------------------------------------------------------------
-- 3. ServiceCategory
------------------------------------------------------------
CREATE TABLE ServiceCategory (
    CategoryID      INT PRIMARY KEY,
    CategoryName    VARCHAR(255),
    Description     VARCHAR(500)
);

------------------------------------------------------------
-- 4. ProviderSkill (Composite Key)
------------------------------------------------------------
CREATE TABLE ProviderSkill (
    ProviderID      INT,
    CategoryID      INT,
    SkillName       VARCHAR(255),
    SkillLevel      VARCHAR(100),
    PRIMARY KEY (ProviderID, CategoryID, SkillName),
    FOREIGN KEY (ProviderID) REFERENCES ServiceProvider(ProviderID),
    FOREIGN KEY (CategoryID) REFERENCES ServiceCategory(CategoryID)
);

------------------------------------------------------------
-- 5. ProjectRequest
------------------------------------------------------------
CREATE TABLE ProjectRequest (
    RequestID       INT PRIMARY KEY,
    ClientID        INT,
    Title           VARCHAR(255),
    Budget          DECIMAL(12,2),
    Deadline        DATETIME,
    RequestTextID   INT,
    CreatedDate     DATETIME,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (RequestTextID) REFERENCES UnstructuredText(TextID)
);

------------------------------------------------------------
-- 6. MatchingResult
------------------------------------------------------------
CREATE TABLE MatchingResult (
    ResultID        INT PRIMARY KEY,
    RequestID       INT,
    ProviderID      INT,
    Score           FLOAT,
    Rank            INT,
    FOREIGN KEY (RequestID) REFERENCES ProjectRequest(RequestID),
    FOREIGN KEY (ProviderID) REFERENCES ServiceProvider(ProviderID)
);

------------------------------------------------------------
-- 7. MessageLog
------------------------------------------------------------
CREATE TABLE MessageLog (
    MessageID       INT PRIMARY KEY,
    RequestID       INT,
    SenderID        INT,
    ReceiverID      INT,
    MessageTextID   INT,
    Timestamp       DATETIME,
    FOREIGN KEY (RequestID) REFERENCES ProjectRequest(RequestID),
    FOREIGN KEY (MessageTextID) REFERENCES UnstructuredText(TextID)
);

------------------------------------------------------------
-- 8. Review
------------------------------------------------------------
CREATE TABLE Review (
    ReviewID        INT PRIMARY KEY,
    RequestID       INT,
    ProviderID      INT,
    Rating          INT,
    CommentTextID   INT,
    ReviewDate      DATETIME,
    FOREIGN KEY (RequestID) REFERENCES ProjectRequest(RequestID),
    FOREIGN KEY (ProviderID) REFERENCES ServiceProvider(ProviderID),
    FOREIGN KEY (CommentTextID) REFERENCES UnstructuredText(TextID)
);

------------------------------------------------------------
-- 9. UnstructuredText
------------------------------------------------------------
CREATE TABLE UnstructuredText (
    TextID        INT PRIMARY KEY,
    RawText       TEXT,
    SourceType    VARCHAR(50),
    CreatedDate   DATETIME
);
