Use Master
GO
    IF exists(Select name From sys.databases Where name='WebBanHangQuanAoNam' )
    DROP Database WebBanHangQuanAoNam
GO
    Create Database WebBanHangQuanAoNam
GO

USE WebBanHangQuanAoNam;

CREATE TABLE CUAHANG(
	MaCH int primary key identity(1,1),
	Ten nvarchar(100) not null,
	DienThoai varchar(20),
	DiaChi nvarchar(100)
) 
GO

CREATE TABLE DANHMUC(
	MaDM int primary key identity(1,1),
	Ten nvarchar(100) not null
) 
GO

CREATE TABLE MATHANG(
	MaMH int primary key identity(1,1),
	Ten nvarchar(100) not null,
	GiaGoc int default 0,
	GiaBan int default 0,
	SoLuong smallint default 0,
	MoTa nvarchar(1000),
	HinhAnh varchar(255),
	MaDM int not null foreign key(MaDM) references DANHMUC(MaDM),
	LuotXem int default 0,
	LuotMua int default 0
) 
GO

CREATE TABLE CHUCVU(
	MaCV int primary key identity(1,1),
	Ten nvarchar(100) not null,
	HeSo float default 1.0
) 
GO

CREATE TABLE NHANVIEN(
	MaNV int primary key identity(1,1),
	Ten nvarchar(100) not null,
	MaCV int not null foreign key(MaCV) references CHUCVU(MaCV),
	DienThoai varchar(20),
	Email varchar(50),
	MatKhau varchar(255)	
) 
GO

CREATE TABLE KHACHHANG(
	MaKH int primary key identity(1,1),
	Ten nvarchar(100) not null,
	DienThoai varchar(20),
	Email varchar(50),
	MatKhau varchar(255)
) 
GO

CREATE TABLE DIACHI(	
	MaDC int primary key identity(1,1),
	MaKH int not null foreign key(MaKH) references KHACHHANG(MaKH),
	DiaChi nvarchar(100) not null,
	PhuongXa varchar(20) default N'Đông Xuyên',
	QuanHuyen varchar(50) default N'TP. Long Xuyên',
	TinhThanh varchar(50) default N'An Giang',
	MacDinh int default 1	
) 
GO

CREATE TABLE HOADON(
	MaHD int primary key identity(1,1),
	Ngay datetime default getdate(),
	TongTien int default 0,
	MaKH int not null foreign key(MaKH) references KHACHHANG(MaKH),
	TrangThai int default 0
) 
GO

CREATE TABLE CTHOADON(
	MaCTHD int primary key identity(1,1),
	MaHD int not null foreign key(MaHD) references HOADON(MaHD),	
	MaMH int not null foreign key(MaMH) references MATHANG(MaMH),
	DonGia int default 0,
	SoLuong smallint default 1,
	ThanhTien int
) 
GO

-- Dữ liệu bảng CUA_HANG
INSERT INTO CUAHANG(Ten, DienThoai, DiaChi) VALUES(N'Cửa hàng văn phòng phẩm ABC','0296-3841190',N'18 Ung Văn Khiêm, P Đông Xuyên, TP Long Xuyên, An Giang');

-- Dữ liệu bảng LOAI_HANG
INSERT INTO DANHMUC(Ten) VALUES(N'Quần');
INSERT INTO DANHMUC(Ten) VALUES(N'Áo');
INSERT INTO DANHMUC(Ten) VALUES(N'Áo Khoác');
INSERT INTO DANHMUC(Ten) VALUES(N'Sơ Mi');

