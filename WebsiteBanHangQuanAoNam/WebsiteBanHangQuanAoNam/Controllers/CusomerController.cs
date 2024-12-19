using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages;
using Newtonsoft.Json;
using WebsiteBanHangQuanAoNam.Data;
using WebsiteBanHangQuanAoNam.Models;

namespace WebsiteBanHangQuanAoNam.Controllers
{
    public class CusomerController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly IPasswordHasher<Khachhang> _passwordHasher;

        public CusomerController(ApplicationDbContext context, IPasswordHasher<Khachhang> passwordHasher)
        {
            _context = context;
            _passwordHasher = passwordHasher;

        }

        public void GetData()
        {
            ViewData["SoLuong"] = LayGioHang().Count;
            ViewBag.danhmuc = _context.Danhmucs.ToList();

            if (HttpContext.Session.GetString("khachhang") != "")
            {
                ViewBag.khachHang = _context.Khachhangs.FirstOrDefault(k => k.Email == HttpContext.Session.GetString("khachhang"));
            }

        }
        public IActionResult dangNhap()
        {
            GetData();
            return View();
        }

        public IActionResult dangXuat()
        {
            HttpContext.Session.SetString("khachhang", "");
            GetData();
            return RedirectToAction("Index");
        }

        [HttpPost]
        public async Task<IActionResult>dangNhap(string email, string matKhau)
        {
            var khachHang = await _context.Khachhangs
                .FirstOrDefaultAsync(m=>m.Email == email);
            if(khachHang != null && _passwordHasher.VerifyHashedPassword(khachHang, khachHang.MatKhau, matKhau) == PasswordVerificationResult.Success)
            {
                HttpContext.Session.SetString("khachhang",khachHang.Email);
                return RedirectToAction(nameof(hoSoKhachHang));
            }
            return RedirectToAction(nameof(dangNhap));
        }

        public IActionResult hoSoKhachHang()
        {
            GetData();
            return View();
        }

        public IActionResult dangKy()
        {
            GetData();
            return View();
        }

        public IActionResult dangNhapThatBai()
        {
            GetData();
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> dangKy(string hoten, string dienthoai, string email, string matkhau)
        {
            Khachhang kh = new Khachhang();
            kh.Ten = hoten;
            kh.DienThoai = dienthoai;
            kh.Email = email;
            kh.MatKhau = _passwordHasher.HashPassword(kh, matkhau); // mã hóa mật khẩu

            if (ModelState.IsValid)
            {
                _context.Add(kh);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(dangNhap));

            }
            else
            {
                return RedirectToAction(nameof(dangNhapThatBai));
            }
        }


        // GET: Cusomer
        public async Task<IActionResult> Index()
        {
            var applicationDbContext = _context.Mathangs.Include(m => m.MaDmNavigation);
            GetData();
            return View(await applicationDbContext.ToListAsync());
        }

        public async Task<IActionResult> laySPThuocDM(int id)
        {
            var MatHang = _context.Mathangs
            .Where(m => m.MaDm == id)
            .Include(m => m.MaDmNavigation);
            ViewBag.tendanhmuc = _context.Danhmucs.FirstOrDefault(d => d.MaDm == id).Ten;
            GetData();
            return View(await MatHang.ToArrayAsync());
        }

