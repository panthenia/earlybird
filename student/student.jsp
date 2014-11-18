<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page import="com.atm.model.User" %>
<%@ page import="com.atm.model.Semester"%>
<%@ page import="com.atm.util.Utils" %>
<%
User cu = Utils.getCurUser(request);
Semester sm = Utils.getCurSem(request);
if (cu.getId() == null || cu.getId() == 0) {
request.setAttribute("msg", Utils.ERR_PLEASELOGIN);
request.getRequestDispatcher("/error.jsp").forward(request, response);
return;
}
int semid;
String semname;
if(sm == null){
    semid = 0;
    semname = "unkown";
}else{
    semid = sm.getId();
    semname = sm.getName();
}

String username = cu.getName();
if (username.equals("")) {
username = cu.getAcc();
}


String a = request.getParameter("a");
String b = request.getParameter("b");
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <title>Student</title>
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="../css/teach.css"/>
    <link rel="stylesheet" href="css/student.css">
    <link rel="stylesheet" href="../css/jquery.datetimepicker.css"/>
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../js/blog.js"></script>
    <script type="text/javascript" src="../js/jquery.datetimepicker.js"></script>
    <script type="text/javascript" src="../js/jquery.dateSelector.js"></script>
    <script type="text/javascript" src="js/contact.js"></script>
    <script type="text/javascript" src="js/courses.js"></script>
    <script type="text/javascript" src="js/blog_data.js"></script>
    <script type="text/javascript" src="js/event.js"></script>
    <script type="text/javascript" src="js/myevent.js"></script>
    <script type="text/javascript" src="js/feedback.js"></script>

</head>
<body>
<p id="userid" style="display:none"><%= cu.getId() %></p>
<p id="semid" style="display:none"><%=semid%></p>
<p id="semname" style="display:none"><%=semname%></p>
<p id="schid" style="display:none"><%=cu.getSchid()%></p>
<p id="userphoto" style="display:none"><%=cu.getPhoto()%></p>
<p id="username" style="display:none"><%=username%></p>
<p id="classname" style="display:none"><%=cu.getClzname()%></p>
<p id="usernum" style="display:none"><%=cu.getNum()%></p>
<p id="clzid" style="display:none"><%=cu.getClzid()%></p>

<div class="addevents" id="light">
    <a href="javascript:void(0)" onclick=
            "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"
       class="cloaeac">
        <img src="../css/image/shoutdown.png">
    </a>

    <form>
        <div class="acname">
            <input id="add-event-title" type="text" placeholder="Activity Name" class="acname"/>
        </div>
        <div class="actime fn-clear">
            <p>Time
                <input name="selectAdate" id="selectAdate" type="text"/>
                <select id="event-hour" style="height:25px">
                    <option value="01">1</option>
                    <option value="2">2</option>
                    <option
                            value="03">3
                    </option>
                    <option value="04">4</option>
                    <option value="05">5</option>
                    <option
                            value="06">6
                    </option>
                    <option value="07">7</option>
                    <option value="08">8</option>
                    <option
                            value="09">9
                    </option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option
                            value="12">12
                    </option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option
                            value="15">15
                    </option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option
                            value="18">18
                    </option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                    <option
                            value="21">21
                    </option>
                    <option value="22">22</option>
                    <option value="23">23</option>
                </select>
                <select id="event-mini" style="height:25px">
                    <option value="01">1</option>
                    <option value="2">2</option>
                    <option
                            value="03">3
                    </option>
                    <option value="04">4</option>
                    <option value="05">5</option>
                    <option
                            value="06">6
                    </option>
                    <option value="07">7</option>
                    <option value="08">8</option>
                    <option
                            value="09">9
                    </option>
                </select>

            </p>
        </div>
        <div class="aclocation fn-clear">
            <input type="text" placeholder="Location"/>
        </div>
        <div class="actextarea fn-clear">
            <textarea placeholder="Details" maxlength="300"></textarea>
        </div>
    </form>
    <div class="actools">
        MaxNum:<input type="text" id="event-maxnum">
        <em>Upload&nbsp;Photo</em>
        <a class="wj-up" title="文件上传" style="display: block;margin: 0;">
            <div style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;overflow: hidden;filter:
        alpha(opacity=0);opacity:0;cursor:pointer;">
                <div>
                    <input type="file" style="width:100%;height:100%;margin:0;cursor:pointer;font-size:100px;"
                           name="filename">
                </div>
            </div>

        </a>
        <a class="acsubmit">Submit</a>
    </div>
