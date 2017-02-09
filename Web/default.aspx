﻿<%@ Page Language="C#" MasterPageFile="default.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="_default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cp" runat="Server">
    <script type="text/javascript" src="<%=Request.ApplicationPath%>/js/pager.js<%=Global.Quid %>"></script>
    <script type="text/javascript">
        var rootUrl = "<%=Request.ApplicationPath%>";
        var articleServiceUrl = rootUrl + "/service/ajaxarticleservice.aspx";
        var tagServiceUrl = rootUrl + "/service/ajaxtagservice.aspx";
        var langPager = {
            prePage: "上一頁",
            nextPage: "下一頁",
            pagerInfo: "總共有{0}篇文章，共{1}頁"
        };
        var gPageIndex = <%=PageIndex%>;
        var gPageSize = <%=PageSize%>;
        var offset = "<%=WebUtility.GetCurrentUserUTCOffset().ToString()%>";

        $(document).ready(function () {
            SetPagerText(langPager.prePage, langPager.nextPage, langPager.pagerInfo);
            WriteUI();
        });

        function UpdatePagerParamAndCallShowResult(pageIndex, pageSize) {
            gPageIndex = parseInt(pageIndex, 10);
            gPageSize = parseInt(pageSize, 10);
            WriteUI()
        }

        function WriteUI() {
            $("#articles").html("");
            $("#pager").html("");
            ShowResult(gPageIndex, gPageSize);
        }
        function ShowResult(pageIndex, pageSize) {
            var param = "cmd=batchget"
                + "&pageindex=" + pageIndex
                + "&pagesize=" + pageSize;
            $.getJSON(articleServiceUrl, param, GetResult)
        }
        function GetResult(data) {
            arrResult = new Array();
            var pageIndexFromResult = 0;
            if (data.Success) {
                $.each(data.Data.PageOfResults, function (i, n) {
                    arrResult.push(n);
                });
                totalCount = data.Data.TotalCount;
                pageIndexFromResult = data.Data.PageNumber;
            } else {
                totalCount = 0;
            }

            if (data.Data.TotalCount <= 0) {
                $("#articles").html(GetNoDataStyle());
                return;
            }
            WriteResult();

            var pageCount;
            if (gPageIndex == null) {
                gPageIndex = 0;
            }
            if (gPageSize == null) {
                gPageSize = 10;
            }
            if ((totalCount % gPageSize) == 0) {
                pageCount = totalCount / gPageSize;
            } else {
                pageCount = parseInt((totalCount / gPageSize).toString(), 10) + 1;
            }
            CreatePagerUsingPagerJS((pageIndexFromResult != gPageIndex ? pageIndexFromResult : gPageIndex), gPageSize, pageCount, totalCount);
        }
        function WriteResult() {
            $("#articles").html("");
            var html = "";
            $.each(arrResult, function (i, n) {
                html += RenderResult(rootUrl, n, offset);
            });
            $("#articles").html(html);
        }
		function GetNoDataStyle() {
			return "<h4>查無文章</h4>"
		}		
    </script>
    <header class="intro-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="site-heading">
                        <h1 class="tagline">Liquid Trouse 電音誌</h1>
                        <div class="subheading tagline">幾個對電音及派對文化有興趣的年輕人所開的網誌，專門分享 Trance & House 音樂及相關資訊</div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    <small>文章列表</small>
                </h1>
            </div>
        </div>
        <div id="articles"></div>
        <div class="row text-center">
            <ul id="pager" class="pager"></ul>
        </div>
    </div>
</asp:Content>

