﻿CREATE DATABASE QLBH;

USE QLBH;

CREATE TABLE MatHang (
	MaHang VARCHAR(10) NOT NULL,
	TenHang VARCHAR(50) NOT NULL,
	DonGia INT,
	CONSTRAINT PK_MatHang PRIMARY KEY(MaHang)
);

CREATE TABLE KhachHang (
	MaKH VARCHAR(10) NOT NULL,
	TenKH VARCHAR(50) NOT NULL,
	GioiTinh VARCHAR(10),
	QueQuan VARCHAR(50),
	CONSTRAINT PK_KhachHang PRIMARY KEY(MaKH)
);

CREATE TABLE HoaDon (
	SoPhieu VARCHAR(10) NOT NULL,
	NgayLap DATE,
	MaKH VARCHAR(10),
	CONSTRAINT PK_HoaDon PRIMARY KEY(SoPhieu),
	CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH)
);

CREATE TABLE CTHoaDon (
	SoPhieu VARCHAR(10) NOT NULL,
	MaHang VARCHAR(10) NOT NULL,
	SoLuong INT CHECK(SoLuong >= 0),
	CONSTRAINT PK_CTHoaDon PRIMARY KEY(SoPhieu, MaHang),
	CONSTRAINT FK_CTHoaDon_HoaDon FOREIGN KEY(SoPhieu) REFERENCES HoaDon(SoPhieu),
	CONSTRAINT FK_CTHoaDon_MaHang FOREIGN KEY(MaHang) REFERENCES MatHang(MaHang)
);

INSERT INTO MatHang VALUES('M1', N'Dưỡng mỗi Ohui', 200000);
INSERT INTO MatHang VALUES('M2', N'Tinh chất Ohui', 10000000);
INSERT INTO MatHang VALUES('M3', N'Kem dưỡng Ohui', 550000);


INSERT INTO KhachHang VALUES('K1', N'Trần Triệu Vy', N'Nữ', N'Hà Nội');
INSERT INTO KhachHang VALUES('K2', N'Trần Đình Trọng', N'Nam', N'Thái Bình');
INSERT INTO KhachHang VALUES('K3', N'Minh Hà', N'Nữ', N'Sài Gòn');

INSERT INTO HoaDon VALUES('P1', '3/3/2019', 'K1');
INSERT INTO HoaDon VALUES('P2', '8/3/2019', 'K1');
INSERT INTO HoaDon VALUES('P3', '8/4/2019', 'K3');

INSERT INTO CTHoaDon VALUES('P1', 'M1', 2);
INSERT INTO CTHoaDon VALUES('P1', 'M3', 3);
INSERT INTO CTHoaDon VALUES('P2', 'M2', 1);

SELECT TOP 10 * FROM MatHang;
SELECT TOP 10 * FROM KhachHang;
SELECT TOP 10 * FROM HoaDon;
SELECT TOP 10 * FROM CTHoaDon;