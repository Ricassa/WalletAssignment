USE [master]
GO
/****** Object:  Database [TestHubDb]    Script Date: 5/26/2023 11:27:18 PM ******/
CREATE DATABASE [TestHubDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestHubDb', FILENAME = N'D:\SQL\MSSQL15.SQLEXPRESS\MSSQL\DATA\TestHubDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestHubDb_log', FILENAME = N'D:\SQL\MSSQL15.SQLEXPRESS\MSSQL\DATA\TestHubDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TestHubDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestHubDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestHubDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestHubDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestHubDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestHubDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestHubDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestHubDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TestHubDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestHubDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestHubDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestHubDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestHubDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestHubDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestHubDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestHubDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestHubDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TestHubDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestHubDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestHubDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestHubDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestHubDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestHubDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestHubDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestHubDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestHubDb] SET  MULTI_USER 
GO
ALTER DATABASE [TestHubDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestHubDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestHubDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestHubDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestHubDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestHubDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TestHubDb] SET QUERY_STORE = OFF
GO
USE [TestHubDb]
GO
/****** Object:  Table [dbo].[Popups]    Script Date: 5/26/2023 11:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Popups](
	[PopID] [int] IDENTITY(1,1) NOT NULL,
	[Pop#] [int] NULL,
	[PopSeq] [int] NULL,
	[PopChar] [varchar](5) NULL,
	[PopCode] [int] NULL,
	[PopDesc] [varchar](50) NULL,
	[PopComment] [varchar](30) NULL,
	[PopEntryPerson] [varchar](30) NULL,
	[PopSysDate] [smalldatetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/26/2023 11:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/26/2023 11:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](60) NULL,
	[Email] [varchar](60) NULL,
	[RoleID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wallet]    Script Date: 5/26/2023 11:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wallet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Type] [varchar](10) NULL,
	[AccountNumber] [varchar](60) NULL,
	[AccountScheme] [varchar](10) NULL,
	[CreatedAt] [datetime] NULL,
	[Owner] [varchar](20) NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Popups] ADD  CONSTRAINT [DC_Popups_PopSysDate]  DEFAULT (getdate()) FOR [PopSysDate]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Wallet]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
/****** Object:  StoredProcedure [dbo].[spDeleteWallet]    Script Date: 5/26/2023 11:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteWallet]
@Id            Int         = NULL,
@Action        Varchar(1),  
@ResultID      Int = 0 OUTPUT     
AS 
DECLARE @ErrorMessage VARCHAR(100)
BEGIN TRY 

IF @Action = 'D'    
BEGIN    
    DELETE FROM Wallet WHERE Id = @Id    
 SET  @ResultID = @Id     
END 
END TRY  
BEGIN CATCH    
  RAISERROR (@ErrorMessage,16, 1 )    
END CATCH 
GO
/****** Object:  StoredProcedure [dbo].[spGetWalletById]    Script Date: 5/26/2023 11:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetWalletById]
@ID Int
AS
SELECT * FROM Wallet WHERE Id=@ID
GO
/****** Object:  StoredProcedure [dbo].[spGetWallets]    Script Date: 5/26/2023 11:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetWallets]
AS
SELECT * FROM Wallet 
GO
/****** Object:  StoredProcedure [dbo].[spWallet_IUD]    Script Date: 5/26/2023 11:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spWallet_IUD]  
@Id            Int         = NULL,    
@Name      Varchar(60) = NULL,     
@Type          Varchar(10), -- 1:MoMo,2:Card    
@AccountNumber    Char(6), -- Only Ist 6 digits will be saved   
@AccountScheme Varchar(10), -- 1:Visa,2:Master Card,3:MTN,4:Vodafone,5:AirtelTigo       
@Owner         Varchar(20),
@UserID        Int,
@Action        Varchar(1),      
@ResultID      Int = 0 OUTPUT     
AS 
DECLARE @ErrorMessage VARCHAR(100)
BEGIN TRY 
IF @Action = 'I' AND ISNULL(@Id,0)=0 
BEGIN 
      -- Check and Prevent Duplicate Wallet Entry
	IF EXISTS(SELECT * FROM Wallet WHERE AccountNumber=@AccountNumber)
	  BEGIN    
		  SELECT @ErrorMessage ='An error Occured: Duplicate Entry.-Wallet Already Exists'    
		  SELECT 1/0    
	  END
    -- Check and Prevent User having more than 5 wallets
	IF (SELECT COUNT(*) FROM Wallet WHERE UserID=@UserID) > 5
	  BEGIN    
		  SELECT @ErrorMessage ='An error Occured: User Cannot have more than 5 wallets'    
		  SELECT 1/0    
	 END

INSERT INTO Wallet    
 (    
Name,     
Type ,  
AccountNumber,    
AccountScheme,     
Owner,
UserID,
CreatedAt
 ) 
SELECT    
   @Name,    
   @Type,    
   @AccountNumber,    
   @AccountScheme,    
   @Owner,
   @UserID,
   GETDATE()
 SELECT @ResultID = SCOPE_IDENTITY()     
END

IF @Action = 'D'    
BEGIN    
    DELETE FROM Wallet WHERE Id = @Id    
 SET  @ResultID = @Id     
END 
END TRY  
BEGIN CATCH    
  RAISERROR (@ErrorMessage,16, 1 )    
END CATCH 
GO
USE [master]
GO
ALTER DATABASE [TestHubDb] SET  READ_WRITE 
GO
