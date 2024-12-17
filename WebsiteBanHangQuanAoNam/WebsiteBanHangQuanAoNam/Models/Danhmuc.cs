﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace WebsiteBanHangQuanAoNam.Models;

[Table("DANHMUC")]
public partial class Danhmuc
{
    [Key]
    [Column("MaDM")]
    public int MaDm { get; set; }

    [StringLength(100)]
    [Display(Name = "Danh Mục")]
    public string Ten { get; set; } = null!;

    [InverseProperty("MaDmNavigation")]
    public virtual ICollection<Mathang> Mathangs { get; set; } = new List<Mathang>();
}
