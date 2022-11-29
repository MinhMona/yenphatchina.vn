﻿<%@ Page Title="Tạo đơn hàng TMĐT khác" Language="C#" MasterPageFile="~/manager/adminMasterNew.Master" AutoEventWireup="true" CodeBehind="tao-don-hang-khac.aspx.cs" Inherits="NHST.manager.tao_don_hang_khac" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="main" class="main-full">
        <div class="row">
            <div class="content-wrapper-before bg-dark-gradient"></div>
            <div class="page-title">
                <div class="card-panel">
                    <h4 class="title no-margin" style="display: inline-block;">Tạo đơn hàng web TMĐT khác</h4>
                </div>
            </div>
            <div class="create-order-cus col s12 section">
                <div class="order-list-info card-panel">
                    <div class="total-info mb-2 create-product">
                        <div class="row section">
                            <div class="col s12">
                                <div class="float-left mt-2">
                                    <div class="search-name input-field col s12 l12">
                                        <%-- <asp:TextBox ID="txtUsername" name="txtUsername" type="text" placeholder="" runat="server" />--%>
                                        <asp:DropDownList ID="ddlUsername" runat="server" CssClass="select2"
                                            DataValueField="ID" DataTextField="Username">
                                        </asp:DropDownList>
                                        <label for="search_name"><span>Username</span></label>
                                    </div>
                                </div>
                                <div class="float-left mt-2">
                                    <div class="search-name input-field col s12 l12">
                                        <asp:DropDownList runat="server" ID="ddlKhoTQ" AppendDataBoundItems="true" DataTextField="WareHouseName" DataValueField="ID"></asp:DropDownList>
                                        <label for="search_name"><span>Kho Trung Quốc</span></label>
                                    </div>
                                </div>
                                <div class="float-left mt-2">
                                    <div class="search-name input-field col s12 l12">
                                        <asp:DropDownList runat="server" ID="ddlKhoVN" AppendDataBoundItems="true" DataTextField="WareHouseName" DataValueField="ID"></asp:DropDownList>
                                        <label for="search_name"><span>Kho Việt Nam</span></label>
                                    </div>
                                </div>
                                <div class="float-left mt-2">
                                    <div class="search-name input-field col s12 l12">
                                        <asp:DropDownList runat="server" ID="ddlShipping" AppendDataBoundItems="true" DataTextField="ShippingTypeName" DataValueField="ID"></asp:DropDownList>
                                        <label for="search_name"><span>Phương thức vận chuyển</span></label>
                                    </div>
                                </div>
                                <div class="float-right mt-2">
                                    <a href="javascript:;" class="btn add-product valign-wrapper" style="display: flex"><i class="material-icons">add</i><span>Sản phẩm</span></a>
                                </div>
                                <div class="clearfix"></div>
                                <div class="responsive-tb">
                                    <table class="table   highlight bordered ">
                                        <thead>
                                            <tr>
                                                <th class="tb-date">Ảnh<br />
                                                    sản phẩm</th>
                                                <th class="tb-date">Link sản phẩm</th>
                                                <th class="tb-date">Tên sản phẩm</th>
                                                <th class="tb-date">Giá sản phẩm</th>
                                                <th class="no-wrap">Màu sắc / kích thước</th>
                                                <th class="tb-date">Số lượng</th>
                                                <th class="tb-date">Ghi chú thêm</th>
                                                <th class="no-wrap">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody class="list-product">
                                            <tr class="slide-up product-item">
                                                <td>
                                                    <div>
                                                        <input class="upload-img productimage" type="file" name="productimage1" onchange="previewFiles(this)" title="">
                                                        <a class="btn-upload">Upload</a>
                                                    </div>
                                                    <div class="preview-img"></div>
                                                </td>
                                                <td>
                                                    <input class="product-link" type="text" value=""></td>
                                                <td>
                                                    <input class="product-name" type="text" value=""></td>
                                                <td>
                                                    <input class="product-price" type="number" value=""></td>
                                                <td>
                                                    <input class="product-colorsize" type="text" value=""></td>
                                                <td>
                                                    <input class="product-quantity" type="number" value="1"></td>
                                                <td>
                                                    <input class="product-request" type="text" value=""></td>

                                                <td class="no-wrap">
                                                    <a href='javascript:;' class="remove-product" onclick="deleteProduct($(this))"><i class="material-icons valign-center">remove_circle</i></a>
                                                </td>

                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="float-right mt-2">
                                    <a href="javascript:;" onclick="CreateOrder()" class="btn create-order">Tạo đơn hàng</a>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdfProductList" runat="server" />
    <asp:HiddenField ID="hdfcountimage" runat="server" Value="1" />
    <asp:Button ID="btncreateuser" runat="server" Text="Cập nhật" CssClass="" UseSubmitBehavior="false" OnClick="btncreateuser_Click" Style="display: none" />
    <!-- END: Page Main-->
    <script>
        function validateText(obj) {
            var value = obj.val();
            if (isBlank(value)) {
                obj.addClass("border-select");
            }
            else {
                obj.removeClass("border-select");
            }
        }
        function validateNumber(obj) {
            var value = parseFloat(obj.val());
            if (value <= 0)
                obj.addClass("border-select");
            else
                obj.removeClass("border-select");
        }
        function isBlank(str) {
            return (!str || /^\s*$/.test(str));
        }
        function CreateOrder() {
            var khotq = $("#<%=ddlKhoTQ.ClientID%>").val();
            var khovn = $("#<%=ddlKhoVN.ClientID%>").val();
            var shipping = $("#<%=ddlShipping.ClientID%>").val();
            if (khotq == 0) {
                alert('Vui lòng chọn kho Trung Quốc');
                return;
            }
            if (khovn == 0) {
                alert('Vui lòng chọn kho Việt Nam');
                return;
            }
            if (shipping == 0) {
                alert('Vui lòng chọn phương thức vận chuyển');
                return;
            }
            if ($(".product-item").length > 0) {
                var html = "";
                var check = false;
                $(".product-item").each(function () {
                    var item = $(this);
                    var productlink_obj = item.find(".product-link");
                    var productlink = item.find(".product-link").val();

                    var productname_obj = item.find(".product-name");
                    var productname = item.find(".product-name").val();

                    var productsizecolor_obj = item.find(".product-colorsize");
                    var productsizecolor = item.find(".product-colorsize").val();

                    var productprice_obj = item.find(".product-price");
                    var productprice = item.find(".product-price").val();

                    var productquantity_obj = item.find(".product-quantity");
                    var productquantity = item.find(".product-quantity").val();
                    var productquantityfloat = parseFloat(item.find(".product-quantity").val());
                    var productrequest = item.find(".product-request").val();

                    if (isBlank(productlink)) {
                        //alert('Vui lòng nhập link sản phẩm');
                        check = true;
                    }
                    if (isBlank(productname)) {
                        //alert('Vui lòng nhập tên sản phẩm');
                        check = true;
                    }
                    if (isBlank(productsizecolor)) {
                        //alert('Vui lòng nhập màu sắc, kích thước sản phẩm');
                        check = true;
                    }
                    if (isBlank(productquantity)) {
                        //alert('Vui lòng số lượng cần mua, và số lượng phải lớn hơn 0');
                        check = true;
                    }
                    else if (productquantityfloat <= 0) {
                        check = true;
                    }
                    if (isBlank(productprice)) {
                        //alert('Vui lòng nhập gia sản phẩm');
                        check = true;
                    }

                    validateText(productlink_obj);
                    validateText(productname_obj);
                    validateText(productsizecolor_obj);
                    validateText(productquantity_obj);
                    validateNumber(productquantity_obj);
                    validateText(productprice_obj);
                });
                if (check == true) {
                    alert('Vui lòng điền đầy đủ thông tin từng sản phẩm');
                }
                else {
                    $(".product-item").each(function () {
                        var item = $(this);
                        var productlink = item.find(".product-link").val();
                        var productname = item.find(".product-name").val();
                        var productsizecolor = item.find(".product-colorsize").val();
                        var productquantity = item.find(".product-quantity").val();
                        var productrequest = item.find(".product-request").val();
                        var image = item.find(".productimage").attr("name");
                        var productprice = item.find(".product-price").val();

                        html += productlink + "]" + productname + "]" + productsizecolor + "]" + productquantity + "]" + productrequest + "]" + image + "]" + productprice + "|";
                    });
                    $("#<%=hdfProductList.ClientID%>").val(html);
                    $("#<%=btncreateuser.ClientID%>").click();
                }
            }
            else {
                alert('Vui lòng nhập sản phẩm');
            }
        }
        $(document).ready(function () {
            $('.create-product .add-product').on('click', function () {
                var countimage = parseFloat($("#<%=hdfcountimage.ClientID%>").val());
                countimage += 1;
                $("#<%= hdfcountimage.ClientID %>").val(countimage);

                var tableHTML = $('.create-product table .list-product');
                var html = `<tr class="slide-up product-item">
                     <td>                     
                        <div>
                           <input class="upload-img productimage" type="file" onchange="previewFiles(this)" name="productimage` + countimage + `" title="">
                           <button class="btn-upload">Upload</button>
                        </div>                                            
                        <div class="preview-img"></div>
                     </td>
                     <td><input class="product-link" type="text" value=""></td>
                     <td><input class="product-name" type="text" value=""></td>    
                     <td><input class="product-price" type="number" value=""></td> ';
                     <td><input class="product-colorsize" type="text" value=""></td> 
                     <td><input class="product-quantity" type="number" value="1"></td>
                     <td><input class="product-request" type="text" value=""></td>              
                     <td class="no-wrap">
                     <!-- Dropdown Trigger -->
                     <a href='javascript:;' class="remove-product" onclick="deleteProduct($(this))"><i class="material-icons valign-center">remove_circle</i></a>                     
                     </td>
                     </tr>`;
                tableHTML.append(html);
            });
            $('.create-product').on('click', '.remove-product', function () {
                $(this).parent().parent().fadeOut(function () {
                    $(this).remove();
                });
            });
        });
    </script>
    <style>
        .border-select {
            border: solid 2px red !important;
        }
    </style>
</asp:Content>
