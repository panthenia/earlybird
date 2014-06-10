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

String a = request.getParameter("a");
String b = request.getParameter("b");
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <title>TeachersTalk</title>
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="../css/teach.css">
    <link rel="stylesheet" href="../css/emoticon.css"/>
    <link rel="stylesheet" href="../css/jquery.datetimepicker.css"/>
    <link href="../css/custom-theme/jquery-ui-1.10.4.custom.css" rel="stylesheet"/>
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/blog.js"></script>
    <script type="text/javascript" src="../js/jquery.datetimepicker.js"></script>
    <script type="text/javascript" src="../js/jquery.emoticons.js"></script>
    <script type="text/javascript" src="../js/jquery.form.js"></script>
    <script type="text/javascript" src="../js/jquery.dateSelector.js"></script>
    <script type="text/javascript" src="../js/jquery-ui-1.10.4.custom.js"></script>
    <script type="text/javascript" src="js/event.js"></script>
    <script type="text/javascript" src="js/blog_data.js"></script>
    <script type="text/javascript" src="js/contact.js"></script>
    <script type="text/javascript" src="js/course.js"></script>
</head>
<body>
<p id="userid" style="display:none"><%= cu.getId() %></p>

<p id="semid" style="display:none"><%=semid%></p>

<p id="userphoto" style="display:none"><%=cu.getPhoto()%></p>

<p id="schid" style="display:none"><%=cu.getSchid()%></p>

<div class="addevents" id="light">
    <a href="javascript:void(0)"
       onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"
       class="cloaeac">
        <img src="../css/image/shoutdown.png">
    </a>

    <form>
        <div class="acname">
            <input type="text" placeholder="Activity Name" class="acname"/>
        </div>
        <div class="actime fn-clear">
            <p>Time
                <input name="selectAdate" id="selectAdate" type="text"/>
                <select id="event-hour" style="height:25px">
                    <option value="01">1</option>
                    <option value="2">2</option>
                    <option value="03">3</option>
                    <option value="04">4</option>
                    <option value="05">5</option>
                    <option value="06">6</option>
                    <option value="07">7</option>
                    <option value="08">8</option>
                    <option value="09">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                    <option value="21">21</option>
                    <option value="22">22</option>
                    <option value="23">23</option>
                </select>
                <select id="event-mini" style="height:25px">
                    <option value="01">1</option>
                    <option value="2">2</option>
                    <option value="03">3</option>
                    <option value="04">4</option>
                    <option value="05">5</option>
                    <option value="06">6</option>
                    <option value="07">7</option>
                    <option value="08">8</option>
                    <option value="09">9</option>
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
            <div style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;overflow: hidden;filter: alpha(opacity=0);opacity:0;cursor:pointer;">
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
    <a href="javascript:void(0)"
       onclick="document.getElementById('dblight').style.display='none';document.getElementById('fade').style.display='none'"
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
<div class="page">
<div class="page-content">
<div class="page-content-left">
<div class="page-content-left-nav">
    <ul>
        <li class="li-first li-checked">
            My&nbsp;Talk
        </li>
        <li>
            Favarite
        </li>
        <li>
            Courses
        </li>
        <li>
            Contacts
        </li>
    </ul>
</div>

<!--博客列表-->
<div class="tab_box">
<div class="myBlog">
<div class="triangle">
    <i></i>
