SELECT * FROM KhachHang;
SELECT * FROM DonHang;
SELECT * FROM Sach;

-- C1:Chèn thêm một bản ghi vào Bảng: Sach

INSERT INTO Sach VALUES('S04', N'Tiếng Anh', 500000, N'Còn sách');





-- C2:Chèn thêm một bản ghi vào Bảng: DonHang

INSERT INTO DonHang VALUES('001', 'KH2', 'S04', 15);




-- C3:Cập nhật TaiKhoan khách hàng KH3 là: '00000001'




UPDATE KhachHang
SET taiKhoan = '00000001'
WHERE maKH = 'KH3';




-- C4:Xóa khỏi bảng đơn hàng các mặt hàng có số lượng bán < 10

DELETE FROM DonHang
WHERE soLuong < 10;




-- C5:Xóa khỏi bảng sách các quyển sách có số lượng bán > 10

DELETE FROM Sach
WHERE mas IN(SELECT maS FROM DonHang WHERE soLuong > 10);




--C6:Cập nhật ghi chu ở bảng sách thành 'gần hết với những quyển sách có số lượng <= 10'

UPDATE Sach
SET ghiChu = N'Gần hết'
WHERE maS IN(SELECT maS FROM DonHang WHERE soLuong <= 10);




--C7:Đưa thông tin quyển sách có số lượng nhỏ nhất


-- Cách 1:
SELECT * FROM Sach
WHERE maS = (SELECT TOP 1 maS FROM DonHang ORDER BY soLuong);

-- Cách 2:
SELECT TOP 1 Sach.* FROM DonHang
INNER JOIN Sach ON DonHang.maS = Sach.maS
ORDER BY soLuong;




-- C8: Đưa ra maS, tenS, donGia, ghiChu của 2 quyển sách có số lượng lớn nhất

-- Cách 1:
SELECT maS, tieuDe, donGia, ghiChu FROM Sach
WHERE maS IN(SELECT TOP 2 maS FROM DonHang ORDER BY soLuong DESC);

-- Cách 2:
SELECT TOP 2 Sach.maS, tieuDe, donGia, ghiChu FROM Sach
INNER JOIN DonHang ON Sach.maS = DonHang.maS
ORDER BY soLuong DESC;




-- C9: Đưa ra thông tin quyển sách có số lượng lớn nhất

-- Cách 1:
SELECT * FROM Sach
WHERE maS = (SELECT TOP 1 maS FROM DonHang ORDER BY soLuong DESC);

-- Cách 2:
SELECT TOP 1 Sach.* FROM DonHang
INNER JOIN Sach ON DonHang.maS = Sach.maS
ORDER BY soLuong DESC;