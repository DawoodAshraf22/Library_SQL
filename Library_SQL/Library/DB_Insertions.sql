USE [Library]
GO

INSERT INTO users (fullname,email,username,password,usertype,isactive)
VALUES('Admin','Admin@gmail.com','Admin','Admin@123','Admin',1)

INSERT INTO users (fullname,email,username,password,usertype,isactive)
VALUES('Student','Student@gmail.com','Student','Student@123','Student',1)


INSERT INTO genre (genrename, description) VALUES
('Fiction', 'Imaginative literature including novels and short stories'),
('Science Fiction', 'Futuristic, scientific, and technological themes'),
('Mystery', 'Crime, detective stories, and suspenseful plots'),
('Romance', 'Love stories and romantic relationships'),
('Biography', 'Accounts of people''s lives written by others'),
('History', 'Records of past events and civilizations'),
('Science', 'Books about scientific principles and discoveries'),
('Fantasy', 'Magical, supernatural, and imaginary worlds'),
('Self-Help', 'Personal development and improvement guides'),
('Technology', 'Books about computers, programming, and IT');

INSERT INTO books (genreid, title, author, genre, publicationyear, isbn, totalcopies, availablecopies) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, '978-0-06-112008-4', 5, 3),
(2, 'Dune', 'Frank Herbert', 'Science Fiction', 1965, '978-0-441-17271-9', 3, 2),
(3, 'The Girl with the Dragon Tattoo', 'Stieg Larsson', 'Mystery', 2005, '978-0-307-26975-1', 4, 1),
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813, '978-0-14-143951-8', 6, 4),
(5, 'Steve Jobs', 'Walter Isaacson', 'Biography', 2011, '978-1-4516-4853-9', 2, 2),
(6, 'A People''s History of the United States', 'Howard Zinn', 'History', 1980, '978-0-06-083865-2', 3, 1),
(7, 'A Brief History of Time', 'Stephen Hawking', 'Science', 1988, '978-0-553-10953-5', 4, 3),
(8, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937, '978-0-547-92822-7', 5, 2),
(9, 'The 7 Habits of Highly Effective People', 'Stephen Covey', 'Self-Help', 1989, '978-1-4516-3964-3', 3, 3),
(10, 'Clean Code', 'Robert C. Martin', 'Technology', 2008, '978-0-13-235088-4', 2, 1),
(1, '1984', 'George Orwell', 'Fiction', 1949, '978-0-452-28423-4', 4, 2),
(2, 'Neuromancer', 'William Gibson', 'Science Fiction', 1984, '978-0-441-56959-1', 3, 1),
(3, 'Gone Girl', 'Gillian Flynn', 'Mystery', 2012, '978-0-307-58836-4', 3, 2),
(4, 'The Notebook', 'Nicholas Sparks', 'Romance', 1996, '978-0-446-60523-6', 4, 3);