/**
 * Created by p on 2014/5/21.
 */

$(document).ready(function () {
    init_myevent();
    $('#myevent-pre').on('click',myevt_pre);
    $('#myevent-next').on('click',myevt_next);
    $('.myevent-search').find('img').on('click',search_myevent);
});
var myevent_start = 0;
var myevent_step = 5;
function init_myevent() {
    var url = '/api/event/listjoined.do?start='+myevent_start+'&num='+myevent_step;

    handle_myevent(url,'');

}
function search_myevent() {
    var mask_text = $(this).parent('.myevent-search').find('input').val();
    var course_list = $('#myevent-ul');
    course_list.find('li[id^=myevent_item_]').each(function () {
        $(this).show();
        if($(this).find('strong').text().indexOf(mask_text) < 0)
            $(this).hide();
    });
}
function myevent_detail() {
    if($(this).attr('show') == '0'){
        $(this).parent().parent().find('.myevent-show').show();
        $(this).attr('show',1);
    }else{
        $(this).parent().parent().find('.myevent-show').hide();
        $(this).attr('show',0);
    }
}
function myevt_pre() {

    if(myevent_start == 0){
        alert('no previous page!');
        return;
    }
        myevent_start -= myevent_step;

    var url_to ='/api/event/listjoined.do?'+'start='+myevent_start+'&num='+myevent_step;

    handle_myevent(url_to,'');
}
function myevt_next() {
    myevent_start += myevent_step;
    var url_to ='/api/event/listjoined.do?'+'start='+myevent_start+'&num='+myevent_step;

    handle_myevent(url_to,'');
}
function exit_myevent() {
    var othis = $(this);
    $.ajax({
        url: '/api/event/unjoin.do?id='+$(this).attr('eventid'),
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                othis.parent().parent().parent().remove();
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });

}
function handle_myevent(url, data) {

    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        dataType: 'json',
        async: false,
        success: function (msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var events = msg.events;
                if(events.length == 0 ){
                    if(myevent_start > 0) {
                        myevent_start -= myevent_step;
                        alert('no next page!');
                    }
                    return;
                }
                $('.myevent-details').find('li[id^=myevent_item_]').remove();
                for (var i = 0; i < events.length; i++) {

                    var divart = $('.myevent-details').find('#myevent-item-model').clone();
                    divart.attr('id', 'myevent_item_' + events[i].id);
                    divart.find('.myevnet-summary').find('strong').text(events[i].title);
                    divart.find('.myevnet-summary').find('.event-info-jd').text(events[i].elocation+events[i].etime);

                    divart.find('.myevnet-summary').find('.event-close').on('click',myevent_detail);
                    divart.find('.myevnet-summary').find('.event-close').attr('show',0);//0 hide 1 show
                    divart.find('.myevent-show').hide();
                    divart.find('.myevent-text').text(events[i].msg);
                    divart.find('.myevent-info').find('#myevent-location').text('Location:'+events[i].elocation);
                    divart.find('.myevent-info').find('#myevent-time').text('Time:'+events[i].etime+'.Limit:'+events[i].emax);
                    divart.find('.myevent-info').find('#myevent-info').text(events[i].username+'.'+events[i].uptime);
                    divart.find('#myevent-exit').attr('eventid',events[i].id);
                    divart.find('#myevent-exit').on('click',exit_myevent);
                    divart.show();
                    $('.myevent-details').find('#myevent-item-model').after(divart);
                }
                $('.myevent-details').find('#myevent-item-model').hide();
            } else {
                alert(err);
            }
        },
        error: function (jqXHR, status, err) {
            alert(err);
        }
    });
}