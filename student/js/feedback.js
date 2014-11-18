/**
 * Created by p on 2014/5/25.
 */
$(document).ready(function () {
    init_feedbacks();
});
function send_feedback() {

    var il = ($('.question-edit-wrap').find('#question-list').find("input[type='radio'][name='look']").length)/3-1;
    var cl = $('.question-edit-wrap').find('#question-list').find("input[type='radio'][name='look']:checked").length;

    if(cl < il){
        alert('some question unfinished');
        return;
    }
    var othis = $(this);
    var url = '/api/feedback/edit.do?id='+othis.attr('fbid')+'&published=1';
    var data ='';

    $('.question-edit-wrap').find('#question-list').find('div[id^=qnum-]').each(function () {
        data += '&feedbackGrades['+$(this).attr('index')+'].grade='+
            $(this).find('input[type="radio"][name="look"]:checked').val()+
            '&feedbackGrades['+$(this).attr('index')+'].qnum='+$(this).attr('qnum');
    });
    data = data.substr(1,data.length);
    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                alert('you have send a question');
                init_feedbacks();
                $('.question-edit-wrap').hide();
                $('.qusetion-wrap').show();
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
function view_feedback() {
    var vdt = $('.question-view-wrap');
    $('.qusetion-wrap').hide();
    var othis = $(this);
    var url = '/api/feedback/info.do?id='+$(this).attr('fbid');
    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var fbc = msg.feedback;
                var qes = fbc.feedbackGrades;
                var qlist = vdt.find('#question-list');
                var qmodel = qlist.find('#question-model');

                qlist.find('div[id^=qnum-]').remove();

                vdt.find('.question-edit-title').find('strong').text(othis.attr('crn'));
                vdt.find('em.techername').text("teacher:"+othis.attr('tn'));
                vdt.find('em.current').text("Current Semester:"+$('#semname').text());

                for(var i=0;i<qes.length;++i){
                    var qm = qmodel.clone();

                    qm.attr('id','qnum-'+qes[i].qnum);
                    qm.attr('qnum',qes[i].qnum);
                    qm.attr('index',i);
                    qm.find('.question-edit-list-nm-name').text(qes[i].qnum+' '+qes[i].descpt);

                    switch (qes[i].grade){
                        case 1:
                            qm.find("input[type='radio'][name='look'][value='1']").attr("checked", true);
                            break;
                        case 2:
                            qm.find("input[type='radio'][name='look'][value='2']").attr("checked", true);
                            break;
                        case 3:
                            qm.find("input[type='radio'][name='look'][value='3']").attr("checked", true);
                            break;
                    }
                    qlist.append(qm);
                    qm.show();
                }
                qmodel.hide();
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
    vdt.show();
}
function edit_feedback() {

    var edt = $('.question-edit-wrap');
    $('.qusetion-wrap').hide();
    var othis = $(this);
    var url = '/api/feedback/info.do?id='+$(this).attr('fbid');
    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var fbc = msg.feedback;
                var qes = fbc.feedbackGrades;
                var qlist = edt.find('#question-list');
                var qmodel = qlist.find('#question-model');

                qlist.find('div[id^=qnum-]').remove();

                edt.find('.question-edit-title').find('strong').text(othis.attr('crn'));
                edt.find('em.techername').text("teacher:"+othis.attr('tn'));
                edt.find('em.current').text("Current Semester:"+$('#semname').text());

                for(var i=0;i<qes.length;++i){
                    var qm = qmodel.clone();

                    qm.attr('id','qnum-'+qes[i].qnum);
                    qm.attr('qnum',qes[i].qnum);
                    qm.find('.nm').text(qes[i].qnum);
                    qm.attr('index',i);
                    qm.find('.question-edit-list-nm-name').text(qes[i].descpt);
                    qlist.append(qm);
                    qm.show();
                }
                qmodel.hide();
                edt.find('.question-edit-tools').find('.sendemail').attr('fbid',othis.attr('fbid'));
                edt.find('.question-edit-tools').find('.sendemail').unbind('click');
                edt.find('.question-edit-tools').find('.sendemail').on('click',send_feedback);
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
    edt.show();
}
function init_feedbacks() {
    var url = '/api/feedback/'+$('#userid').text()+'/list.do?semid='+$('#semid').text();

    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var fbs = msg.feedbacks;
                var fls = $('#feed-back-list');
                var nfb = fls.find('#fb-new-model');
                var ofb = fls.find('#fb-old-model');
                fls.find('li[id^=feedback-]').remove();
                for(var i=0;i<fbs.length;++i){
                    if(fbs[i].published == '0'){//unpublished
                        var fm = nfb.clone();
                        fm.attr('id','feedback-'+fbs[i].id);
                        fm.find('.question-name').text(fbs[i].crsname);
                        fm.find('.question-tooles-fill').attr('fbid',fbs[i].id);
                        fm.find('.question-tooles-fill').attr('tn',fbs[i].teaname);
                        fm.find('.question-tooles-fill').attr('crn',fbs[i].crsname);
                        fm.find('.question-tooles-fill').on('click',edit_feedback);
                        fls.append(fm);
                        fm.show();
                    }else {//published
                        var fm = ofb.clone();
                        fm.attr('id','feedback-'+fbs[i].id);
                        fm.find('.question-name').text(fbs[i].crsname);
                        fm.find('.question-tooles-view').attr('fbid',fbs[i].id);
                        fm.find('.question-tooles-view').attr('tn',fbs[i].teaname);
                        fm.find('.question-tooles-view').attr('crn',fbs[i].crsname);
                        fm.find('.question-tooles-view').on('click',view_feedback);
                        fls.append(fm);
                        fm.show();
                    }
                }
                nfb.hide();
                ofb.hide();
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
