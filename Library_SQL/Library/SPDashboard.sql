USE [Library]
GO
CREATE OR ALTER PROC [dbo].[SPDashboard]
@Action			int					=	NULL, 
@ID				int					=	NULL, 
@ParentID		int					=	NULL,
@userid			int					=	NULL,
@Search			VARCHAR(100)		=	NULL,
@usertype		VARCHAR(100)		=	NULL, 
@Output         VARCHAR(100)    = NULL OUTPUT
AS
BEGIN
    IF @Action = 0
    BEGIN
	if @ID is null
	BEGIN
		SELECT
		(
		SELECT COUNT(BookID) totalBooks
		FROM books
		) totalBooks,
		(
		SELECT COUNT(genreID) genre
		FROM genre
		) genre,
		(
		SELECT COUNT(bookissuesid) issuedBooks
		FROM bookissues
		)issuedBooks,
		(
		SELECT COUNT(Userid) totalStudents
		FROM users
		Where usertype = 'Student'
		)totalStudents
	
		SELECT b.title as bookTitle ,fullname as student,bi.issuedate,bi.duedate
		FROM bookissues bi
		join books b on bi.bookid =  b.bookid
		join users u on bi.userid =  u.userid
	END
	else 
	BEGIN
		SELECT
		(
		SELECT COUNT(BookID) totalBooks
		FROM books
		) totalBooks,
		(
		SELECT COUNT(genreID) genre
		FROM genre
		) genre,
		(
		SELECT COUNT(bookissuesid) issuedBooks
		FROM bookissues
		)issuedBooks,
		(
		SELECT COUNT(Userid) totalStudents
		FROM users
		Where usertype = 'Student'
		)totalStudents
	
		SELECT b.title as bookTitle ,fullname as student,bi.issuedate,bi.duedate
		FROM bookissues bi
		join books b on bi.bookid =  b.bookid
		join users u on bi.userid =  u.userid
	END 
	


    END
END
GO