</div>
<div class="showevents" id="dblight">
    <a href="javascript:void(0)" onclick=
            "document.getElementById('dblight').style.display='none';document.getElementById('fade').style.display='none'"
       class="closeg">
        <img src="../css/image/shoutdown.png">
    </a>

    <div class="showevents-ban"></div>
    <h1>Starbucks VS Dumb Starbucks</h1>

    <div class="myevent-text fn-clear" id="event-detail-msg">
        Drama is the specific mode of fiction represented in performance Drama is the specific mode of fiction
        represented in performance Drama is the specific mode of fiction represented in performance Drama is the
        specific mode of fiction represented in performance Drama is the specific mode of fiction represented in
        performance Drama is the specific mode of fiction represented in performance Drama is the specific mode of
        fiction represented in performance
    </div>
    <div class="myevent-picture fn-clear">

    </div>
    <div class="showevents-info">
        <p id="event-location">

        </p>

        <p id="event-time">

        </p>

        <p id="event-info">

        </p>
    </div>
    <a class="apply">
        Apply
    </a>
</div>
<div id="fade" class="black_overlay" style="display: none;"></div>
<div class="header">
    <div class="header-nav fn-clear">
        <ul>
            <li class="hn-1">
        <span class="header-title">
        <img src="../css/image/headr-title.png">
        </span><span>
        <img src="../css/image/c-1.png"/>
        <img src="../css/image/c-2.png"/>
        </span>
            </li>
        </ul>
    </div>
    <div class="header-sign fn-clear">
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
<div class="page">
<div class="page-content">
<div class="page-content-left">
<div class="page-content-left-nav">
    <ul>
        <li class="li-first li-checked">
            Teachers&nbsp;Talk
        </li>
        <li>
            Favarite
        </li>
        <li>
            My Courses
        </li>
        <li>
            Questionnaire
        </li>
        <li>
            Contacts
        </li>
        <li>
            My Event
        </li>
    </ul>
</div>

