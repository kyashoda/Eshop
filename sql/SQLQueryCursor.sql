Use Eshop
Select * from Product where [Name] ='Summy'
Update[dbo].[Product]
		Set [Name] = 'Jommer',
		[Cost] = '1500',
		[CategoryId] = 11
where Product.[Name] = 'Summy'

delete [dbo].[Order] where ProductId In (select Pid from Product
										  where Product.CategoryId=11)

delete Product where CategoryId = 11
delete ProductCategory
		where [Name] = 'Lights'


-----========Implementing cursors=======--------

Declare @ProductCount INT
Declare @Category nvarchar(10)

Declare  Cur_trendingCategories Cursor For
select Count(Product.[Name]) as [ProductCount],ProductCategory.[Name]
From Product Right outer join  ProductCategory 
on Product.CategoryId = ProductCategory.Id
Group by ProductCategory.[Name]

open Cur_trendingCategories
Fetch Next from Cur_trendingCategories
Into  @ProductCount , @Category
--Logic
While @@FETCH_STATUS = 0
Begin
    If @ProductCount > 3
	Print @Category + 'is trending'
	Else if @ProductCount>0 and @ProductCount <=3
	Print @Category + 'Has Normal Purchases'
	else 
	Print @Category + 'Has No new Products'
Fetch Next from Cur_trendingCategories Into  @ProductCount , @Category
End

-----End row by row processing------
Close Cur_trendingCategories
Deallocate Cur_trendingCategories