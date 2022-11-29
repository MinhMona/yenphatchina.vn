﻿<%@ Page Title="Danh sách đơn hàng mua hộ" Language="C#" MasterPageFile="~/manager/adminMasterNew.Master" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="NHST.manager.OrderList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Import Namespace="NHST.Controllers" %>
<%@ Import Namespace="NHST.Models" %>
<%@ Import Namespace="NHST.Bussiness" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        p.s-txt.no-wrap.red-text {
            font-weight: bold;
        }

        .order-status {
            width: 100%;
            height: 35px;
            line-height: 20px;
            padding: 5px 10px;
            background: #fff;
            color: #000;
            border: 1px solid #d0bcbc;
            transition: 0.2s ease;
            margin-bottom: 10px;
        }

            .order-status:hover {
                background: #F64302;
                color: #fff;
                border: 1px solid #F64302;
            }

            .order-status.active {
                background: #F64302;
                color: #fff;
                border: 1px solid #F64302;
            }

        .submit {
            display: flex;
            align-items: center;
            justify-content: space-between
        }
    </style>
    <div id="main" class="main-full">
        <div class="row">
            <div class="content-wrapper-before bg-dark-gradient"></div>
            <div class="col s12 page-title">
                <div class="card-panel">
                    <div class="title-flex">
                        <h4 class="title no-margin">Đơn hàng mua hộ</h4>
                    </div>
                </div>
            </div>
            <div class="list-staff col s12 section">
                <div class="list-table card-panel">
                    <div class="row section">
                        <div class="col s12">
                            <div class="top-table-filter">
                                <div class="sort-tb-wrap">
                                    <div class="filter-link select-sort">
                                        <span>Sắp xếp theo</span>
                                        <asp:DropDownList runat="server" ID="ddlSortType" onchange="SearchSort();">
                                            <asp:ListItem Value="0" Text="--Sắp xếp--"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="ID đơn hàng tăng"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="ID đơn hàng giảm"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Trạng thái đơn hàng tăng"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="Trạng thái đơn hàng giảm"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="filter-link">
                                        <asp:Button runat="server" class="btn" OnClick="btnExcel_Click" Text="Xuất Excel" UseSubmitBehavior="false" Style="background-color: green;"></asp:Button>
                                        <a href="#" class="btn-icon btn" id="filter-btn"><i class="material-icons">filter_list</i><span>Bộ lọc nâng cao</span></a>
                                    </div>
                                </div>

                                <div class="filter-wrap" style="display: block">
                                    <div class="row">
                                        <div class="input-field col s12 l3">
                                            <asp:DropDownList runat="server" ID="ddlType">
                                                <asp:ListItem Value="0" Selected="True">Tất cả</asp:ListItem>
                                                <asp:ListItem Value="1">ID</asp:ListItem>
                                                <asp:ListItem Value="2">Username</asp:ListItem>
                                                <asp:ListItem Value="3">Mã vận đơn</asp:ListItem>
                                                <asp:ListItem Value="4">Mã đơn hàng</asp:ListItem>
                                                <asp:ListItem Value="5">Mã khách hàng</asp:ListItem>
                                            </asp:DropDownList>
                                            <label for="select_by">Tìm kiếm theo</label>
                                        </div>
                                        <div class="input-field col s12 l3">
                                            <asp:TextBox runat="server" placeholder="" ID="tSearchName" type="text" onkeypress="myFunction()" class="validate"></asp:TextBox>
                                            <label for="search_name"><span>ID/Vận đơn/Username/ID User</span></label>
                                        </div>
                                        <div class="input-field col s6 l3">
                                            <asp:TextBox ID="rFD" runat="server" placeholder="" Type="text" class="datetimepicker from-date"></asp:TextBox>
                                            <label>Từ ngày</label>
                                        </div>
                                        <div class="input-field col s6 l3">
                                            <asp:TextBox runat="server" Type="text" placeholder="" ID="rTD" class="datetimepicker to-date"></asp:TextBox>
                                            <label>Đến ngày</label>
                                            <span class="helper-text" data-error="Vui lòng chọn ngày bắt đầu trước"></span>
                                        </div>
                                        <div class="input-field col s6 l3">
                                            <asp:TextBox runat="server" ID="rPriceFrom" placeholder="" type="number" class="validate from-price" min="0"></asp:TextBox>
                                            <label for="from_price">Giá từ</label>
                                        </div>
                                        <div class="input-field col s6 l3">
                                            <asp:TextBox runat="server" ID="rPriceTo" placeholder="" type="number" class="validate to-price" min="0"></asp:TextBox>
                                            <label for="to_price" data-error="wrong">Giá đến</label>
                                            <span class="helper-text"
                                                data-error="Vui lòng chọn giá trị lớn hơn giá bắt đầu"></span>
                                        </div>
                                        <div class="input-field col s12 l3">
                                            <asp:ListBox runat="server" SelectionMode="Multiple" class="select_all" ID="ddlStatus">
                                                <asp:ListItem Value="-1">Tất cả</asp:ListItem>
                                                <asp:ListItem Value="0">Chưa đặt cọc</asp:ListItem>
                                                <asp:ListItem Value="2">Đã đặt cọc</asp:ListItem>
                                                <asp:ListItem Value="4">Đã mua hàng</asp:ListItem>
                                                <asp:ListItem Value="5">Shop phát hàng</asp:ListItem>
                                                <asp:ListItem Value="6">Hàng về kho TQ</asp:ListItem>
                                                <asp:ListItem Value="3">Đang vận chuyển Quốc tế</asp:ListItem>
                                                <asp:ListItem Value="7">Hàng về kho VN</asp:ListItem>
                                                <asp:ListItem Value="9">Khách đã thanh toán</asp:ListItem>
                                                <asp:ListItem Value="10">Đã hoàn thành</asp:ListItem>
                                                <asp:ListItem Value="1">Hủy</asp:ListItem>
                                            </asp:ListBox>
                                            <label for="status">Trạng thái</label>
                                        </div>
                                        <div class="input-field col s12 l3">
                                            <asp:DropDownList runat="server" ID="ddlStaffOrder" AppendDataBoundItems="true"
                                                DataValueField="ID" DataTextField="Username">
                                            </asp:DropDownList>
                                            <label for="select_by">Nhân viên mua hàng</label>
                                        </div>
                                        <div class="input-field col s12 l9">
                                        </div>
                                        <div class="input-field col s12 l3">
                                            <asp:DropDownList runat="server" ID="ddlStaffSale" AppendDataBoundItems="true"
                                                DataValueField="ID" DataTextField="Username">
                                            </asp:DropDownList>
                                            <label for="select_by">Nhân viên kinh doanh</label>
                                        </div>
                                        <div class="input-field col s12 l9">
                                        </div>
                                        <div class="input-field col s12 l3 submit">
                                            <div class="mvd">
                                                <label>
                                                    <asp:TextBox Enabled="true" ID="cbMaVanDon" unchecked runat="server" type="checkbox" /><span id="lbCheckBox">Đơn không có mã vận đơn</span>
                                                </label>
                                                <asp:HiddenField runat="server" ID="hdfCheckBox" Value="0" />
                                            </div>
                                            <div class="search" style="padding-bottom: 15px;">
                                                <a class="btnSort btn ">Lọc kết quả</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col s12 l6">
                                            <asp:Button ID="bttnAll" runat="server" CssClass="order-status btnall" UseSubmitBehavior="false" OnClick="btnAll_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn0" runat="server" CssClass="order-status btn0" UseSubmitBehavior="false" OnClick="btn0_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn2" runat="server" CssClass="order-status btn2" UseSubmitBehavior="false" OnClick="btn2_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn4" runat="server" CssClass="order-status btn4" UseSubmitBehavior="false" OnClick="btn4_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn5" runat="server" CssClass="order-status btn5" UseSubmitBehavior="false" OnClick="btn5_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn6" runat="server" CssClass="order-status btn6" UseSubmitBehavior="false" OnClick="btn6_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn3" runat="server" CssClass="order-status btn3" UseSubmitBehavior="false" OnClick="btn3_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn7" runat="server" CssClass="order-status btn7" UseSubmitBehavior="false" OnClick="btn7_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn9" runat="server" CssClass="order-status btn9" UseSubmitBehavior="false" OnClick="btn9_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn10" runat="server" CssClass="order-status btn10" UseSubmitBehavior="false" OnClick="btn10_Click" />
                                        </div>
                                        <div class="col s12 l3">
                                            <asp:Button ID="btn1" runat="server" CssClass="order-status btn1" UseSubmitBehavior="false" OnClick="btn1_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="list-staff col s12 section">
                <div class="list-table card-panel">
                    <div class="responsive-tb">
                        <table class="table bordered highlight striped ">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Ảnh
                                        <br />
                                        sản phẩm</th>
                                    <th>Thông tin</th>
                                    <th>Username</th>
                                    <th style="min-width: 100px;">Nhân viên
                                        <br />
                                        đặt hàng</th>
                                    <th style="min-width: 120px;">Nhân viên
                                        <br />
                                        kinh doanh</th>
                                    <th>Mã đơn hàng - Mã vận đơn<br />
                                        <div class="search-th">
                                            <div class="row">
                                                <div class="col s6 pr-0">
                                                    <asp:TextBox runat="server" onkeypress="searchMHD()" placeholder="Lọc mã đơn hàng" ID="txtSearchMDH"></asp:TextBox>
                                                </div>
                                                <div class="col s6 pl-0">
                                                    <asp:TextBox runat="server" onkeypress="searchMVD()" placeholder="Lọc mã vận đơn" ID="txtSearchMVD"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </th>
                                    <th style="min-width: 100px;">Timeline</th>
                                    <th style="min-width: 100px;">Trạng thái</th>
                                    <th style="min-width: 100px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Literal ID="ltr" runat="server" EnableViewState="false"></asp:Literal>
                            </tbody>
                        </table>
                    </div>
                    <div class="pagi-table float-right mt-2">
                        <%this.DisplayHtmlStringPaging1();%>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdfStatus" runat="server" Value="-1" />
    <asp:HiddenField ID="hdfStaffID" runat="server" />
    <asp:HiddenField ID="hdfType" runat="server" />
    <asp:HiddenField ID="hdfOrderID" runat="server" />
    <asp:Button ID="btnPay" runat="server" OnClick="btnPay_Click" Style="display: none" UseSubmitBehavior="false" />
    <asp:Button ID="btnDeposit" runat="server" OnClick="btnDeposit_Click" Style="display: none" UseSubmitBehavior="false" />
    <asp:Button Style="display: none" UseSubmitBehavior="false" ID="btnSearch" runat="server" OnClick="btnSearch_Click" />
    <asp:Button Style="display: none" UseSubmitBehavior="false" ID="btnSearchMVD" runat="server" OnClick="btnSearchMVD_Click" />
    <asp:Button Style="display: none" UseSubmitBehavior="false" ID="btnSearchMDH" runat="server" OnClick="btnSearchMDH_Click" />
    <asp:Button Style="display: none" UseSubmitBehavior="false" ID="btnUpdateStaff" runat="server" OnClick="btnUpdateStaff_Click" />
    <script type="text/javascript">
        function payallorder(orderID, obj) {
            var r = confirm('Bạn muốn thanh toán đơn hàng này: ' + orderID);
            if (r == true) {
                obj.removeAttr("onclick");
                $("#<%=hdfOrderID.ClientID%>").val(orderID);
                $("#<%=btnPay.ClientID%>").click();
            }
        }
        function depositOrder(orderID, obj) {
            var c = confirm('Bạn muốn đặt cọc đơn: ' + orderID);
            if (c == true) {
                obj.removeAttr("onclick");
                $("#<%=hdfOrderID.ClientID%>").val(orderID);
                $("#<%=btnDeposit.ClientID%>").click();
            }
        }
        function myFunction() {
            if (event.which == 13 || event.keyCode == 13) {

                $('#<%=btnSearch.ClientID%>').click();
            }
        }
        function SearchSort() {
            $('#<%=btnSearch.ClientID%>').click();
        }
        function searchMHD() {
            if (event.which == 13 || event.keyCode == 13) {

                $('#<%=btnSearchMDH.ClientID%>').click();
            }
        }
        function searchMVD() {
            if (event.which == 13 || event.keyCode == 13) {

                $('#<%=btnSearchMVD.ClientID%>').click();
            }
        }
        $('#lbCheckBox').click(function () {
            if ($('#<%=hdfCheckBox.ClientID%>').val() / 2 == 0) {
                $('#<%=hdfCheckBox.ClientID%>').val('1');
            }
            else {
                $('#<%=hdfCheckBox.ClientID%>').val('0');

            }
        })
        $(document).ready(function () {

            if ($('#<%=hdfCheckBox.ClientID%>').val() == 0) {

                $('#<%=cbMaVanDon.ClientID%>').prop("checked", false);
            } else {
                $('#<%=cbMaVanDon.ClientID%>').prop("checked", true);
            }

        });
        $('.btnSort').click(function () {
            $('#<%=btnSearch.ClientID%>').click();
        })
        function ChooseDathang(OrderID, obj) {
            var dathangID = obj.val();
            $.ajax({
                type: "POST",
                url: "/manager/OrderList.aspx/UpdateStaff",
                data: "{OrderID:'" + OrderID + "',StaffID:'" + dathangID + "',Type:'2'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var data = msg.d;
                    if (data != "null") {
                        if (data != "notpermission") {
                            location.reload();
                        }
                        else {
                            alert('Bạn không có quyền');
                        }
                    }
                    else {
                        alert('Vui lòng đăng nhập lại.');
                    }
                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    alert('lỗi checkend');
                }
            });
        }
        function ChooseSaler(OrderID, obj) {
            var SalerID = obj.val();
            $.ajax({
                type: "POST",
                url: "/manager/OrderList.aspx/UpdateStaff",
                data: "{OrderID:'" + OrderID + "',StaffID:'" + SalerID + "',Type:'1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var data = msg.d;
                    if (data != "null") {
                        if (data != "notpermission") {
                            location.reload();
                        }
                        else {
                            alert('Bạn không có quyền');
                        }
                    }
                    else {
                        alert('Vui lòng đăng nhập lại.');
                    }
                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    alert('lỗi checkend');
                }
            });
        }
        function ChangeStaff(obj) {
            var id = obj.val();
            if (id == 1) {
                $("#pnListStaff").removeClass('hide');
                $("#staffsaler").addClass('hide');
                $("#staffdh").removeClass('hide');
            }
            else if (id == 2) {
                $("#pnListStaff").removeClass('hide');
                $("#staffdh").addClass('hide');
                $("#staffsaler").removeClass('hide');
            }
            else {
                $("#pnListStaff").addClass('hide');
                $("#staffdh").addClass('hide');
                $("#staffsaler").addClass('hide');
            }
        }
        <%--function UpdateStaff(obj) {
            var staff = 0;
            var type = $("#<%=ddlStaffType.ClientID%>").val();
            if (type == 1) {
                var staff = $("#<%=ddlStaffDH.ClientID%>").val();
            }
            else if (type == 2) {
                var staff = $("#<%=ddlStaffSaler.ClientID%>").val();
            }

            if (staff > 0) {
                var c = confirm("Bạn muốn cập nhật nhân viên?");
                if (c) {
                    obj.attr('disabled');
                    $("#<%=hdfType.ClientID%>").val(type);
                    $("#<%=hdfStaffID.ClientID%>").val(staff);
                    $("#<%=btnUpdateStaff.ClientID%>").click();
                }
            }
        }--%>
        function CheckStaff(ID) {
            $.ajax({
                type: "POST",
                url: "/manager/OrderList.aspx/CheckStaff",
                data: "{MainOrderID:'" + ID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {

                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    alert(errorthrow);
                }
            });
        }
    </script>
</asp:Content>
