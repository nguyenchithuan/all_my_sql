﻿CREATE DATABASE Test1;

USE Test1;

CREATE TABLE NhanVien (
	MaNV NVARCHAR(10) NOT NULL,
	HoTenNV NVARCHAR(50) NOT NULL,
	NamLamViec INT,
	Luong MONEY
);


CREATE TABLE KhachHang (
	MaKH NVARCHAR(10) NOT NULL,
	HoTen NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	QueQuan NVARCHAR(50),
	GioiTinh NVARCHAR(10)
);


CREATE TABLE DonDatHang(
	SoHD NVARCHAR(10) NOT NULL,
	MaKH NVARCHAR(10) NOT NULL,
	MaNV NVARCHAR(10) NOT NULL,
	SanPham NVARCHAR(10) NOT NULL
);

ALTER TABLE NhanVien
ADD CONSTRAINT PK_NhanVien PRIMARY KEY(MaNV);

ALTER TABLE KhachHang
ADD CONSTRAINT PK_KhachHang PRIMARY KEY(MaKH);

ALTER TABLE DonDatHang
ADD CONSTRAINT PK_DonDatHang PRIMARY KEY(SoHD);

ALTER TABLE DonDatHang
ADD CONSTRAINT FK_DonDatHang_KhachHang FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH);

ALTER TABLE DonDatHang
ADD CONSTRAINT FK_DonDatHang_NhanVien FOREIGN KEY(MaNV) REFERENCES NhanVien(MaNV);

INSERT INTO NhanVien VALUES('N1', N'Trần An Nhiên', 2013, 60000000);
INSERT INTO NhanVien VALUES('N2', N'Lê Bình An', 2018, 90000000);
INSERT INTO NhanVien VALUES('N3', N'Phan Huy Vân', 2020, 50000000);

INSERT INTO KhachHang VALUES('KH1', N'Trần Hoàng Hôn', '1-5-1979', N'Hà Nội', 'Nam');
INSERT INTO KhachHang VALUES('KH2', N'Khổng Long', '8-3-2000', N'Hà Tĩnh', 'Nam');
INSERT INTO KhachHang VALUES('KH3', N'Đặng Mỹ', '5-1-1997', N'Hà Nội', 'Nữ');

INSERT INTO DonDatHang VALUES('H001', 'KH1', 'N1', 'SON MÔI');
INSERT INTO DonDatHang VALUES('H002', 'KH2', 'N2', 'KEM DƯỠNG');
INSERT INTO DonDatHang VALUES('H003', 'KH3', 'N2', 'TÚI');
-- C2:

SELECT NhanVien.MaNV, HoTenNV, Luong FROM DonDatHang
INNER JOIN NhanVien ON DonDatHang.MaNV = NhanVien.MaNV
INNER JOIN KhachHang ON DonDatHang.MaKH = KhachHang.MaKH
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) > 25;

-- C3:

SELECT MaNV, HoTenNV, Luong FROM NhanVien
WHERE NamLamViec > 2012;


-- C4:


SELECT TOP 1 NhanVien.MaNV, HoTenNV, COUNT(SanPham) AS 'Số lượng SP' FROM DonDatHang
INNER JOIN NhanVien ON DonDatHang.MaNV = NhanVien.MaNV
GROUP BY NhanVien.MaNV, HoTenNV
ORDER BY COUNT(SanPham) DESC;

-- C5:

SELECT TOP 2 MaKH, HoTen, YEAR(GETDATE()) - YEAR(NgaySinh) AS 'Tuổi' FROM KhachHang
WHERE QueQuan = N'Hà Nội'
ORDER BY HoTen DESC;


-- C6:

INSERT INTO DonDatHang VALUES('H004', 'KH3', 'N1', 'GIÀY');



-- C7:

UPDATE NhanVien
SET Luong = Luong * 90 / 100
WHERE MaNV NOT IN(SELECT MaNV FROM DonDatHang);

-- C8:

DELETE NhanVien WHERE HoTenNV NOT LIKE N'%u%';