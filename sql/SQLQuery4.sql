USE EShop

--Comment--
--Get All Products--

SELECT * FROM Product

--Get all product that have category id =10--
SELECT * FROM Product
where CategoryId = 10

--Get Total Cost From Listed with categoryid = 10--
Select Sum(Cost) from Product
where CategoryId= 10


--Get product name, cost from product table--
Select Name, Cost From Product


--Save above as View--
CREATE VIEW vw_Product As
(Select Name, Cost From Product)

--See the View Result--
Select * From vw_Product

--Get all products that start with k--
Select * from Product
where Name Like 'K%'

--Get all products has second character as e--
Select * from Product
Where Name Like '_e%'

--Get all products whose cost i snot equal to 5000
Select * from Product
where Cost <> 5000

Select * From Product 
where Cost < 1000

--'%s' => The word starts (^) with any character and contains 's' at the end ($)--
Select * From Product
Where Name Like '%K%i'

Select * From Product
Where Name Like '%i'

--Selecet all Products with names as T-shirt, Iphone, kurti--

Select * From Product
Where Name = 'T-Shirt' OR Name = ' IPhone 14' OR Name = 'Kurti'

--Better Technique Using In operator--
select *from Product
Where Name in ('T-Shirt','Kurti','Iron Box')

--Get all products having a category id matching a category in Productcategory table--
select * From Product
where CategoryId IN (Select Id from ProductCategory)


--Get the customer name and order id for all customer--
Select [CName], [OrderId] from Customer, [dbo].[Order]
Where CustomerId = [dbo].[Order].CustomerId




--get total revenue generated by 'Liktha M S'
--Customer Name from customer table
--Total Cost from product
--Orders table contains customer purchases

Select SUM(Cost)
From [dbo].[Order], Customer, Product
Where [dbo].[Order].CustomerId = Customer.CID
And [dbo].[Order] .ProductId = Product.PID
And Customer.CName = 'Likitha M S'


--Get all Customer details--
select * From Customer


--Get all customers orders. customerID,ordrID

select [OrderId],[CID] From [dbo].[Customer],[dbo].[Order]
Where  [dbo].[Order].CustomerId = Customer.CID


--Get total revenue generated by customer 