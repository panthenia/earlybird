    <%@ page contentType="text/html; charset=utf-8" language="java" %>
        <%@ page import="com.atm.model.User"%>
        <%@ page import="com.atm.util.Utils"%>
        <%@ page import="com.atm.model.Semester"%>

            <%
User cu = Utils.getCurUser(request);
Semester sm = Utils.getCurSem(request);
if (cu.getId() == null || cu.getId() == 0) {
request.setAttribute("msg", Utils.ERR_PLEASELOGIN);
request.getRequestDispatcher("/error.jsp").forward(request, response);
return;
}
int semid;
if(sm == null)
    semid = 0;
else semid = sm.getId();
String username = cu.getName();
if (username.equals("")) {
username = cu.getAcc();
}
%>
    <!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <title>ATM</title>
    <link rel="stylesheet" href="../css/base.css"/>
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="css/atm.css"/>
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/public.js"></script>
    <script type="text/javascript" src="js/score.js"></script>
</head>
<body>
        <p id="gnum" style="display:none"><%=request.getParameter("gnum")%></p>
        <p id="crsid" style="display:none"><%=request.getParameter("crsid")%></p>
        <p id="clzid" style="display:none"><%=request.getParameter("clzid")%></p>
        <p id="userid" style="display:none"><%= cu.getId() %></p>
        <p id="semid" style="display:none"><%=semid%></p>
        <p id="userphoto" style="display:none"><%=cu.getPhoto()%></p>
        <p id="schid" style="display:none"><%=cu.getSchid()%></p>
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
<div class="container">
    <div class="container-left fn-clear">
        <div class="classname">
            <h1><%=request.getParameter("clzname")%></h1>

            <p><%=request.getParameter("grade")%></p>
        </div>
        <div class="timeout">
        <div class="group-br"></div>
            <div class="timeshow fn-clear" id="timeshow">
                00:00
            </div>
            <p><em class="min">min</em><em class="sec">sec</em></p>

            <div class="timetool">
                <a class="start"><img src="css/image/start.jpg"></a>
                <a class="stop"><img src="css/image/stop.jpg"/> </a>
                <a class="clear"><img src="css/image/clear.png"/> </a>
            </div>

        </div>
    </div>
    <div class="container-right fn-clear">
        <div class="group" style="display: none" id="group-model">
            <div class="group-br"></div>
            <div class="group-child">
                <div class="group-child-child" id="group-a" style="display: none">
                    <div class="group-child-child-title">
                        <h1>Group A</h1>

                        <div class="score">
                            SCORE
                        </div>
                        <div class="score-list">
                            <ul>
                                <li>1</li>
                                <li>2</li>
                                <li>3</li>
                                <li>4</li>
                                <li>5</li>
                            </ul>
                        </div>
                    </div>
                    <div class="group-list">
                        <ul>

                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>