<!--博客列表-->
<div class="tab_box">
<div class="myBlog">
    <div class="triangle">
        <i></i>
    </div>
    <!--博客收听-->
    <div class="blog-tools">
        <ul>
            <li class="toolshover">
                My Teachers
            </li>
            <li>
                All
            </li>
        </ul>
    </div>
    <div class="newblog-wrap">
        <div class="myBlog-wrap" id="blog-myself">
            <div class="blog-pre-next">
                <a id="myb-pre" style="position:absolute;">Previous</a>
                <a id="myb-next" style="margin-left:520px">Next</a>
            </div>
            <div class="feed fn-clear" id="newblog-1" style="display: none">
                <div class="userimg">
                    <img src="../img/userlogo.jpg" height="63px" width="63px">
                </div>
                <div class="blog-content">
                    <div class="blog-title">
                        Clare Thede
                    </div>
                    <div class="blog-intro">
                        Burano island. Final the weather is awesome ! Thanks God !
                    </div>
                    <div class="blog-photo fn-clear">
                        <ul>
                            <li class="photo-1" id="aphotoitem">
                                <img src="../img/bg1.jpg" style="width: 201px;height:201px;"/>

                            </li>

                        </ul>

                    </div>
                    <div class="send-info">
                        <a class="like" id="like">
                            Like&nbsp;
                        </a>
                        (<em class="likemuch" id="likemuch">9</em>) ·
                        <a class="comment" id="comment">
                            Comment
                        </a>
                        ·
                        <a class="send-share" id="send-share">
                            Share
                        </a>
                        ·
                        <a>
                            <img id="favor-icon" src="../css/image/nosc.jpg">
                        </a>
                        · <span class="send-ww"><em class="send-time" id="send-time">11</em><em
                            class="send-where"
                            id="send-where">Treviso, Italy</em> ·</span>
                    </div>

                    <div class="comment-list">
                        <div class="comment-triangle"></div>
                        <div class="comment-detail">
                            <ul class="like-list" id="comment-list">
                                <li id="comment-model">
                                    <div class="comment-user">
                                        <img src="../img/userlogo.jpg" height="30px" width="30px"/>
                                    </div>
                                    <div class="comment-user-info">
                                        <p>
                                            <em class="comment-user-name" id="comment-user-name">Zhang Yihan</em><em
                                                class="comment-user-zhiye">Dancing
                                            teacher Missy</em>!!!
                                        </p>

                                        <p>
                                            <em class="comment-tiem">18</em>hours ago · Like
                                        </p>
                                    </div>
                                </li>

                                <li class="mycomment">
                                    <div class="comment-user">
                                        <img src="../img/userlogo.jpg" height="30px" width="30px"/>
                                    </div>
                                    <div class="comment-edit">
                                        <textarea maxlength="380" placeholder="Write a comment…"></textarea>
                                    </div>
                                    <a class="comment-send" id="comment-send-button">
                                        Send
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>

        </div>
        <div class="allPeople" id="blog-allpeople">
            <div class="blog-pre-next">
                <a id="apb-pre" style="position:absolute;">Previous</a>
                <a id="apb-next" style="margin-left:520px">Next</a>
            </div>
            <div class="feed fn-clear" id="newblog-1" style="display: none">
                <div class="userimg">
                    <img src="../img/userlogo.jpg" height="63px" width="63px">
                </div>
                <div class="blog-content">
                    <div class="blog-title">
                        Clare Thede
                    </div>
                    <div class="blog-intro">
                        Burano island. Final the weather is awesome ! Thanks God !
                    </div>
                    <div class="blog-photo fn-clear">
                        <ul>
                            <li class="photo-1" id="aphotoitem">
                                <img src="../img/bg1.jpg" style="width: 201px;height:201px;"/>

                            </li>

                        </ul>

                    </div>
                    <div class="send-info">
                        <a class="like" id="like">
                            Like&nbsp;
                        </a>
                        (<em class="likemuch" id="likemuch">9</em>) ·
                        <a class="comment" id="comment">
                            Comment
                        </a>
                        ·
                        <a class="send-share" id="send-share">
                            Share
                        </a>
                        ·
                        <a>
                            <img id="favor-icon" src="../css/image/nosc.jpg">
                        </a>
                        · <span class="send-ww"><em class="send-time" id="send-time">11</em><em
                            class="send-where"
                            id="send-where">Treviso, Italy</em> ·</span>
                    </div>

                    <div class="comment-list">
                        <div class="comment-triangle"></div>
                        <div class="comment-detail">
                            <ul class="like-list" id="comment-list">
                                <li id="comment-model">
                                    <div class="comment-user">
                                        <img src="../img/userlogo.jpg" height="30px" width="30px"/>
                                    </div>
                                    <div class="comment-user-info">
                                        <p>
                                            <em class="comment-user-name" id="comment-user-name">Zhang Yihan</em><em
                                                class="comment-user-zhiye">Dancing
                                            teacher Missy</em>!!!
                                        </p>

                                        <p>
                                            <em class="comment-tiem">18</em>hours ago · Like
                                        </p>
                                    </div>
                                </li>

                                <li class="mycomment">
                                    <div class="comment-user">
                                        <img src="../img/userlogo.jpg" height="30px" width="30px"/>
                                    </div>
                                    <div class="comment-edit">
                                        <textarea maxlength="400" placeholder="Write a comment…"></textarea>
                                    </div>
                                    <a class="comment-send" id="comment-send-button">
                                        Send
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>
<div class="myfavorite g">
    <div class="triangle">
        <i></i>
    </div>
    <div class="favorite-wrap">
        <div class="favorite-title">
            <h1> Favorite List</h1>
        </div>
        <div class="favorite-list">
            <div class="favorite-search-wrap">
                <div class="favorite-search">
                    <input type="text" placeholder="Favorite"/>

                    <img id="search-favor-icon" src="../css/image/search.jpg"/>

                </div>
            </div>
            <div class="favorite-list-detail">
                <ul id="favor-ul">
                    <li id="favor-model" style="display:none">
                        <div class="favorite-name">
                            Starbucks VS Dumb Starbucks
                        </div>
                        <div class="favorite-tooles">
                            <img src="../css/image/delete.jpg"/><a>Delete</a>
                        </div>
                    </li>

                </ul>
            </div>
        </div>
    </div>

    <div class="favor-pre-next">
    <a id="favor-pre" >Previous</a>
    <a id="favor-next" style="margin-left:370px">Next</a>
    </div>
