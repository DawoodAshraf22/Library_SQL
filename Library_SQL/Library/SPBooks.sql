USE [Library]
GO
CREATE OR ALTER PROC [dbo].[SPBooks]
    @Action         int                 = NULL, 
    @ID             int                 = NULL, 
    @ParentID       int                 = NULL,
    @userid         int                 = NULL, 
    @Search         VARCHAR(100)        = NULL, 
    @bookid         int                 = NULL,
    @genreid        int                 = NULL,
    @title          VARCHAR(255)        = NULL,
    @author         VARCHAR(100)        = NULL,
    @genre          VARCHAR(50)         = NULL,
    @publicationyear INT                = NULL,
    @isbn           VARCHAR(20)         = NULL,
    @totalcopies    INT                 = NULL,
    @availablecopies INT               = NULL,
    @createdat      DateTime            = NULL,
    @updatedat      DateTime            = NULL,
    @Output         VARCHAR(100)        = NULL OUTPUT 
AS 
BEGIN 
    IF @Action = 0  -- SELECT ALL
    BEGIN 
        SELECT * FROM books 
    END 
    ELSE IF @Action = 1  -- SELECT BY ID
    BEGIN 
        SELECT * FROM books WHERE bookid = @ID
    END 
    ELSE IF @Action = 2  -- INSERT
    BEGIN 
        INSERT INTO books (genreid, title, author, genre, publicationyear, isbn, totalcopies, availablecopies)
        VALUES(@genreid, @title, @author, @genre, @publicationyear, @isbn, @totalcopies, @availablecopies)
        
        SET @Output = 'Book added successfully'
    END 
    ELSE IF @Action = 3  -- UPDATE
    BEGIN 
        UPDATE books
        SET
            genreid = COALESCE(@genreid, genreid),
            title = COALESCE(@title, title),
            author = COALESCE(@author, author),
            genre = COALESCE(@genre, genre),
            publicationyear = COALESCE(@publicationyear, publicationyear),
            isbn = COALESCE(@isbn, isbn),
            totalcopies = COALESCE(@totalcopies, totalcopies),
            availablecopies = COALESCE(@availablecopies, availablecopies),
            updatedat = GETUTCDATE()
        WHERE bookid = @ID
        
        SET @Output = 'Book updated successfully'
    END 
    ELSE IF @Action = 4  -- DELETE/SOFT DELETE
    BEGIN 
        DELETE FROM books WHERE bookid = @ID
        SET @Output = 'Book deleted successfully'
    END
END 
GO