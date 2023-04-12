---------------------------CHỈ MỤC------------------------------


-- CHỈ MỤC NHẰM TĂNG TỐC ĐỘ TÌM KIẾM TRÊN CÁC BẢNG DỮ LIỆU RẤT LỚN (HÀNG TRIỆU BẢN GHI)
--> ĐÁNH CHỈ MỤC CHO CÁC CỘT THƯỜNG XUYÊN ĐƯỢC TÌM KIẾM
--> SẮP XẾP CÁC HÀNG THEO THỨC TỰ


-- ƯU ĐIỂM CỦA CHỈ MỤC:
--1. TĂNG TỐC ĐỘ TÌM KIẾM CỦA CÁC CÂU LỆNH SELECT, ORDER BY, GROUP BY
--2. TỐI ƯU CHO CÁC BẢNG CÓ SỐ LƯỢNG BẲNG GHI RẤT LỚN (HÀNG TRIỆU)



-- NHƯỢC ĐIỂM
--1. NÓ CHỈ NÊN ĐƯỢC SỬ DỤNG VỚI CÁC BẢNG IT ĐƯỢC INSERT/UPDATE/DELETE
--> NẾU INSERT/UPDATE/DELETE THƯỜNG XUYÊN SẼ GÂY RA CHẬM (VÌ NÓ PHẢI INSERT/UPDATE/DELETE LUÔN VÀO BẢNG INDEX)

--2. KHÔNG NÊN SỬ DỤNG CỚI CÁC BĂNG THƯỜNG CÓ SỰ THAY ĐỔI.
-- VD: BẢNG HOADON TRONG QUẢN LÝ BÁN HÀNG -> BĂNG HOADON THƯỜNG ĐƯỢC INSERT/UPDATE/DELETE




---------------------------CÂU LỆNH----------------------------------

SELECT * FROM SinhVien;

--1. SINGLE COLUMN INDEX: CHỈ MỤC ĐƠN CỘT
CREATE INDEX INDEX_masv ON SinhVien(maSV);


--2. UNIQue INDEX: CHỈ MỤC DUY NHÂT
CREATE UNIQUE INDEX INDEX_maSv2 ON sinhVien(maSv);


--3. COMPOSITIVE INDEX: CHỈ MỤC PHỨC HỢP - 2/ NHIỀU CỘT TẠO THÀNH 1 INDEX
CREATE INDEX INDEX_maSv3 ON SinhVien(maSV, hoten);


--4. IMPLICIT INDEX: CHỈ MỤC CÓ SẴN KHI TẠO BẲNG, ĐÓ LÀ PRIMARY KEY, UNIQUE
