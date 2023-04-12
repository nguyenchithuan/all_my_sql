------------------------------ CÂU 1-------------------------------------


CREATE DATABASE QLDM;

USE QLDM;

CREATE TABLE Bao (
	MaToBao NVARCHAR(10) NOT NULL,
	TenBao NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(50)
);

CREATE TABLE DocGia (
	MaDG NVARCHAR(10) NOT NULL,
	HoTen NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	GioiTinh NVARCHAR(10),
	DiaChi NVARCHAR(50)
);


CREATE TABLE DatMua (
	MaDG NVARCHAR(10) NOT NULL,
	MaToBao NVARCHAR(10) NOT NULL,
	Quy INT,
	Nam INT,
	SoLuong INT,
	DonGia MONEY
);



ALTER TABLE Bao 
ADD CONSTRAINT PK_bao PRIMARY KEY(MaToBao);

ALTER TABLE DocGia 
ADD CONSTRAINT PK_docGia PRIMARY KEY(MaDG);

ALTER TABLE DatMua
ADD CONSTRAINT PK_datMua PRIMARY KEY(MaDG, MaToBao);

ALTER TABLE DatMua
ADD CONSTRAINT FK_datMua_bao FOREIGN KEY(MaToBao) REFERENCES Bao(MaToBao);

ALTER TABLE DatMua
ADD CONSTRAINT FK_datMua_docGia FOREIGN KEY(MaDG) REFERENCES DocGia(MaDG);

INSERT INTO bao VALUES('B01', N'An ninh nhân dân', N'Hà Nội');
INSERT INTO bao VALUES('B02', N'Thủ đô', N'Hà Nội');
INSERT INTO bao VALUES('B03', N'Thể thao', N'Hải Phòng');
INSERT INTO bao VALUES('B04', N'Giải trí', N'Bắc Ninh');

INSERT INTO docgia VALUES('DG01', N'Nguyễn Thị Lan Anh', '2/23/2002', N'Nữ', N'Quảng Ninh')
INSERT INTO docgia VALUES('DG02', N'Tô Đăng Đạt', '10/8/2003', N'Nam', N'Hà Nội')
INSERT INTO docgia VALUES('DG03', N'Hoàng Quý Khánh', '10/3/2003', N'Nam', N'Hà Nội')
INSERT INTO docgia VALUES('DG04', N'Nguyễn Thanh Sơn', '7/8/2005', N'Nam', N'Thanh Hóa')

INSERT INTO datmua VALUES('DG01', 'B01', '3', '2019', '10', '15000')
INSERT INTO datmua VALUES('DG02', 'B02', '4', '2020', '12', '20000')
INSERT INTO datmua VALUES('DG03', 'B03', '2', '2018', '9', '30000')
INSERT INTO datmua VALUES('DG04', 'B04', '1', '2019', '7', '10000')
INSERT INTO datmua VALUES('DG02', 'B03', '1', '2019', '7', '10000')

SELECT * FROM bao;
SELECT * FROM docGia;
SELECT * FROM datMua;


------------------------------ CÂU 2-------------------------------------


-- C1:

SELECT DocGia.MaDG, HoTen FROM DatMua
INNER JOIN Bao ON DatMua.MaToBao = Bao.MaToBao
INNER JOIN DocGia ON DatMua.MaDG = DocGia.MaDG
WHERE TenBao = N'An ninh nhân dân' AND Nam = 2019;


-- C2:

SELECT TOP 1 DocGia.MaDG, HoTen, SUM(SoLuong) AS 'Tổng số lượng' FROM DatMua
INNER JOIN DocGia ON DatMua.MaDG = DocGia.MaDG
GROUP BY DocGia.MaDG, HoTen
ORDER BY SUM(SoLuong) DESC;

-- C3:

SELECT TenBao FROM DatMua
INNER JOIN Bao ON DatMua.MaToBao = Bao.MaToBao
WHERE Quy != 1 AND Nam != 2019;


-- C4: 

SELECT HoTen, NgaySinh, YEAR(GETDATE()) - YEAR(NgaySinh) AS 'Tuổi' FROM DocGia
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) > 19 AND HoTen LIKE N'Nguyễn%';


-- C5:

SELECT DocGia.MaDG, HoTen, TenBao FROM DatMua
INNER JOIN Bao ON DatMua.MaToBao = Bao.MaToBao
INNER JOIN DocGia ON DatMua.MaDG = DocGia.MaDG
WHERE Quy = 2 AND Nam = 2019 AND SoLuong > 10;


-- C6.1 :

SELECT Bao.MaToBao, TenBao, SUM(SoLuong * DonGia) AS 'Tổng tiền bán của mỗi tờ báo' FROM DatMua
INNER JOIN Bao ON DatMua.MaToBao = Bao.MaToBao
GROUP BY Bao.MaToBao, TenBao;



-- C6.2 :

SELECT TOP 1 Bao.MaToBao, TenBao, SUM(SoLuong * DonGia) AS 'Tổng tiền bán Max của tờ báo' FROM DatMua
INNER JOIN Bao ON DatMua.MaToBao = Bao.MaToBao
GROUP BY Bao.MaToBao, TenBao
ORDER BY SUM(SoLuong * DonGia) DESC;


-- C7:

ALTER TABLE DocGia
ADD QueQuan NVARCHAR(50);

UPDATE DocGia
SET QueQuan = N'Việt Nam';



-- C8:

UPDATE DocGia
SET DiaChi = N'Hà Nội'
WHERE HoTen = N'Nguyễn Thanh Sơn';


-- C9:

DELETE FROM DatMua
WHERE MaDG = (SELECT MaDG FROM DocGia WHERE HoTen = N'Nguyễn Thị Lan Anh');