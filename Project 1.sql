CREATE TABLE Book1 (
    Book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    genre VARCHAR(50),
    published_year INT,
    price NUMERIC(10, 2),
    stock INT
);

CREATE TABLE Customer1 (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    City VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Order1 (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customer1 (Customer_ID),
    Book_ID INT REFERENCES Book1(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


select * from Book1;
select * from Customer1;
select * from Order1;


COPY 
Customer1(Customer_ID, Name, Email, Phone, City, Country)
FROM '‪C:/Users/HP/Downloads/Customer1.csv'
DELIMITER','
CSV HEADER;


COPY 
Book1(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM '‪C:\Users\HP\Downloads\Book1.csv1'
DELIMITER','
CSV HEADER;

COPY 
Order1(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM '‪‪C:\Users\HP\Downloads\Order1.csv'
DELIMITER','
CSV HEADER;


--1) Retrive all books in the "Fiction" genre:

	select * from Book1
	Where genre='Fiction';

--2) find books issued after year 1950:
    select * from Book1
	where published_year > 1950;

--3) List all customers from Canada

    select * from Customer1 
	where Country = 'Canada';

--4) Show orders placed in November 2023

	select * from Order1 
	where order_date between '2023-11-01' and '2023-11-30';

--5) Retrieve the total stock of books available

	select sum(stock) AS Total_Stock 
	from Book1;
--6) Find the details of the most expensive book

	select * from Book1 
	order by Price DESC 
	limit 1;

--7) Show all customers who ordered more than 1 quantity of a book

	select * from order1   
	where Quantity > 1;	

--8) Retrieve all orders where the total amount exceeds $20
    
	select * from order1
	where total_amount > 20;

--9) List all genres available in the Books table
	select distinct genre
	from book1;

--10) Find the book with the lowest stock
	select * from book1
	order by stock
	limit 1;

--11) Calculate the total revenue generated from all orders 
	select sum(total_amount) AS Total_Revenue
	from order1;
	
--Advance Questions

--1) Retrieve the total number of books sold for each genre
    select b.Genre, sum(o.Quantity) AS Total_Books_Sold
    from Book1 b
    join Order1 o ON b.Book_ID = o.Book_ID
    GROUP BY b.Genre;

--2) Find the average price of books in the "Fantasy" genre
	select AVG(Price) AS Average_Price
	from Book1
	where Genre = 'Fantasy';

--3) List customers who have placed at least 2 orders
	select c.Customer_ID, c.Name, count(o.Order_ID) AS Order_Count
	from Customer1 c
	join Order1 o ON c.Customer_ID = o.Customer_ID
	group by c.Customer_ID, c.Name
	having count(o.Order_ID) >= 2;

--4) Find the most frequently ordered book
	select b.Book_ID, b.Title, sum(o.Quantity) AS Total_Order
	from Book1 b
	join Order1 o ON b.Book_ID = o.Book_ID
	group by b.Book_ID, b.Title
	order by Total_Order DESC
	LIMIT 1;

--5)Show the top 3 most expensive books of 'Fantasy' Genre
	select Book_ID, Title, Price
	from Book1
	where Genre = 'Fantasy'
	order by Price DESC
	limit 3;

--6) Retrieve the total quantity of books sold by each author
	select b.author, sum(o.quantity) as Total_Quantity_Sold
	from book1 b
	join order1 o on b.book_id=o.book_id
	group by author;

--7) List the cities where customers who spent over $30 are located
	select distinct city c, total_amount
	from customer1 c
	join order1 o on c.customer_id=o.customer_id
	where total_amount > 30;

--8) Find the customer who spent the most on orders
	select c.customer_id,c.name,sum(o.total_amount) AS Total_spent
	from customer1 c
	join order1 o on c.customer_id=o.customer_id
	group by c.customer_id ,c.name
	order by Total_spent DESC
	limit 1;

--9) Calculate the stock remaining after fulfilling all orders
    select b.book_id, b.title, b.stock, COAlESCE(Sum(o.quantity),0) AS Order_quantity, 
	b.stock - COAlESCE(Sum(o.quantity),0) AS Remaining_Stock
	from book1 b
	left join order1 o on o.book_id=b.book_id
	group by b.book_id
	order by b.book_id;
	
	
	