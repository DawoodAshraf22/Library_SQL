USE [Library]
GO
CREATE OR ALTER PROC [dbo].[SPUser]
@Action			int					=	NULL, 
@ID				int					=	NULL, 
@ParentID		int					=	NULL,
@userid			int					=	NULL,
@Search			VARCHAR(100)		=	NULL,
@fullname		VARCHAR(100)		=	NULL, 
@email			VARCHAR(100)		=	NULL, 
@username		VARCHAR(100)		=	NULL, 
@password		VARCHAR(100)		=	NULL, 
@usertype		VARCHAR(100)		=	NULL, 
@isactive		BIT					=	1,
@Output         VARCHAR(100)		=	NULL OUTPUT 
AS 
BEGIN 

	IF @Action = 0 
	BEGIN 
		SELECT * FROM users 
	END 
	ELSE IF @Action = 1 
	BEGIN 
		SELECT * FROM users Where Userid = @ID
	END 
	ELSE IF @Action = 2 
	BEGIN 
		INSERT INTO users (fullname,email,username,password,usertype,isactive)
		VALUES(@fullname,@email,@username,@password,@usertype,0)

		SET @Output = 'users inserted successfully';
	END 
	ELSE IF @Action = 3 
	BEGIN 
		UPDATE users
		SET
		fullname = coalesce(@fullname,fullname),
		email = coalesce(@email,email),
		username = coalesce(@username,username),
		password = coalesce(@password,password),
		isactive = coalesce(@isactive,isactive)
		WHERE Userid = @ID

		SET @Output = 'users updated successfully';
	END 
	ELSE IF @Action = 4
	BEGIN 
		UPDATE users
		SET
		isactive = 0
		WHERE Userid = @ID

		SET @Output = 'users deleted successfully';
	END 

END 
