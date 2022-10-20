
CREATE TRIGGER tr_onInsert
   ON  [dbo].[Product]
   AFTER insert
AS 
BEGIN
	
	Declare @Id BigInt
	Set @Id = (select PID from inserted)
	Print @Id

	insert into [Audit]
		values ('Insertion event occured', @Id)

END
GO

----======================Inserting manually to product table
