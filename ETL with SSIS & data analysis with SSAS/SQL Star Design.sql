USE [NorthwindDW2]
GO

CREATE TABLE [dbo].[Continent](
	[ContinentKey] [int] IDENTITY(1,1) PRIMARY KEY,
	[ContinentName] [nvarchar](20) NOT NULL
	)
GO

CREATE TABLE [dbo].[Country](
	[CountryKey] [int] IDENTITY(1,1) PRIMARY KEY,
	[CountryName] [nvarchar](40) NOT NULL,
	[CountryCode] [nvarchar](3) NOT NULL,
	[CountryCapital] [nvarchar](40) NOT NULL,
	[Population] [int] NULL,
	[Subdivision] [ntext] NULL,
	[ContinentKey] [int] REFERENCES [dbo].[Continent] ([ContinentKey])
	)
GO

CREATE TABLE [dbo].[State](
	[StateKey] [int] IDENTITY(1,1) PRIMARY KEY,
	[StateName] [nvarchar](40) NOT NULL,
	[EnglishStateName] [nvarchar](40) NULL,
	[StateType] [nvarchar](40) NOT NULL,
	[StateCode] [nvarchar](3) NULL,
	[StateCapital] [nvarchar](40) NULL,
	[RegionName] [nvarchar](40) NULL,
	[RegionCode] [nvarchar](3) NULL,
	[CountryKey] [int] REFERENCES [dbo].[Country] ([CountryKey])
	)
GO


CREATE TABLE [dbo].[City](
	[CityKey] [int] IDENTITY(1,1) PRIMARY KEY,
	[CityName] [nvarchar](40) NOT NULL,
	[StateKey] [int] REFERENCES [dbo].[State] ([StateKey]),
	[CountryKey] [int] REFERENCES [dbo].[Country] ([CountryKey])
	)
GO

CREATE TABLE [dbo].[Customer](
	[CustomerKey] [int] IDENTITY(1,1) PRIMARY KEY,
	[CustomerID] [nchar](5) UNIQUE,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Address] [nvarchar](60) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[CityKey] [int] REFERENCES [dbo].[City] ([CityKey])
	)
GO

CREATE TABLE [dbo].[Employee](
	[EmployeeKey] [int] PRIMARY KEY,
	[FirstName] [nvarchar](10) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [date] NULL,
	[HireDate] [date] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[SupervisorKey] [int] REFERENCES [dbo].[Employee] ([EmployeeKey])
	)
GO

CREATE TABLE [dbo].[Category](
	[CategoryKey] [int] PRIMARY KEY,
	[CategoryName] [nvarchar](15) NOT NULL,
	[Description] [ntext] NULL
	)
GO

CREATE TABLE [dbo].[Product](
	[ProductKey] [int] PRIMARY KEY,
	[ProductName] [nvarchar](40) NOT NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[Discontinued] [bit] NOT NULL,
	[CategoryKey] [int] REFERENCES [dbo].[Category] ([CategoryKey])
	)
GO

CREATE TABLE [dbo].[Shipper](
	[ShipperKey] [int] PRIMARY KEY,
	[CompanyName] [nvarchar](40) NOT NULL
	)
GO

CREATE TABLE [dbo].[Supplier](
	[SupplierKey] [int] PRIMARY KEY,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Address] [nvarchar](60) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[CityKey] [int] REFERENCES [dbo].[City] ([CityKey])
	)
GO

CREATE TABLE [dbo].[Territories](
	[EmployeeKey] [int] REFERENCES [dbo].[Employee] ([EmployeeKey]),
	[CityKey] [int] REFERENCES [dbo].[City] ([CityKey]),
 CONSTRAINT [PK_Territories_EmployeeKey_CityKey] PRIMARY KEY ([EmployeeKey],[CityKey])
 )
GO

CREATE TABLE [dbo].[Time](
	[TimeKey] [int] IDENTITY(1,1) PRIMARY KEY,
	[Date] [date] UNIQUE,
	[DayNbWeek] [tinyint] NULL,
	[DayNameWeek] [nvarchar](10) NULL,
	[DayNbMonth] [tinyint] NULL,
	[DayNbYear] [smallint] NULL,
	[WeekNbYear] [tinyint] NULL,
	[MonthNumber] [tinyint] NULL,
	[MonthName] [nvarchar](10) NULL,
	[Quarter] [tinyint] NULL,
	[Semester] [tinyint] NULL,
	[Year] [smallint] NULL
	)
GO

CREATE TABLE [dbo].[Sales](
	[CustomerKey] [int] REFERENCES [dbo].[Customer] ([CustomerKey]),
	[EmployeeKey] [int] REFERENCES [dbo].[Employee] ([EmployeeKey]),
	[OrderDateKey] [int] REFERENCES [dbo].[Time] ([TimeKey]),
	[DueDateKey] [int] REFERENCES [dbo].[Time] ([TimeKey]),
	[ShippedDateKey] [int] REFERENCES [dbo].[Time] ([TimeKey]),
	[ShipperKey] [int] REFERENCES [dbo].[Shipper] ([ShipperKey]),
	[ProductKey] [int] REFERENCES [dbo].[Product] ([ProductKey]),
	[SupplierKey] [int] REFERENCES [dbo].[Supplier] ([SupplierKey]),
	[OrderNo] [int] NOT NULL,
	[OrderLineNo] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
	[SalesAmount] [money] NOT NULL,
	[Freight] [money] NOT NULL,
 CONSTRAINT [AK_IOrders_OrderNo_OrderLineNo] UNIQUE ([OrderNo], [OrderLineNo])
 )
GO

CREATE TABLE [dbo].[TempCities](
	[City] [nvarchar](40) NULL,
	[State] [nvarchar](40) NULL,
	[Country] [nvarchar](40) NULL
)
GO
