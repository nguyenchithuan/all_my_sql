﻿CREATE DATABASE QLChamCong;

USE QLChamCong;

CREATE TABLE NhanVien (
	MaNV NVARCHAR(10) NOT NULL,
	Hoten NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	Luong MONEY,
	GioiTinh NVARCHAR(10)
);

CREATE TABLE DuAn (
	MaDA NVARCHAR(10) NOT NULL,
	TenDA NVARCHAR(50) NOT NULL,
	NamBatDau INT
);

CREATE TABLE ChamCong (
	MaNV NVARCHAR(10) NOT NULL,
	MaDA NVARCHAR(10) NOT NULL,
	SoGio INT
);


ALTER TABLE NhanVien
ADD CONSTRAINT PK_NhanVien PRIMARY KEY(MaNV);

ALTER TABLE DuAn
ADD CONSTRAINT PF_DuAn PRIMARY KEY(MaDA);

ALTER TABLE ChamCong
ADD CONSTRAINT PK_ChamCong PRIMARY KEY(MaNV, MaDA);

ALTER TABLE ChamCong
ADD CONSTRAINT FK_ChamCong_NhanVien FOREIGN KEY(MaNV) REFERENCES NhanVien(MaNV);

ALTER TABLE ChamCong
ADD CONSTRAINT FK_ChamCong_DuAn FOREIGN KEY(MaDA) REFERENCES DuAn(MaDA);

INSERT INTO NhanVien VALUES('V01', N'Trần Văn Tèo', '1-3-1968', '9000000', N'Nam');
INSERT INTO NhanVien VALUES('V02', N'Lê Huy', '3-3-1988', '6000000', N'Nam');
INSERT INTO NhanVien VALUES('V03', N'Đặng Thị Hiếu', '5-1-2001', '60000000', N'Nữ');

INSERT INTO DuAn VALUES('DA1', N'Phần mềm dạy online', 2019);
INSERT INTO DuAn VALUES('DA2', N'Mạng Toàn cầu', 2020);
INSERT INTO DuAn VALUES('DA3', N'Quản lý sách', 2021);

INSERT INTO ChamCong VALUES('V01', 'DA1', 28);
INSERT INTO ChamCong VALUES('V01', 'DA2', 200);
INSERT INTO ChamCong VALUES('V02', 'DA1', 90);


SELECT * FROM NhanVien;
SELECT * FROM DuAn;
SELECT * FROM ChamCong;


-- C2:

SELECT MaNV, Hoten, YEAR(GETDATE()) - YEAR(NgaySinh) AS 'Tuổi' FROM NhanVien
WHERE GioiTinh = N'Nam' AND YEAR(GETDATE()) - YEAR(NgaySinh) > 15;


-- C3:

SELECT NhanVien.MaNV, Hoten, COUNT(SoGio) AS 'Tổng số giời' FROM ChamCong 
INNER JOIN NhanVien ON ChamCong.MaNV = NhanVien.MaNV
INNER JOIN DuAn ON ChamCong.MaDA = DuAn.MaDA
WHERE Hoten = N'Lê Huy'
GROUP BY NhanVien.MaNV, Hoten;

-- C4:

SELECT TOP 1 NhanVien.MaNV, Hoten, COUNT(SoGio) AS 'Tổng số giời' FROM ChamCong 
INNER JOIN NhanVien ON ChamCong.MaNV = NhanVien.MaNV
INNER JOIN DuAn ON ChamCong.MaDA = DuAn.MaDA
GROUP BY NhanVien.MaNV, Hoten
ORDER BY COUNT(SoGio) DESC;


-- C5:

SELECT TOP 2 NhanVien.MaNV, Hoten, Luong FROM ChamCong
INNER JOIN NhanVien ON ChamCong.MaNV = NhanVien.MaNV
INNER JOIN DuAn ON ChamCong.MaDA = DuAn.MaDA
WHERE TenDA = N'Mạng Toàn cầu'
ORDER BY Hoten;

-- C6:

INSERT INTO ChamCong VALUES('V02', 'DA2', 100);


-- C7:
UPDATE NhanVien
SET Luong = Luong * 110 / 100
WHERE MaNV IN (SELECT MaNV FROM ChamCong WHERE SoGio > 50);


-- C8:

DELETE NhanVien WHERE MaNV NOT IN(SELECT MaNV FROM ChamCong);