</div>

<div class="courses g">
    <div class="triangle">
        <i></i>
    </div>
    <div class="courser-wrap">
        <div class="myinfo">
            name:<strong id="student-name">Returner</strong>Class:
            <strong id="student-class">Y1-2013A</strong>Number:
            <strong id="student-sid">258258</strong>
        </div>
        <div class="coursesSearch">
            <div class="coursesSearch-tools">
                Course:<select class="select1" id="course-select">
                <option value="all">All</option>
                <option value="">1</option>
                <option value="">2</option>
            </select>
                <select class="select2" id="semester-select">
                    <option value="12">Current Semester: 2013 Autumn</option>
                    <option value="11">1</option>
                    <option value="02">12</option>
                </select>
                <a id="course-search">Search</a>
            </div>
        </div>
        <div class="courses-table">
            <table border="1" bordercolor="#acbaca">
                <tbody id="course-table">
                <tr id="course-title">
                    <th class="t" id="course">Course</th>
                    <th id="absence">Absence</th>
                    <th id="class-atm">Class ATM</th>
                    <th id="quiz-aver">Quiz Average</th>
                    <th id="mid">Mid Exam</th>
                    <th id="final">Final Exam</th>
                    <th id="total">Total</th>
                </tr>

                </tbody>
            </table>

        </div>
    </div>
</div>
    <div class="question g">
    <div class="triangle">
    <i></i>
    </div>
    <div class="favorite-wrap qusetion-wrap">
    <div class="favorite-title">
    <h1> Questionnaire List</h1>
    </div>
    <div class="favorite-list">
    <div class="favorite-search-wrap">
    <div class="favorite-search">
    <input type="text" placeholder="Questionnaire" />
    <img src="../css/image/search.jpg" />
    </div>
    </div>
    <div class="favorite-list-detail">
    <ul id="feed-back-list">
    <li id="fb-old-model" style="display: none">
    <div class="favorite-name question-name">
    Q 2ORAL 3
    </div>
    <div class="qusetion-zt">
    Sent
    </div>
    <div class="question-tooles-view">
    <img src="../css/image/eye.jpg" />
    <a>
    View
    </a>
    </div>
    </li>
    <li id="fb-new-model" style="display: none">
    <div class="favorite-name question-name">
    Q 3Writing
    </div>
    <div class="qusetion-zt"></div>
    <div class="question-tooles-fill">
    <img src="../css/image/edit.jpg" />
    <a>
    Edit
    </a>
    </div>
    </li>

    </ul>
    </div>
    </div>
    </div>
    <div class="question-edit-wrap">
    <div class="question-edit">
    <h1>Questionnaire</h1>
    <div class="question-edit-title">
    <strong>Q3Writing</strong><em class="techername">Teacher:<em>Chris Pual</em></em><em class="current">Current Semester:<em >2013 Autumn</em></em>
    </div>
    <div class="question-edit-list fn-clear" id="question-list">
    <div class="question-edit-bq fn-clear">
    <ul>
    <li>
    <img src="../css/image/sx.jpg">
    </li>
    <li>
    <img src="../css/image/happy.jpg">
    </li>
    <li>
    <img src="../css/image/laugh.jpg">
    </li>
    </ul>
    </div>
    <div class="question-edit-list-nm fn-clear" id="question-model">

       <span class="question-edit-list-nm-name">Q3WrtingQ3WrtingQ3Wrting</span>
    <form>
    <input type="radio"  name="look" value="1"/>
    <input type="radio"  name="look" value="2"/>
    <input type="radio"  name="look" value="3"/>
    </form>
    </div>
    </div>
    </div>
    <div class="question-edit-tools">
    <em >
    <img src="../css/image/goback.jpg">
    </em>
    <a class="goback">
    Back
    </a>
    <em class="sendemail"><em>
    <img src="../css/image/email.jpg">
    </em>
    <a>
    Send
    </a></em>
    </div>
    </div>
    <div class="question-view-wrap">
    <div class="question-edit">
    <h1>Questionnaire</h1>
    <div class="question-edit-title">
    <strong>Q3Writing</strong><em class="techername">Teacher:<em>Chris Pual</em></em><em class="current">Current Semester:<em >2013 Autumn</em></em>
    </div>
    <div class="question-edit-list fn-clear" id="question-list">
    <div class="question-edit-bq fn-clear">
    <ul>
    <li>
    <img src="../css/image/sx.jpg">
    </li>
    <li>
    <img src="../css/image/happy.jpg">
    </li>
    <li>
    <img src="../css/image/laugh.jpg">
    </li>
    </ul>
    </div>
    <div class="question-edit-list-nm fn-clear" id="question-model">

        <span class="question-edit-list-nm-name">Q3WrtingQ3WrtingQ3Wrting</span>
    <form>
    <input type="radio"  name="look" value="1"/>
    <input type="radio"  name="look" value="2"/>
    <input type="radio"  name="look" value="3"/>
    </form>
    </div>

    </div>
    </div>
    <div class="question-edit-tools question-view-tools">
    <em >
    <img src="../css/image/chale.jpg">
    </em>
    <a class="goback">
    Cancel
    </a>
    </div>
    </div>
    </div>
