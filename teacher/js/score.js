/**
 * Created by p on 2014/5/31.
 */
$(document).ready(function () {

    gnum = parseInt($('#gnum').text());
    init_groups();

    for(var i=1;i<=60;++i){
        $('.choose-time').find('select').append('<option value="'+i+'">'+i+'</option>');
    }
    $('a.start').on('click',start_count);
    $('a.stop').on('click',stop_count);
    $('a.clear').on('click',fresh_count);
    $('.account-li-last').on('click',logout);
    $('.account-li-first').on('click', function () {
        window.location.href = 'edit.jsp';
    });
});
function logout() {
    $.ajax({
        url: '/logout.do',
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                window.location.href = '../../login.html';
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
var se = null, m = 0, s = 1;
var gnum ;
function count_time() {
    if(m == 0 && s == 0){
        clearInterval(se);
        $('#timeshow').text('00:00');
        alert('time over!');

        return;
    }
    if (s == 0) { m -= 1; s = 59; }

    t = (m <= 9 ? "0" + m : m) + ":" + (s <= 9 ? "0" + s : s);
    $('#timeshow').text(t);
    s -= 1;

}
function start_count() {
    $(this).attr("disabled", true);

    if(se != null)
        return;
    m=$('.choose-time').find('select').val()-1;
    s=59;

    se = setInterval(count_time, 1000);
}
function stop_count() {
    clearInterval(se);
}
function fresh_count() {
    clearInterval(se);
    m = s = 0;
    $('#timeshow').text("00:00");
    $('a.start').attr("disabled", false);
}
function init_groups() {
    $.ajax({
        url: '/api/user/list.do?utype=4&schid=1&clzid='+$('#clzid').text(),
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success:function (msg){
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var users = msg.users;
                var user_num = users.length;
                var grps = Math.ceil(user_num/gnum);
                var grp_rows = Math.ceil(grps/3);
                var grp_container = new Array();

                if(gnum > user_num)
                    gnum = user_num;
                for(var i=1;i <= grps;++i){
                    var tgrp = $('#group-a').clone();
                    tgrp.attr('id','group-'+i);
                    tgrp.attr('team',i);
                    tgrp.find('.group-child-child-title').find('h1').text('Group '+i);
                    var user_list = tgrp.find('.group-list').find('ul');
                    for(var ci = (i*gnum)-gnum;ci<(i*gnum);++ci){
                        if(ci < users.length){
                            user_list.append('<li stuid="'+users[ci].id+'">'+users[ci].name+'</li>');
                        }
                    }
                    tgrp.find('.score').on('click', function () {
                        $(this).next().toggle();
                    });
                    tgrp.find(".score-list li").each(function(){
                        $(this).click(function () {
                            $(".score-list").hide();
                            $(this).parent().parent().prev().text(' '+$(this).text()).css({'color':'#ea565f','font-size':'24px','font-weight':'600'});
                            var team = $(this).parent().parent().parent().parent().attr('team');
                            var data = 'rcid='+$('#crsid').text()+'&team='+team+'&grade='+$(this).text();
                            $(this).parent().parent().parent().parent().find('.group-list').find('li').each(function () {
                                data += '&stuid='+$(this).attr('stuid');
                            });
                            //alert(data);

                             $.ajax({
                             url: '/api/coursegrade/team/add.do',
                             type: 'POST',
                             data: data,
                             dataType: 'json',
                             async: false,
                             success:function (msg){
                             var err = msg.err;
                             if (typeof(err) == 'undefined' || err == '') {
                                //alert('score ok');
                             }
                             },
                             error: function(jqXHR, status, err) {
                             alert(err);
                             }
                             });
                        });
                    });
                    tgrp.show();
                    grp_container.push(tgrp);
                }

                for(var i=1;i<=grp_rows;++i){
                    var c_row = $('#group-model').clone();
                    var g_list = c_row.find('.group-child');
                    for(var ci = (i*3)-3;ci< (i*3);++ci){
                        if(ci < grp_container.length){
                            g_list.append(grp_container[ci]);
                        }
                    }
                    c_row.show();
                    $('.container-right').append(c_row);
                }
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}