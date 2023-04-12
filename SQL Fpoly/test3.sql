CREATE DATABASE QLHangHoa;

USE QLHangHoa;

CREATE TABLE MatHang (
	msmh NVARCHAR(10) NOT NULL,
	tenhang NVARCHAR(50) NOT NULL,
	dongia MONEY,
	dvt NVARCHAR(50)
);

CREATE TABLE KhachHang (
	makh NVARCHAR(10) NOT NULL,
	tenkh NVARCHAR(10) NOT NULL,
	diachi NVARCHAR(50)
);

CREATE TABLE PhieuNhap (
	sopn NVARCHAR(10) NOT NULL,
	ngaylap DATE,
	makh NVARCHAR(10),
	kho NVARCHAR(10)
);

CREATE TABLE ctnhap (
	sopn NVARCHAR(10) NOT NULL,
	msmh NVARCHAR(10) NOT NULL,
	soluong int
);

ALTER TABLE MatHang
ADD CONSTRAINT PK_MatHang PRIMARY KEY(msmh);

ALTER TABLE KhachHang
ADD CONSTRAINT PK_KhachHang PRIMARY KEY(makh);

ALTER TABLE PhieuNhap
ADD CONSTRAINT PK_PhieuNhap PRIMARY KEY(sopn);

ALTER TABLE CTnhap
ADD CONSTRAINT PK_ctnhap PRIMARY KEY(sopn, msmh);


ALTER TABLE PhieuNhap
ADD CONSTRAINT FK_phieuNhap_khachHang FOREIGN KEY(makh) REFERENCES KhachHang(makh);

ALTER TABLE ctnhap
ADD CONSTRAINT FK_ctnhap_phieuNhap FOREIGN KEY(sopn) REFERENCES phieuNhap(sopn);

ALTER TABLE ctnhap
ADD CONSTRAINT FK_ctnhap_mathang FOREIGN KEY(msmh) REFERENCES MatHang(msmh);


INSERT INTO MatHang VALUES('H01', N'Kẹo', 2000, N'Hộp');
INSERT INTO MatHang VALUES('H02', N'Bánh', 3500, N'Chiếc');

INSERT INTO KhachHang VALUES('K01', N'Lê Tùng Lâm', 'HN');
INSERT INTO KhachHang VALUES('K02', N'Nguyễn Tuấn Tú', 'Hải Phòng');


INSERT INTO PhieuNhap VALUES('P01', '3-2-2022', 'K02', 'HN');
INSERT INTO PhieuNhap VALUES('P02', '5-3-2021', 'K01', 'Hải Phòng');

INSERT INTO ctnhap VALUES('P01', 'H02', '200');
INSERT INTO ctnhap VALUES('P01', 'H01', '100');
INSERT INTO ctnhap VALUES('P02', 'H01', '150');


SELECT * FROM MatHang;
SELECT * FROM KhachHang;
SELECT * FROM PhieuNhap;
SELECT * FROM ctnhap;

-- c1:

SELECT makh, ngaylap, kho, dongia * soluong AS 'Thành tiền'  FROM ctnhap
INNER JOIN PhieuNhap ON PhieuNhap.sopn = ctnhap.sopn
INNER JOIN MatHang ON MatHang.msmh = ctnhap.msmh
WHERE dongia * soluong <= 1000000;

-- c2:

SELECT tenhang, SUM(soluong) FROM ctnhap
INNER JOIN PhieuNhap ON PhieuNhap.sopn = ctnhap.sopn
INNER JOIN MatHang ON MatHang.msmh = ctnhap.msmh
WHERE YEAR(ngaylap) = 2006
GROUP BY tenhang


-- c4:

SELECT MatHang.msmh,tenhang, SUM(dongia * soluong) AS 'Tổng tiền' FROM ctnhap
INNER JOIN MatHang ON MatHang.msmh = ctnhap.msmh
GROUP BY MatHang.msmh, tenhang;


-- c5:

SELECT TOP 1 MatHang.msmh,tenhang, SUM(dongia * soluong) AS 'Tổng tiền' FROM ctnhap
INNER JOIN MatHang ON MatHang.msmh = ctnhap.msmh
GROUP BY MatHang.msmh, tenhang
ORDER BY SUM(dongia * soluong) DESC;


--c6:

DELETE FROM MatHang
WHERE msmh NOT IN (SELECT msmh FROM ctnhap);

--c7:

UPDATE KhachHang
SET diachi = N'Hà Nội'
WHERE tenkh = N'Lê Bình Huy'


-- c8:

SELECT tenhang, tenkh, ngaylap FROM ctnhap
INNER JOIN PhieuNhap ON PhieuNhap.sopn = ctnhap.sopn
INNER JOIN MatHang ON MatHang.msmh = ctnhap.msmh
INNER JOIN KhachHang ON KhachHang.makh = PhieuNhap.makh
WHERE kho = '7' AND dongia > 50000;
