use WFA3DotNet

create table tblCustomer(
customerID varchar(20) not null primary key,
custname varchar(20),
dob varchar(30),
city varchar(20)

)

select *from tblCustomer

insert into tblCustomer values ('123456', 'David Letterman', '04-Apr-1949', 'Hartford');
insert into tblCustomer values ('123457', 'Barry Sanders', '12-Dec-1967','Detroit');
insert into tblCustomer values ('123458', 'Jean-Luc Picard', '9-Sep-1940', 'San Francisco');
insert into tblCustomer values ('123459', 'Jerry Seinfeld', '23-Nov-1965','New York City');
insert into tblCustomer values ('123460', 'Fox Mulder', '05-Nov-1962', 'Langley');
insert into tblCustomer values ('123461', 'Bruce Springsteen', '29-Dec-1960','Camden');
insert into tblCustomer values ('123462', 'Barry Sanders', '05-Aug-1974','Martha''s Vineyard');
insert into tblCustomer values ('123463', 'Benjamin Sisko', '23-Nov-1955','San Francisco');
insert into tblCustomer values ('123464', 'Barry Sanders', '19-Mar-1966','Langley');
insert into tblCustomer values ('123465', 'Martha Vineyard', '19-Mar-1963','Martha''s Vineyard');


create table TblAccountType (
typecode int not null primary key,
typedesc varchar(20)
)

insert into tblAccountType values (1, 'Checking');
insert into tblAccountType values (2, 'Saving');
insert into tblAccountType values (3, 'Money Market');
insert into tblAccountType values (4, 'Super Checking');

select *from TblAccountType

create table TblAccount(
customerID varchar(20) foreign key references tblCustomer(customerID),
accountnumber varchar(20) not null primary key,
accounttypecode int foreign key references TblAccountType(typecode),
dateopened date default getDate(),
balance float
)

insert into tblAccount values('123456', '123456-1', 1, '04-Apr-1993', 2200.33);
insert into tblAccount values('123456', '123456-2', 2, '04-Apr-1993', 12200.99);
insert into tblAccount values('123457', '123457-1', 3, '01-JAN-1998', 50000.00);
insert into tblAccount values('123458', '123458-1', 1, '19-FEB-1991', 9203.56);
insert into tblAccount values('123459', '123459-1', 1, '09-SEP-1990', 9999.99);
insert into tblAccount values('123459', '123459-2', 1, '12-MAR-1992', 5300.33);
insert into tblAccount values('123459', '123459-3', 2, '12-MAR-1992', 17900.42);
insert into tblAccount values('123459', '123459-4', 3, '09-SEP-1998', 500000.00);
insert into tblAccount values('123460', '123460-1', 1, '12-OCT-1997', 510.12);
insert into tblAccount values('123460', '123460-2', 2, '12-OCT-1997', 3412.33);
insert into tblAccount values('123461', '123461-1', 1, '09-MAY-1978', 1000.33);
insert into tblAccount values('123461', '123461-2', 2, '09-MAY-1978', 32890.33);
insert into tblAccount values('123461', '123461-3', 3, '13-JUN-1981', 51340.67);
insert into tblAccount values('123462', '123462-1', 1, '23-JUL-1981', 340.67);
insert into tblAccount values('123462', '123462-2', 2, '23-JUL-1981', 5340.67);
insert into tblAccount values('123463', '123463-1', 1, '1-MAY-1998', 513.90);
insert into tblAccount values('123463', '123463-2', 2, '1-MAY-1998', 1538.90);
insert into tblAccount values('123464', '123464-1', 1, '19-AUG-1994', 1533.47);
insert into tblAccount values('123464', '123464-2', 2, '19-AUG-1994', 8456.47);

select *from TblAccount


 -- 1)Print customer id and balance of customers who have at least $5000 in any of their accounts. 

 select cust.customerId, accnt.balance
 from tblCustomer cust
 join tblAccount accnt
 on cust.customerId=accnt.customerId
 where balance<=5000


 -- 2)Print names of customers whose names begin with a ‘B’. 
   
  select custname from tblCustomer where custname like 'B%'

 -- 3)Print all the cities where the customers of this bank live. 

 select city from tblCustomer


 -- 4) Use IN [and NOT IN] clauses to list customers who live in [and don’t live in] San Francisco or Hartford. 

 select custname, city
 from tblCustomer
 where city in ('San Francisco','Hartford')

 select custname, city
 from tblCustomer
 where city not in ('San Francisco','Hartford')

 -- 5) Show name and city of customers whose names contain the letter 'r' and who live in Langley. 

 select custname, city
 from tblCustomer
 where custname like 'r%' and city='Langley'

 -- 6) How many account types does the bank provide? 

 select count(typedesc) as accounttypes
 from TblAccountType

 -- 7) Show a list of accounts and their balance for account numbers that end in '-1' 

 select accountnumber, balance
 from TblAccount
 where accountnumber like '%-1'

 -- 8) Show a list of accounts and their balance for accounts opened on or after July 1, 1990. 

 select accnt.accountnumber, accnt.balance, accnt.dateopened
 from TblAccount accnt
 join TblAccountType accnttype
 on accnt.accounttypecode =accnttype.typecode
 where accnt.dateopened>= '1-july-1990'

 -- 9) If all the customers decided to withdraw their money, how much cash would the bank need? 

 select sum(balance) as totalcashneeded
 from TblAccount

 -- 10) List account number(s) and balance in accounts held by ‘David Letterman’. 

 select accnt.accountnumber, accnt.balance
 from TblAccount accnt
 join tblCustomer cust
 on accnt.customerID = cust.customerID
 where cust.custname = 'David Letterman'


 -- 11)	List the name of the customer who has the largest balance (in any account). 
 
 select custname from tblCustomer
 where customerID = (select customerID
 from TblAccount 
 where balance =(select max(balance) from TblAccount))

 -- 12)	List customers who have a ‘Money Market’ account. 

 select cust.custname
 from tblCustomer cust
 join TblAccount accnt on cust.customerID = accnt.customerID
 join TblAccountType accnttype on accnttype.typecode = accnt.accounttypecode
 where accnttype.typedesc='money market'

 -- 13)	Produce a listing that shows the city and the number of people who live in that city. 

 select cust.city, count(city) as noofpplincty
 from tblCustomer cust
 group by cust.city

 -- 14)	Produce a listing showing customer name, the type of account they hold and the balance in that account. (Make use of Joins)

 select cust.custname, accnttype.typedesc, accnt.balance
 from tblCustomer cust
 join TblAccount accnt on cust.customerID = accnt.customerID
 join TblAccountType accnttype on accnttype.typecode = accnt.accounttypecode

 -- 15)	Produce a listing that shows the customer name and the number of accounts they hold. (Make use of Joins)

 select cust.custname, count(accnt.accountnumber) as accountcustomerholds
 from tblCustomer cust
 join TblAccount accnt
 on cust.customerID = accnt.customerID
 group by cust.custname

 -- 16)	 Produce a listing that shows an account type and the average balance in accounts of that type. (Make use of Joins)

 select accnttype.typedesc, avg(accnt.balance) as AverageBal
 from TblAccount accnt
 join TblAccountType accnttype
 on accnt.accounttypecode = accnttype.typecode
 group by accnttype.typedesc




