CREATE DATABASE QLBH;

USE QLBH;

CREATE TABLE MatHang (
	MaHang NVARCHAR(10) NOT NULL,
	TenHang NVARCHAR(50) NOT NULL,
	DonGia MONEY
);

CREATE TABLE KhachHang (
	MaKH NVARCHAR(10) NOT NULL,
	TenKH NVARCHAR(50) NOT NULL,
	GioiTinh NVARCHAR(10) NOT NULL,
	QueQuan NVARCHAR(50)
);


CREATE TABLE HoaDon (
	SoPhieu NVARCHAR(10) NOT NULL,
	NgayLap DATE,
	MaKH NVARCHAR(10) NOT NULL
);

CREATE TABLE CTHoaDon (
	SoPhieu NVARCHAR(10) NOT NULL,
	MaHang NVARCHAR(10) NOT NULL,
	SoLuong INT
);


ALTER TABLE MatHang
ADD CONSTRAINT PK_MatHang PRIMARY KEY(MaHang);


ALTER TABLE KhachHang
ADD CONSTRAINT PK_KhachHang PRIMARY KEY(MaKH);


ALTER TABLE HoaDon
ADD CONSTRAINT PK_HoaDon PRIMARY KEY(SoPhieu);

ALTER TABLE CTHoaDon
ADD CONSTRAINT PK_CTHoaDon PRIMARY KEY(SoPhieu, MaHang);


ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH);

ALTER TABLE CTHoaDon
ADD CONSTRAINT FK_CTHoaDon_HoaDon FOREIGN KEY(SoPhieu) REFERENCES HoaDon(SoPhieu);

ALTER TABLE CTHoaDon
ADD CONSTRAINT FK_CTHoaDon_MatHang FOREIGN KEY(MaHang) REFERENCES MatHang(MaHang);


INSERT INTO MatHang VALUES('M1', N'Dưỡng môi Ohui', 200000);
INSERT INTO MatHang VALUES('M2', N'Tinh chất Ohui', 1000000);
INSERT INTO MatHang VALUES('M3', N'Kem dưỡng Ohui', 550000);


INSERT INTO KhachHang VALUES('K1', N'Trần Triệu Vy', N'Nữ', N'Hà Nội');
INSERT INTO KhachHang VALUES('K2', N'Trần Đình Trọng', N'Nam', N'Thái Bình');
INSERT INTO KhachHang VALUES('K3', N'Minh Hà', N'Nữ', N'Sài Gòn');

INSERT INTO HoaDon VALUES('P1', '3-3-2019', 'K1');
INSERT INTO HoaDon VALUES('P2', '8-3-2019', 'K1');
INSERT INTO HoaDon VALUES('P3', '8-4-2019', 'K3');

INSERT INTO CTHoaDon VALUES('P1', 'M1', 2);
INSERT INTO CTHoaDon VALUES('P1', 'M2', 3);
INSERT INTO CTHoaDon VALUES('P2', 'M2', 1);


-- C2:

SELECT MaKH, TenKH, GioiTinh FROM KhachHang
WHERE TenKH LIKE N'Nguyễn%' AND QueQuan = N'Hà Nội';


-- C3:

SELECT KhachHang.MaKH, TenKH, SUM(DonGia * SoLuong) AS 'Tổng Tiền' FROM CTHoaDon 
INNER JOIN MatHang ON CTHoaDon.MaHang = MatHang.MaHang
INNER JOIN HoaDon ON HoaDon.SoPhieu = CTHoaDon.SoPhieu
INNER JOIN KhachHang ON HoaDon.MaKH = KhachHang.MaKH
WHERE SoLuong * DonGia > 1000000
GROUP BY HoaDon.SoPhieu, KhachHang.MaKH, TenKH;

-- C4:

SELECT MaKH, TenKH FROM KhachHang
WHERE MaKH NOT IN(SELECT MaKH FROM HoaDon 
WHERE SoPhieu IN (SELECT SoPhieu FROM CTHoaDon));


SELECT MaKH, TenKH FROM KhachHang
WHERE MaKH NOT IN(SELECT KhachHang.MaKH FROM CTHoaDon 
INNER JOIN HoaDon ON HoaDon.SoPhieu = CTHoaDon.SoPhieu
INNER JOIN KhachHang ON HoaDon.MaKH = KhachHang.MaKH);

-- C5:

SELECT KhachHang.MaKH, TenKH, MatHang.MaHang, TenHang, DonGia, SoLuong FROM CTHoaDon 
INNER JOIN MatHang ON CTHoaDon.MaHang = MatHang.MaHang
INNER JOIN HoaDon ON HoaDon.SoPhieu = CTHoaDon.SoPhieu
INNER JOIN KhachHang ON HoaDon.MaKH = KhachHang.MaKH
WHERE TenKH = N'Trần Triệu Vy';


-- C6:

INSERT INTO CTHoaDon VALUES('P3', 'M3', 4);


-- C7:
UPDATE KhachHang
SET QueQuan = N'Miền Tây'
WHERE TenKH = N'Minh Hà';


-- C8:

DELETE FROM MatHang
WHERE TenHang = N'Kem dưỡng Ohui';