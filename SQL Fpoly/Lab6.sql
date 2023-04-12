CREATE DATABASE QLDH;

USE QLDH;

CREATE TABLE KhachHang (
	maKH NVARCHAR(10) NOT NULL,
	tenKH NVARCHAR(50) NOT NULL,
	taiKhoan INT
);

CREATE TABLE Sach (
	maS NVARCHAR(10) NOT NULL,
	tieuDe NVARCHAR(50) NOT NULL,
	donGia INT,
	ghiChu NVARCHAR(50)
);


CREATE TABLE DonHang (
	maDH NVARCHAR(10) NOT NULL,
	maKH NVARCHAR(10) NOT NULL,
	maS NVARCHAR(10) NOT NULL,
	soLuong INT
);


ALTER TABLE KhachHang 
ADD CONSTRAINT PK_KhachHang PRIMARY KEY(maKH);

ALTER TABLE Sach
ADD CONSTRAINT PK_Sach PRIMARY KEY(maS);

ALTER TABLE DonHang
ADD CONSTRAINT PK_DonHang PRIMARY KEY(maDH, maKH, maS);

ALTER TABLE DonHang
ADD CONSTRAINT FK_DonHang_khachHang 
FOREIGN KEY(maKH) REFERENCES KhachHang(maKH);


ALTER TABLE DonHang
ADD CONSTRAINT FK_DonHang_Sach 
FOREIGN KEY(maS) REFERENCES Sach(maS);

INSERT INTO KhachHang VALUES('KH1', N'Tùng', 00054502);
INSERT INTO KhachHang VALUES('KH2', N'Nga', 00082347);
INSERT INTO KhachHang VALUES('KH3', N'Vân', 00056341);

INSERT INTO Sach VALUES('S01', N'Tin học', 75000, N'Mới nhập');
INSERT INTO Sach VALUES('S02', N'Văn học', 82000, N'Hết sách');
INSERT INTO Sach VALUES('S03', N'Công nghệ', 110000, N'Còn sách');

INSERT INTO DonHang VALUES('001', 'KH1', 'S02', 7);
INSERT INTO DonHang VALUES('002', 'KH1', 'S03', 10);
INSERT INTO DonHang VALUES('003', 'KH3', 'S02', 20);


-- Hiển thị makh, tenkh, mas, soluong, donggia, thanhtien
SELECT KhachHang.maKH, tenKH, Sach.maS, soLuong, donGia, soLuong * donGia AS 'Thành tiền'
FROM DonHang INNER JOIN KhachHang ON DonHang.maKH = KhachHang.maKH
			 INNER JOIN Sach ON DonHang.maS = Sach.maS;


-- Hiển thị Top 2 khách hàng mua hang với số tiền nhiều nhất với:
--MaKH, Masach, soluong, dongia, thanhtien
SELECT TOP 2 KhachHang.maKH, Sach.maS, soLuong, donGia, soLuong * donGia AS 'Thành tiền'
FROM DonHang INNER JOIN KhachHang ON DonHang.maKH = KhachHang.maKH
			 INNER JOIN Sach ON DonHang.maS = Sach.maS
ORDER BY soLuong * donGia DESC;


-- Hiển thị các sách có số lượng nằm trong khoảng từ 10 đến 20.
SELECT * FROM DonHang INNER JOIN Sach ON DonHang.maS = Sach.maS
WHERE soluong BETWEEN 10 AND 20;


-- Đưa ra makh,tenkh,masach,tensach,soluong,dongia đã mua sách công nghệ
SELECT KhachHang.maKH, tenKH, Sach.maS, tieuDe, soLuong, donGia
FROM DonHang INNER JOIN KhachHang ON DonHang.maKH = KhachHang.maKH
			INNER JOIN Sach ON DonHang.maS = Sach.maS
WHERE tieuDe = N'Công nghệ';


-- Đưa ra masach, tensach các quyển sách có soluong >=10.
SELECT Sach.maS, tieuDe
FROM DonHang INNER JOIN Sach ON DonHang.maS = Sach.maS
WHERE soLuong >= 10;


--Chèn thêm một bản ghi mới vào bảng SACH.
INSERT INTO Sach VALUES('S04', N'Tin học', 60000, N'Còn sách');


-- Hiển thị MaDH, MaKH, tổng thành tiền đã mua trong từng đơn hàng. 
-- Chỉ hiển thị những đơn hàng có tổng thành tiền >=500.000 và sắp xếp
-- theo thứ tự giảm dần của cột tổng thành tiền.
SELECT maDH, MaKH, soLuong * donGia AS N'Thành tiền'
FROM DonHang INNER JOIN Sach ON DonHang.maS = Sach.maS
WHERE soLuong * donGia >= 500000
ORDER BY soLuong * donGia DESC;

--Hiển thị tên sách có số lượng đặt mua nhỏ hơn số lượng mua trung bình của các sách.
SELECT tieuDe FROM DonHang INNER JOIN Sach ON DonHang.maS = Sach.maS
WHERE soLuong <= (SELECT AVG(soLuong) FROM DonHang);