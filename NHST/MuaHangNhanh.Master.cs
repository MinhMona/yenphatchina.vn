﻿using NHST.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace NHST
{
    public partial class MuaHangNhanh : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
                LoadMenu();
            }
        }
        public void LoadMenu()
        {
            string html = "";
            var categories = MenuController.GetByLevel(0);
            if (categories != null)
            {
                double animation = 0.1;
                foreach (var c in categories)
                {
                    html += " <li class=\"wow animate__bounce animated\" data-wow-delay=\"" + animation + "s\">";
                    if (Convert.ToBoolean(c.Target))
                        html += "<a target=\"_blank\" href=\"" + c.MenuLink + "\">" + c.MenuName + "</a>";
                    else
                        html += "<a href=\"" + c.MenuLink + "\">" + c.MenuName + "</a>";
                    html += "</li>";
                    animation = animation + 0.2;
                }
                ltrMenu.Text = html;
            }
        }
        public void LoadData()
        {
            var confi = ConfigurationController.GetByTop1();
            if (confi != null)
            {
                ltrCurrency.Text = "<p class=\"text-intro\">Tỷ giá: <span>" + string.Format("{0:N0}", Convert.ToDouble(confi.Currency)) + " VNĐ/NDT</span></p>";
                ltrHotline.Text = "<p class=\"text-intro\">Hotline: <span>" + confi.Hotline + "</span></p>";
                ltrLogo.Text = "<a href=\"/\"><img src=\"" + confi.LogoIMG + "\" alt=\"\"></a>";

                ltrAddHaNoi.Text = "<p>" + confi.Address + "</p>";
                ltrPhoneHaNoi.Text = "<p>" + confi.Hotline + "</p>";
                ltrEmailHaNoi.Text = "<p>" + confi.EmailContact + "</p>";

                //ltrAddHCM.Text = "<p>" + confi.Address3 + "</p>";
                //ltrPhoneHCM.Text = "<p>" + confi.HotlineSupport + "</p>";
                //ltrEmailHCM.Text = "<p>" + confi.EmailSupport + "</p>";

                //ltrZalo1.Text += "<li><a href=\"" + confi.ZaloLink + "\" target=\"_blank\"><img src=\"/App_Themes/CSSDAIAN/images/zalo.png\" alt=\"\"></a></li>";
                //ltrZalo2.Text += "<li><a href=\"" + confi.Twitter + "\" target=\"_blank\"><img src=\"/App_Themes/CSSDAIAN/images/zalo.png\" alt=\"\"></a></li>";
                //ltrZalo3.Text += "<li><a href=\"" + confi.GooglePlus + "\" target=\"_blank\"><img src=\"/App_Themes/CSSDAIAN/images/zalo.png\" alt=\"\"></a></li>";
                //ltrZalo4.Text += "<li><a href=\"" + confi.Instagram + "\" target=\"_blank\"><img src=\"/App_Themes/CSSDAIAN/images/zalo.png\" alt=\"\"></a></li>";
            }

            #region lấy meta
            HtmlHead objHeader = (HtmlHead)Page.Header;
            HtmlMeta meta = new HtmlMeta();
            meta = new HtmlMeta();
            meta.Attributes.Add("name", "description");
            meta.Content = confi.MetaDescription;
            objHeader.Controls.Add(meta);

            meta = new HtmlMeta();
            meta.Attributes.Add("name", "keyword");
            meta.Content = confi.MetaKeyword;
            objHeader.Controls.Add(meta);
            ltrSEO.Text += "<script>" + confi.GoogleAnalytics + "</script>";
            ltrSEO.Text += "<script>" + confi.WebmasterTools + "</script>";
            ltrHeaderSeo.Text += "<script>" + confi.HeaderScriptCode + "</script>";
            #endregion

            if (Session["userLoginSystem"] != null)
            {
                string username = Session["userLoginSystem"].ToString();
                var acc = AccountController.GetByUsername(username);
                if (acc != null)
                {
                    #region phần thông báo
                    decimal levelID = Convert.ToDecimal(acc.LevelID);
                    int levelID1 = Convert.ToInt32(acc.LevelID);
                    string level = "1 Vương Miện";
                    var userLevel = UserLevelController.GetByID(levelID1);
                    if (userLevel != null)
                    {
                        level = userLevel.LevelName;
                    }
                    string userIMG = "";
                    var ai = AccountInfoController.GetByUserID(acc.ID);
                    if (ai != null)
                    {
                        if (!string.IsNullOrEmpty(ai.IMGUser))
                            userIMG = ai.IMGUser;
                    }
                    decimal countLevel = UserLevelController.GetAll("").Count();
                    decimal te = levelID / countLevel;
                    te = Math.Round(te, 2, MidpointRounding.AwayFromZero);
                    decimal tile = te * 100;
                    #endregion

                    #region New
                    ltrLogin.Text += "<div class=\"acc-info\">";
                    ltrLogin.Text += "<a class=\"acc-info-btn\" href=\"/thong-tin-nguoi-dung\"><i class=\"icon fa fa-user\"></i><span>" + username + "</span></a>";
                    ltrLogin.Text += "<div class=\"status-desktop\">";
                    ltrLogin.Text += "<div class=\"status-wrap\">";
                    ltrLogin.Text += "<div class=\"status__header\">";
                    ltrLogin.Text += "<h4>" + level + "</h4>";
                    ltrLogin.Text += "</div>";
                    ltrLogin.Text += "<div class=\"status__body\">";
                    ltrLogin.Text += "<div class=\"level\">";
                    ltrLogin.Text += "<div class=\"level__info\">";
                    ltrLogin.Text += "<p>Level</p>";
                    ltrLogin.Text += "<p class=\"rank\">" + level + "</p>";
                    ltrLogin.Text += "</div>";
                    ltrLogin.Text += "<div class=\"level__process\"><span style=\"width: " + tile + "%\"></span></div>";
                    ltrLogin.Text += "</div>";
                    ltrLogin.Text += "<div class=\"balance\">";
                    ltrLogin.Text += "<p>Số dư:</p>";
                    ltrLogin.Text += "<div class=\"balance__number\"><p class=\"vnd\">" + string.Format("{0:N0}", acc.Wallet) + " vnđ</p></div>";
                    ltrLogin.Text += "</div>";
                    if (acc.RoleID != 1)
                        ltrLogin.Text += "<div class=\"links\"><a href=\"/manager/login\">Quản trị<i class=\"fa fa-caret-right\"></i></a></div>";
                    ltrLogin.Text += "<div class=\"links\"><a href=\"/thong-tin-nguoi-dung\">Thông tin tài khoản<i class=\"fa fa-caret-right\"></i></a></div>";
                    ltrLogin.Text += "<div class=\"links\"><a href=\"/danh-sach-don-hang?t=1\">Đơn hàng của bạn<i class=\"fa fa-caret-right\"></i></a></div>";
                    ltrLogin.Text += "<div class=\"links\"><a href=\"/lich-su-giao-dich\">Lịch sử giao dịch<i class=\"fa fa-caret-right\"></i></a></div>";
                    ltrLogin.Text += "</div>";
                    ltrLogin.Text += "<div class=\"status__footer\"><a href=\"/dang-xuat\" class=\"ft-btn\">ĐĂNG XUẤT</a></div>";
                    ltrLogin.Text += "</div>";
                    ltrLogin.Text += "</div>";
                    ltrLogin.Text += "<div class=\"status-mobile\">";
                    ltrLogin.Text += "<a href=\"/thong-tin-nguoi-dung\" class=\"user-menu-logo\"><img src=\"" + userIMG + "\" alt=\"\"></a>";
                    ltrLogin.Text += "<h3 class=\"username\">" + username + "</h3>";
                    ltrLogin.Text += "<div class=\"user-info\">Số tiền: <span class=\"money\">" + string.Format("{0:N0}", acc.Wallet) + "</span> vnđ | Level <span class=\"vip\">" + level + "</span></div>";
                    ltrLogin.Text += "<div class=\"nav-percent\">";
                    ltrLogin.Text += "<div class=\"nav-percent-ok\" style=\"width: " + tile + "%\"></div>";
                    ltrLogin.Text += "</div>";
                    ltrLogin.Text += "<div class=\"profile-bottom\">";
                    ltrLogin.Text += "<ul class=\"menu-in-profile\">";
                    ltrLogin.Text += "<li><a href=\"/\"><i class=\"fa fa-home\"></i>TRANG CHỦ</a></li>";
                    ltrLogin.Text += "<li><a href=\"/theo-doi-mvd\"><i class=\"fa fa-search\"></i>TRACKING</a></li>";
                    ltrLogin.Text += "<li><a href=\"/danh-sach-don-hang?t=1\"><i class=\"fa fa-home\"></i>MUA HÀNG HỘ</a></li>";
                    ltrLogin.Text += "<li><a href=\"/lich-su-giao-dich\"><i class=\"fa fa-money\"></i>TÀI CHÍNH</a></li>";
                    ltrLogin.Text += "<li><a href=\"/khieu-nai\"><i class=\"fa fa-exclamation\"></i>KHIẾU NẠI</a></li>";
                    ltrLogin.Text += "<li><a href=\"/thong-tin-nguoi-dung\"><i class=\"fa fa-user\"></i>QUẢN LÝ TÀI KHOẢN</a></li>";
                    ltrLogin.Text += "</ul>";
                    ltrLogin.Text += "</div><a href=\"/dang-xuat\" class=\"main-btn\">Đăng xuất</a></div>";
                    ltrLogin.Text += "<div class=\"overlay-status-mobile\"></div>";
                    ltrLogin.Text += "</div>";
                    #endregion
                }
            }
            else
            {
                ltrLogin.Text += "<div class=\"box-btn\">";
                ltrLogin.Text += "<ul class=\"right-plugin\">";
                ltrLogin.Text += "<li><img src=\"/App_Themes/CSSMHN/images/user-login.png\" alt=\"\">";
                ltrLogin.Text += "<a href =\"/dang-ky\">Đăng ký</a><span>|</span><a href =\"/dang-nhap\">Đăng nhập</a>";
                ltrLogin.Text += "</li>";
                ltrLogin.Text += "</ul>";
                ltrLogin.Text += "</div>";
            }
        }
    }
}