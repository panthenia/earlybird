/**
 * Created by p on 2014/5/14.
 */
$(document).ready(function (){

    init_events();//获取event列表
    $('.account-li-last').on('click',logout);
    $('a.addevent').on('click',function(){
        var event_mini = $('#event-mini');
        for(var i=10;i<60;++i){
            event_mini.append('<option value="'+i+'">'+i+'</option>');
        }
        $('#light').show();
        $('#fade').show();
    });
    $('a.acsubmit').on('click',add_event);
    $('#dblight').find('a.apply').on('click',event_join_click);
    $("input[id='event-maxnum']").keyup(function(){
        $(this).val($(this).val().replace(/\D|^0/g,''));
    }).bind("paste",function(){
        $(this).val($(this).val().replace(/\D|^0/g,''));
    }).css("ime-mode", "disabled");

    $('#evt-pre').on('click',evt_pre);
    $('#evt-next').on('click',evt_next);

});
var event_start=0;
var event_step=3;
var ce_num = 0;

function evt_pre() {

    if(event_start == 0){
        alert('no previous page!');
        return;
    }
    event_start -= event_step;

    var url_to ='/api/event/list.do?'+'start='+event_start+'&num='+event_step;

    handle_event(url_to,'');
}
function evt_next() {

    if(ce_num < event_step){
        alert('no next page!');
        return;
    }
    event_start += event_step;
    var url_to ='/api/event/list.do?'+'start='+event_start+'&num='+event_step;

    handle_event(url_to,'');
}
function add_event() {
    var year = $('#selectAdate_selectYear').val();
    var mon = $('#selectAdate_selectMonth').val();
    var day = $('#selectAdate_selectDay').val();
    var time = $('#event-hour').val()+':'+$('#event-mini').val()+':00';
    var date = year+'-'+mon+'-'+day;

    var maxnum = $("input[id='event-maxnum']").val();
    var location = $('input[placeholder="Location"]').val();
    var msg = $('textarea[placeholder="Details"]').val();
    var title = $('.addevents').find('input[class="acname"]').val();


    if(maxnum == "" || title == "") {
        alert('plese fill the title and maxnum');
        return;
    }
    var data = 'elocation='+location+'&etime='+date+' '+time+'&emax='+maxnum+'&msg='+msg+'&title='+title;

    $.ajax({
        url: '/api/event/add.do',
        type: 'POST',
        data: data,
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                $('#light').hide();
                init_events();
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });

    $('#fade').hide();
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
function onEventTileClicked(){
    var event_id = $(this).attr('eventid');


    var edt = $('#dblight');
    var evt = $('.events').find('#div_article_'+event_id);

    edt.find('h1').text(evt.find('.events-title').find('a').text());
    //alert(evt.find('.events-title').find('p').text());
    edt.find('#event-detail-msg').text(evt.find('.events-title').find('p').text());
    edt.find('.showevents-info').find('#event-location').text(evt.find('.location').text());
    edt.find('.showevents-info').find('#event-time').text(evt.find('.whattime').text());
    edt.find('.showevents-info').find('#event-info').text(evt.find('.events-info').text());


    if($(this).attr('joined') == '0'){
        edt.find('a.apply').text('Apply');
        edt.find('a.apply').attr('joined',0);
    }
    else  {
        edt.find('a.apply').text('UnApply');
        edt.find('a.apply').attr('joined',1);
    }
    edt.find('a.apply').attr('eventid',event_id);

    edt.show();
    $('#fade').show();
}
function event_join_click(){

    var apply_this = $(this);
    var url;
    var eventid = $(this).attr('eventid');
    if($(this).text() == 'Apply')
        url = '/api/event/join.do?id='+eventid;
    else url='/api/event/unjoin.do?id='+eventid;

    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                init_myevent();
                if(apply_this.text()== 'Apply'){
                    $('.events').find('div[id=div_article_'+eventid+']').find('div.events-title').find('a').attr('joined',1);
                    apply_this.text('UnApply');
                }
                else {
                    $('.events').find('div[id=div_article_'+eventid+']').find('div.events-title').find('a').attr('joined',0);
                    apply_this.text('Apply');
                }
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });


}
function handle_event(url,data){
    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        dataType: 'json',
        async: false,

        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var events = msg.events;
                ce_num = events.length;
                if(events.length == 0){
                    if(event_start > 0){
                        event_start -= event_step;
                        alert('no next page!');
                    }
                    $('.events').find('#event_model').hide();
                    return;
                }

                $('.events').find('div[id^=div_article_]').remove();
                for (var i = 0; i < events.length; i++) {
                    var divart = $('.events').find('#event_model').clone();
                    var joins = events[i].joins;
                    divart.attr('id', 'div_article_'+events[i].id);
                    divart.find('.events-title').find('a').attr('eventid',events[i].id);
                    divart.find('.events-who').find('img').attr('src',events[i].userphoto);
                    divart.find('.events-title').find('a').attr('joined',0);//0 unjoined 1 joined
                    for(var j=0;j<joins.length;++j){
                        if(joins[j].userid == $('#userid').text())
                            divart.find('.events-title').find('a').attr('joined',1);
                    }
                    divart.find('.events-title').find('a').text(events[i].title);
                    divart.find('.events-title').find('p').text(events[i].msg);
                    divart.find('.events-title').find('a').on('click',onEventTileClicked);
                    divart.find('.location').text('Location:'+events[i].elocation);
                    divart.find('.whattime').text('Time:'+events[i].etime);
                    divart.find('.events-info').text(events[i].username+' '+events[i].uptime);
                    divart.show();
                    $('.events').find('#event_model').after(divart);
                }
                $('.events').find('#event_model').hide();
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
function init_events(){

    var url_to ='/api/event/list.do?'+'start='+event_start+'&num='+event_step;
    handle_event(url_to,'');

    $.ajax({
        url: '/api/event/alert/count.do',
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                $('div.whatnm').text(msg.count);
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}