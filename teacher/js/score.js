/**
 * Created by p on 2014/5/31.
 */
$(document).ready(function () {

    gnum = parseInt($('#gnum').text());
    $('.modal-body').find('img').each(function () {
       $(this).on('click', function () {
           if($(this).attr('full') == '0'){
               $(this).attr('src','images/star-full.png');
               var ci = parseInt($(this).attr('ci'));
               max_score = ci;
               for(var i=1;i<ci;++i){
                   $(this).siblings('img[ci='+i+']').each(function () {
                       $(this).attr('src','images/star-full.png');
                   })
               }

               for(var i= 5;i>ci;--i){
                   $(this).siblings('img[ci='+i+']').each(function () {
                       //alert('changed');
                       $(this).attr('src','images/star-empty.png');
                   })
               }
           }else if($(this).attr('full') == '1'){
               $(this).attr('src','images/star-empty.png');
               var ci = parseInt($(this).attr('ci'));
               max_score = ci-1;
               for(var i=1;i<ci;++i){
                   $(this).siblings('img[ci='+i+']').each(function () {
                       $(this).attr('src','images/star-full.png');
                   })
               }

               for(var i= 5;i>ci;--i){
                   $(this).siblings('img[ci='+i+']').each(function () {
                       //alert('changed');
                       $(this).attr('src','images/star-empty.png');
                   })
               }
           }

        //alert(max_score);
       });

    });
    $('.modal-footer').find('a').on('click', function () {

        var data = 'rcid='+$('#crsid').text()+'&team='+$(this).attr('team')+'&grade='+max_score;
        var c_grp = $('#group-'+$(this).attr('team'));
        for(var i=0;i<current_group_ids.length;++i){
            data += ('&stuid='+current_group_ids[i]);
        }
        $('#scoreModal').modal('hide');
        //alert(data);
        $.ajax({
            url: '/api/coursegrade/team/add.do',
            type: 'POST',
            data: data,
            dataType: 'json',
            async: false,
            success: function(msg, status) {
                var err = msg.err;
                if (typeof(err) == 'undefined' || err == '') {
                    if(max_score > ever_max_score){
                        ever_max_score = max_score;
                        $('#max-score-list').remove();
                        var max_grp = c_grp.clone();
                        max_grp.attr('id','max-score-list');
                        max_grp.css('margin-right','-40px');

                        max_grp.find('.group-child-child-title').css('border-bottom','1px solid #ffffff');
                        max_grp.css('float','right');
                        max_grp.css('width','250px');
                        max_grp.css('border','1px #ffffff solid');
                        max_grp.find('h1').text('TOP '+$('#gnum').text());
                        max_grp.find('h1').css('color','#ea565f');
                        max_grp.find('h1').css('font-size','20px');
                        max_grp.find('li').each(function () {
                           $(this).append("<img src='images/star-full.png'>");
                           $(this).append("<p> = "+max_score+"</p>");
                        });
                        $('.timeout').after(max_grp);

                    }
                } else {
                    alert(err);
                }
            },
            error: function(jqXHR, status, err) {
                alert(err);
            }
        });
    });
    init_groups();


    $('a.start').on('click',start_count);
    $('a.stop').on('click',stop_count);
    $('a.clear').on('click',fresh_count);
    $('.account-li-last').on('click',logout);
    $('.account-li-first').on('click', function () {
        window.location.href = 'edit.jsp';
    });
});
var current_group_ids = new Array();
var max_score = -1;
var ever_max_score = -1;
function go_score() {
    var modal = $('#scoreModal');
    modal.find('p').text($(this).text()+' Score');
    modal.find('a').attr('team',$(this).attr('team'));
    current_group_ids.length = 0;
    $(this).parent().next().find('li[id!=user-list-item]').each(function () {
        current_group_ids.push($(this).attr('id'));
    });
    modal.modal('show');
}
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
var se = null, m = 0, s = 1,timer_state = 0;//0-未开始计时，1-正在计时，2-暂停
var gnum ;
function count_time() {

    if(s == 59){
        s = 0;
        m += 1;
    }
    s++;
    t = (m <= 9 ? "0" + m : m) + ":" + (s <= 9 ? "0" + s : s);
    $('#timeshow').text(t);


}
function start_count() {

    if(timer_state == 1)
        return;
    if(timer_state == 0){
        s = 0;
        m = 0;
        timer_state = 1;
        se = setInterval(count_time, 1000);
    }
    if(timer_state == 2){
        timer_state = 1;
        se = setInterval(count_time, 1000);
    }


}
function stop_count() {
    timer_state = 2;
    clearInterval(se);
}
function fresh_count() {
    clearInterval(se);
    m = s = 0;
    $('#timeshow').text("00:00");
    timer_state = 0;
}
function init_groups() {
    $.ajax({
        url: '/api/user/list.do?utype=4&schid='+$('#schid').text()+'&clzid='+$('#clzid').text(),
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
                    tgrp.find('.group-child-child-title').find('h1').attr('team',i);
                    tgrp.find('.group-child-child-title').find('h1').on('click',go_score);

                    var user_list = tgrp.find('.group-list').find('ul');
                    for(var ci = (i*gnum)-gnum;ci<(i*gnum);++ci){
                        if(ci < users.length){
                            var auser = user_list.find('#user-list-item').clone();
                            auser.attr('id',users[ci].id);
                            auser.find('img').attr('src',users[ci].photo);
                            users[ci].nameen.length > 0 ? auser.find('span').text(users[ci].nameen):auser.find('span').text(users[ci].name);
                            auser.find('span').text();
                            auser.on('mouseover', function () {
                                $(this).find('img').css('width','31px');
                                $(this).find('img').css('height','31px');
                                $(this).find('span').css('font-size','16px');
                                $(this).find('span').css('font-weight','bold');

                            });
                            auser.on('mouseout', function () {
                                $(this).find('img').css('width','25px');
                                $(this).find('img').css('height','25px');
                                $(this).find('span').css('font-size','15px');
                                $(this).find('span').css('font-weight','normal');
                            });
                            auser.show();
                            user_list.append(auser);
                        }
                    }
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