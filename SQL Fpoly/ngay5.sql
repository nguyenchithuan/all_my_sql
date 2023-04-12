create database video5
go
use video5
go
create table mathang(
  mahang nchar(10) not null,
  tenhang nvarchar(50) not null,
  soluong int,
  mausac nvarchar(20),
  namsx int,
  dongia money
)
alter table mathang add constraint
   pk_mathang primary key(mahang)

insert into mathang values('M1',N'Dưỡng môi ohui',200,N'Xanh',2019,200000),
                                               ('M2',N'Tinh chất ohui',300,N'Đỏ',2021,100000),
                                               ('M3',N'Kem dưỡng ohui',100,N'Vàng',2018,550000),
                                               ('M4',N'Kem dưỡng ohui',150,N'Xanh',2018,130000)



1. Đưa ra tất cả các dữ liệu từ bảng:
SELECT * FROM mathang;

2. Đưa ra maHang, tenHang, SongLuong từ bảng:
SELECT mahang, tenhang, soluong FROM mathang;

3. thay đổi tên cột hiển thị
SELECT mahang AS N'Mã hang', tenhang AS 'Tên hàng' FROM mathang;

4. SELECT TOP/ SELECT TOP PERCENT đưa ra số bản ghi 
đầu tiên hoặc số phần trăm bản ghi đầu tiên

SELECT TOP 10 mahang, tenhang, soluong FROM mathang;

SELECT TOP 100 PERCENT * FROM mathang;

5. distinct: hiển thị các giá trị khác nhau trong colomn

SELECT DISTINCT mausac FROM mathang;

6. where: lọc các dữ liệu thường đc sử dụng ở delete, select, update
	=, >, <, >=, <=, <>(!=)
	AND OR

6.1 đưa ra các mat hàng có số lượng >= 300;

SELECT mahang, tenhang, soluong, dongia FROM mathang
WHERE soluong >= 200;


6.2 đưa ra các mặt hàng không phải màu xanh
SELECT mahang, tenhang, soluong, mausac, dongia FROM mathang
WHERE mausac <> N'Đỏ'

6.3 đưa ra các mặt hàng màu xanh có số lượng >= 200

SELECT * FROM mathang WHERE soluong >= 200 AND mausac = N'Xanh'

6.4 đưa ra các mặt hàng có màu Xanh và namsx là 2019

SELECT * FROM mathang WHERE mausac = N'Xanh' AND namsx >= 2018;
SELECT * FROM mathang

6.5 đưa ra các mặt hàng có màu xanh hoặc màu đỏ

SELECT * FROM mathang WHERE mausac = N'Xanh' OR mausac = N'Đỏ'









-----------------------------------------------------------

INSERT INTO MATHANG VALUES('M5',N'Nguyễn Văn Nam',150,N'Xanh',2018,130000)
INSERT INTO MATHANG VALUES('M6',N'Lê Thế Anh',150,N'Xanh',2018,130000)
INSERT INTO MATHANG VALUES('M7',N'Nguyễn Minh Anh',150,N'Xanh',2018,130000)
INSERT INTO MATHANG VALUES('M8',N'Nguyễn Thị Anh',150,N'Xanh',2018,130000)
INSERT INTO MATHANG VALUES('M9',N'Nguyễn Minh Toản',150,N'Xanh',2018,130000)
1. like %: lệnh tìm kiếm dữ liệu chuỗi có ở trong một chuỗi khác hay không

-- đưa ra tất cả các sản phẩm có tên là ohui
LIKE LÀ TIỀM KIẾM MỘT CHUỖI

2. tìm những người có họ nguyễn
SELECT * FROM mathang WHERE tenhang LIKE N'Nguyễn%';

3. đưa ra các măt hàng có tên Anh
SELECT * FROM mathang WHERE tenhang like N'%Anh'

4. đưa ra các mặt hàng có đệm là Thị

SELECT * FROM mathang WHERE tenhang like N'%thị%'



ALTER TABLE mathang
ADD  ngaysinh date;

5. ngày tháng; getdate();

SELECT getdate()
SELECT month(getdate())
SELECT day(getdate())
SELECT year(getdate())

SELECT getdate()

SELECT year(getdate()) - year('2-28-2000');

UPDATE mathang
SET ngaysinh = '2-11-2000'
WHERE mahang = 'M4';

SELECT *, YEAR(GETDATE()) - YEAR(ngaysinh) AS N'Tuổi' FROM mathang;

đưa ra các người có tuổi >= 23

SELECT *, YEAR(GETDATE()) - YEAR(ngaysinh) AS N'Tuổi' FROM mathang
WHERE YEAR(GETDATE()) - YEAR(ngaysinh) >= 23;