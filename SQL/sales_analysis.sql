use mywork;

select *
from transactions;

select count(TransactionID) 
from transactions;

-- Hitung jumlah kolom TransactionID yang null
select count(*) as missingTransactionID
from transactions
Where TransactionID is null;

-- Cek null di semua kolom
select 
sum(case when TransactionID is null then 1 else 0 end) as Missing_TransactionID,
sum(case when CustomerID is null then 1 else 0 end) as Missing_CustomerID,
sum(case when TransactionDate is null then 1 else 0 end) as Missing_TransactionDate,
sum(case when TransactionValue is null then 1 else 0 end) as Missing_TransactionValue,
sum(case when ProductCategory is null then 1 else 0 end) as Missing_ProductCategory,
sum(case when PaymentMethod is null then 1 else 0 end) as Missing_PaymentMethod,
sum(case when CustomerGender is null then 1 else 0 end) as Missing_CustomerGender,
sum(case when CustomerAgeGroup is null then 1 else 0 end) as Missing_CustomerAgeGroup,
sum(case when Region is null then 1 else 0 end) as Missing_Region
from transactions;

-- Menampilkan baris TransactionID yang lebih dari 1
select TransactionID, count(*) as DuplicateCount
from transactions
group by TransactionID
having count(*)>1;

-- Menampilkan data yang identik di semua kolom
select *
from transactions
group by TransactionID, CustomerID, TransactionDate, TransactionValue, ProductCategory, PaymentMethod,
		CustomerGender, CustomerAgeGroup, Region
having count(*)>1;

-- Mengubah Tipe kolom TransactionDate ke Tipe Date
alter table transactions
modify column TransactionDate date;

-- Total jumlah transaksi per kategori
select ProductCategory,
	count(TransactionID) as TotalTransaksi,
    sum(TransactionValue) as TotalNilaiTransaksi
from transactions
group by ProductCategory
order by TotalNilaiTransaksi desc;
    
-- Metode pembayaran paling populer
select PaymentMethod,
	count(PaymentMethod) as TotalTransaksi,
    round(avg(TransactionValue), 2) as RataRataTransaksi 
from transactions
group by PaymentMethod
order by TotalTransaksi desc;

-- Segmentasi usia dan gender
select CustomerAgeGroup, CustomerGender,
	count(TransactionID) as TotalTransaksi
from transactions
group by CustomerAgeGroup, CustomerGender
order by TotalTransaksi desc;

-- Performa wilayah
select Region,
	sum(TransactionValue) as TotalNilaiTransaksi,
    round(avg(TransactionValue), 2) as RataRataTransaksi
from transactions
group by Region
order by TotalNilaiTransaksi desc
limit 5;

-- Pendapatan penjualan bulanan
select
	extract(year from TransactionDate) as Year,
    extract(month from TransactionDate) as Month,
	sum(TransactionValue) as MonthlySales,
    count(ProductCategory) as MonthlyProductSales
from transactions
group by Year, Month
order by Year, Month;

set sql_safe_updates=1;

select  *
from transactions;