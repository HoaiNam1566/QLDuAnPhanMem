using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace WebsiteBanHangQuanAoNam.Models;

[Table("HOADON")]
public partial class Hoadon
{
    [Key]
    [Column("MaHD")]
    public int MaHd { get; set; }

    [Column(TypeName = "datetime")]
    [Display(Name = "Ngày")]
    public DateTime? Ngay { get; set; }
    [Display(Name = "Tổng Tiền")]
    public int? TongTien { get; set; }
    
    [Column("MaKH")]
    [Display(Name = "Mã Khách")]
    public int MaKh { get; set; }
    [Display(Name = "Trạng Thái")]
    public int? TrangThai { get; set; }

    [InverseProperty("MaHdNavigation")]
    public virtual ICollection<Cthoadon> Cthoadons { get; set; } = new List<Cthoadon>();

    [ForeignKey("MaKh")]
    [InverseProperty("Hoadons")]
    public virtual Khachhang MaKhNavigation { get; set; } = null!;
}
