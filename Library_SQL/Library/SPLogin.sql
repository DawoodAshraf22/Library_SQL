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

	IF @Action = 0 
	BEGIN 
		SELECT * FROM users 
	END 

END 
