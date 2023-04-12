-- CREATE TABLE student_2(
--	  id VARCHAR(25),
--	  ten VARCHAR(50),
--	  sinh_nhat DATE,
--	  nam_nhap_hoc INT
-- );

CREATE TABLE student_3 AS
SELECT id, ten, ngay_sinh
FROM student_1;