select * from [Person].[Person] AS PP

SELECT* FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'firstname'

SELECT
PP.BusinessEntityID,
PP.FirstName,
PP.LastName,
PP.MiddleName,
PP.NameStyle,
PP.Suffix,
PP.Title,
PP.AdditionalContactInfo,
PP.PersonType,
EA.EmailAddress,
PT.PhoneNumberTypeID,
PN.PhoneNumber
FROM [Person].[Person] AS PP 
LEFT JOIN  [Person].[EmailAddress] AS EA ON EMAILADDRESS = EMAILADDRESS
LEFT JOIN [Person].[PhoneNumberType] AS PT ON PhoneNumberTypeID = PhoneNumberTypeID
LEFT JOIN [Person].[PersonPhone] AS PN ON PhoneNumber = PhoneNumber

select * from sales.SalesOrderDetail join sales.SalesOrderHeader
on sales.SalesOrderDetail.SalesOrderID=sales.SalesOrderHeader.SalesOrderID
where month(orderdate)=5 and year(orderdate)=2011

SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2011-05-01' AND OrderDate < '2011-06-01';


SELECT SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011 AND MONTH(OrderDate) = 5;

SELECT
    YEAR(OrderDate) AS SalesYear,
    MONTH(OrderDate) AS SalesMonth,
    SUM(TotalDue) AS TotalSales
FROM
    Sales.SalesOrderHeader
WHERE
    YEAR(OrderDate) = 2011
GROUP BY
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY
    TotalSales ASC;


select 
firstname,lastname,
sum(linetotal) as totalsales 
from person.Person P
inner join sales.Customer C on p.BusinessEntityID=c.PersonID
inner join sales.SalesOrderHeader SH on sh.CustomerID=c.CustomerID
inner join sales.SalesOrderDetail SD on sd.SalesOrderID=sh.SalesOrderID
where p.FirstName='Gustavo' and p.LastName='Achong'
group by p.BusinessEntityID,p.FirstName,p.LastName;











