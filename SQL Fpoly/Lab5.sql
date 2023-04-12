CREATE DATABASE QuanLySV;

USE QuanLySV;

CREATE TABLE SinhVien (
	MaSV NVARCHAR(10) NOT NULL,
	HoTen NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	QueQuan NVARCHAR(50),
	DiemToan INT,
	DiemLy INT,
	GioiTinh NVARCHAR(10),
	CHECK(GioiTinh = N'Nam' OR GioiTinh = N'Nữ'),
	CONSTRAINT PK_SinhVien PRIMARY KEY(MaSV)
);

INSERT INTO SinhVien VALUES('S001', N'Lê Minh Tuấn', '1/1/2000', N'Hà Nội', 7, 9, 'Nam');
INSERT INTO SinhVien VALUES('S002', N'Đỗ Mỹ Linh', '5/8/1998', N'Hà Tĩnh', 10, 10, 'Nam');
INSERT INTO SinhVien VALUES('S003', N'Mai Phương Thúy', '6/9/1999', N'Nghệ An', 8, 7, N'Nữ');
INSERT INTO SinhVien VALUES('S004', N'Lê Quang Tuấn', '5/6/1999', N'Hà Nội', 9, 9, 'Nam');

-- 1. Đưa ra thông tin tất cả các sinh viên quê Hà Nội

SELECT * FROM SinhVien WHERE QueQuan = N'Hà Nội';

-- 2. Đưa ra maSV, tenSV các sinh viên Nam

SELECT MaSV, HoTen FROM SinhVien WHERE GioiTinh = N'Nam';

-- 3. Đưa ra danh sach sinh viên giảm dần theo điểm môn toán

SELECT * FROM SinhVien
ORDER BY DiemToan DESC;

-- 4. Đưa ra quê sinh viên không lặp nếu trùng nhau

SELECT DISTINCT QueQuan FROM SinhVien;

-- 5. Đưa ra maSV, tenSV, gioiTinh, tongdiem của sinhvien

SELECT MaSV, HoTen, GioiTinh, DiemToan + DiemLy AS N'Tổng Điểm' FROM SinhVien;

-- 6. Đưa ra các sinh viên có quên Hà Nội và giới tinh Nữ

SELECT * FROM SinhVien WHERE QueQuan = N'Hà Nội' AND GioiTinh = N'Nữ';

-- 7. Đưa ra thông tin 3 sinh viên đầu tiên của bảng

SELECT TOP 3 * FROM SinhVien;

-- 8. Đưa ra masv,tensv,quequan của các sinh viên quê Hà tĩnh hoặc nghệ an

SELECT MaSV, HoTen, QueQuan FROM SinhVien WHERE QueQuan = N'Hà Tĩnh' OR QueQuan = N'Nghệ An';

-- 9. Đưa ra các sinh viên với trường ngaysinh được sắp xếp theo chiều tăng dần

SELECT * FROM SinhVien
ORDER BY NgaySinh ASC;

-- 10. Đưa ra các sinh viên có họ Lê

SELECT * FROM SinhVien WHERE HoTen LIKE 'Lê%';

-- 11. Đưa ra masv,hoten,tuoi của các sinh viên

SELECT MaSV, HoTen, YEAR(GETDATE()) - YEAR(NgaySinh) AS N'Tuổi' FROM SinhVien;

-- 12. Đưa ra masv,hoten,ngaysinh,tuoi của các sinh viên có tuổi >= 22

SELECT MaSV, HoTen, NgaySinh, YEAR(GETDATE()) - YEAR(NgaySinh) AS N'Tuổi' FROM SinhVien
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) >= 22;

-- 13. Đưa ra các sinh viên có Tên là Tuấn quê Hà nội

SELECT * FROM SinhVien 
WHERE HoTen LIKE N'%Tuấn' AND QueQuan = N'Hà Nội';