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
		<meta charset="utf-8" />
		<meta name="keywords" content="teach ATM" />
		<title>ATM</title>
		<link rel="stylesheet" href="../css/base.css" >
		<link rel="stylesheet" href="../css/public.css" />
        <link rel="stylesheet" href="css/page.css" />
        <link rel="stylesheet" href="css/atm.css"/>
        <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="js/group.js"></script>
	</head>
	<body>
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
            <a>
                <%=username%>
            </a>

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
<div class="main">
<img src="css/image/line.jpg" width="693" height="1" style="display:block;">
<div class="group">
<div class="group_left">
<span class="group_span1" id="clzname"><%=request.getParameter("name")%></span>
<span class="group_span2" id="clzgrade"><%=request.getParameter("grade")%></span>
<span class="group_span3">GROUP</span>
<span class="group_span4">分组方式</span>
</div>
<input type="button" value="players in a team" class="btn_03" >
<div class="group_right" style="display:none">
<span class="group_span5">输入人数</span>
<input name="" type="text" class="text_01">
<input name="" type="button" value="分组" class="btn_02" clzid="<%=request.getParameter("clzid")%>" crsid="<%=request.getParameter("crsid")%>">
</div>
</div>
<img src="css/image/line.jpg" width="693" height="1" style="display:block;">
</div>
<!-- main -->


	<div class="footer"></div>
	</body>

</html>
