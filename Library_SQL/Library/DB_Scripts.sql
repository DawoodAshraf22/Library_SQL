

USE Library

CREATE TABLE users (
    userid INT PRIMARY KEY identity(1,1),
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    usertype VARCHAR(20) NOT NULL,
    createdat DateTime DEFAULT GETUTCDATE(),
    isactive BIT DEFAULT 1
);

CREATE TABLE genre (
    genreid INT PRIMARY KEY identity(1,1),
    genrename VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(100),
    createdat DateTime DEFAULT GETUTCDATE(),
);

CREATE TABLE books (
    bookid INT PRIMARY KEY identity(1,1),
	genreid INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    publicationyear INT,
    isbn VARCHAR(20) UNIQUE,
    totalcopies INT DEFAULT 1,
    availablecopies INT DEFAULT 1,
    createdat DateTime DEFAULT GETUTCDATE(),
    updatedat DateTime DEFAULT GETUTCDATE()

	FOREIGN KEY (genreid) REFERENCES genre(genreid),
);

CREATE TABLE bookissues (
    bookissuesid INT PRIMARY KEY  identity(1,1),
    bookid INT NOT NULL,
    userid INT NOT NULL,
    issuedate DATE NOT NULL,
    duedate DATE NOT NULL,
    returndate DATE NULL,
    fineamount DECIMAL(10,2) DEFAULT 0.00,
    status  VARCHAR(50) NOT NULL,
    createdat DateTime DEFAULT GETUTCDATE(),
    
    FOREIGN KEY (bookid) REFERENCES books(bookid),
    FOREIGN KEY (userid) REFERENCES users(userid)
);

CREATE TABLE fines (
    fineid INT PRIMARY KEY  identity(1,1),
    bookissuesid INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paidamount DECIMAL(10,2) DEFAULT 0.00,
    status  VARCHAR(20) NOT NULL ,
    createdat DateTime DEFAULT GETUTCDATE(),
    paidat DateTime NULL

    FOREIGN KEY (bookissuesid) REFERENCES bookissues(bookissuesid)
);