</div>
<!--博客发布-->
<div class="sent-wrap fn-clear" id="release_blog">
    <div class="blog-edit">


        <div class="userlogo">
            <img src="<%=cu.getPhoto()%>"/>
        </div>
        <div class="blog-inf fn-clear">
            <textarea id="blog-text" class="blog-detail" placeholder="Share the information ……"
                      maxlength="300"></textarea>

            <div class="send-tools fn-clear">
                <div class="blog-fj">
                    <img src="../css/image/hxj.png"/>
                </div>
                <div class="classgroup fn-clear">
                    <div class="classgroup-detail">
                        Share with: <strong>All</strong>

                        <div>
                            <img src="../css/image/show.png"/>
                        </div>
                    </div>
                </div>
                <a class="share" id="send-blog">
                    Share
                </a>
            </div>
        </div>
    </div>
    <div class="extratools fn-clear">
        <div class="selectschool">
            <div class="closedown">
                <a class="closeschool"><img src="../css/image/shoutdown.png"/> </a>
            </div>
            <form>
                <ul id="class-list">
                    <li id="class-list-item">
                        <div class="schoollogo"></div>
                        <div class="classname">Drama-1</div>
                        <div class="schoolname">Shanghai Experimental School</div>
                        <input type="checkbox" name="schoolname" id="schoolname1"/>
                    </li>

                </ul>
            </form>
            <div class="schooltools">
                <a class="selectAll">Select all</a> <a class="deselectAll">Deselete all</a> <input type="submit"
                                                                                                   value="OK"/>
            </div>

        </div>
        <div class="list-share-what">
            <ul>
                <li id='share-group'>ClassGroup</li>
                <li id='share-public'>All</li>
            </ul>
        </div>
        <div class="upphoto">
            <form id="attaform" method="post">

                <input id="1-file-input" name="File" type="file"/>

                <input id="2-file-input" name="File" type="file"/>

                <div id="progress"
                     style="position: relative;border: 1px #0d0d0d solid;padding: 1px;border-radius: 3px;text-align: left;display: none; margin-right: 70px;">
                    <div style="background-color: #80a060;width: 0%;height: 20px;border-radius: 3px;" id="bar"></div>
                    <div id="percent">0%</div>
                </div>
            </form>
            <!--<a class="shutdown"><img src="css/image/shoutdown.png"></a>
            <a class="deletephoto"><img src="css/image/delete.jpg"> </a>style="opacity:0;style="opacity:0""-->
        </div>
    </div>
</div>
<div class="blog-tools">
    <ul>
        <li class="toolshover">
            Classes
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
            <a id="myb-next" style="margin-left:550px">Next</a>
        </div>
        <div class="feed fn-clear" id="newblog-1">
            <div class="userimg">
                <img src="../img/userlogo.jpg">
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
                            <img src="../img/bg1.jpg"/>

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
                    · <span class="send-ww"><em class="send-time" id="send-time">11</em>hours ago in <em
                        class="send-where" id="send-where">Treviso, Italy</em> ·</span>
                </div>

                <div class="comment-list">
                    <div class="comment-triangle"></div>
                    <div class="comment-detail">
                        <ul class="like-list" id="comment-list">
                            <li id="comment-model">
                                <div class="comment-user">
                                    <img src="../img/userlogo.jpg"/>
                                </div>
                                <div class="comment-user-info">
                                    <p>
                                        <em class="comment-user-name" id="comment-user-name">Zhang Yihan</em><em
                                            class="comment-user-zhiye">Dancing teacher Missy</em>!!!
                                    </p>

                                    <p>
                                        <em class="comment-tiem">18</em>hours ago · Like
                                    </p>
                                </div>
                            </li>

                            <li class="mycomment">
                                <div class="comment-user">
                                    <img src="../img/userlogo.jpg"/>
                                </div>
                                <div class="comment-edit">
                                    <textarea maxlength="300" placeholder="Write a comment…"
                                              style="width:380px;"></textarea>
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
            <a id="apb-next" style="margin-left:550px;">Next</a>
        </div>
        <div class="feed fn-clear" id="newblog-1">
            <div class="userimg">
                <img src="../img/userlogo.jpg">
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
                            <img src="../img/bg1.jpg"/>

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
                    · <span class="send-ww"><em class="send-time" id="send-time">11</em>hours ago in <em
                        class="send-where" id="send-where">Treviso, Italy</em> ·</span>
                </div>

                <div class="comment-list">
                    <div class="comment-triangle"></div>
                    <div class="comment-detail">
                        <ul class="like-list" id="comment-list">
                            <li id="comment-model">
                                <div class="comment-user">
                                    <img src="../img/userlogo.jpg"/>
                                </div>
                                <div class="comment-user-info">
                                    <p>
                                        <em class="comment-user-name" id="comment-user-name">Zhang Yihan</em><em
                                            class="comment-user-zhiye">Dancing teacher Missy</em>!!!
                                    </p>

                                    <p>
                                        <em class="comment-tiem">18</em>hours ago · Like
                                    </p>
                                </div>
                            </li>

                            <li class="mycomment">
                                <div class="comment-user">
                                    <img src="../img/userlogo.jpg"/>
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
        <a id="favor-pre">Previous</a>
        <a id="favor-next" style="margin-left:370px">Next</a>
    </div>