        // GET: Cusomer/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var mathang = await _context.Mathangs
                .Include(m => m.MaDmNavigation)
                .FirstOrDefaultAsync(m => m.MaMh == id);
            if (mathang == null)
            {
                return NotFound();
            }
            GetData();
            return View(mathang);
        }
     

        // Doc danh sach gio hang tu session
        public List<GioHang> LayGioHang()
        {
            var session = HttpContext.Session;
            string? jsonGioHang = session.GetString("shopcart");
            if (jsonGioHang != null)
            {
                var gioHangItems = JsonConvert.DeserializeObject<List<GioHang>>(jsonGioHang);
                return gioHangItems ?? new List<GioHang>();
            }
            return new List<GioHang>();
        }

        // luu danh sach cac thanh phan trong gio hang vao session
        public void luuGioHangVaoSession(List<GioHang> list)
        {
            var session = HttpContext.Session;
            string jsonGioHang = JsonConvert.SerializeObject(list);
            session.SetString("shopcart", jsonGioHang);
        }

        // xoa session gio hang
        public void xoaGioHang()
        {
            var session = HttpContext.Session;
            session.Remove("shopcart");
        }

        // them mon hang vao gio hang
        public async Task<IActionResult> themSanPhamVaoGioHang(int id)
        {
            var mathang = await _context.Mathangs
                .FirstOrDefaultAsync(m => m.MaMh == id);
            if (mathang == null)
            {
                return NotFound("Sản phẩm không tồn tại");
            }
            var cart = LayGioHang();
            var item = cart.Find(p => p.MatHang.MaMh == id);
            if (item != null)
            {
                item.SoLuong++;
            }
            else
            {
                cart.Add(new GioHang() { MatHang = mathang, SoLuong = 1 });
            }
            luuGioHangVaoSession(cart);
            GetData();
            return RedirectToAction(nameof(ViewCart));
        }

        // chuyen den trang gio hang
        public IActionResult ViewCart()
        {
            GetData();
            return View(LayGioHang());
        }

        // xoa mat hang trong gio
        public IActionResult xoaMatHangTrongGio(int id)
        {
            var cart = LayGioHang();
            var item = cart.Find(p => p.MatHang.MaMh == id);
            if (item != null)
            {
                cart.Remove(item);
            }
            luuGioHangVaoSession(cart);
            GetData();
            return RedirectToAction(nameof(ViewCart));
        }

        // Cập nhật số lượng một mặt hàng trong giỏ 
        public IActionResult capNhatGioHang(int id, int soLuong)
        {
            var cart = LayGioHang();
            var item = cart.Find(m => m.MatHang.MaMh == id);
            if (item != null)
            {
                item.SoLuong = soLuong;
            }
            luuGioHangVaoSession(cart);
            GetData();
            return RedirectToAction(nameof(ViewCart));

        }

        // ham lay tat ca mat hang co trong gio
        public int soLuongMatHang()
        {
            var cart = LayGioHang();
            return cart.Sum(i => i.SoLuong);
        }

        public IActionResult CheckOut()
        {
            GetData();
            return View(LayGioHang());
        }

        public IActionResult GioiThieu()
        {
            GetData();
            return View();
        }

        [HttpPost, ActionName("CreateBill")]
        public async Task<IActionResult> CreateBill(string email, string hoten, string dienthoai, string diachi)
        {
            // Xử lý thông tin khách hàng (trường hợp khách mới)
            var kh = new Khachhang();
            kh.Email = email;
            kh.Ten = hoten;
            kh.DienThoai = dienthoai;
            _context.Add(kh);
            await _context.SaveChangesAsync();

            var hd = new Hoadon();
            hd.Ngay = DateTime.Now;
            hd.MaKh = kh.MaKh;

            _context.Add(hd);
            await _context.SaveChangesAsync();

            // thêm chi tiết hóa đơn
            var cart = LayGioHang();

            int thanhtien = 0;
            int tongtien = 0;
            foreach (var i in cart)
            {
                var ct = new Cthoadon();
                ct.MaHd = hd.MaHd;
                ct.MaMh = i.MatHang.MaMh;
                thanhtien = i.MatHang.GiaBan * i.SoLuong ?? 1;
                tongtien += thanhtien;
                ct.DonGia = i.MatHang.GiaBan;
                ct.SoLuong = (short)i.SoLuong;
                ct.ThanhTien = thanhtien;
                _context.Add(ct);
            }
            await _context.SaveChangesAsync();

            // cập nhật tổng tiền hóa đơn
            hd.TongTien = tongtien;
            _context.Update(hd);
            await _context.SaveChangesAsync();

            // xóa giỏ hàng
            xoaGioHang();
            GetData();
            return View(hd);
        }


    }
}