-- Dữ liệu bảng MAT_HANG
-- Dữ liệu bảng MAT_HANG với 13 mặt hàng quần áo
INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Thun polo Basic Trắng Cotton', N'Chất liệu cotton 100% thấm hút tốt, thiết kế cổ tròn đơn giản phù hợp với mọi dịp.', 150000, 135000, 50, 'at4.jpg', 2, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Thun Oversize Đen', N'Form rộng thoải mái, chất liệu vải dày dặn, phù hợp phong cách đường phố.', 180000, 162000, 40, 'at6.jpg', 2, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Thun Tay Lỡ In Hình', N'Áo thun tay lỡ với họa tiết in hình độc đáo, trẻ trung, phù hợp với giới trẻ.', 200000, 180000, 35, 'at2.jpg', 2, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Thun Polo Đen', N'Áo polo cổ bẻ lịch sự, vải cotton co giãn 4 chiều mang lại sự thoải mái.', 250000, 225000, 30, 'at3.jpg', 2, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Thun Xám In Hình Đẹp', N'Mẫu áo thun trơn cổ tròn, vải mềm mại và không xù lông sau khi giặt.', 160000, 144000, 45, 'a5.jpg', 2, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Thun Tay Dài Màu Xám', N'Áo thun dài tay phù hợp cho mùa thu, chất liệu vải dày và ấm.', 190000, 171000, 25, 'at5.jpg', 2, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Quần vải Slimfit Màu Đen', N'Quần kaki nam form slimfit hiện đại, dễ phối đồ và sử dụng trong nhiều dịp.', 350000, 315000, 20, 'qd1.jpg', 1, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Quần vải ống suông', N'Quần jean co giãn nhẹ, thiết kế ống đứng, phù hợp cho mọi độ tuổi.', 400000, 360000, 15, 'qd2.jpg', 1, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Quần Short kaki đen', N'Quần short nam thời trang, chất liệu thun co giãn, thoáng mát.', 300000, 270000, 25, 'q1.jpg', 1, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Sơ Mi Trắng Oxford', N'Áo sơ mi trắng basic form slimfit, chất vải Oxford dày dặn và lịch sự.', 320000, 288000, 30, 'sm1.jpg', 4, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Khoác Jeans', N'Áo khoác bomber với chất liệu dù, chống gió tốt, phong cách cá tính.', 450000, 405000, 20, 'ak1.jpg', 3, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Khoác Hoodie Xanh navy', N'Áo khoác hoodie với lớp nỉ ấm áp, phù hợp cho mùa lạnh.', 400000, 360000, 25, 'ak3.jpg', 3, 0, 0);

INSERT INTO MATHANG(Ten, MoTa, GiaGoc, GiaBan, SoLuong, HinhAnh, MaDM, LuotXem, LuotMua) 
VALUES (N'Áo Khoác Cardigan Len', N'Áo khoác jeans chất liệu dày dặn, cổ điển và dễ phối đồ.', 500000, 450000, 15, 'ak1.jpg', 3, 0, 0);

-- Dữ liệu bảng CHUC_VU
INSERT INTO CHUCVU(Ten) VALUES(N'Quản lý');
INSERT INTO CHUCVU(Ten) VALUES(N'Nhân viên thu ngân');
INSERT INTO CHUCVU(Ten) VALUES(N'Nhân viên kho');

-- Dữ liệu bảng NHANVIEN
--INSERT INTO NHANVIEN(Ten,MaCV,DienThoai,Email,MatKhau) VALUES(N'Nguyễn Phước Tân',1,'0909456789','nptan@abc.com','202cb962ac59075b964b07152d234b70');
--INSERT INTO NHANVIEN(Ten,MaCV,DienThoai,Email,MatKhau) VALUES(N'Dương Thị Mỹ Thuận',2,'0988778899','dtmthuan@abc.com','202cb962ac59075b964b07152d234b70');
--INSERT INTO NHANVIEN(Ten,MaCV,DienThoai,Email,MatKhau) VALUES(N'Trần Huỳnh Sơn',3,'0903123123','thson@abc.com','202cb962ac59075b964b07152d234b70');
--INSERT INTO NHANVIEN(Ten,MaCV,DienThoai,Email,MatKhau) VALUES(N'Lê Ngọc Thanh',2,'0913454544','lnthanh@abc.com','202cb962ac59075b964b07152d234b70');

-- Dữ liệu bảng KHACHHANG
--INSERT INTO KHACHHANG(Ten,DienThoai,Email,MatKhau) VALUES(N'','','','');

-- Dữ liệu bảng DIACHI
--INSERT INTO DIACHI(MaKH,DiaChi,PhuongXa,QuanHuyen,TinhThanh,MacDinh) VALUES(1,N'',N'',N'',N'',1);

-- Dữ liệu bảng HOADON
--INSERT INTO HOADON(TongTien,MaKH,TrangThai) VALUES(70000,1,0);


-- Dữ liệu bảng CTHOA_DON
--INSERT INTO CTHOADON(MaHD,MaMH,DonGia,SoLuong,ThanhTien) VALUES(1,2,23000,1,23000);

GO

SELECT * FROM DANHMUC;
SELECT * FROM MATHANG;