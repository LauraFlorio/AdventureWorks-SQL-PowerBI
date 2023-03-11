-- TAB GENERALVIEW:

-- KPIS:

-- i)		Total Internet Sales Amount
-- ii)		Total Internet Sales
-- iii)		Product Categories
-- iv)		Total of Customers
-- v)		Total Internet Sales Amount and Profit per month
-- vi)		Total Internet Sales by Gender
-- vii)		Profit Margin
-- viii)	Total Sales per Month
-- ix)		Profit per Country

-- Tables:
select top(5) * from FactInternetSales -- TABLE 1
select top(5) * from DimProductCategory -- TABLE 2
select top(5) * from DimGeography -- TABLE 3
select top(5) * from DimCustomer -- TABLE 4

-- TAB CLIENTS:

-- KPIS:

-- i)		Sales per Country
-- ii)		Customers per Country
-- iii)		Sales per Gender
-- iv)		Sales per Category

select top(5) * from FactInternetSales -- TABLE 1
select top(5) * from DimGeography -- TABLE 3
select top(5) * from DimCustomer -- TABLE 4

-- Columns:

-- SalesOrderNumber                         (TABLE 1: FactInternetSales)
-- OrderDate                                (TABLE 1: FactInternetSales)
-- EnglishProductCategoryName               (TABLE 2: DimProductCategory)
-- CustomerKey							    (TABLE 1: FactInternetSales)
-- First Name + Last Name                   (TABLE 4: DimCustomer)
-- Gender                                   (TABLE 4: DimCustomer)
-- EnglishCountryRegionName                 (TABLE 3: DimGeography)
-- OrderQuantity                            (TABLE 1: FactInternetSales)
-- TotalProductCost                         (TABLE 1: FactInternetSales)
-- SalesAmount                              (TABLE 1: FactInternetSales)
-- SalesAmount - TotalProductCost (Profit)	(TABLE 1: FactInternetSales)

-- Creating view RESULTS_ADW
GO
CREATE OR ALTER VIEW RESULTS_ADW as
select 
	fis.SalesOrderNumber,
	fis.OrderDate,
	dpc.EnglishProductCategoryName as ProductCategory,
	fis.CustomerKey,
	dc.FirstName + ' ' + dc.LastName as CustomerName,
	replace(replace(dc.Gender, 'M', 'Male'), 'F', 'Female') as CustomerGender,
	dg.EnglishCountryRegionName as Country,
	fis.OrderQuantity as SalesQuantity,
	fis.SalesAmount,
	fis.TotalProductCost,
	fis.SalesAmount - fis.TotalProductCost as Profit
from
	FactInternetSales fis
	left join DimProduct dp on fis.ProductKey = dp.ProductKey
		left join DimProductSubcategory dps on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
			left join DimProductCategory dpc on dps.ProductCategoryKey = dpc.ProductCategoryKey
	left join DimCustomer dc on fis.CustomerKey = dc.CustomerKey
		left join DimGeography dg on dc.GeographyKey = dg.GeographyKey
GO

select * from RESULTS_ADW
