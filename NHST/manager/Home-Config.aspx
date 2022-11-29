﻿<%@ Page Title="" Language="C#" MasterPageFile="~/manager/adminMasterNew.Master" AutoEventWireup="true" CodeBehind="Home-Config.aspx.cs" Inherits="NHST.manager.Home_Config" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Import Namespace="NHST.Controllers" %>
<%@ Import Namespace="NHST.Models" %>
<%@ Import Namespace="NHST.Bussiness" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/css/gijgo.min.css" rel="stylesheet" type="text/css" />
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/js/gijgo.min.js" type="text/javascript"></script>
    <style>
        .register-link {
            color: blue;
            text-decoration: underline;
            font-style: italic;
        }

        .panel-body {
            background: #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="main" class="main-full">
        <div class="row">
            <div class="content-wrapper-before bg-dark-gradient"></div>
            <div class="page-title">
                <div class="card-panel">
                    <h4 class="title no-margin" style="display: inline-block;">CẤU HÌNH TRANG CHỦ</h4>

                </div>
            </div>

            <div class="list-staff col s12 section">
                <div class="list-table card-panel">

                    <div class="tb-header mb-2">
                        <h5>Danh sách menu</h5>
                        <div class="right-action" style="margin-left: 5px;">
                            <a href="/manager/AddParentMenu" class="btn modal-trigger waves-effect">Thêm menu cha</a>
                        </div>
                    </div>
                    <div class="responsive-tb">
                        <div id="tree_1" class="tree-demo">
                            <asp:Literal ID="ltrTree" runat="server"></asp:Literal>
                        </div>
                        <div>
                            <a class="btn primary-btn" onclick="Test()">Cập nhật</a>
                        </div>
                    </div>
                </div>
            </div>


            <div class="list-staff col s12 section" style="display:none">
                <div class="list-table card-panel">
                    <div class="tb-header mb-2">
                        <h5>Danh sách các bước</h5>
                    </div>
                    <div class="responsive-tb">
                        <table class="table bordered centered highlight">
                            <thead>
                                <tr>
                                    <th>Tên bước</th>
                                    <th>Hình ảnh</th>
                                    <th class="tb-date">Link</th>
                                    <th class="tb-date">Index</th>
                                    <th class="tb-date">Trạng thái</th>
                                    <th class="tb-date">Ngày tạo</th>
                                    <th class="tb-date">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Literal runat="server" ID="ltrListStep"></asp:Literal>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="list-staff col s12 section">
                <div class="list-table card-panel">
                    <div class="tb-header mb-2">
                        <h5>Danh sách dịch vụ</h5>
                    </div>
                    <div class="responsive-tb">
                        <table class="table bordered centered highlight">
                            <thead>
                                <tr>
                                    <th>Vị trí</th>
                                    <th>Tên dịch vụ</th>
                                    <th>Hình ảnh</th>
                                    <th class="tb-date">Trạng thái</th>
                                    <th class="tb-date">Ngày tạo</th>
                                    <th class="tb-date">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Literal runat="server" ID="ltrListService"></asp:Literal>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
            <div class="list-staff col s12 section">
                <div class="list-table card-panel">
                    <div class="tb-header mb-2">
                        <h5>Danh sách quyền lợi khách hàng</h5>
                    </div>
                    <div class="responsive-tb">
                        <table class="table bordered centered highlight">
                            <thead>
                                <tr>
                                    <th>Tên quyền lợi</th>
                                    <th class="tb-date">Trạng thái</th>
                                    <th>Vị trí</th>
                                    <th>Loại</th>
                                    <th class="tb-date">Ngày tạo</th>
                                    <th class="tb-date">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Literal runat="server" ID="ltrListCustomersBenefit"></asp:Literal>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

               <div class="list-staff col s12 section" style="display:none">
                <div class="list-table card-panel">
                    <div class="tb-header mb-2">
                        <h5>Danh sách câu hỏi thường gặp</h5>
                    </div>
                    <div class="responsive-tb">
                        <table class="table bordered centered highlight">
                            <thead>
                                <tr>
                                    <th>Tên câu hỏi</th>
                                    <th>Nội dung</th>
                                    <th>Vị trí</th>
                                    <th>Trạng thái</th>
                                    <th class="tb-date">Ngày chỉnh sửa</th>
                                    <th class="tb-date">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Literal runat="server" ID="ltrQuestion"></asp:Literal>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="list-staff col s12 section" style="display:none">
                <div class="list-table card-panel">
                    <div class="tb-header mb-2">
                        <h5>Danh sách tin tức mới và vận chuyển hàng Trung Quốc</h5>
                    </div>
                    <div class="responsive-tb">
                        <table class="table bordered centered highlight">
                            <thead>
                                <tr>
                                    <th>Tên tin</th>
                                    <th>Nội dung</th>
                                    <th>Vị trí</th>
                                    <th>Loại</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Literal runat="server" ID="ltrListNews"></asp:Literal>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="list-staff col s12 section" style="display: none">
                <div class="list-table card-panel">
                    <div class="tb-header mb-2">
                        <h5>Danh sách khách hàng đánh giá</h5>
                    </div>
                    <div class="responsive-tb">
                        <table class="table bordered centered highlight">
                            <thead>
                                <tr>
                                    <th>Tên khách hàng</th>
                                    <th>Nội dung</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày sửa</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Literal runat="server" ID="ltrCustomers"></asp:Literal>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- END: Page Main-->
    <div id="modalEditCustomers" class="modal modal-fixed-footer">
        <div class="modal-hd">
            <span class="right"><i class="material-icons modal-close right-align">clear</i></span>
            <h4 class="no-margin center-align">Chỉnh sửa đánh giá khách hàng</h4>
        </div>
        <div class="modal-bd">
            <div class="row">
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="txtNameCustomers" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Tên khách hàng</label>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="txtContentCustomers" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Nội dung tin</label>
                </div>               
                <div class="input-field col s12">
                    <span class="black-text">Hình ảnh</span>
                    <div style="display: inline-block; margin-left: 15px;">
                        <asp:FileUpload runat="server" ID="EditCustomersIMG" class="upload-img" type="file" onchange="previewFiles(this);" title=""></asp:FileUpload>
                        <button class="btn-upload">Upload</button>
                    </div>
                    <div class="preview-img">
                        <asp:Image ID="EditCustomersIMGBefore" runat="server" />
                    </div>
                </div>
                <div class="input-field col s12">
                    <div class="switch status-func">
                        <span class="mr-2">Trạng thái: </span>
                        <label>
                            Ẩn<asp:TextBox runat="server" ID="EditCustomersStatus" onclick="CustomersStatusFunction()" type="checkbox"></asp:TextBox><span class="lever"></span>Hiện
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-ft">
            <div class="ft-wrap center-align">
                <a id="btnUpCustomers" onclick="btnUpCustomers()" class="modal-action btn modal-close waves-effect waves-green mr-2">Cập nhật</a>
                <a href="#!" class="modal-action btn orange darken-2 modal-close waves-effect waves-green ml-2">Hủy</a>
            </div>
        </div>
    </div>
    <!-- BEGIN: Modal edit step -->
    <asp:HiddenField ID="hdfIDCustomers" runat="server" />
    <asp:HiddenField ID="hdfEditCustomersStatus" runat="server" Value="0" />
    <asp:Button ID="buttonUpCustomers" runat="server" OnClick="btnUpCustomers_Click" Style="display: none" />

    <!-- END: Page Main-->
    <div id="modalEditNews" class="modal modal-fixed-footer">
        <div class="modal-hd">
            <span class="right"><i class="material-icons modal-close right-align">clear</i></span>
            <h4 class="no-margin center-align">Chỉnh sửa tin tức</h4>
        </div>
        <div class="modal-bd">
            <div class="row">
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="EditNewsTitle" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Tên tin tức</label>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="EditNewsSummary" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Nội dung tin</label>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="EditNewsLink" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-link">Link</label>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" placeholder="" ID="EditNewsPosition" TextMode="Number" min="0"></asp:TextBox>
                    <label class="active">Vị trí</label>
                </div>
                 <div class="input-field col s12">
                    <asp:ListBox runat="server" name="" ID="ddlTypeNews">
                        <asp:ListItem Value="1">Tin tức mới</asp:ListItem>
                        <asp:ListItem Value="2">Vận chuyển hàng Trung Quốc</asp:ListItem>
                    </asp:ListBox>
                    <label>Loại</label>
                </div>
                <div class="input-field col s12">
                    <span class="black-text">Hình ảnh</span>
                    <div style="display: inline-block; margin-left: 15px;">
                        <asp:FileUpload runat="server" ID="EditNewsIMG" class="upload-img" type="file" onchange="previewFiles(this);" title=""></asp:FileUpload>
                        <button class="btn-upload">Upload</button>
                    </div>
                    <div class="preview-img">
                        <asp:Image ID="EditNewsIMGBefore" runat="server" />
                    </div>
                </div>
                <div class="input-field col s12">
                    <div class="switch status-func">
                        <span class="mr-2">Trạng thái: </span>
                        <label>
                            Ẩn<asp:TextBox runat="server" ID="EditNewsStatus" onclick="NewsStatusFunction()" type="checkbox"></asp:TextBox><span class="lever"></span>Hiện
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-ft">
            <div class="ft-wrap center-align">
                <a id="btnUpNews" onclick="btnUpNews()" class="modal-action btn modal-close waves-effect waves-green mr-2">Cập nhật</a>
                <a href="#!" class="modal-action btn orange darken-2 modal-close waves-effect waves-green ml-2">Hủy</a>
            </div>
        </div>
    </div>
    <!-- BEGIN: Modal edit step -->
    <asp:HiddenField ID="hdfIDNews" runat="server" />
    <asp:Button ID="buttonUpNews" runat="server" OnClick="btnUpNews_Click" Style="display: none" />
    <asp:HiddenField ID="hdfEditNewsID" runat="server" Value="0" />
    <asp:HiddenField ID="hdfEditNewsStatus" runat="server" Value="0" />
    <!-- BEGIN: Modal edit step -->
    <div id="modalEditStep" class="modal modal-fixed-footer">
        <div class="modal-hd">
            <span class="right"><i class="material-icons modal-close right-align">clear</i></span>
            <h4 class="no-margin center-align">Chỉnh sửa bước</h4>
        </div>
        <div class="modal-bd">
            <div class="row">
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" ID="EditStepName" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Tên bước</label>
                </div>
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" ID="EditStepIndex" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-number">Sắp xếp</label>
                </div>
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" ID="EditStepClassIcon" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-icon">Class icon</label>
                </div>
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" ID="EditStepLink" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-link">Link</label>
                </div>
                <div class="input-field col s12">
                    <span class="black-text">Hình ảnh</span>
                    <div style="display: inline-block; margin-left: 15px;">
                        <asp:FileUpload runat="server" ID="EditStepIMG" class="upload-img" type="file" onchange="previewFiles(this);" title=""></asp:FileUpload>
                        <button class="btn-upload">Upload</button>
                    </div>
                    <div class="preview-img">
                        <asp:Image ID="EditIMGBefore" runat="server" />
                    </div>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" placeholder="" ID="EditStepSumary" class="materialize-textarea"></asp:TextBox>
                    <label class="active">Mô tả ngắn</label>
                </div>
                <div class="input-field col s12">
                    <div class="switch status-func">
                        <span class="mr-2">Trạng thái:  </span>
                        <label>
                            Ẩn<asp:TextBox ID="EditStepStatus" runat="server" type="checkbox" onclick="StatusStepFunction()"></asp:TextBox><span class="lever"></span>
                            Hiện
                        </label>

                    </div>
                </div>
            </div>
        </div>
        <div class="modal-ft">
            <div class="ft-wrap center-align">
                <a id="BtnUpStep" onclick="btnUpStep()" class="modal-action btn modal-close waves-effect waves-green mr-2">Cập nhật</a>
                <a href="#!" class="modal-action btn orange darken-2 modal-close waves-effect waves-green ml-2">Hủy</a>
            </div>
        </div>
    </div>
    <asp:Button ID="buttonUpdateStep" runat="server" OnClick="BtnUpStep_Click" Style="display: none" />
    <asp:HiddenField ID="hdfStepID" runat="server" Value="0" />
    <asp:HiddenField ID="hdfStepStatus" runat="server" Value="0" />
    <!-- END: Modal edit step -->

    <!-- BEGIN: Modal edit services -->
    <div id="modalEditServices" class="modal modal-fixed-footer">
        <div class="modal-hd">
            <span class="right"><i class="material-icons modal-close right-align">clear</i></span>
            <h4 class="no-margin center-align">Chỉnh sửa dịch vụ</h4>
        </div>
        <div class="modal-bd">
            <div class="row">
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="EditServicesTitle" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Tiêu đề</label>
                </div>
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" placeholder="" ID="EditServicesPosition" TextMode="Number" min="0"></asp:TextBox>
                    <label class="active">Vị trí</label>
                </div>
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" ID="EditServicesLink" type="text" class="validate" data-type="text-only" placeholder=""></asp:TextBox>
                    <label class="active" for="edit__step-link">Link</label>
                </div>
                <div class="input-field col s12">
                    <span class="black-text">Hình ảnh</span>
                    <div style="display: inline-block; margin-left: 15px;">
                        <asp:FileUpload runat="server" ID="EditServicesIMG" class="upload-img" type="file" onchange="previewFiles(this);" title=""></asp:FileUpload>
                        <button class="btn-upload">Upload</button>
                    </div>
                    <div class="preview-img">
                        <asp:Image ID="EditServicesIMGBefore" runat="server" />
                    </div>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" placeholder="" ID="EditServicesSummary" class="materialize-textarea"></asp:TextBox>
                    <label class="active">Mô tả ngắn</label>
                </div>

                <div class="input-field col s12">
                    <div class="switch status-func">
                        <span class="mr-2">Trạng thái: </span>
                        <label>Ẩn<asp:TextBox ID="EditServicesStatus" onclick="ServicesStatusFunction()" runat="server" type="checkbox"></asp:TextBox><span class="lever"></span>Hiện</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-ft">
            <div class="ft-wrap center-align">
                <a id="btnUpService" onclick="btnUpService()" class="modal-action btn modal-close waves-effect waves-green mr-2">Cập nhật</a>
                <a href="#!" class="modal-action btn orange darken-2 modal-close waves-effect waves-green ml-2">Hủy</a>
            </div>

        </div>
    </div>
    <asp:Button ID="buttonUpServices" runat="server" OnClick="btnUpServices_Click" Style="display: none" />
    <asp:HiddenField ID="hdfEditServicesID" runat="server" Value="0" />
    <asp:HiddenField ID="hdfEditServicesStatus" runat="server" Value="0" />
    <!-- END: Modal edit services -->
        <div id="modalEditQuest" class="modal modal-fixed-footer">
        <div class="modal-hd">
            <span class="right"><i class="material-icons modal-close right-align">clear</i></span>
            <h4 class="no-margin center-align">Chỉnh sửa câu hỏi thường gặp</h4>
        </div>
        <div class="modal-bd">
            <div class="row">
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="txtNameQuest" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Tên câu hỏi</label>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="txtContentQuest" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Nội dung câu hỏi</label>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" ID="txtLinkQuest" placeholder="" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-link">Link</label>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" placeholder="" ID="txtIndexQuest" TextMode="Number" min="0"></asp:TextBox>
                    <label class="active">Vị trí</label>
                </div>
                <div class="input-field col s12">
                    <div class="switch status-func">
                        <span class="mr-2">Trạng thái: </span>
                        <label>
                            Ẩn<asp:TextBox runat="server" ID="EditQuestStatus" onclick="QuestStatusFunction()" type="checkbox"></asp:TextBox><span class="lever"></span>Hiện
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-ft">
            <div class="ft-wrap center-align">
                <a id="btnUpQuest" onclick="btnUpQuest()" class="modal-action btn modal-close waves-effect waves-green mr-2">Cập nhật</a>
                <a href="#!" class="modal-action btn orange darken-2 modal-close waves-effect waves-green ml-2">Hủy</a>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hdfIDQuest" runat="server" />
    <asp:Button ID="buttonUpQuest" runat="server" OnClick="btnUpQuest_Click" Style="display: none" />
    <asp:HiddenField ID="hdfEditQuestID" runat="server" Value="0" />
    <asp:HiddenField ID="hdfEditQuestStatus" runat="server" Value="0" />
    <!-- BEGIN: Modal edit Benefit -->
    <div id="modalEditBenefits" class="modal modal-fixed-footer">
        <div class="modal-hd">
            <span class="right"><i class="material-icons modal-close right-align">clear</i></span>
            <h4 class="no-margin center-align">Chỉnh sửa quyền lợi khách hàng</h4>
        </div>
        <div class="modal-bd">
            <div class="row">
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" placeholder="" ID="EditBenefitName" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-name">Tên quyền lợi</label>
                </div>
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" placeholder="" ID="EditBenefitPosition" type="number" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-number">Vị trí</label>
                </div>
                <div class="input-field col s12 m6">
                    <asp:TextBox runat="server" placeholder="" ID="EditBenefitLink" type="text" class="validate" data-type="text-only"></asp:TextBox>
                    <label class="active" for="edit__step-link">Link</label>
                </div>
                <div class="input-field col s12 m6">
                    <asp:ListBox runat="server" name="" ID="ddlEditBenefitType">
                        <asp:ListItem Value="1">Cam kết của chúng tôi</asp:ListItem>
                        <asp:ListItem Value="2">Quyền lợi khách hàng</asp:ListItem>
                    </asp:ListBox>
                    <label>Loại</label>
                </div>
                <div class="input-field col s12">
                    <span class="black-text">Hình ảnh</span>
                    <div style="display: inline-block; margin-left: 15px;">
                        <asp:FileUpload runat="server" ID="EditBenefitIMG" class="upload-img" type="file" onchange="previewFiles(this);" title=""></asp:FileUpload>
                        <button class="btn-upload">Upload</button>

                    </div>
                    <div class="preview-img">
                        <asp:Image ID="EditBenefitIMGBefore" runat="server" />
                    </div>
                </div>
                <div class="input-field col s12">
                    <asp:TextBox runat="server" placeholder="" ID="EditBenefitDescription" class="materialize-textarea"></asp:TextBox>
                    <label class="active">Mô tả ngắn</label>
                </div>
                <div class="input-field col s12">
                    <div class="switch status-func">
                        <span class="mr-2">Trạng thái: </span>
                        <label>
                            Ẩn
                    <asp:TextBox runat="server" ID="EditBenefitStatus" onclick="BenefitStatusFunction()" type="checkbox"></asp:TextBox>
                            <span class="lever"></span>
                            Hiện
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-ft">
            <div class="ft-wrap center-align">
                <a id="btnUpBenefit" onclick="btnUpBenefit()" class="modal-action btn modal-close waves-effect waves-green mr-2">Cập nhật</a>
                <a href="#!" class="modal-action btn orange darken-2 modal-close waves-effect waves-green ml-2">Hủy</a>
            </div>
        </div>
    </div>
    <asp:Button runat="server" ID="btnUpdate" OnClick="btnUpdate_Click" Style="display: none;" />
    <asp:HiddenField runat="server" ID="hdfTest" />
    <asp:HiddenField ID="hdfID" runat="server" />
    <asp:Button ID="buttonUpBenefit" runat="server" OnClick="btnUpBenefit_Click" Style="display: none" />
    <asp:HiddenField ID="hdfEditBenefitID" runat="server" Value="0" />
    <asp:HiddenField ID="hdfEditBenefitStatus" runat="server" Value="0" />
    <asp:HiddenField runat="server" ID="hdfMenuID" />
    <asp:Button runat="server" ID="btnDeleteMenu" Style="display: none" OnClick="btnDeleteMenu_Click" />
    <script type="text/javascript">
        function btnUpStep() {
            $('#<%=buttonUpdateStep.ClientID%>').click();
        }
        function btnUpService() {
            $('#<%=buttonUpServices.ClientID%>').click();
        }
        function btnUpBenefit() {
            $('#<%=buttonUpBenefit.ClientID%>').click();
        }
        function btnUpNews() {
            $('#<%=buttonUpNews.ClientID%>').click();
        }
        function btnUpCustomers() {
            $('#<%=buttonUpCustomers.ClientID%>').click();
        }
        function btnUpQuest() {
            $('#<%=buttonUpQuest.ClientID%>').click();
        }
        function editMenu(ID) {
            var win = window.open("/manager/editmenu.aspx?i=" + ID + "", '_blank');
            //win.focus();
            //window.location = "/admin/categoryinfo.aspx?ID=" + ID + "";
        }
        function AddChildMenu(ID) {
            var win = window.open("/manager/AddMenu.aspx?ID=" + ID + "", '_blank');
            //win.focus();
            //window.location = "/admin/addChildCategory.aspx?ID=" + ID + "";
        }
        function DeleteMenu(ID) {
            var c = confirm('Bạn muốn xóa menu này??');
            if (c) {
                $("#<%=hdfMenuID.ClientID%>").val(ID);
                $("#<%=btnDeleteMenu.ClientID%>").click();
            }
        }
        function EditCustomers(ID) {
            $.ajax({
                type: "POST",
                url: "/manager/Home-Config.aspx/loadinfoCustomers",
                data: '{ID: "' + ID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var data = JSON.parse(msg.d);
                    if (data != null) {
                        $('#<%=txtNameCustomers.ClientID%>').val(data.Fullname);
                        $('#<%=txtContentCustomers.ClientID%>').val(data.ContactContent);
                        $('#<%=EditCustomersIMGBefore.ClientID%>').attr("src", data.Images);
                        var a = data.IsHidden;
                        if (a == false) {
                            $('#<%=EditCustomersStatus.ClientID%>').prop('checked', true);
                            $('#<%=hdfEditCustomersStatus.ClientID%>').val('0');
                        }
                        else {
                            $('#<%=EditCustomersStatus.ClientID%>').prop('checked', false);
                            $('#<%=hdfEditCustomersStatus.ClientID%>').val('1');
                        }
                        $('#<%=hdfIDCustomers.ClientID%>').val(data.ID);
                        $('select').formSelect();
                    }
                    else
                        swal("Error", "Không thành công", "error");
                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    swal("Error", "Fail updateInfoAcc", "error");
                }
            });
        }
        function EditNews(ID) {
            $.ajax({
                type: "POST",
                url: "/manager/Home-Config.aspx/loadinfoNews",
                data: '{ID: "' + ID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var data = JSON.parse(msg.d);
                    if (data != null) {
                        $('#<%=EditNewsTitle.ClientID%>').val(data.NewsTitle);
                        $('#<%=EditNewsSummary.ClientID%>').val(data.NewsDesc);
                        $('#<%=EditNewsLink.ClientID%>').val(data.NewsLink);
                        $('#<%=EditNewsPosition.ClientID%>').val(data.NewsPosition);
                        $('#<%=EditNewsIMGBefore.ClientID%>').attr("src", data.NewsIMG);
                        var a = data.IsHidden;
                        if (a == false) {
                            $('#<%=EditNewsStatus.ClientID%>').prop('checked', true);
                            $('#<%=hdfEditNewsStatus.ClientID%>').val('0');
                        }
                        else {
                            $('#<%=EditNewsStatus.ClientID%>').prop('checked', false);
                            $('#<%=hdfEditNewsStatus.ClientID%>').val('1');
                        }
                        $('#<%=hdfEditNewsID.ClientID%>').val(data.ID);
                        $('select').formSelect();
                    }
                    else
                        swal("Error", "Không thành công", "error");
                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    swal("Error", "Fail updateInfoAcc", "error");
                }
            });
        }
        function EditBenefits(ID) {
            $.ajax({
                type: "POST",
                url: "/manager/Home-Config.aspx/loadinfoBenefits",
                data: '{ID: "' + ID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var data = JSON.parse(msg.d);
                    if (data != null) {
                        $('#<%=EditBenefitName.ClientID%>').val(data.CustomerBenefitName);
                        $('#<%=EditBenefitPosition.ClientID%>').val(data.Position);
                        $('#<%=EditBenefitLink.ClientID%>').val(data.CustomerBenefitLink);
                        $('#<%=EditBenefitDescription.ClientID%>').val(data.CustomerBenefitDescription);
                        $('#<%=ddlEditBenefitType.ClientID%>').val(data.ItemType);
                        $('#<%=EditBenefitIMGBefore.ClientID%>').attr("src", data.Icon);
                        var a = data.IsHidden;
                        if (a == false) {
                            $('#<%=EditBenefitStatus.ClientID%>').prop('checked', true);
                            $('#<%=hdfEditBenefitStatus.ClientID%>').val('0');
                        }
                        else {
                            $('#<%=EditBenefitStatus.ClientID%>').prop('checked', false);
                            $('#<%=hdfEditBenefitStatus.ClientID%>').val('1');
                        }
                        $('#<%=hdfEditBenefitID.ClientID%>').val(data.ID);
                        $('select').formSelect();
                    }
                    else
                        swal("Error", "Không thành công", "error");
                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    swal("Error", "Fail updateInfoAcc", "error");
                }
            });
        }
        function EditServices(ID) {
            $.ajax({
                type: "POST",
                url: "/manager/Home-Config.aspx/loadinfoServices",
                data: '{ID: "' + ID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var data = JSON.parse(msg.d);
                    if (data != null) {
                        $('#<%=EditServicesTitle.ClientID%>').val(data.ServiceName);
                        $('#<%=EditServicesLink.ClientID%>').val(data.ServiceLink);
                        $('#<%=EditServicesSummary.ClientID%>').val(data.ServiceContent);
                        $('#<%=EditServicesPosition.ClientID%>').val(data.Position);
                        $('#<%=EditServicesIMGBefore.ClientID%>').attr("src", data.ServiceIMG);

                        var a = data.IsHidden;
                        if (a == false) {
                            $('#<%=EditServicesStatus.ClientID%>').prop('checked', true);
                            $('#<%=hdfEditServicesStatus.ClientID%>').val('0');
                        }
                        else {
                            $('#<%=EditServicesStatus.ClientID%>').prop('checked', false);
                            $('#<%=hdfEditServicesStatus.ClientID%>').val('1');
                        }
                        $('#<%=hdfEditServicesID.ClientID%>').val(data.ID);
                        $('select').formSelect();
                    }
                    else
                        swal("Error", "Không thành công", "error");
                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    swal("Error", "Fail updateInfoAcc", "error");
                }
            });
        }
        function ServicesStatusFunction() {
            var a = $('#<%=hdfEditServicesStatus.ClientID%>').val();
            if (a == '0') {

                $('#<%=hdfEditServicesStatus.ClientID%>').val('1');
            }
            else {

                $('#<%=hdfEditServicesStatus.ClientID%>').val('0');
            }
        }        
        function QuestStatusFunction() {
            var a = $('#<%=hdfEditQuestStatus.ClientID%>').val();
            if (a == '0') {

                $('#<%=hdfEditQuestStatus.ClientID%>').val('1');
            }
            else {

                $('#<%=hdfEditQuestStatus.ClientID%>').val('0');
            }
        }
        function BenefitStatusFunction() {
            var a = $('#<%=hdfEditBenefitStatus.ClientID%>').val();
            if (a == '0') {

                $('#<%=hdfEditBenefitStatus.ClientID%>').val('1');
            }
            else {

                $('#<%=hdfEditBenefitStatus.ClientID%>').val('0');
            }
        }
        function StatusStepFunction() {

            var a = $('#<%=hdfStepStatus.ClientID%>').val();
            if (a == '0') {

                $('#<%=hdfStepStatus.ClientID%>').val('1');
            }
            else {

                $('#<%=hdfStepStatus.ClientID%>').val('0');
            }
            console.log($('#<%=hdfStepStatus.ClientID%>').val());
        }
        function EditStep(ID) {
            $.ajax({
                type: "POST",
                url: "/manager/Home-Config.aspx/loadinfoStep",
                data: '{ID: "' + ID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var data = JSON.parse(msg.d);
                    if (data != null) {
                        $('#<%=EditStepName.ClientID%>').val(data.StepName);
                        $('#<%=EditStepIndex.ClientID%>').val(data.StepIndex);
                        $('#<%=EditStepSumary.ClientID%>').val(data.StepContent);
                        $('#<%=EditStepClassIcon.ClientID%>').val(data.ClassIcon);
                        $('#<%=EditStepLink.ClientID%>').val(data.StepLink);
                        $('#<%=EditIMGBefore.ClientID%>').attr("src", data.StepIMG);

                        var a = data.IsHidden;
                        if (a == false) {
                            $('#<%=EditStepStatus.ClientID%>').prop('checked', true);
                            $('#<%=hdfStepStatus.ClientID%>').val('0');
                        }
                        else {
                            $('#<%=EditStepStatus.ClientID%>').prop('checked', false);
                            $('#<%=hdfStepStatus.ClientID%>').val('1');
                        }
                        $('#<%=hdfStepID.ClientID%>').val(data.ID);
                        $('select').formSelect();
                    }
                    else
                        swal("Error", "Không thành công", "error");
                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    swal("Error", "Fail updateInfoAcc", "error");
                }
            });
        }

        function EditQuest(ID) {
            $.ajax({
                type: "POST",
                url: "/manager/Home-Config.aspx/loadinfoQuest",
                data: '{ID: "' + ID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var data = JSON.parse(msg.d);
                    if (data != null) {
                        $('#<%=txtNameQuest.ClientID%>').val(data.QuesTitle);
                        $('#<%=txtContentQuest.ClientID%>').val(data.QuesDesc);
                        $('#<%=txtLinkQuest.ClientID%>').val(data.QuesLink);
                        $('#<%=txtIndexQuest.ClientID%>').val(data.QuesPosition);
                        var a = data.IsHiden;
                        if (a == false) {
                            $('#<%=EditQuestStatus.ClientID%>').prop('checked', true);
                            $('#<%=hdfEditQuestStatus.ClientID%>').val('0');
                        }
                        else {
                            $('#<%=EditQuestStatus.ClientID%>').prop('checked', false);
                            $('#<%=hdfEditQuestStatus.ClientID%>').val('1');
                        }
                        $('#<%=hdfEditQuestID.ClientID%>').val(data.ID);
                        $('select').formSelect();
                    }
                    else
                        swal("Error", "Không thành công", "error");
                },
                error: function (xmlhttprequest, textstatus, errorthrow) {
                    swal("Error", "Fail updateInfoAcc", "error");
                }
            });
        }

        function Test() {
            var v = $('#tree_1').jstree(true).get_json('#', { flat: false });
            var mytext = JSON.stringify(v);
            console.log(v);
            var listitem = "";
            for (var i in v) {
                var item = "";
                var ids = "";
                if (typeof (v[i].li_attr.id) != "undefined") {
                    ids = v[i].li_attr.id;
                }
                var parent = [];
                if (typeof (v[i].children) != null) {
                    var child = v[i].children;
                    for (var j in child) {
                        if (typeof (child[j].id) != "undefined") {
                            parent += child[j].id + "|";
                        }
                        else {
                            parent += "|";
                        }
                    }
                }
                listitem += ids + "-" + parent + "*";
            };
            $("#<%=hdfTest.ClientID%>").val(listitem);
            $("#<%= btnUpdate.ClientID%>").click();
        }
    </script>
</asp:Content>
