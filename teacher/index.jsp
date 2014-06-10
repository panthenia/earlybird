    <%@ page contentType="text/html; charset=utf-8" language="java" %>
        <%@ page import="com.atm.model.User"%>
        <%@ page import="com.atm.util.Utils"%>
        <%@ page import="com.atm.model.Semester"%>

            <%
User cu = Utils.getCurUser(request);
if (cu.getId() == null || cu.getId() == 0) {
request.setAttribute("msg", Utils.ERR_PLEASELOGIN);
request.getRequestDispatcher("/error.jsp").forward(request, response);
return;

}
String username = cu.getName();
if (username.equals("")) {
username = cu.getAcc();
}
%>

    <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="keywords" content="teach ATM"/>
    <title>EarlyBird</title>
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="css/page.css"/>
    <link rel="stylesheet" href="css/atm.css"/>
</head>
<body>
<div class="header">
    <div class="header-nav">
        <ul>
            <li class="hn-1">
                <span class="header-title"><img src="css/image/headr-title.png"></span> <span><img
                    src="css/image/c-1.png"/><img src="css/image/c-2.png"/>  </span>
            </li>
            <li class="hn-2" onclick="window.location.href='select.jsp'">Academic&nbsp;Time&nbsp;Management
                <div class="tools" style="width:10px"><img src="css/image/tool.jpg"/></div>
            </li>
            <li onclick="window.location.href='town.jsp'">Teachers Town</li>
        </ul>
    </div>
    <div class="header-sign">
        <a><%=username%></a>

        <div><img src="css/image/user.png"></div>
    </div>
</div>
        <div class="page-border"></div>
<!-- main -->
<div class="main">
    <div class="main_atm">
        <img src="css/image/pic_img1.png" width="274" height="262" style="display:block; float:left;">

        <div class="main_atm_r">
            <span>ATM</span>
            <samp>Academic Time Management</samp>
            <ul class="ul_atm">
                <li><p>Grouping engine</p></li>
                <li><p>Participation rewards</p></li>
                <li><p>Records keeping easy</p></li>
            </ul>
            <input name="" type="button" value="Click Here" class="btn_01" onclick="goto_atm()">
        </div>
    </div>
    <img src="css/image/line.jpg" width="693" height="1" style="display:block; margin-top:40px;">

    <div class="main_teachers">
        <div class="main_teachers_left">
            <span>Teachers Talk</span>
            <ul class="ul_atm">
                <li><p>Share and Search material</p></li>
                <li><p>Extended online learning</p></li>
                <li><p>Connection</p></li>
            </ul>
            <input name="" type="button" value="Click Here" class="btn_01" onclick="goto_tt()">
        </div>
        <img src="css/image/pic_img2.png" width="274" height="256" style="display:block; float:right;">
    </div>

</div>
<!-- main -->


<div class="footer"></div>
<script>
    function goto_atm() {
        window.location.href = 'select.jsp';
    }
    function goto_tt() {
        window.location.href = 'town.jsp';
    }
</script>
</body>
</html>
