﻿<%@ Page Language="C#" MasterPageFile="~/UserMasterNew.Master" AutoEventWireup="true" CodeBehind="chi-tiet-thanh-toan-ho.aspx.cs" Inherits="NHST.chi_tiet_thanh_toan_ho1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <link href="/App_Themes/AdminNew45/assets/js/fancybox-master/dist/jquery.fancybox.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div id="main">
        <div class="row">
            <div class="content-wrapper-before blue-grey lighten-5"></div>
            <div class="col s12">
                <div class="container">
                    <div class="all">
                        <div class="card-panel mt-3 no-shadow">
                            <div class="row">
                                <div class="col s12">
                                    <div class="page-title mt-2 center-align">
                                        <h4>
                                            <asp:Literal runat="server" ID="ltrPayID"></asp:Literal></h4>
                                    </div>
                                </div>
                                <div class="col s12">

                                    <div class="row section">
                                        <div class="col s12">
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Username:</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row">
                                                        <div class="input-field col s12">
                                                            <asp:Literal ID="ltrIfn" runat="server"></asp:Literal>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Số điện thoại:</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row">
                                                        <div class="input-field col s12">
                                                            <asp:Literal ID="ltrPhone" runat="server"></asp:Literal>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row top-justify">
                                                <div class="left-fixed">
                                                    <p class="txt">Hóa đơn thanh toán hộ:</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="list-order">
                                                        <div class="row order-wrap">
                                                            <asp:Literal ID="ltrList" runat="server"></asp:Literal>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Tổng tiền Tệ (¥):</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row">
                                                        <div class="input-field col s12">
                                                            <asp:TextBox runat="server" ID="txtTotalPriceCNY" placeholder="0" class="" disabled></asp:TextBox>
                                                            <label class="active">Tệ (¥)</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Tổng tiền (VNĐ):</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row">
                                                        <div class="input-field col s12">
                                                            <asp:TextBox runat="server" ID="txtTotalPriceVND" placeholder="0" class="" disabled></asp:TextBox>
                                                            <label class="active">Việt Nam Đồng (VNĐ)</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Phần trăm dịch vụ</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row">
                                                        <div class="input-field col s12 m6">
                                                            <asp:TextBox runat="server" ID="txtPercent" placeholder="0" class="" disabled></asp:TextBox>
                                                            <label>Phần trăm (%)</label>
                                                        </div>
                                                        <div class="input-field col s12 m6">
                                                            <asp:TextBox runat="server" ID="txtFeeBuyPro" placeholder="0" class="" disabled></asp:TextBox>
                                                            <label class="active">Việt Nam Đồng (VNĐ)</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Tỉ giá:</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row">
                                                        <div class="input-field col s12">
                                                            <telerik:RadNumericTextBox runat="server" Skin="MetroTouch"
                                                                ID="rTigia" NumberFormat-DecimalDigits="0" Value="0"
                                                                NumberFormat-GroupSizes="3" Width="100%" Enabled="false">
                                                            </telerik:RadNumericTextBox>
                                                            <label class="active">Tỉ giá</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Hình ảnh:</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row">
                                                        <div class="input-field col s12">
                                                            <p>Ảnh thanh toán hộ:</p>
                                                            <asp:Literal runat="server" ID="ltrImagePay"></asp:Literal>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Ghi chú:</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row">
                                                        <div class="input-field col s12">
                                                            <asp:TextBox ID="txtNote" runat="server" CssClass="materialize-textarea" TextMode="MultiLine"></asp:TextBox>
                                                            <label for="textarea2">Nội dung</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-row">
                                                <div class="left-fixed">
                                                    <p class="txt">Trạng thái:</p>
                                                </div>
                                                <div class="right-content">
                                                    <div class="row" style="float: left">
                                                        <asp:Literal runat="server" ID="lblStatus"></asp:Literal>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="float-right mt-2">
                                                <a href="/danh-sach-thanh-toan-ho" class="btn back-order">Trở về</a>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
    <script src="/App_Themes/AdminNew45/assets/js/fancybox-master/dist/jquery.fancybox.min.js"></script>
    <script>   
        function readFile(input) {
            var k = 0;
            var counter = input.files.length;
            for (x = 0; x < counter; x++) {
                if (input.files && input.files[x]) {
                    var reader = new FileReader();
                    var t = k + x;
                    reader.onload = function (e) {
                        var a = "<div class=\"img-block\"><img class=\"materialboxed 2" + t + "\" src =\"" + e.target.result + "\" ><span class=\"material-icons red-text delete\" onclick=\"Delete($(this))\">clear</span></div>";
                        $(".preview-img").append(a);
                        $(".materialboxed").materialbox({
                            inDuration: 150,
                            onOpenStart: function (element) {
                                $(element).parents('.material-placeholder').attr('style', 'overflow:visible !important;');
                            },
                            onCloseStart: function (element) {
                                $(element).parents('.material-placeholder').attr('style', '');
                            }
                        });
                        //$(".preview-img").append('<li class=\"2' + t + '\"><img src="' + e.target.result + '" class="img-thumbnail"><a href=\"javascript:;\" onclick=\"Delete($(this))\">Xóa</a></li>');
                    };
                    reader.readAsDataURL(input.files[x]);
                    k++;
                }
            }
        }
    </script>
</asp:Content>
