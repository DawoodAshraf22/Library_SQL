USE [Library]
GO

CREATE OR ALTER PROC [dbo].[SPFines]
    @Action         int                 = NULL, 
    @ID             int                 = NULL, 
    @ParentID       int                 = NULL,
    @userid         int                 = NULL, 
    @Search         VARCHAR(100)        = NULL, 
    @fineid         int                 = NULL,
    @bookissuesid   int                 = NULL,
    @amount         DECIMAL(10,2)       = NULL,
    @paidamount     DECIMAL(10,2)       = NULL,
    @status         VARCHAR(20)         = NULL,
    @createdat      DateTime            = NULL,
    @paidat         DateTime            = NULL,
    @Output         VARCHAR(100)        = NULL OUTPUT 
AS 
BEGIN 
    IF @Action = 0  -- SELECT ALL
    BEGIN 
        SELECT * FROM fines 
    END 
    ELSE IF @Action = 1  -- SELECT BY ID
    BEGIN 
        SELECT * FROM fines WHERE fineid = @ID
    END 
    ELSE IF @Action = 2  -- INSERT
    BEGIN 
        INSERT INTO fines (bookissuesid, amount, paidamount, status, paidat)
        VALUES(@bookissuesid, @amount, @paidamount, @status, @paidat)
        
        SET @Output = 'Fine record added successfully'
    END 
    ELSE IF @Action = 3  -- UPDATE
    BEGIN 
        UPDATE fines
        SET
            bookissuesid = COALESCE(@bookissuesid, bookissuesid),
            amount = COALESCE(@amount, amount),
            paidamount = COALESCE(@paidamount, paidamount),
            status = COALESCE(@status, status),
            paidat = COALESCE(@paidat, paidat)
        WHERE fineid = @ID
        
        SET @Output = 'Fine record updated successfully'
    END 
    ELSE IF @Action = 4  -- DELETE
    BEGIN 
        DELETE FROM fines WHERE fineid = @ID
        SET @Output = 'Fine record deleted successfully'
    END
    ELSE IF @Action = 5  -- SEARCH (by status)
    BEGIN 
        IF @Search IS NOT NULL
        BEGIN
            SELECT * FROM fines 
            WHERE status LIKE '%' + @Search + '%'
        END
    END
    ELSE IF @Action = 6  -- SELECT BY PARENTID (BookIssuesID)
    BEGIN 
        SELECT * FROM fines WHERE bookissuesid = @ParentID
    END
    ELSE IF @Action = 7  -- SELECT BY USERID (via bookissues table)
    BEGIN 
        SELECT f.* 
        FROM fines f
        INNER JOIN bookissues bi ON f.bookissuesid = bi.bookissuesid
        WHERE bi.userid = @userid
    END
    ELSE IF @Action = 8  -- GET UNPAID FINES
    BEGIN 
        SELECT * FROM fines WHERE status != 'Paid' OR paidamount < amount
    END
    ELSE IF @Action = 9  -- GET OVERDUE FINES (unpaid and past due)
    BEGIN 
        SELECT f.* 
        FROM fines f
        INNER JOIN bookissues bi ON f.bookissuesid = bi.bookissuesid
        WHERE f.status != 'Paid' AND f.paidamount < f.amount
        AND bi.returndate IS NULL AND bi.duedate < GETDATE()
    END
    ELSE IF @Action = 10  -- PAY FINE (partial or full payment)
    BEGIN 
        DECLARE @CurrentPaid DECIMAL(10,2)
        DECLARE @TotalAmount DECIMAL(10,2)
        DECLARE @NewPaidAmount DECIMAL(10,2)
        
        SELECT @CurrentPaid = paidamount, @TotalAmount = amount 
        FROM fines WHERE fineid = @ID
        
        SET @NewPaidAmount = @CurrentPaid + @paidamount
        
        UPDATE fines
        SET
            paidamount = @NewPaidAmount,
            status = CASE 
                        WHEN @NewPaidAmount >= @TotalAmount THEN 'Paid' 
                        WHEN @NewPaidAmount > 0 THEN 'Partially Paid' 
                        ELSE status 
                     END,
            paidat = CASE 
                        WHEN @paidamount > 0 THEN GETDATE() 
                        ELSE paidat 
                     END
        WHERE fineid = @ID
        
        SET @Output = 'Fine payment processed successfully'
    END
    ELSE IF @Action = 11  -- GET FINES SUMMARY BY USER
    BEGIN 
        SELECT 
            bi.userid,
            u.fullname,
            COUNT(f.fineid) as total_fines,
            SUM(f.amount) as total_amount,
            SUM(f.paidamount) as total_paid,
            SUM(f.amount - f.paidamount) as total_balance
        FROM fines f
        INNER JOIN bookissues bi ON f.bookissuesid = bi.bookissuesid
        INNER JOIN users u ON bi.userid = u.userid
        WHERE bi.userid = @userid
        GROUP BY bi.userid, u.fullname
    END
END 
GO