<div class="contacts g fn-clear">
    <div class="triangle">
        <i></i>
    </div>
    <div class="list" id="chat_leftpanel">
        <div class="top">
            <div class="myProfile">
                <img id="contact_photo" src="../img/myinfo.png"/>

                <div id="accountAvatarWrapper" class="avatar" click="">
                </div>
                <div class="info">
                    <span class="nikcName"><%=username%></span>
                </div>
            </div>
        </div>
        <div class="chatListSearch">
            <div class="chatListSearchPanel">
                <div>
                    <span><img src="../css/image/friiends.jpg"></span>

                    <div class="chatListSearchInput">
                        <input id="conv_search" class="left" type="text" placeholder="search" value="" name="search"/>

                        <div class="chearlogo"><img src="../css/image/search.png"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="conversationContainer">
            <table class="chatList">
                <tbody id="chat-list">
                <tr id="chat-class">
                    <th>
                        <div>Math1</div>
                    </th>
                </tr>
                <tr id="chat-student">
                    <td>
                        <div>
                            <div class="avatar_wrap"><img src="../img/avater.jpg"/></div>
                            <div id="name-a" class="avater-info">usan Tao</div>
                            <div id="name-b" class="avater-info">usan Tao</div>
                        </div>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </div>
    <div class="chatMainPanel" id="chat-main-panel" style="display: none">
        <div class="chatTitle">
            <div class="chatNameWrap">
                <p id="messagePanelTitle" class="messageName">ABCD</p>
            </div>
        </div>
        <div class="chatScorll">
            <div id="chat_chatmsglist" class="chatContent">
                <div class="chatItem me" id="chatme-model" style="display:none">
                    <div class="chatItemContent">
                        <img class="chatavatar" src="../img/avater.jpg"/>

                        <div class="cloud cloudText">
                            <div class="cloudPannel">
                                <div class="cloudBody">
                                    <div class="cloudContent">
                                        <pre style="white-space: pre-wrap">adfalksdf</pre>
                                    </div>
                                </div>
                                <div class="cloudArrow"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chatItem you" id="chatyou-model" style="display:none">
                    <div class="chatItemContent">
                        <img class="chatavatar" src="../img/avater.jpg">

                        <div class="cloud cloudText">
                            <div class="cloudPannel">
                                <div class="cloudBody">
                                    <div class="cloudContent">
                                        <pre style="white-space: pre-wrap">123123123</pre>
                                    </div>
                                </div>
                                <div class="cloudArrow "></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="chat_editor" class="chatOperator lightBorder">
            <div class="inputArea" id="inputArea">
                <div class="attach">
                    <a id="sendEmojiIcon" class="func expression" title="选择表情" href="JavaScript:void(0)"></a>

                    <form id="sendFileIcon" class="left" style="" target="actionFrame" method="post"
                          enctype="multipart/form-data"
                          url="">
                        <a id="uploadFileContainer" class="func file" title="文件图片"
                           style="position: relative;display: block;margin: 0;"
                                >
                            <div style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;overflow: hidden;filter:
        alpha(opacity=0);opacity:0;cursor:pointer;">
                                <div>
                                    <input type="file"
                                           style="width:100%;height:100%;margin:0;cursor:pointer;font-size:100px;"
                                           name="filename"></input>
                                </div>
                            </div>
                        </a>
                    </form>
                </div>
                <textarea id="textInput" class="chatInput lightBorder" type="text"></textarea>
                <a class="chatSend " id="chat-send">Send</a>
            </div>
        </div>
    </div>

