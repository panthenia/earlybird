<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="com.atm.model.User" %>
<%@ page import="com.atm.util.Utils" %>
<%@ page import="com.atm.model.Semester" %>

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
    <title>ATM</title>
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="css/page.css"/>
    <link rel="stylesheet" href="css/atm.css"/>
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/public.js"></script>
    <script type="text/javascript" src="js/show.js"></script>
</head>
<body>
<style>
    .head-text{
        margin-top: 50px;
        margin-left: 200px;
        position: relative;
        width: 200px;
        height: 100px;
    }
    .head-text #clzname{
        display: block;
        line-height: 50px;
        font-size: 35px;
        font-weight: bold;
        color: #34495e;
        float: right;
        font-family: Arial, Helvetica, sans-serif;
    }
    .head-text #clzgrade{
        display: block;
        line-height: 30px;
        font-size: 20px;
        float: right;
        color: #34495e;
        font-family: Arial, Helvetica, sans-serif;
    }
    #splash_img{
        margin: 0 auto;
    }
    .user-box-model{
        margin: 50px auto 0;
        width: 840px;
        position: relative;
    }

    .user-list-left{
        width: 250px;
        float: left;
        margin-bottom: 50px;
    }
    .user-list-mid{
        margin-left: 45px;
        width: 250px;
        float: left;
    }
    .user-list-right{
        margin-left: 45px;
        width: 250px;
        float: left;

    }
    .user-item{
        width: 250px;
        height: 40px;
        margin-top: 5px;
    }
    .user-logo{
        width:30px;
        height:30px;
        border-radius:50px;
        vertical-align:middle;
    }
    .user-name{
        width: 140px;
        color: #34495e;
        font-size: 15px;
        font-weight:bold ;
        display: inline-block;
        margin-left: 5px;
    }
    .user-star{
        width:25px;
        height:25px;
        vertical-align:middle;
    }
    .user-score{
        width: 30px;
        display: inline-block;
        font-size: 15px;
        color: #34495e;
        font-weight: bold;
        margin-left: 5px;
    }
</style>
<div class="header">
    <div class="header-nav fn-clear">
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
    <div class="town-header-sign fn-clear">
        <em>
            <%=username%>
        </em>

        <div>
            <a class="account-user">
                <img src="../css/image/user.png">
            </a>

            <div class="account-list">
                <img src="../css/image/sanjx.jpg"/>
                <ul>
                    <li class="account-li-first">
                        Profile Settings
                    </li>
                    <li class="account-li-last">
                        Logout
                    </li>

                </ul>
            </div>
        </div>
        <div>
            <img src="../css/image/infonm.png"/>
            <a>
                <div class="whatnm">
                    5
                </div>
            </a>
        </div>
        <div>
            <a>
                <img src="../css/image/tools.png"/>
            </a>
        </div>
    </div>

</div>
<div class="page-border"></div>
<!-- main -->
    <div class="head-text">
        <div  id="clzname"><%=request.getParameter("name")%></div>
        <div  id="clzgrade"><%=request.getParameter("grade")%></div>
        <div id="crsid" style="display: none"><%=request.getParameter("crsid")%></div>
    </div>
    <img id="splash_img" src="css/image/line.jpg" width="693" height="1" style="display:block;">

    <div class="user-box-model" style="display: none" id="box-model">
        <div class=" user-list-left">
            <div class="user-item" style="display: none" id="left-item-model">
                <img class="user-logo" src="images/guangzhao.png">
                <span class="user-name">Barack Obama</span>
                <img class="user-star" src="images/star-full.png">
                <span class="user-score"> = 5</span>
            </div>
        </div>
        <div class="user-list-mid">
            <div class="user-item" style="display: none" id="mid-item-model">
                <img class="user-logo" src="images/guangzhao.png">
                <span class="user-name">Barack Obama</span>
                <img class="user-star" src="images/star-full.png">
                <span class="user-score"> = 5</span>
            </div>
        </div>
        <div class="user-list-right">
            <div class="user-item" style="display: none" id="right-item-model">
                <img class="user-logo" src="images/guangzhao.png">
                <span class="user-name">Barack Obama</span>
                
                <img class="user-star" src="images/star-full.png">
                <span class="user-score"> = 5</span>
            </div>
        </div>

        <img src="css/image/line.jpg" width="693" height="1" style="display:block;">
    </div>

<div class="footer"></div>
</body>

</html>
