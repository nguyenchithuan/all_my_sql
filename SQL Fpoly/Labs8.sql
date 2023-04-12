CREATE DATABASE QLDT;

USE QLDT;

CREATE TABLE giaovien (
	magv NVARCHAR(10) NOT NULL,
	hoten NVARCHAR(50) NOT NULL,
	ngaysinh DATE,
	quequan NVARCHAR(50),
	gioitinh NVARCHAR(10)
);

CREATE TABLE detai (
	madt NVARCHAR(10) NOT NULL,
	tendt NVARCHAR(50) NOT NULL,
	namthhien INT,
	magv NVARCHAR(10)
);

CREATE TABLE sinhvien (
	masv NVARCHAR(10) NOT NULL,
	hoten NVARCHAR(50) NOT NULL,
	ngaysinh DATE,
	quequan NVARCHAR(50),
	diem INT,
	madt NVARCHAR(10)
);


ALTER TABLE giaovien
ADD CONSTRAINT PK_giaovien PRIMARY KEY(magv);

ALTER TABLE detai
ADD CONSTRAINT PK_detai PRIMARY KEY(madt);

ALTER TABLE detai
ADD CONSTRAINT FK_detai_giaovien FOREIGN KEY(magv) REFERENCES giaovien(magv);

ALTER TABLE sinhvien
ADD CONSTRAINT PK_sinhvien PRIMARY KEY(masv);

ALTER TABLE detai
ADD CONSTRAINT FK_sinhvien_detai FOREIGN KEY(madt) REFERENCES detai(madt);

INSERT INTO giaovien VALUES('Gv01', N'Trần Thị Loan', '6/5/1978', N'Nam Định', N'Nữ');
INSERT INTO giaovien VALUES('Gv02', N'Lê Viết Thịnh', '5/3/1989', N'Hà Tĩnh', N'Nam');
INSERT INTO giaovien VALUES('Gv03', N'Trần Hữu Thiện', '9/1/1991', N'Hà Nội', N'Nam');

INSERT INTO detai VALUES('D01', N'Công nghệ 4.0', 2017, 'Gv01');
INSERT INTO detai VALUES('D02', N'Công nghệ Blockchain', 2018, 'Gv03');
INSERT INTO detai VALUES('D03', N'Bitcoin', 2018, 'Gv03');

INSERT INTO sinhvien VALUES('S001', N'Lê Quang Tèo', '1/1/2000', N'Hà Nội', 7, 'D02');
INSERT INTO sinhvien VALUES('S002', N'Đồ Mỹ Linh', '5/8/1998', N'Hà Tĩnh', 10, 'D01');
INSERT INTO sinhvien VALUES('S003', N'Mai Phương Thúy', '6/9/1999', N'Nghệ An', 8, 'D02');

SELECT * FROM giaovien;
SELECT * FROM detai;
SELECT * FROM sinhvien;

DELETE giaovien
WHERE magv = 'GV04';

DELETE sinhvien
WHERE masv = 'S004';

-- Câu 2:
SELECT masv,sinhvien.hoten, sinhvien.quequan, tendt FROM sinhvien
INNER JOIN detai ON sinhvien.madt = detai.madt
INNER JOIN giaovien ON giaovien.magv = detai.magv
WHERE giaovien.hoten = N'Trần Thị Loan';



-- Câu 3:
SELECT masv, hoten, YEAR(GETDATE()) - YEAR(ngaysinh) AS 'tuoi' FROM sinhvien
WHERE quequan = N'Hà Nội' AND YEAR(GETDATE()) - YEAR(ngaysinh) >= 18;




-- Câu 4:
SELECT TOP 1 giaovien.magv, hoten, COUNT(detai.magv) AS 'Số lần xuât hiện' 
FROM detai
RIGHT JOIN giaovien ON giaovien.magv = detai.magv
GROUP BY giaovien.magv, hoten
ORDER BY COUNT(detai.magv) DESC;


-- Câu 5:
SELECT detai.madt, tendt, AVG(diem) AS 'Điểm TB' FROM sinhvien
INNER JOIN detai ON sinhvien.madt = detai.madt
GROUP BY detai.madt, tendt;



-- Câu 6:
INSERT INTO giaovien VALUES('Gv04', N'Nguyễn Văn Minh', '9/1/1991', N'Hà Nội', N'Nam');
INSERT INTO detai VALUES('D04', N'Tiếng Anh', 2017, 'Gv04');
INSERT INTO sinhvien VALUES('S004', N'Nguyễn Chí Thuận', '10/20/2000', N'Hà Nội', 10, 'D03');



-- Câu 7:
UPDATE giaovien
SET quequan = N'Hà Nội'
WHERE hoten = N'Trần Thị Loan';



-- Câu 8:
DELETE FROM detai
WHERE madt NOT IN(SELECT madt FROM sinhvien);
