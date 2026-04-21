create database Digital_Library;
use Digital_Library;
create table Books(
BookId int primary key,
Book_Title varchar(100) not null,
Author varchar(100),
Category varchar(50) not null
);

create table Students(
StudentId int primary key,
Student_Name varchar(100) not null,
Gender varchar(15),
Department varchar(50),
JoinDate date
);

create table IssuedBooks(
IssueId int primary key,
BookId int,
StudentId int,
IssueDate date,
ReturnDate date,
foreign key (BookId) references Books(BookId),
foreign key (StudentId) references Students(StudentId)
);  

insert into Books values
(1, 'Python Programming', 'John Smith', 'Technology'),
(2, 'World History', 'A Sharma', 'History'),
(3, 'Data Structures', 'Ravi Kumar', 'Technology'),
(4, 'Fictional Stories', 'Chetan', 'Fiction'),
(5, 'AI Basics', 'Andrew Nig', 'Science'),
(6, 'Ancient Civilizations', 'Romila Thapar', 'History'),
(7, 'C Programming', 'Dennis Ritche', 'Technology'),
(8, 'Modern Fiction', 'Arundhati', 'Fiction'),
(9, 'Indian Economy', 'Rajesh', 'Economy'),
(10, 'Operating Systems ', 'Laurel', 'Science'),
(11, 'Machine learning' , 'Ton Mitchell','Technology');

insert into Students values
(101, 'Heshwanthini','Female', 'CSE', '2022-06-10'),
(102, 'Swetha','Female', 'CSE', '2021-08-15'),
(103, 'Chandhu','Male', 'IT', '2020-03-20'),
(104, 'Kiran','Male', 'ECE', '2019-02-14'),
(105, 'Jyothirmai','Female', 'CSE', '2023-02-05'),
(106, 'Neha','Female', 'EEE', '2022-08-11'),
(107, 'Karthik','Male', 'EEE', '2021-09-18'),
(108, 'Varsha','Female', 'IT', '2020-11-25'),
(109, 'Akshitha','Female', 'ECE', '2023-01-10'),
(110, 'Arjun','Male', 'IT', '2018-05-22'),
(111, 'Sravani','Female', 'CSE', '2022-12-01'),
(112, 'Revanth','Male', 'ECE', '2021-04-17');

insert into IssuedBooks values
(1, 1, 101, '2026-04-01', NULL),
(2, 2, 102, '2026-06-24', NULL),
(3, 3, 103, '2026-03-17', NULL),
(4, 4, 105, '2026-04-01', '2026-04-01'),
(5, 5, 106, '2026-04-02', '2026-04-02'),
(6, 6, 107, '2026-03-01', '2026-03-25'),
(7, 7, 108, '2026-03-03', '2026-03-20'),
(8, 8, 109, '2026-03-02', NULL),
(9, 9, 112, '2026-02-04', NULL),
(10, 10, 112, '2026-04-10',NULL),
(11, 2, 104, '2021-01-10', '2021-01-21'),
(12, 3, 110, '2020-07-16', '2020-07-23'),
(13, 1 , 106, '2026-04-05', '2026-04-15'),
(14, 11, 107, '2026-05-12', NULL);

select * from Students;
select * from Books;
select * from IssuedBooks;

-- Overdue books
select s.Student_Name , s.Department, b.Book_Title, b.Category,  ib.IssueDate
from IssuedBooks ib
join Students s on ib.StudentId = s.StudentId
join books b on ib.BookId = b.BookId
where ib.ReturnDate is null
and datediff(curdate(),ib.IssueDate) > 14;

-- Popularity Index
select b.Category, count(*) as Total_Borrows
from IssuedBooks ib
join Books b on ib.BookId = b.BookId
group by b.Category
order by Total_Borrows desc;
SET SQL_SAFE_UPDATES = 0;
-- Inactive accounts
alter table Students add Status varchar(20);
update Students
set Status = 'Inactive'
where StudentId not in (
    select distinct StudentId
    from IssuedBooks
    where IssueDate >= date_sub(curdate(), interval 3 year)
);

select * from Students;

update Students
set Status='Active'
where Status is null;

select * from Students;