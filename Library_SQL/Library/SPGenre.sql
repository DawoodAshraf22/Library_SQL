USE [Library]
GO
CREATE OR ALTER PROC [dbo].[SPGenre]
    @Action         INT             = NULL, 
    @ID             INT             = NULL,
    @GenreName      VARCHAR(50)     = NULL,
    @Description    VARCHAR(100)    = NULL,
    @Output         VARCHAR(100)    = NULL OUTPUT
AS
BEGIN
    -- Get All Records
    IF @Action = 0
    BEGIN
        SELECT * FROM genre;
    END
    -- Get Record By ID
    ELSE IF @Action = 1
    BEGIN
        SELECT * FROM genre WHERE genreid = @ID;
    END
    -- Insert Record
    ELSE IF @Action = 2
    BEGIN
        INSERT INTO genre (genrename, description)
        VALUES (@GenreName, @Description);

        SET @Output = 'Genre inserted successfully';
    END
    -- Update Record
    ELSE IF @Action = 3
    BEGIN
        UPDATE genre
        SET 
            genrename   = COALESCE(@GenreName, genrename),
            description = COALESCE(@Description, description)
        WHERE genreid = @ID;

        SET @Output = 'Genre updated successfully';
    END
    -- Soft Delete (Deactivate)
    ELSE IF @Action = 4
    BEGIN
        DELETE FROM genre WHERE genreid = @ID;
        SET @Output = 'Genre deleted successfully';
    END
END
GO
