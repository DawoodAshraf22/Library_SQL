USE [Library]
GO
CREATE OR ALTER PROC [dbo].[SPLogin]
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

	IF @Action = 21 --REGISTER 1 
	BEGIN 
		INSERT INTO users (fullname,email,username,password,usertype,isactive)
		VALUES(@fullname,@email,@username,@password,@usertype,0)

		SET @Output = 'REGISTER inserted successfully';
	END 
	ELSE IF @Action = 22 --Login 2 
	BEGIN 
		SELECT *, 'https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg' as [ProfilePic]
		FROM users
		WHERE email = @email AND password = @password
	END
	ELSE IF @Action = 23 --forget pass 
	BEGIN 
		if exists (SELECT *
		FROM users
		WHERE email = @email)
		BEGIN
		SET @Output = 'Reset password';
		END
	END
	ELSE IF @Action = 24 
	BEGIN 
		UPDATE users --Reset pass 
		SET
		password = coalesce(@password,password)
		WHERE   email = @email

		SET @Output = 'users updated successfully';
	END

END 
