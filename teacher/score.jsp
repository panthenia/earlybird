<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="com.atm.model.User" %>
<%@ page import="com.atm.util.Utils" %>
<%@ page import="com.atm.model.Semester" %>

<%
    User cu = Utils.getCurUser(request);
    Semester sm = Utils.getCurSem(request);
    if (cu.getId() == null || cu.getId() == 0) {
        request.setAttribute("msg", Utils.ERR_PLEASELOGIN);
        request.getRequestDispatcher("/error.jsp").forward(request, response);
        return;
    }
    int semid;
    if (sm == null)
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
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/public.js"></script>
    <script type="text/javascript" src="js/score.js"></script>
</head>
<body>
<p id="gnum" style="display:none"><%=request.getParameter("gnum")%>
</p>

<p id="crsid" style="display:none"><%=request.getParameter("crsid")%>
</p>

<p id="clzid" style="display:none"><%=request.getParameter("clzid")%>
</p>

<p id="userid" style="display:none"><%= cu.getId() %>
</p>

<p id="semid" style="display:none"><%=semid%>
</p>

<p id="userphoto" style="display:none"><%=cu.getPhoto()%>
</p>

<p id="schid" style="display:none"><%=cu.getSchid()%>
</p>
<style>
    .modal-open {
        overflow: hidden;
    }
    .score-star{
        margin-top: 60px;
        width: 70px;
        height: 70px;
    }
    .modal {
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        z-index: 1050;
        display: none;
        overflow: hidden;
        -webkit-overflow-scrolling: touch;
        outline: 0;
    }
    .modal.fade .modal-dialog {
        -webkit-transition: -webkit-transform .3s ease-out;
        -o-transition:      -o-transform .3s ease-out;
        transition:         transform .3s ease-out;
        -webkit-transform: translate3d(0, -25%, 0);
        -o-transform: translate3d(0, -25%, 0);
        transform: translate3d(0, -25%, 0);
    }
    .modal.in .modal-dialog {
        -webkit-transform: translate3d(0, 0, 0);
        -o-transform: translate3d(0, 0, 0);
        transform: translate3d(0, 0, 0);
    }
    .modal-open .modal {
        overflow-x: hidden;
        overflow-y: auto;
    }
    .modal-dialog {
        position: relative;
        width: auto;
        margin: 10px;
    }
    .modal-content {
        position: relative;
        background-color: #fff;
        -webkit-background-clip: padding-box;
        background-clip: padding-box;
        border: 1px solid #999;
        border: 1px solid rgba(0, 0, 0, .2);
        border-radius: 6px;
        outline: 0;
        -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
        box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
    }
    .modal-backdrop {
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        z-index: 1040;
        background-color: #000;
    }
    .modal-backdrop.fade {
        filter: alpha(opacity=0);
        opacity: 0;
    }
    .modal-backdrop.in {
        filter: alpha(opacity=50);
        opacity: .5;
    }
    .modal-header {
        min-height: 16.42857143px;
        padding: 15px;
        border-bottom: 1px solid #e5e5e5;
    }
    .modal-header .close {
        margin-top: -2px;
    }
    .modal-title {
        margin: 0;
        line-height: 1.42857143;
    }
    .modal-body {
        position: relative;
        padding: 15px;
    }
    .modal-footer {
        padding: 15px;
        text-align: right;
        border-top: 1px solid #e5e5e5;
    }
    .modal-footer .btn + .btn {
        margin-bottom: 0;
        margin-left: 5px;
    }
    .modal-footer .btn-group .btn + .btn {
        margin-left: -1px;
    }
    .modal-footer .btn-block + .btn-block {
        margin-left: 0;
    }
    .modal-scrollbar-measure {
        position: absolute;
        top: -9999px;
        width: 50px;
        height: 50px;
        overflow: scroll;
    }
    @media (min-width: 768px) {
        .modal-dialog {
            width: 600px;
            margin: 30px auto;
        }
        .modal-content {
            -webkit-box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
            box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
        }
        .modal-sm {
            width: 300px;
        }
    }
    @media (min-width: 992px) {
        .modal-lg {
            width: 900px;
        }
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
<div class="container">
    <div class="container-left fn-clear">
        <div class="classname">
            <h1><%=request.getParameter("clzname")%>
            </h1>

            <p><%=request.getParameter("grade")%>
            </p>

        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <p style="color: #ea565f;font-size: 30px;font-weight: bold;text-align: right;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TIME METER
        </p>
        <div class="timeout">
            <div class="group-br"></div>
            <div class="timeshow fn-clear" id="timeshow">
                &nbsp;00:00
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

                    </div>
                    <div class="group-list">
                        <ul>
                            <li id="user-list-item" style="display: none">
                                <img src="">
                                <span></span>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="scoreModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <p style="font-size: 24px;font-weight: bold;color: #34495e;" id="myModalLabel">Modal title</p>

            </div>
            <div class="modal-body" style="text-align: center;height: 250px">
                <img src="images/star-empty.png" ci="1" class="score-star" full="0">
                <img src="images/star-empty.png" ci="2" class="score-star" full="0">
                <img src="images/star-empty.png" ci="3" class="score-star" full="0">
                <img src="images/star-empty.png" ci="4" class="score-star" full="0">
                <img src="images/star-empty.png" ci="5" class="score-star" full="0">
            </div>
            <div class="modal-footer">
                <a style="font-size: 24px;font-weight: bold;color: #A4A4A4;">SAVE</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
