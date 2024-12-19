using Microsoft.AspNetCore.Identity;
using WebsiteBanHangQuanAoNam.Data;
using WebsiteBanHangQuanAoNam.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddDbContext<ApplicationDbContext>();
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(option =>
{
	option.Cookie.Name = "ABC";
	option.IdleTimeout = TimeSpan.FromMinutes(30);
});
builder.Services.AddSingleton<IPasswordHasher<Khachhang>, PasswordHasher<Khachhang>>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseSession();
app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
	name: "default",
	pattern: "{controller=Cusomer}/{action=Index}/{id?}");

app.Run();
