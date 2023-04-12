CREATE DATABASE QlBanHang1;

USE QlBanHang1;

CREATE TABLE MatHang(
	maHang NVARCHAR(10) NOT NULL,
	tenHang NVARCHAR(50) NOT NULL,
	soLuong INT,
	mauSac NVARCHAR(20),
	namSx INT,
	donGia MONEY
);

ALTER TABLE MatHang
ADD CONSTRAINT PK_MatHang PRIMARY KEY(maHang)

INSERT INTO MatHang VALUES('M1', N'Dưỡng môi ohui', 200, N'Xanh', 2019, 200000)
INSERT INTO MatHang VALUES('M2', N'Tinh chất ohui', 300, N'Đỏ', 2021, 100000)
INSERT INTO MatHang VALUES('M3', N'Kem dưỡng ohui', 100, N'Vàng', 2018, 550000)
INSERT INTO MatHang VALUES('M4', N'Dưỡng môi ohui', 150, N'Xanh', 2018, 130000)

--1. Đưa ra tất cả các thông tin của bảng

SELECT * FROM MatHang;

--2. Đưa ra maHang, tenHang, soLuong của bảng

SELECT maHang, tenHang, soLuong FROM MatHang;

--3. Đưa ra tên cột thay đổi nhưng không làm thay đổi giá trị góc

SELECT maHang AS N'Mã Hàng', tenHang AS N'Tên Hàng', soLuong AS N'Số Lượng' FROM MatHang;

--4. top N/ top N PERCENT hiện thị số bản ghi đầu tiên hoặc số phần trăm bản ghi đầu tiên

SELECT TOP 10 * FROM MatHang;

SELECT TOP 75 PERCENT maHang, tenHang, soLuong FROM matHang;

--5. DISTINCT: duy nhất truy vấn các bản ghi có dữ liệu khác nhau thường gọi the tường thuộc tính

SELECT DISTINCT mauSac FROM matHang;

--6. WHERE: lọc dữ liệu
--thường được dùng trong truy vấn dữ liệu select, update dữ liệu, delete xóa dữ liệu

-->, <, <=, >= , =, <>(!=)
--AND OR

--6.1. đưa ra các mặt hàng có số lượng >= 200

SELECT MaHang, tenHang FROM MatHang Where soLuong >= 200;

SELECT maHang, tenHang FROM MatHang WHERE mauSac <> N'Xanh';

--6.2 đưa ra các mặt hàng có màu xanh và số lượng >= 200

SELECT maHang AS N'Mã Hàng', tenHang AS N'Tên Hàng' , soLuong AS N'Số Lượng', mauSac AS N'Màu Sắc' FROM MatHang
WHERE soLuong >= 200 AND mauSac = N'Xanh';

--6.3 Đưa ra các mặt hàng có màu xanh hoặc màu đỏ

SELECT maHang AS N'Mã Hàng', mauSac AS N'Màu sắc'
FROM MatHang WHERE mauSac = N'Xanh' OR mauSac = N'Đỏ';

--7. đưa ra maHang, tenHang, soLuong, donGia, thanhTien của từng mặt hàng

SELECT maHang, tenHang, soLuong, donGia, soLuong * donGia AS 'Thành tiền'
FROM MatHang;

--8. ORDER BY ASC, DESC đừng để sắp xếp
-- không ghi gì hoặc ASC là tăng đần
-- DESC là giảm dần

SELECT * FROM MatHang
WHERE mauSac = N'Xanh'
ORDER BY donGia ASC;

-- WHERE luôn đi liền vứa table xong rồi mới đến order by: sắp xếp tăng dần hay giảm dần

SELECT * FROM MatHang
WHERE mauSac = N'Xanh'
ORDER BY donGia DESC;

--------------------------------------------------------------------------------

INSERT INTO MatHang VALUES('M5', N'Nguyễn Văn Nam', 200, N'Xanh', 2019, 340000)
INSERT INTO MatHang VALUES('M6', N'Lê Thế Anh', 150, N'Đỏ', 2022, 130000)
INSERT INTO MatHang VALUES('M7', N'Nguyễn Minh Anh', 400, N'Xanh', 2018, 130000)
INSERT INTO MatHang VALUES('M8', N'Nguyễn Thị Anh', 400, N'Xanh', 2018, 130000)
INSERT INTO MatHang VALUES('M9', N'Nguyễn Thị Minh Toàn', 400, N'Xanh', 2018, 130000)

-- 1. like %: được sd để tìm kiếm một ký tự hoặc 1 chuỗi trong dữ liệu

-- Đưa ra tất cả các sản phẩm có tên là ohui

SELECT * FROM MatHang WHERE tenHang LIKE '%ohui'

-- Đưa ra tất cả các người có họ là Nguyễn

SELECT * FROM MatHang WHERE tenHang LIKE N'Nguyễn%';

-- Đưa ra các mặt hàng có tên là Anh

SELECT * FROM MatHang WHERE tenHang like N'%Anh';

--Đưa ra các mặt hàng có họ đêm là Thị

SELECT * FROM MatHang WHERE tenHang LIKE N'%Thị%';



-- Ngày tháng: getdate(): lấy ra thời gian hiện tại

SELECT GETDATE();

-- lấy ra ngày hiện tại ta đùng DAY(Thời gian);
SELECT DAY(GETDATE());

-- lấy ra tháng hiện tại ta dùng MONTH(Thời gian);
SELECT MONTH(GETDATE());

-- lấy ra năm hiện tại ta dùng YEAR(Thời gian);
SELECT YEAR(GETDATE());

-- Tính thời gian hoặc tuổi
SELECT YEAR (GETDATE()) - YEAR('10/20/2003') AS N'Tuổi';


SELECT MONTH(GETDATE()) AS 'Tháng',
DAY(GETDATE()) AS 'Ngày' ,
YEAR(GETDATE()) AS 'Năm';

-- THÊM CỘT NGÀY SINH

ALTER TABLE matHang
ADD ngaySinh DATE;

-- Thay đổi dữ liệu

UPDATE matHang
SET ngaySinh = '11-2-2005'
WHERE maHang = N'M9';

SELECT * FROM matHang;

-- đưa ra tên maHang, tenhang, tuoi của mặt hàng

SELECT maHang, tenHang, YEAR(GETDATE()) - YEAR(ngaySinh) AS 'Tuôi'
FROM matHang;

SELECT *, YEAR(GETDATE()) - YEAR(ngaySinh) AS N'Tuổi'
FROM MatHang WHERE YEAR(GETDATE()) - YEAR(ngaySinh) > 21;