</div>

<div class="courses g">
    <div class="triangle">
        <i></i>
    </div>
    <div class="courses-wrap">
        <div class="courses-list-wrap">
            <div class="courses-title">
                <h1> Courses List</h1>
            </div>
            <div class="courses-list">
                <div class="courses-search-wrap">
                    <div class="courses-search">
                        <input type="text" placeholder="Course"/>
                        <img src="../css/image/search.jpg"/>
                    </div>
                </div>
                <div class="courses-list-detail">
                    <ul id="course-ul">
                        <li>
                            <div class="courses-img">
                                <img src="../css/image/eyes.jpg" style="width:35px"/>
                            </div>
                            <div class="courses-name">
                                Science G1
                            </div>
                            <div class="courses-eyes">
                                <img src="../css/image/eyes.jpg"/>
                                <a>
                                    View
                                </a>
                            </div>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
        <div class="courses-detail-wrap">
            <h1 class="courses-detail-title">Course</h1>

            <div class="courses-detail-name">
                Science G1
            </div>
            <div class="courses-detail-nav">
                <ul>
                    <li class="courser-hover">
                        Course Evaluation Set Up
                    </li>
                    <li>
                        Course Content Set Up
                    </li>
                </ul>
            </div>
            <div class="courser-detail-list-wrap fn-clear">
                <div class="courser-detail-table">
                    <table cellpadding="1" cellspacing="1" border="1" c>
                        <tbody>
                        <tr>
                            <th class="a">Performance</th>
                            <th>30%</th>
                        </tr>
                        <tr>
                            <td class="b">Absence Limit</td>
                            <td id="absenceslim"></td>
                        </tr>
                        <tr>
                            <td class="b">Class Performance</td>
                            <td id="tgper">30</td>
                        </tr>
                        <tr>
                            <td class="b">Quiz</td>
                            <td id="quizper">30</td>
                        </tr>
                        <tr>
                            <th class="a">Exam</th>
                            <th>70%</th>
                        </tr>
                        <tr>
                            <td class="c">Middle Exam</td>
                            <td id="middleper">0</td>
                        </tr>
                        <tr>
                            <td class="c">Final Exam</td>
                            <td id="finalper">40</td>
                        </tr>
                        <tr>
                            <td class="d e">Totol Score</td>
                            <td class="d" id="total">100</td>
                        </tr>
                        </tbody>
                    </table>

                </div>

                <div class="courser-detail-set fn-clear">
                    <ul id="course-file-list">
                        <li id="course-file-item-model">
                            <div class="courser-detail-set-name">
                                <div style="float: left">
                                    <em class="wj-img">
                                        <img src="../css/image/ccandeler.jpg"/>
                                    </em>
                                </div>

                                <div style="float: left">
                                    <em class="wj-name">Week 0</em>
                                </div>
                                <!---->
                                <div style="float: left">
                                    <em class="wj-lx">Outline</em>
                                </div>

                                <div style="position:absolute;left:380px;margin-top:-5px;">
                                    <a class="wj-up" title="文件上传" style="display: block;margin: 0;">
                                        <div style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;overflow: hidden;filter: alpha(opacity=0);opacity:0;cursor:pointer;">
                                            <div>
                                                <form id="course-week-form" method="post">
                                                    <input id="course-week-file" name="File" type="file"
                                                           style="width:100%;height:100%;margin:0;cursor:pointer;font-size:100px;"
                                                           name="filename">

                                                    </input>

                                                </form>
                                            </div>
                                        </div>
                                        <em>Upload</em>
                                    </a>
                                </div>
                                <div id="progressbar"
                                     style="width: 60px;height:7px;position:absolute;left:380px;"></div>
                                <div style="position:absolute;left:400px;">
                                    <a class="wj-show">
                                        <img src="../css/image/eye.jpg"/>
                                        View
                                    </a>
                                </div>


                            </div>
                            <div class="wj-zhankai">
                                <p id="file-item-model">
                                    <img src="../css/image/wj.jpg" class="wj-img-s"/>
                                    <strong>english builder lesson 1. pdf</strong>
                                    <em>
                                        <img src="../css/image/wj-download%20.jpg">
                                        Download
                                    </em>
                                </p>

                            </div>
                        </li>
                        <li id="add-week-model">
                            <div class="courser-detail-set-name">
                                <em class="wj-img">
                                    <img src="../css/image/ccandeler.jpg">
                                </em>
                                <select class="wj-name" style="margin-top:10px"></select>
                                <input class="wj-lx" maxLength="26" placeholder="input description"
                                       style="margin-left:90px;height:25px;"/>
                                <a class="wj-name" style="margin-left:90px;">add</a>
                            </div>
                        </li>
                    </ul>
                    <!--<div style="width: 618px;">
                    <a id="course-week-pre" style="position:absolute;">Week 0-9</a>
                    <a id="course-week-next" style="margin-left:500px">Week 10-24</a>
                    </div>-->
                </div>

            </div>

            <div class="goback" id="goback">
                <img src="../css/image/goback.jpg"/>
                Back
            </div>
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
                            <div class="avater-info">usan Tao</div>
                        </div>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </div>
    <div class="chatMainPanel" id="chat-main-panel">
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
                          enctype="multipart/form-data" url="">
                        <a id="uploadFileContainer" class="func file" title="文件图片"
                           style="position: relative;display: block;margin: 0;">
                            <div style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;overflow: hidden;filter: alpha(opacity=0);opacity:0;cursor:pointer;">
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
        <div class="events-1 ev fn-clear" id="event_model">
            <div class="events-who fn-clear">
                <img src="../img/userlogo.jpg"/>
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
            <a id="evt-next">Next</a>
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
    $("#sendEmojiIcon").jqfaceedit({
        txtAreaObj: $("#textInput"),
        containerObj: $('#chat_editor'),
        top: -950,
        left: -700
    });
    $("#selectAdate").dateSelector();
</script>
<script>
    $(document).ready(function () {
        initRegCourseSelector();
    })
    function initRegCourseSelector() {
        var url_to = '/api/regcourse/list.do';
        var data_to = 'semid=<%=semid%>&schid=<%=cu.getSchid()%>&teaid=<%=cu.getId()%>';

        $.ajax({
            url: url_to,
            type: 'POST',
            data: data_to,
            dataType: 'json',
            async: false,

            success: function (msg, status) {
                var err = msg.err;
                if (typeof(err) == 'undefined' || err == '') {
                    var rcs = msg.regcourses;

                    var class_list = $('#class-list');
                    var class_item = class_list.find('#class-list-item');
                    for (var i = 0; i < rcs.length; i++) {
                        var item = class_item.clone();
                        item.attr('clzid', rcs[i].clzid);
                        item.find('.classname').text(rcs[i].clzname);
                        item.find('.schoolname').text(rcs[i].schname);
                        class_list.append(item);
                    }
                    class_item.hide();
                } else {
                    //alert(err);
                }
            },
            error: function (jqXHR, status, err) {
                //alert(err);
            }
        });
    }
</script>
</html>
