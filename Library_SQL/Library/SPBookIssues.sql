USE [Library]
GO

CREATE OR ALTER PROC [dbo].[SPBookIssues]
    @Action         int                 = NULL, 
    @ID             int                 = NULL, 
    @ParentID       int                 = NULL,
    @userid         int                 = NULL, 
    @Search         VARCHAR(100)        = NULL, 
    @bookissuesid   int                 = NULL,
    @bookid         int                 = NULL,
    @userid_issue   int                 = NULL,  -- Renamed to avoid parameter conflict
    @issuedate      DATE                = NULL,
    @duedate        DATE                = NULL,
    @returndate     DATE                = NULL,
    @fineamount     DECIMAL(10,2)       = NULL,
    @status         VARCHAR(50)         = NULL,
    @createdat      DateTime            = NULL,
    @Output         VARCHAR(100)        = NULL OUTPUT 
AS 
BEGIN 
    IF @Action = 0  -- SELECT ALL
    BEGIN 
        SELECT * FROM bookissues 
    END 
    ELSE IF @Action = 1  -- SELECT BY ID
    BEGIN 
        SELECT * FROM bookissues WHERE bookissuesid = @ID
    END 
    ELSE IF @Action = 2  -- INSERT
    BEGIN 
        INSERT INTO bookissues (bookid, userid, issuedate, duedate, returndate, fineamount, status)
        VALUES(@bookid, @userid_issue, ISNULL(@issuedate,GETUTCDATE()), @duedate, @returndate, @fineamount, @status)
        
        SET @Output = 'Book issue record added successfully'
    END 
    ELSE IF @Action = 3  -- UPDATE
    BEGIN 
        UPDATE bookissues
        SET
            bookid = COALESCE(@bookid, bookid),
            userid = COALESCE(@userid_issue, userid),
            issuedate = COALESCE(@issuedate, issuedate),
            duedate = COALESCE(@duedate, duedate),
            returndate = COALESCE(@returndate, returndate),
            fineamount = COALESCE(@fineamount, fineamount),
            status = COALESCE(@status, status)
        WHERE bookissuesid = @ID
        
        SET @Output = 'Book issue record updated successfully'
    END 
    ELSE IF @Action = 4  -- DELETE
    BEGIN 
        DELETE FROM bookissues WHERE bookissuesid = @ID
        SET @Output = 'Book issue record deleted successfully'
    END
END 
GO