</div>
<div class="myevent g">
    <div class="triangle">
        <i></i>
    </div>
    <div class="myeventwrao">
        <div class="favorite-title">
            <h1> Event List</h1>
        </div>
        <div class="myevent-list">
            <div class="myevent-search-wrap">
                <div class="myevent-search">
                    <input type="text" placeholder="Event"/>
                    <img src="../css/image/search.jpg"/>
                </div>
            </div>
            <div class="myevent-details">
                <ul id="myevent-ul">
                    <li id="myevent-item-model">
                    <div class="myevnet-summary">
                        <strong>Starbucks VS Dumb Starbucks</strong>
                        <em class="event-info-jd"></em>
                        <a class="event-close">
                                View
                        </a>
                        <em class="event-jd-img">
                            <img src="../css/image/eyes.jpg"/>
                        </em>
                    </div>
                        <div class="myevent-show fn-clear">
                            <div class="myevent-text fn-clear">
                                Drama is the specific mode of fiction represented in performance Drama is the specific
                                mode of fiction represented in performance Drama is the specific mode of fiction
                                represented in performance Drama is the specific mode of fiction represented in
                                performance Drama is the specific mode of fiction represented in performance Drama is
                                the specific mode of fiction represented in performance Drama is the specific mode of
                                fiction represented in performance
                            </div>
                            <div class="myevent-picture fn-clear">

                            </div>
                            <div class="myevent-info">
                                <p id="myevent-location"></p>

                                <p id="myevent-time"></p>

                                <p id="myevent-info"></p>
                            </div>
                            <div class="myevent-button">
                                <a>Successfully Apply</a>
                                <a id="myevent-exit">Select Exit</a>
                            </div>
                        </div>

                    </li>
                </ul>

            </div>
    <div class="favor-pre-next">
    <a id="myevent-pre">Previous</a>
    <a id="myevent-next" style="margin-left:370px">Next</a>
    </div>
        </div>

    </div>
</div>
</div>
</div>
<!--右侧-->
<div class="page-content-right">
    <div class="page-content-right-nav">
        <span>Calendar</span>

    </div>
    <div class="calender">
        <input type="text" id="datetimepicker"/>
    </div>
    <div class="events">
        <div class="page-content-right-nav">
            <span>Event</span>
            <a class="addevent">
                +add
            </a>
        </div>

        <div class="events-1 ev fn-clear" id="event_model" style="display: none">
            <div class="events-who fn-clear">
                <img src="../img/userlogo.jpg" height="44px" width="44px"/>
            </div>
            <div class="events-content fn-clear">
                <div class="events-title">
                    <a>
                        Drama is the specific mode of fiction represented in performance
                    </a>

                    <p style="display:none"></p>
                </div>
                <div class="location">
                    Location:<em>Zhongshan Park</em>
                </div>
                <div class="whattime">
                    Time:<em>9:00 am</em>,<em>20th Jun.</em>
                </div>
                <div class="events-info">
                    Angle Chen 10:21am,Feb.14
                </div>
            </div>
        </div>
        <div class="pre-next-info">
            <a id="evt-pre">Previous</a>
            <a id="evt-next" >Next</a>
        </div>
    </div>
</div>
</div>
</body>

<script>
    $('#datetimepicker').datetimepicker({
        inline: true,
        timepicker: false
    });

    $("#selectAdate").dateSelector();
</script>
</html>
