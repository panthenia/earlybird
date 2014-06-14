/**
 * Created by p on 2014/5/17.
 * control student's contacts page
 */


$(document).ready(function (){

    init_contacts_list();

    $('#contact_photo').attr('src',$('#userphoto').text());
});
var courses;
var students = new Array();

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
function get_students(url,data,clzid) {
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
                students[lt-1].clzid = clzid;

                //alert('course_num:'+course_num);
                //alert(courses[course_num].crsname);

                var cm = class_model.clone();
                cm.find('th').find('div').text(clzid);
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

                class_model.remove();
                student_model.remove();

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

    var dt = 'utype=4&schid='+$('#schid').text()+'&clzid='+$('#clzid').text();

    get_students('/api/user/list.do',dt,$('#clzid').text());

    setInterval(get_msg,5000);//start the time that fresh msg
}
