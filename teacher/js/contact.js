/**
 * Created by p on 2014/5/16.
 */

$(document).ready(function (){

    init_contacts_list();
    init_page_image();
    //$('#contact_photo').attr('src',$('#userphoto').text());
});
var courses;
var students = new Array();
var is_last_course = false;
function init_page_image() {
    var url_to = '/api/user/info.do';
    var data_to = 'utype=3&id=' +$('#userid').text();
    $.ajax({
        url: url_to,
        type: 'POST',
        data: data_to,
        dataType: 'json',
        async: false,
        success: function (msg, status) {
        var err = msg.err;
        if (typeof(err) == 'undefined' || err == '') {
        var user = msg.user;
            $('#contact_photo').attr('src',user.photo);
            $('.userlogo').find('img').attr('src',user.photo);
        } else {
            alert(err);
        }
        },
        error: function (jqXHR, status, err) {
        alert(err);
        }
        });

    }
function get_msg(){
    var url = '/api/p2pmsg/list.do';

    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        beforeSend: function(jqXHR) {

        },
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var msgs = msg.msgs;
                for(var i=0;i<msgs.length;++i){

                    var c_p = $('#chat-panel-'+msgs[i].senderid);
                    var mymsg = c_p.find('#chatyou-model').clone();
                    mymsg.attr('id','msg'+msgs[i].id);
                    mymsg.find('pre').text(msgs[i].msg);
                    mymsg.find('img').attr('src',c_p.attr('userimg'));
                    c_p.find('#chat_chatmsglist').append(mymsg);
                    mymsg.show();
                }
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        },
        complete: function(jqXHR, status) {

        }
    });
}
function send_chat(){
    var othis=$(this);
    var url = '/api/p2pmsg/send.do';
    var data = 'recverid='+$(this).attr('userid')+'&msg='+$(this).parent('#inputArea').find('#textInput').val();

    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        dataType: 'json',
        async: false,
        beforeSend: function(jqXHR) {

        },
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var c_p = $('#chat-panel-'+othis.attr('userid'));
                var mymsg = c_p.find('#chatme-model').clone();
                mymsg.attr('id','msg'+othis.attr('userid'));
                mymsg.find('pre').text(othis.parent('#inputArea').find('#textInput').val());
                mymsg.find('img').attr('src',$('#userphoto').text());
                c_p.find('#chat_chatmsglist').append(mymsg);
                mymsg.show();
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        },
        complete: function(jqXHR, status) {

        }
    });
}
function init_chat(){

    var c_panel = $('#chat-panel-'+$(this).attr('userid'));
    $("div[id^='chat-panel-']").hide();

    c_panel.show();
}
function get_students(url,data,course_num) {
    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        dataType: 'json',
        async: false,
        beforeSend: function(jqXHR) {

        },
        success: function(msg, status) {

            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var contact_list = $('#chat-list');
                var class_model = $('#chat-class');
                var student_model = $('#chat-student');
                var lt = students.push(msg.users);
                var users = msg.users;
                students[lt-1].clzid = courses[course_num].clzid;

                //alert('course_num:'+course_num);
                //alert(courses[course_num].crsname);

                var cm = class_model.clone();

                cm.find('th').find('div').text(courses[course_num].crsname);
                cm.show();
                contact_list.append(cm);
                for(var i=0;i<users.length;++i){
                    var sm = student_model.clone();
                    var chat_panel;

                    sm.find('img').attr('src',users[i].photo);
                    sm.find('img').attr('style','max-width:35px');
                    sm.find('#name-a').text(users[i].nameen);
                    sm.find('#name-b').text(users[i].name);
                    sm.attr('userid',users[i].id);

                    chat_panel = $('#chat-main-panel').clone();
                    chat_panel.attr('id','chat-panel-'+users[i].id);
                    chat_panel.attr('userid',$(this).attr('userid'));
                    $('#chat-main-panel').after(chat_panel);
                    $('#chat-main-panel').hide();
                    chat_panel.find('#messagePanelTitle').text(users[i].name);
                    chat_panel.find('#chat-send').attr('userid',users[i].id);
                    chat_panel.find('#chat-send').on('click',send_chat);
                    chat_panel.attr('userimg',users[i].photo);
                    chat_panel.hide();
                    sm.show();
                    sm.on('click',init_chat);
                    contact_list.append(sm);
                }
                if(is_last_course) {
                    class_model.remove();
                    student_model.remove();
                }
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        },
        complete: function(jqXHR, status) {

        }
    });

}
function init_contacts_list(){

    var url_to = '/api/regcourse/list.do';
    var data_to = 'semid='+$('#semid').text()+'&schid='+$('#schid').text()+'&teaid='+$('#userid').text();
    //alert(data_to);
    $.ajax({
        url: url_to,
        type: 'POST',
        data: data_to,
        dataType: 'json',
        async: false,
        beforeSend: function(jqXHR) {

        },
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
               courses = msg.regcourses;

               for(var i=0;i<courses.length;++i){//get the students in each class
                   var dt = 'utype=4'+'&schid='+$('#schid').text()+'&clzid='+courses[i].clzid;
                   //alert(dt);
                   if(i == courses.length-1)
                        is_last_course = true;
                   else is_last_course = false;
                   get_students('/api/user/list.do',dt,i);
               }
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        },
        complete: function(jqXHR, status) {

        }
    });
    setInterval(get_msg,1000*60);//start the time that fresh msg
}
