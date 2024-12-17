using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace WebsiteBanHangQuanAoNam.Models;

[Table("MATHANG")]
public partial class Mathang
{
    [Key]
    [Column("MaMH")]
    public int MaMh { get; set; }

    [StringLength(100)]
    [Display(Name = "Tên mặt hàng")]
    public string Ten { get; set; } = null!;

    [Display(Name = "Giá gốc")]
    public int? GiaGoc { get; set; }

    [Display(Name = "Giá bán")]
    public int? GiaBan { get; set; }

    [Display(Name = "Số lượng")]
    public short? SoLuong { get; set; }

    [Display(Name = "Mô tả")]
    [StringLength(1000)]
    public string? MoTa { get; set; }

    [Display(Name = "Ảnh")]
    [StringLength(255)]
    [Unicode(false)]
    public string? HinhAnh { get; set; }

    [Display(Name = "Danh mục")]
    [Column("MaDM")]
    public int MaDm { get; set; }

    [Display(Name = "Lượt xem")]
    public int? LuotXem { get; set; }

    [Display(Name = "Lượt mua")]
    public int? LuotMua { get; set; }

    [InverseProperty("MaMhNavigation")]
    public virtual ICollection<Cthoadon> Cthoadons { get; set; } = new List<Cthoadon>();

    [Display(Name = "Danh mục")]
    [ForeignKey("MaDm")]
    [InverseProperty("Mathangs")]
    public virtual Danhmuc MaDmNavigation { get; set; } = null!;
}
