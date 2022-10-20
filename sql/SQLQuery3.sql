/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [Total Products]
      ,[Name]
  FROM [EShop].[dbo].[vw_GetProductCountByCategory]
  WHERE [Name] = 'Lights' 
  
  --querying view--


 Create Procedure sp_GetProductCountByCategory
 As
 Begin
 select count(*) as [Total Products], ProductCategory.[Name] From Product, ProductCategory
 Where Product.CategoryId = [dbo].[ProductCategory].Id
 group by ProductCategory.[Name]
 Having ProductCategory.[Name] Like '%i%'
 And Count(*)<4
 Order by count(*), ProductCategory.[Name] desc
 End

 --Execute Stored Procedure
 Exec [dbo].[sp_GetProductCountByCategory]


 --FUNCTION :Get the most expensive product--

 Create Function fn_GetMaxProduct()
 Returns BigInt
 As
 Begin
 Declare @result BigInt
 select @result = Max(Cost) from Product
 return @result
 End

 Create Function fn_GetMinProduct()
 Returns BigInt
 As
 Begin
 Declare @res BigInt
 Select @res = Min(Cost) from Product
 return @res
 End

 ----======Executing Functions=====------
 Select [dbo].[fn_GetMaxProduct]() as [Most Expensive],
[dbo].[fn_GetMinProduct]() as [Least Expensive]



---=======Exeuting functions with normal table columns

select [dbo].[fn_GetMaxProduct]() as [Most Expensive],
		[Name]
		From Product
		Where [Cost] =   [dbo].[fn_GetMaxProduct]()

----=======function that returns a table
Create Function fn_SampleData()
Returns Table
As
Return
(
	select Product.[Name] as [ProductName], ProductCategory.[Name] as [CategoryName]
	from Product, ProductCategory
	where Product.CategoryId = ProductCategory.Id
)

----======Executing a function that returns a table
Select * From [dbo].[fn_SampleData]()



---====Select from 2 tables - No where condition
select * from [dbo].[Order], Customer                    --cross join cmobination or product of 2 tables
where [dbo].[Order].CustomerId IN Customer.CID


---=========Working with pre-defined keyworrds
-----=========Inner Join only common Records
Select * From Customer Inner join [dbo].[Order]
					ON [dbo].[Order].CustomerId = Customer.CID
					Where Customer.CName Like '%a%'


------==Left Outer Join : all records of left and only matching records of right
Select * from Customer Left Outer Join [dbo].[Order]
						ON Customer.CID = [dbo].[Order].CustomerId

---====Right Outer join ;All records of right and only matching records of left
Select * From Customer Right Outer Join [dbo].[Order]
						ON Customer.CID = [dbo].[Order].CustomerId

---======full Outer Jion :All records of left + Matching records of right &&
-------------------------All records of right + Matching Rcords of left
-------------------------Wheneever match is not found Null is Subsituted

Select * from Product Full Outer Join Customer
					ON Product.PID = Customer.CID

---====Cross Join: random Permutation combination ( product of records of both table)
Select * from Product Cross Join Customer


---====Inserting manually to protect table

GO

INSERT INTO [dbo].[Product]
           ([Name]
           ,[Cost]
           ,[CategoryId])
     VALUES
         ('Dummy', 500, 11)
		 INSERT INTO [dbo].[Product]
           ([Name]
           ,[Cost]
           ,[CategoryId])
     VALUES
         ('Summy', 400, 11)
GO

Select * from Audit


Use EShop
Go

Alter Procedure sp_InsertNewCustomer(@Name NVarchar(50), @Email NVARCHAR(50))
As
Begin

--Add Customer then automatically add a dummy order


Begin Transaction T1

INSERT INTO [dbo].[Customer]
           ([CName]
           ,[Email])
     VALUES
          (@Name, @Email)

IF @@ERROR <> 0
	Rollback Transaction T1

Declare @Cid Int
Set @Cid = @@Identity        --builtin variable automatically stores the auto -geenarted pKey

INSERT INTO [dbo].[Order]
           ([Status]
           ,[OrderDate]
           ,[ProductId]
           ,[CustomerId])
     VALUES
	 ('In-Progress', GetDate(), 1008, @Cid)

IF @@ERROR <> 0
	Rollback Transaction T1 --Undo the insertion 
Commit Transaction T1      
End
 
----====Execute stored procdures
select top 1 * from Customer Order by  CID desc
select top 1 * from [dbo].[Order] Order by [OrderId] desc
