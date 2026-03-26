-- Tạo cơ sở dữ liệu
CREATE DATABASE furnitured;
GO

USE furnitured;
GO

-- Tạo bảng ACCOUNT
IF OBJECT_ID('dbo.account', 'U') IS NOT NULL
    DROP TABLE dbo.account;
GO

CREATE TABLE account (
    acc_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    username NVARCHAR(200) NULL UNIQUE,
    password NVARCHAR(45) NULL,
    acc_type NVARCHAR(10) NOT NULL CHECK (acc_type IN ('admin', 'seller', 'buyer'))
);
GO

-- Tạo bảng ADMIN
IF OBJECT_ID('dbo.admin', 'U') IS NOT NULL
    DROP TABLE dbo.admin;
GO

CREATE TABLE admin (
    aid INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    email NVARCHAR(200) NULL UNIQUE,
    acc_id INT NULL,
    CONSTRAINT fk_admin_account_id FOREIGN KEY (acc_id) 
        REFERENCES account (acc_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
GO

CREATE INDEX idx_admin_account_id ON admin (acc_id);
GO

-- Tạo bảng BUYER
IF OBJECT_ID('dbo.buyer', 'U') IS NOT NULL
    DROP TABLE dbo.buyer;
GO

CREATE TABLE buyer (
    bid INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    uemail NVARCHAR(200) NULL UNIQUE,
    uaddress NVARCHAR(MAX) NULL,
    acc_id INT NULL,
    uphone NVARCHAR(15) NULL,
    bname NVARCHAR(200) NULL,
    CONSTRAINT fk_buyer_account_id FOREIGN KEY (acc_id) 
        REFERENCES account (acc_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
GO

CREATE INDEX idx_buyer_account_id ON buyer (acc_id);
GO

-- Tạo bảng SELLER
IF OBJECT_ID('dbo.seller', 'U') IS NOT NULL
    DROP TABLE dbo.seller;
GO

CREATE TABLE seller (
    sid INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    semail NVARCHAR(100) NULL UNIQUE,
    sphone NVARCHAR(15) NULL,
    saddress NVARCHAR(MAX) NULL,
    acc_id INT NULL,
    sname NVARCHAR(200) NULL,
    CONSTRAINT fk_seller_account_id FOREIGN KEY (acc_id)
        REFERENCES account (acc_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE INDEX idx_seller_account_id ON seller (acc_id);
GO

-- Tạo bảng CATEGORY
IF OBJECT_ID('dbo.category', 'U') IS NOT NULL
    DROP TABLE dbo.category;
GO

CREATE TABLE category (
    cid INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    cname NVARCHAR(200) NULL UNIQUE
);
GO

-- Tạo bảng PRODUCT
IF OBJECT_ID('dbo.product', 'U') IS NOT NULL
    DROP TABLE dbo.product;
GO

CREATE TABLE product (
    pid INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    pname NVARCHAR(200) NULL,
    cid INT NULL,
    pqty INT NULL,
    pprice FLOAT NULL,
    sid INT NULL,
    cname NVARCHAR(200) NULL,
    image NVARCHAR(MAX) NULL,
    statusProduct NVARCHAR(100) NULL,
    CONSTRAINT fk_seller_id FOREIGN KEY (sid)
        REFERENCES seller (sid)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_category_id FOREIGN KEY (cid)
        REFERENCES category (cid)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
GO

CREATE INDEX idx_product_category_id ON product (cid);
CREATE INDEX idx_product_seller_id ON product (sid);
GO

-- Tạo bảng PURCHASE
CREATE TABLE purchase (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    bid INT NULL,
    pid INT NULL,
    price FLOAT NULL,
    p_date NVARCHAR(20) NULL,
    baddress NVARCHAR(MAX) NULL,
    receive_date NVARCHAR(20) NULL,
    status NVARCHAR(45) NULL,
    sid INT NULL,
    method NVARCHAR(100) NULL,
    CONSTRAINT fk_seller_id_purchase FOREIGN KEY (sid)
        REFERENCES seller (sid)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT purchase_ibfk_1 FOREIGN KEY (bid)
        REFERENCES buyer (bid)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT purchase_ibfk_2 FOREIGN KEY (pid)
        REFERENCES product (pid)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
