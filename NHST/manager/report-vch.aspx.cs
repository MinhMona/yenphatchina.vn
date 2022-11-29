﻿using MB.Extensions;
using NHST.Bussiness;
using NHST.Controllers;
using NHST.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NHST.manager
{
    public partial class report_vch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userLoginSystem"] == null)
                {
                    Response.Redirect("/trang-chu");
                }
                else
                {
                    string username_current = Session["userLoginSystem"].ToString();
                    tbl_Account ac = AccountController.GetByUsername(username_current);
                    if (ac != null)
                        if (ac.RoleID != 2 && ac.RoleID != 0)
                            Response.Redirect("/trang-chu");
                    LoadData();
                }
            }
        }

        private void LoadData()
        {
            int stype = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["stype"]))
            {
                stype = Request.QueryString["stype"].ToString().ToInt(0);
                select_by.SelectedValue = stype.ToString();
            }
            string search = "";
            if (!string.IsNullOrEmpty(Request.QueryString["s"]))
            {
                search = Request.QueryString["s"].ToString().Trim();
                txtSearchName.Text = search;
            }

            string fd = Request.QueryString["fd"];
            if (!string.IsNullOrEmpty(fd))
                rFD.Text = fd;
            string td = Request.QueryString["td"];
            if (!string.IsNullOrEmpty(td))
                rTD.Text = td;

            int stt = Request.QueryString["stt"].ToInt(-1);

            int page = 0;
            Int32 Page = GetIntFromQueryString("Page");
            if (Page > 0)
            {
                page = Page - 1;
            }

            string username = Session["userLoginSystem"].ToString();
            var acc = AccountController.GetByUsername(username);
            if (acc != null)
            {
                List<ReportTrans> rs = new List<ReportTrans>();
                var r = ExportRequestTurnController.GetByFilter_SqlHelperNewWithPage(stt, fd, td, stype, search, page, 20);
                if (r.Count > 0)
                {
                    double totalWeightAll = 0;
                    double totalPriceNotPay = 0;
                    double totalPriceVNDAll = 0;
                    foreach (var item in r)
                    {
                        ReportTrans t = new ReportTrans();
                        t.ID = item.ID;
                        t.Username = item.Username;
                        t.DateRequest = string.Format("{0:dd/MM/yyyy}", item.CreatedDate);
                        string dateOutWH = "";
                        int TotalPackages = 0;
                        var re = RequestOutStockController.GetByExportRequestTurnID(item.ID);
                        if (re.Count > 0)
                        {
                            dateOutWH += "<table class=\"table table-bordered table-hover\">";
                            dateOutWH += "<tr>";
                            dateOutWH += "  <th>Mã vận đơn</th>";
                            dateOutWH += "  <th>Ngày XK</th>";
                            dateOutWH += "</tr>";
                            TotalPackages = re.Count;
                            foreach (var ro in re)
                            {
                                dateOutWH += "<tr>";
                                var smallpack = SmallPackageController.GetByID(Convert.ToInt32(ro.SmallPackageID));
                                if (smallpack != null)
                                {
                                    dateOutWH += "<td>" + smallpack.OrderTransactionCode + "</td>";
                                    if (smallpack.DateOutWarehouse != null)
                                    {
                                        dateOutWH += "<td>" + string.Format("{0:dd/MM/yyyy}", Convert.ToDateTime(smallpack.DateOutWarehouse)) + "</td>";
                                    }
                                    else
                                    {
                                        dateOutWH += "<td><span class=\"bg-red\">Chưa xuất kho</span></td>";
                                    }
                                }
                                dateOutWH += "<tr>";
                            }
                            dateOutWH += "</table>";
                        }

                        t.DateOutWH = dateOutWH;
                        t.TotalPackages = TotalPackages.ToString();
                        totalWeightAll += Convert.ToDouble(item.TotalWeight);
                        if (item.Status == 1)
                            totalPriceNotPay += Convert.ToDouble(item.TotalPriceVND);
                        else
                            totalPriceVNDAll += Convert.ToDouble(item.TotalPriceVND);
                        t.TotalWeight = Math.Round(Convert.ToDouble(item.TotalWeight), 1).ToString();
                        t.TotalPrice = string.Format("{0:N0}", item.TotalPriceVND) + " VNĐ";
                        t.StaffNote = item.StaffNote;
                        t.ShippingTypeInVNID = Convert.ToInt32(item.ShippingTypeInVNID);
                        t.StatusStr = PJUtils.ReturnStatusTT(item.Status);
                        t.Status = item.Status;
                        t.StatusExport = PJUtils.ReturnStatusXK(item.StatusExport);
                        rs.Add(t);
                    }
                    lblWeightAll.Text = totalWeightAll.ToString();
                    lblPriceAllVND.Text = string.Format("{0:N0}", totalPriceVNDAll);
                    lblPriceNotPay.Text = string.Format("{0:N0}", totalPriceNotPay);
                }
                else
                {
                    lblWeightAll.Text = "0";
                    lblPriceAllVND.Text = "0";
                    lblPriceNotPay.Text = "0";
                }
                int total = ExportRequestTurnController.GetTotal(stt, stype, search, fd, td);
                pagingall(rs, total);
            }

        }
        #region Pagging
        public void pagingall(List<ReportTrans> acs, int total)
        {
            int PageSize = 20;
            if (total > 0)
            {
                int TotalItems = total;
                if (TotalItems % PageSize == 0)
                    PageCount = TotalItems / PageSize;
                else
                    PageCount = TotalItems / PageSize + 1;
                Int32 Page = GetIntFromQueryString("Page");
                if (Page == -1) Page = 1;
                int FromRow = (Page - 1) * PageSize;
                int ToRow = Page * PageSize - 1;
                if (ToRow >= TotalItems)
                    ToRow = TotalItems - 1;
                StringBuilder hcm = new StringBuilder();

                for (int i = 0; i < acs.Count; i++)
                {
                    var item = acs[i];

                    hcm.Append("<tr>");
                    hcm.Append("<td>" + item.ID + "</td>");
                    hcm.Append("<td>" + item.Username + "</td>");
                    hcm.Append("<td>" + item.DateRequest + "</td>");
                    hcm.Append("<td>" + item.DateOutWH + " </td>");
                    hcm.Append("<td>" + item.TotalPackages + "</td>");
                    hcm.Append("<td>" + item.TotalWeight + "</td>");
                    hcm.Append("<td>" + item.TotalPrice + "</td>");
                    var ship = ShippingTypeVNController.GetByID(Convert.ToInt32(item.ShippingTypeInVNID));
                    if (ship != null)
                        hcm.Append("<td>" + ship.ShippingTypeVNName + "</td>");
                    else
                        hcm.Append("<td></td>");
                    hcm.Append("<td>" + item.StatusStr + "</td>");
                    hcm.Append("<td>" + item.StatusExport + "</td>");
                    hcm.Append("<td><textarea class=\"txtNote\">" + item.StaffNote + "</textarea>");
                    hcm.Append("<a href =\"javascript:;\" class=\"btn btn-info\" onclick=\"updateNote($(this),'" + item.ID + "')\">Cập nhật</a>");
                    hcm.Append("<span class=\"update-info\" style=\"width:100%; clear:both; float:left; color blue; display:none\">Cập nhật thành công</span></td>");
                    hcm.Append("<td>" + item.NoteUser + "</td>");
                    hcm.Append("<td>");
                    hcm.Append(" <div class=\"action-table\">");
                    if (item.Status != 2)
                    {
                        hcm.Append("<a href =\"javascript:;\" onclick=\"PayByWallet($(this),'" + item.ID + "')\" data-position=\"top\" ><i class=\"material-icons\">payment</i><span>THANH TOÁN BẰNG VÍ</span></a>");
                        hcm.Append("<a href =\"javascript:;\" onclick=\"Pay($(this),'" + item.ID + "')\" data-position=\"top\" ><i class=\"material-icons\">payment</i><span>THANH TOÁN TRỰC TIẾP</span></a>");
                        hcm.Append("<a href =\"javascript:;\" onclick=\"Delete($(this),'" + item.ID + "')\" data-position=\"top\" ><i class=\"material-icons\">delete</i><span>HỦY YÊU CẦU</span></a>");
                    }
                    hcm.Append("</div>");

                    hcm.Append("</td>");
                    hcm.Append("</tr>");
                }
                ltr.Text = hcm.ToString();
            }
        }

        public static Int32 GetIntFromQueryString(String key)
        {
            Int32 returnValue = -1;
            String queryStringValue = HttpContext.Current.Request.QueryString[key];
            try
            {
                if (queryStringValue == null)
                    return returnValue;
                if (queryStringValue.IndexOf("#") > 0)
                    queryStringValue = queryStringValue.Substring(0, queryStringValue.IndexOf("#"));
                returnValue = Convert.ToInt32(queryStringValue);
            }
            catch
            { }
            return returnValue;
        }
        private int PageCount;
        protected void DisplayHtmlStringPaging1()
        {
            Int32 CurrentPage = Convert.ToInt32(Request.QueryString["Page"]);
            if (CurrentPage == -1) CurrentPage = 1;
            string[] strText = new string[4] { "Trang đầu", "Trang cuối", "Trang sau", "Trang trước" };
            if (PageCount > 1)
                Response.Write(GetHtmlPagingAdvanced(6, CurrentPage, PageCount, Context.Request.RawUrl, strText));
        }
        private static string GetPageUrl(int currentPage, string pageUrl)
        {
            pageUrl = Regex.Replace(pageUrl, "(\\?|\\&)*" + "Page=" + currentPage, "");
            if (pageUrl.IndexOf("?") > 0)
            {
                if (pageUrl.IndexOf("Page=") > 0)
                {
                    int a = pageUrl.IndexOf("Page=");
                    int b = pageUrl.Length;
                    pageUrl.Remove(a, b - a);
                }
                else
                {
                    pageUrl += "&Page={0}";
                }

            }
            else
            {
                pageUrl += "?Page={0}";
            }
            return pageUrl;
        }
        public static string GetHtmlPagingAdvanced(int pagesToOutput, int currentPage, int pageCount, string currentPageUrl, string[] strText)
        {
            //Nếu Số trang hiển thị là số lẻ thì tăng thêm 1 thành chẵn
            if (pagesToOutput % 2 != 0)
            {
                pagesToOutput++;
            }

            //Một nửa số trang để đầu ra, đây là số lượng hai bên.
            int pagesToOutputHalfed = pagesToOutput / 2;

            //Url của trang
            string pageUrl = GetPageUrl(currentPage, currentPageUrl);


            //Trang đầu tiên
            int startPageNumbersFrom = currentPage - pagesToOutputHalfed; ;

            //Trang cuối cùng
            int stopPageNumbersAt = currentPage + pagesToOutputHalfed; ;

            StringBuilder output = new StringBuilder();

            //Nối chuỗi phân trang
            //output.Append("<div class=\"paging\">");
            //output.Append("<ul class=\"paging_hand\">");

            //Link First(Trang đầu) và Previous(Trang trước)
            if (currentPage > 1)
            {
                //output.Append("<li class=\"UnselectedPrev \" ><a title=\"" + strText[0] + "\" href=\"" + string.Format(pageUrl, 1) + "\">|<</a></li>");
                //output.Append("<li class=\"UnselectedPrev\" ><a title=\"" + strText[1] + "\" href=\"" + string.Format(pageUrl, currentPage - 1) + "\"><i class=\"fa fa-angle-left\"></i></a></li>");
                output.Append("<a class=\"prev-page pagi-button\" title=\"" + strText[1] + "\" href=\"" + string.Format(pageUrl, currentPage - 1) + "\">Prev</a>");
                //output.Append("<span class=\"Unselect_prev\"><a href=\"" + string.Format(pageUrl, currentPage - 1) + "\"></a></span>");
            }

            /******************Xác định startPageNumbersFrom & stopPageNumbersAt**********************/
            if (startPageNumbersFrom < 1)
            {
                startPageNumbersFrom = 1;

                //As page numbers are starting at one, output an even number of pages.  
                stopPageNumbersAt = pagesToOutput;
            }

            if (stopPageNumbersAt > pageCount)
            {
                stopPageNumbersAt = pageCount;
            }

            if ((stopPageNumbersAt - startPageNumbersFrom) < pagesToOutput)
            {
                startPageNumbersFrom = stopPageNumbersAt - pagesToOutput;
                if (startPageNumbersFrom < 1)
                {
                    startPageNumbersFrom = 1;
                }
            }
            /******************End: Xác định startPageNumbersFrom & stopPageNumbersAt**********************/

            //Các dấu ... chỉ những trang phía trước  
            if (startPageNumbersFrom > 1)
            {
                output.Append("<a href=\"" + string.Format(GetPageUrl(currentPage - 1, pageUrl), startPageNumbersFrom - 1) + "\">&hellip;</a>");
            }
            //Duyệt vòng for hiển thị các trang
            for (int i = startPageNumbersFrom; i <= stopPageNumbersAt; i++)
            {
                if (currentPage == i)
                {
                    output.Append("<a class=\"pagi-button current-active\">" + i.ToString() + "</a>");
                }
                else
                {
                    output.Append("<a class=\"pagi-button\" href=\"" + string.Format(pageUrl, i) + "\">" + i.ToString() + "</a>");
                }
            }
            //Các dấu ... chỉ những trang tiếp theo  
            if (stopPageNumbersAt < pageCount)
            {
                output.Append("<a href=\"" + string.Format(pageUrl, stopPageNumbersAt + 1) + "\">&hellip;</a>");
            }
            //Link Next(Trang tiếp) và Last(Trang cuối)
            if (currentPage != pageCount)
            {
                //output.Append("<span class=\"Unselect_next\"><a href=\"" + string.Format(pageUrl, currentPage + 1) + "\"></a></span>");
                //output.Append("<li class=\"UnselectedNext\" ><a title=\"" + strText[2] + "\" href=\"" + string.Format(pageUrl, currentPage + 1) + "\"><i class=\"fa fa-angle-right\"></i></a></li>");
                output.Append("<a class=\"next-page pagi-button\" title=\"" + strText[2] + "\" href=\"" + string.Format(pageUrl, currentPage + 1) + "\">Next</a>");
                //output.Append("<li class=\"UnselectedNext\" ><a title=\"" + strText[3] + "\" href=\"" + string.Format(pageUrl, pageCount) + "\">>|</a></li>");
            }
            //output.Append("</ul>");
            //output.Append("</div>");
            return output.ToString();
        }
        #endregion

        #region button event

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string fd = "";
            string td = "";
            int status = ddlstatus.SelectedValue.ToInt(-1);
            string searchname = txtSearchName.Text.Trim();
            string stype = select_by.SelectedValue;
            if (!string.IsNullOrEmpty(rFD.Text))
            {
                fd = rFD.Text.ToString();
            }
            if (!string.IsNullOrEmpty(rTD.Text))
            {
                td = rTD.Text.ToString();
            }

            if (string.IsNullOrEmpty(searchname) == true && fd == "" && td == "" && status == -1 && stype == "0")
            {
                Response.Redirect("report-vch");
            }
            else
            {
                Response.Redirect("report-vch?stype=" + stype + "&s=" + searchname + "&fd=" + fd + "&td=" + td + "&stt=" + status);
            }
        }

        #endregion
        public class ReportTrans
        {
            public int ID { get; set; }
            public string Username { get; set; }
            public string CreatedBy { get; set; }
            public string DateRequest { get; set; }
            public string DateOutWH { get; set; }
            public string TotalPackages { get; set; }
            public string TotalWeight { get; set; }
            public string TotalPrice { get; set; }
            public string StaffNote { get; set; }
            public int ShippingTypeInVNID { get; set; }
            public string StatusStr { get; set; }
            public string StatusExport { get; set; }
            public int Status { get; set; }
            public string NoteUser { get; set; }
        }

        #region Webservice
        [WebMethod]
        public static string UpdateStaffNote(int ID, string staffNote)
        {
            var ex = ExportRequestTurnController.GetByID(ID);
            if (ex != null)
            {
                ExportRequestTurnController.UpdateStaffNote(ID, staffNote);
                return "ok";
            }
            return "none";
        }
        #endregion

        protected void btnPayByWallet_Click(object sender, EventArgs e)
        {
            DateTime currentDate = DateTime.Now;
            string username = "";
            string username_current = Session["userLoginSystem"].ToString();
            int UID_Admin = 0;
            var userAdmin = AccountController.GetByUsername(username_current);
            if (userAdmin != null)
            {
                UID_Admin = userAdmin.ID;
            }
            int id = hdfID.Value.ToInt(0);
            if (id > 0)
            {
                var ots = ExportRequestTurnController.GetByID(id);
                if (ots != null)
                {
                    username = ots.Username;
                    int UID = Convert.ToInt32(ots.UID);

                    double totalPay = Convert.ToDouble(ots.TotalPriceVND);

                    if (totalPay > 0)
                    {
                        var user_wallet = AccountController.GetByID(UID);
                        if (user_wallet.Wallet < totalPay)
                        {
                            PJUtils.ShowMessageBoxSwAlert("Không đủ tiền trong tài khoản!, vui lòng nạp thêm tiền!", "e", true, Page);
                        }
                        else
                        {
                            #region Trừ tiền VC
                            var acc = AccountController.GetByID(UID);
                            if (acc != null)
                            {
                                double wallet = Convert.ToDouble(acc.Wallet);
                                double totalPriceVND = Convert.ToDouble(ots.TotalPriceVND);
                                double walletLeft = wallet - totalPriceVND;
                                AccountController.updateWallet(UID, walletLeft, currentDate, username);
                                HistoryPayWalletController.Insert(UID, username, 0, totalPriceVND,
                                    username + " đã thanh toán đơn hàng vận chuyển hộ.", walletLeft, 1, 8, currentDate, username);
                            }
                            #endregion

                            ExportRequestTurnController.UpdateStatus(ots.ID, 2);
                           
                            PJUtils.ShowMessageBoxSwAlert("Thanh toán thành công", "s", true, Page);
                        }
                    }
                }
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            DateTime currentDate = DateTime.Now;
            string username = "";
            string username_current = Session["userLoginSystem"].ToString();
            int UID_Admin = 0;
            var userAdmin = AccountController.GetByUsername(username_current);
            if (userAdmin != null)
            {
                UID_Admin = userAdmin.ID;
            }
            int id = hdfID.Value.ToInt(0);
            if (id > 0)
            {
                var ots = ExportRequestTurnController.GetByID(id);
                if (ots != null)
                {
                    username = ots.Username;
                    int UID = Convert.ToInt32(ots.UID);

                    double totalPay = Convert.ToDouble(ots.TotalPriceVND);

                    if (totalPay > 0)
                    {
                        var user_wallet = AccountController.GetByID(UID);
                        if (user_wallet != null)
                        {
                            double wallet = Convert.ToDouble(user_wallet.Wallet);
                            wallet = wallet + totalPay;
                            string contentin = user_wallet.Username + " đã được nạp tiền vào tài khoản.";
                            //AdminSendUserWalletController.UpdateStatus(id, 2, contentin, currentDate, username_current);
                            AdminSendUserWalletController.Insert(user_wallet.ID, user_wallet.Username, totalPay, 2, 10, contentin, currentDate, username_current);
                            AccountController.updateWallet(user_wallet.ID, wallet, currentDate, username_current);
                            HistoryPayWalletController.Insert(user_wallet.ID, user_wallet.Username, 0, totalPay, user_wallet.Username + " đã được nạp tiền vào tài khoản.", wallet, 2, 4, currentDate, username_current);
                        }
                        #region Trừ tiền VC
                        var acc = AccountController.GetByID(UID);
                        if (acc != null)
                        {
                            double wallet = Convert.ToDouble(acc.Wallet);
                            double totalPriceVND = Convert.ToDouble(ots.TotalPriceVND);
                            double walletLeft = wallet - totalPriceVND;
                            AccountController.updateWallet(UID, walletLeft, currentDate, username);
                            HistoryPayWalletController.Insert(UID, username, 0, totalPriceVND,
                                username + " đã thanh toán đơn hàng vận chuyển hộ.", walletLeft, 1, 8, currentDate, username);
                        }
                        #endregion

                        ExportRequestTurnController.UpdateStatus(ots.ID, 2);
                    }

                    PJUtils.ShowMessageBoxSwAlert("Thanh toán thành công", "s", true, Page);
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string username_current = Session["userLoginSystem"].ToString();
            var userAdmin = AccountController.GetByUsername(username_current);
            if (userAdmin != null)
            {
                if (userAdmin.RoleID == 0 || userAdmin.RoleID == 5)
                {
                    int id = hdfID.Value.ToInt(0);
                    if (id > 0)
                    {
                        var exp = ExportRequestTurnController.GetByID(id);
                        if (exp != null)
                        {
                            var req = RequestOutStockController.GetByExportRequestTurnID(exp.ID);
                            if (req.Count > 0)
                            {
                                foreach (var temp in req)
                                {
                                    TransportationOrderNewController.UpdateRequestOutStockNew(temp.TransportationID.Value, 4, userAdmin.Username, DateTime.Now);
                                    RequestOutStockController.DeleteByExportID(exp.ID);
                                }
                            }
                        }
                        var kqexp = ExportRequestTurnController.Remove(id);
                        if (Convert.ToInt32(kqexp) > 0)
                        {
                            PJUtils.ShowMessageBoxSwAlert("Hủy thành công.", "s", true, Page);
                        }
                        else
                        {
                            PJUtils.ShowMessageBoxSwAlert("Có lỗi trong quá trình xử lý. Vui lòng thử lại.", "e", true, Page);
                        }
                    }
                }
                else
                {
                    PJUtils.ShowMessageBoxSwAlert("Bạn không đủ quyền thực hiện chức năng này!", "i", true, Page);
                }
            }
        }

    }
}