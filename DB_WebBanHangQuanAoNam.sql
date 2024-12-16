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
INSERT INTO DANHMUC(Ten) VALUES(N'Sản phẩm điện tử');
INSERT INTO DANHMUC(Ten) VALUES(N'Dụng cụ văn phòng');
INSERT INTO DANHMUC(Ten) VALUES(N'Dụng cụ học sinh');
INSERT INTO DANHMUC(Ten) VALUES(N'Sản phẩm giấy');

-- Dữ liệu bảng MAT_HANG
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Máy Tính Văn Phòng Casio SX 100 - W-DP',N'Kích thước (Dài × Rộng × Dày) : 110,5 × 91 × 9,4 mm. Màn hình lớn dễ dàng đọc dữ liệu. Có 2 nguồn năng lượng: mặt trời & pin.',200000,180000,10,'m1.jpg',1,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Máy Tính Casio FX580VN X-PK (Màu Hồng)',N'Máy Tính Casio FX580VN X-PK (Màu Hồng) thuộc dòng máy tính khoa học ClassWiz, được hãng máy tính Casio Nhật Bản sản xuất dành riêng cho nền giáo dục Việt. Sản phẩm tích hợp tới 521 tính năng, trong đó có rất nhiều tính năng mà các dòng máy tính khoa học trên thị trường hiện nay không có được. Casio fx-580VN X được phép đưa vào phòng thi. Tốc độ xử lý nhanh gấp 4 lần, giảm thời gian tính toán xuống mức tối thiểu ',757000,681000,20,'m2.jpg',1,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Máy Tính CASIO FX-880BTG (Màu Xanh Biển)',N'Máy tính Casio fx-880BTG thuộc dòng máy tính khoa học ClassWiz của hãng máy tính CASIO. Máy tính Casio fx-880BTG đã ra đời với nhiều cải tiến về: thiết kế - giao diện, tính năng nổi trội và độ chính xác cao… để đáp ứng thực tiễn dạy và học tại Việt Nam, đồng thời thay đổi tư duy học tập lâu nay của học sinh.',820000,738000,20,'m3.jpg',1,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Máy Tính Khoa Học Thiên Long Flexio Fx680VN Plus (Màu Trắng)',N'Máy tính có thiết kế hiện đại, cá tính. Máy mỏng nhẹ với chất liệu bền bỉ, phím bấm có độ chống mòn và mờ cao. Dàn phím được bố trí khoa học và thuận tiện cho các thao tác trên máy tính. Độ bền phím bấm lên tới 500.000 lần. Có tính năng thông báo pin yếu.',635000,571000,30,'m4.jpg',1,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Kệ Nhựa 3 Tầng - King Star - Màu Xanh Dương',N'Màu sắc trang nhã. Khay thiết kế 3 tầng tiện dụng. Thao tác lắp đặt, tháo rời đơn giản, dễ dàng. Bề mặt có các khe hở, tránh ẩm mốc. Khay đựng tài liệu 3 tầng thường được dùng trong các văn phòng công sở, trường học để cất giữ, bảo quản, phân loại các giấy tờ, tài liệu quan trọng.',178000,1000,25,'v1.jpg',2,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Bìa Trình Ký Đôi Toppoint A4 TOP-134A - Xanh Lá',N'Sản phẩm được làm từ chất liệu nhựa cứng PP cao cấp. Thanh kẹp cũng được thiết kế bằng chất liệu có độ bền cao. Sản phẩm có kích thước phù hợp với khổ giấy A4. Giấy được gọng sắt giữ lại, không lo giấy bị bay hoặc thất lạc khi chờ ký. Gọng sắt bền, không bị gãy khi sử dụng quá nhiều.',52000,46800,50,'v2.jpg',2,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Khay Cắm Bút Flexoffice FO-PS01',N'Sản phẩm làm bằng nhựa cao cấp, thân thiện với môi trường, an toàn khi sử dụng. Có nhiều ngăn để đựng bút viết. Thiết kế trong suốt hiện đại, đơn giản nhưng tinh tế với kiểu dáng nhỏ gọn tiện dụng',60000,54000,30,'v3.jpg',2,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Cắm Bút Moshi 016',N'Sản phẩm làm bằng nhựa cao cấp, màu sắc đẹp và bắt mắt. Sản phẩm được thiết kế với kiểu dáng đơn giản, kích thước nhỏ gọn không chiếm nhiều diện tích. Sản phẩm giúp cho việc sắp xếp các đồ dùng nơi bàn làm việc trở nên gọn gàng, ngăn nắp.',60000,54000,30,'v4.jpg',2,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Bìa Còng 5P F4 Kokuyo 285B - Màu Xanh',N'Có thiết kế khổ F4 đáp ứng tốt việc lưu trữ số lượng lớn tài liệu và giấy tờ quan trọng. Có thể lưu trữ tài liệu thuộc nhiều kích cỡ, phù hợp với hầu hết các loại giấy tờ. Áp dụng công nghệ tiên tiến của Nhật Bản trong sản xuất đảm bảo chất lượng sản phẩm. Chất liệu bìa bằng simili cao cấp, phủ màng OPP với ưu điểm bền chắc, không bám bụi và tránh được nhiều trường hợp cong vênh trong quá trình sử dụng.',85000,765000,10,'v5.jpg',2,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Hộp 24 Kẹp Bướm Màu 41mm - Hồng Hà 6642',N'Sản xuất từ chất liệu kim loại cao cấp, được phủ Niken chống gỉ giúp kẹp bướm luôn bền đẹp theo thời gian. Phần lò xo của kẹp linh hoạt, nhẹ, dễ dùng, không bị lỏng hay bung rời sau nhiều lần sử dụng. Tay cầm chắc chắn, vừa vặn tạo cảm giác thoải mái khi sử dụng. Đa dạng đủ mọi kích cỡ từ 15 - 51 mm phù hợp với mọi nhu cầu. Có 4 màu tươi sáng, hợp xu hướng giúp bàn làm việc nhiều màu sắc, khơi gợi cảm hứng và sáng tạo.',83000,74700,20,'v6.jpg',2,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Máy Bấm Giá Hand MX5500 - Màu Xanh',N'Sản phẩm là dụng cụ tiện lợi dùng để bấm giá đồng loạt các sản phẩm một cách nhanh chóng. Cấu tạo máy bấm đơn giản, giúp bạn dễ dàng bấm in giá và điều chỉnh giá theo ý muốn. Sản phẩm được làm bằng chất liệu nhựa chắc chắn, kháng vỡ, cho lực bấm nhẹ, thao tác nhanh chóng và dễ dàng hơn. Thiết kế sản phẩm nhỏ gọn, tiện lợi.',205000,184500,20,'v7.jpg',2,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Bộ Compa 8 Món - Bút Chì Kim - Yalong 19020',N'Compass được làm từ kim loại cứng cáp, không gỉ sét, độ bền cao. Sản phẩm có thiết kế chắc chắn, dễ sử dụng, giúp bạn vẽ hình đẹp và chuẩn xác. Đầu nhọn của một bên chân compass có lực cố định vừa phải, giúp compass đứng vững trên giấy khi quay. Bộ sản phẩm được đựng trong hộp thiếc chắc chắn, chất liệu cứng cáp, dễ dàng cất giữ và bảo quản. Bộ sản phẩm gồm: 2 compass, 1 chì gỗ, 1 gọt bút chì, 1 gôm, 1 thước kẻ 15 cm, 1 thước đo độ và 2 thước eke.',53000,53000,20,'h1.jpg',3,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Bóp Viết Vải Polyester Stacom 2 Ngăn Hình Hoa Cúc PB-2011C - Màu Xanh Mint',N'Sản phẩm được làm bằng chất liệu vải Polyester chống thấm nước và dễ dàng tẩy rửa khi bị bẩn, bền đẹp dùng để sắp xếp các vật dụng, thuận tiện mang đi mọi lúc mọi nơi. Kích thước nhỏ gọn với hình dáng chữ nhật cùng họa tiết dễ thương. Thiết kế dây khóa kéo chắc chắn, trơn tru, đóng mở dễ dàng, thuận tiện khi sử dụng, độ bền cao. Sản phẩm có 2 ngăn, đủ để chứa tất cả những đồ dùng học tập cần thiết.',70000,63000,20,'h2.jpg',3,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Bộ 2 Hộp Thực Hành Toán Và Tiếng Việt Lớp 1',N'Chất liệu: Nhựa. Số Lượng/Bộ: 2. Trọng lượng (gr): 1100. Kích Thước Bao Bì: 25.5 x 18.5 x 8.5 cm',240000,216000,20,'h3.jpg',3,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Bảng Bộ 2 Mặt A4 - Queen BS-02 - Viền Cam',N'Sản phẩm bao gồm 1 bảng 2 mặt (1 mặt viết phấn, 1 mặt viết lông bảng) và 01 bút lông bảng có sẵn đồ bôi chuyên dành cho học sinh. Mặt viết phấn mịn và bám phấn giúp viết rõ nét, chữ viết đẹp. Mặt viết lông bảng màu trắng, mặt trơn dễ viết, dễ xóa. Bảng có kích thước A4 nhỏ gọn, tiện lợi.',54000,48600,20,'h4.jpg',3,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Bộ Lắp Ghép Mô Hình Kỹ Thuật (Lớp 4, Lớp 5)',N'Bộ Lắp Ghép Mô Hình Kỹ Thuật là sản phẩm vô cùng tiện lợi, giúp các bé phát triển tư duy một cách tự nhiên nhất theo phương pháp vừa học vừa chơi. Bộ dụng cụ có màu sắc đa dạng, tạo sự hứng cho người dùng. Ngoài ra còn được làm bằng chất liệu an toàn, thiết kế dễ dàng tháo ráp và sử dụng.',92000,82800,20,'h5.jpg',3,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Thước Bộ Eke - Keyroad KR971430',N'Thước bộ eke là dụng cụ học tập phổ biến, được sử dụng ngay từ cấp tiểu học. Bộ thước gồm: 1 thước thẳng 15cm, 1 thước đo độ, 2 thước eke. Sản phẩm được làm bằng chất liệu nhựa cứng siêu bền, thân trong, in dãy vạch số chính xác và sắc nét. Túi đựng bộ thước tiện dụng xinh xắn, gọn nhẹ, dễ dàng cất vào cặp. Chất liệu nhựa dẻo chất lượng tốt, trong suốt, thẳng, độ bền cao, không tróc chữ số và đặc biệt có thể bẻ cong thoải mái mà không gãy.',19000,19000,30,'h6.jpg',3,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Giấy Photo A4 70gsm - IK Plus (500 Tờ)',N'Giấy in A4 của thương hiệu IK Plus được sản xuất từ những nguyên liệu sợi cây cao cấp với quy trình sản xuất theo công nghệ hiện đại và tiên tiến, không chứa chất gây độc hại và mùi khó chịu. Được nhập khẩu từ Indonesia đạt tiêu chuẩn ISO 9001 và ISO 14001, nên độ ổn định của giấy luôn đảm bảo chất lượng và uy tín cho người tiêu dùng. Giấy không bị bụi, giúp bảo vệ sức khỏe người sử dụng,thân thiện với môi trường.',84000,75600,50,'g1.jpg',4,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Giấy photo Double A A4/80 gsm',N'Giấy photo Double A A4/80 gsm với kích thước A4, thân thiện với môi trường và thích hợp với hầu hết các loại máy in phun, máy in laser, máy fax laser, máy photocopy. Sản phẩm thiết kế khổ giấy A4, thích hợp sử dụng làm giấy in, photo trong các văn phòng hoặc trong gia đình. Giấy có bề dày tốt, bề mặt láng mịn, độ cản quang của giấy cao hơn do đó giảm hiện tượng nhìn thấu trang và cho phép sử dụng cả hai mặt giấy một cách toàn diện nhất. Chất liệu giấy an toàn, không chứa chất gây độc hại và mùi khó chịu, thân thiện với môi trường.',108000,97200,50,'g2.jpg',4,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Tập Doraemon Fly - A5 5 Ô Ly 96 Trang ĐL 120g/m2 - Campus NB-ADFL96 (Màu Ngẫu Nhiên)',N'Chất liệu: Giấy ngoại nhập chất lượng cao, bề mặt giấy trơn láng, viết đẹp, mượt mà. Định lượng: 120g/m2. Đặc biệt, tập 5 ô ly Doraemon Fly của Campus đã được cải tiến hoàn toàn mới với giấy tập đảm bảo 100% không lem cùng bìa tập trắng sáng hơn, dày hơn. Thiết kế bìa vở trẻ trung, bắt mắt và là thiết kế độc quyền của Campus. Hệ thống đánh dấu bằng số thông minh cùng dòng kẻ (5 ô ly 2 x 2mm) in chính xác, rõ nét.',27000,27000,50,'g3.jpg',4,0,0);
INSERT INTO MATHANG(Ten,MoTa,GiaGoc,GiaBan,SoLuong,HinhAnh,MaDM,LuotXem,LuotMua) VALUES(N'Sổ Diary Icon The Sun',N'Sản phẩm sử dụng loại giấy láng, mịn, không lóa mắt, phù hợp để viết và vẽ rất dễ dàng. Sổ được sử dụng lò xo chắc chắn còn giúp bạn dễ dàng lật mở, gập sổ tiết kiệm không gian dễ dàng trong ghi chú, tốc ký. Giấy sổ là loại giấy chất lượng cao, độ bền cao, bề mặt giấy mềm mượt, viết êm, không thấm mực và không dễ quăn hay rách, nhàu. Cuốn sổ thích hợp dùng cho học sinh, sinh viên, nhân viên văn phòng.',39000,35100,50,'g4.jpg',4,0,0);

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