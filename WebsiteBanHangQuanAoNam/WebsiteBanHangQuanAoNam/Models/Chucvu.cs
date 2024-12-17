using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace WebsiteBanHangQuanAoNam.Models;

[Table("CHUCVU")]
public partial class Chucvu
{
    [Key]
    [Column("MaCV")]
    [Display(Name = "Mã Chức Vụ")]
    public int MaCv { get; set; }

    [StringLength(100)]
    public string Ten { get; set; } = null!;
    [Display(Name = "Hệ Số ")]
    public double? HeSo { get; set; }

    [InverseProperty("MaCvNavigation")]
    public virtual ICollection<Nhanvien> Nhanviens { get; set; } = new List<Nhanvien>();
}
