﻿using MB.Extensions;
using NHST.Bussiness;
using NHST.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NHST
{
    public partial class chi_tiet_thanh_toan_ho1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userLoginSystem"] != null)
                {
                    LoadData();
                }
                else
                {
                    Response.Redirect("/dang-nhap");
                }
            }
        }
        public void LoadData()
        {
            var id = RouteData.Values["id"].ToString().ToInt(0);
            if (id > 0)
            {
                string username = Session["userLoginSystem"].ToString();
                var u = AccountController.GetByUsername(username);
                if (u != null)
                {
                    int UID = u.ID;
                    var p = PayhelpController.GetByIDAndUID(id, UID);
                    if (p != null)
                    {
                        ViewState["ID"] = id;                                     

                        ltrPayID.Text = " Chi tiết thanh toán hộ #" + p.ID + "";
                        ltrIfn.Text = username;
                        ltrPhone.Text = p.Phone;
                        txtPercent.Text = p.PercentPay;
                        txtFeeBuyPro.Text = string.Format("{0:N0}", Convert.ToDouble(p.FeeBuyPro));
                        txtTotalPriceCNY.Text = string.Format("{0:#.##}", Convert.ToDouble(p.TotalPrice));
                        txtTotalPriceVND.Text = string.Format("{0:N0}", Convert.ToDouble(p.TotalPriceVND));
                        rTigia.Value = Convert.ToDouble(p.Currency);
                        txtNote.Text = p.Note;                        
                        lblStatus.Text = PJUtils.ReturnStatusPayHelpNew(Convert.ToInt32(p.Status));
                        var pds = PayhelpDetailController.GetByPayhelpID(id);
                        if (pds.Count > 0)
                        {
                            foreach (var item in pds)
                            {
                                ltrList.Text += "<div class=\"input-field col s12 m6\">";
                                ltrList.Text += "<input type=\"text\" class=\"txtDesc2\" disabled value=\"" + item.Desc2 + "\">";
                                ltrList.Text += "<label class=\"active\">Giá tiền (tệ)</label>";
                                ltrList.Text += "</div>";
                                ltrList.Text += "<div class=\"input-field col s12 m6\">";
                                ltrList.Text += "<input type=\"text\" value=\"" + item.Desc1 + "\" disabled class=\"txtDesc1\">";
                                ltrList.Text += "<label class=\"active\">Nội dung</label>";
                                ltrList.Text += "</div>";
                            }
                        }
                        #region Hình ảnh
                        if (!string.IsNullOrEmpty(p.ImagePay))
                        {
                            var b = p.ImagePay.Split('|').ToList();
                            for (var i = 0; i < b.Count - 1; i++)
                            {
                                ltrImagePay.Text += "<div class=\"img-block\"><a href=\"" + b[i] + "\" data-fancybox ><img src=\"" + b[i] + "\" alt=\"image\" style=\"width: 25%;\"></a></div>";
                            }
                        }
                        else
                        {
                            ltrImagePay.Text += "<div></div>";
                        }
                        #endregion
                    }
                    else Response.Redirect("/thanh-toan-ho");
                }
                else Response.Redirect("/thanh-toan-ho");
            }
            else
            {
                Response.Redirect("/thanh-toan-ho");
            }
        }
    }
}