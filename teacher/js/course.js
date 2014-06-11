/**
 * Created by p on 2014/5/19.
 */
$(document).ready(function (){

    var cfl = $('#course-file-list');
    var cim = cfl.find('#course-file-item-model');
    $('.courses-search').find('img').on('click',search_course);
    $('#course-week-pre').on('click', function () {

    });
    $('#course-week-next').on('click', function () {

    });
    $('#show-media').find('#close-icon').on('click',closeshowmedia);
    init_course_list();

});
function closeshowmedia(){
    $('#show-media').hide();
    $('#fade').hide();
    $('#show-media').find('div.play-file').remove();
}
var getByteLen = function (val) {
    var len = 0;
    for (var i = 0; i < val.length; i++) {
        if (val[i].match(/[^x00-xff]/ig) != null)
            len += 2;
        else
            len += 1;
    };
    return len;
}
function getPredixName(val){
    var nm = "";
    var vl = 44;
    var i=0;
    while(vl > 0 && i<val.length){
        if (val[i].match(/[^x00-xff]/ig) != null)
            vl -= 2;
        else
            vl -= 1;
        nm += val[i];
        i+=1;
    }
    return nm;
}
function search_course() {
    var mask_text = $(this).parent('.courses-search').find('input').val();
    var course_list = $('#course-ul');
    course_list.find('li[id^=course-item-]').each(function () {
        $(this).show();
        if($(this).find('.courses-name').text().indexOf(mask_text) < 0)
            $(this).hide();
    });
}
function show_week_file() {
    var othis = $(this);
    if(othis.attr('show-file') == '1'){
        othis.parent().parent().parent().find('.wj-zhankai').hide();
        othis.attr('show-file',0);
        return;
    }
    var url = '/api/treasure/list.do?crsid='+othis.attr('courseid')+'&week='+othis.attr('weeknum');
    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var files = msg.treasures;
                var fc = othis.parent().parent().parent().find('.wj-zhankai');
                var fm = fc.find('#file-item-model');
                fc.find('p[id^=sub-file-]').remove();

                for(var i=0;i<files.length;++i){
                    var ff = fm.clone();
                    ff.attr('id','sub-file-'+i);
                    var name_lenth = getByteLen(files[i].tname);
                    var new_name = getPredixName(files[i].tname);
                    if(name_lenth > 47)
                        ff.find('strong').text(new_name+'...');
                    else ff.find('strong').text(files[i].tname);
                    ff.find('#down').attr('file-path',files[i].tpath);
                    ff.find('#down').attr('trid',files[i].id);
                    ff.find('#down').on('click',download_file);
                    ff.find('#show').attr('file-path',files[i].tpath);
                    ff.find('#show').on('click', function () {

                        $('#show-media').append('<a class="play-file" href="'+$(this).attr('file-path')+'">'+$(this).attr('file-path')+'</a>');
                        $('#show-media').show();
                        $('#show-media').find('a.play-file').media( { width: 400, height: 300, autoplay: true } );
                        $('#fade').show();
                    });
                    ff.show();
                    fc.append(ff);
                }
                fm.hide();
                fc.show();
                othis.attr('show-file',1);
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
function upload_file() {
    var form = $(this).parent('#course-week-form');
    var othis = $(this);
    var sp = $(this).parent('#course-week-form').parent().parent().parent();
    var prg = $(this).parent('#course-week-form').parent().parent().parent().parent().parent().find('#progressbar');

    form.ajaxForm({
        url: '/api/treasure/upload.do?crsid='+$(this).attr('courseid')+'&week='+$(this).attr('weeknum'),
        dataType: 'json',
        beforeSend: function(jqXHR) {
            sp.hide();
            prg.progressbar({
                value: 0
            });
            prg.progressbar( "option", "max", 100 );
            prg.css('visibility','visible');
        },
        uploadProgress: function(event, position, total, percentComplete) {
            prg.progressbar({
                value: percentComplete
            });
        },
        success: function(msg, status) {


            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                alert('upload file successfully');
            } else {
                alert(err);
            }

        },
        error: function (jqXHR, status, err) {
            alert(err);
        },
        complete: function(jqXHR, status) {
            othis.attr('disabled', false);
            prg.css('visibility','hidden');
            sp.show();

        }
    });

    form.submit();
}
function download_file() {
    var url_to = '/api/treasure/download.do';
    var data_to = 'id='+$(this).attr('trid');

    $.ajax({
        url: url_to,
        type: 'POST',
        data: data_to,
        dataType: 'json',
        context: this,
        beforeSend: function(jqXHR) {

        },
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                window.location.href = url_to+'?d=1&'+data_to;
            } else {
                alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        },
        complete: function(jqXHR, status) {
            $(this).attr('disabled', false);
        }

});
}

function init_course_list(){
    var course_list = $('.courses-list-detail').find('ul');
    var course_model = course_list.find('li');

    course_model.hide();
    $.ajax({
        url: '/api/course/list.do?schid='+$('#schid').text(),
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        beforeSend: function(jqXHR) {

        },
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var courses = msg.courses;

                for(var i=0;i<courses.length;++i){
                    var cr = course_model.clone();

                    cr.attr('id','course-item-'+courses[i].name);
                    cr.find('.courses-img').find('img').attr('src',courses[i].logo);
                    cr.find('.courses-name').text(courses[i].name);
                    cr.find('.courses-eyes').find('a').attr('cid',i);

                    cr.find('.courses-eyes').find('a').on('click',function(){

                        var week_list = $('#course-file-list');
                        var week_model = week_list.find('#course-file-item-model');

                        week_list.find('li[id^=week-item-]').remove();
                        var wks = week_list.find('#add-week-model').find('select');
                        week_list.find('#add-week-model').find()
                        var c_detail = $('.courses-detail-wrap');
                        var i =parseInt($(this).attr('cid'));
                        c_detail.find('.courses-detail-name').text(courses[i].name);
                        c_detail.find('#absenceslim').text(courses[i].absenceslim);
                        c_detail.find('#tgper').text(courses[i].tgper);
                        c_detail.find('#quizper').text(courses[i].quizper);
                        c_detail.find('#middleper').text(courses[i].middleper);
                        c_detail.find('#finalper').text(courses[i].finalper);

                        for(var t=0;t<25;++t)
                            wks.append('<option value ="'+t+'">'+t+'</option>');
                        week_list.find('#add-week-model').find('a.wj-name').attr('crsid',courses[i].id);
                        week_list.find('#add-week-model').find('a.wj-name').unbind('click');
                        week_list.find('#add-week-model').find('a.wj-name').on('click', function () {

                            var nwk_name = $(this).parent().find('input.wj-lx').val();
                            var nwk_index = $(this).parent().find('select.wj-name').val();
                            var othis = $(this);
                            var crsid = othis.attr('crsid');
                            var dt = 'crsid='+crsid+'&week='+nwk_index+'&name='+nwk_name;
                            alert(dt);
                            if(nwk_name.length < 1){
                                alert('input week destcription');
                                return;
                            }
                            $.ajax({
                                url: '/api/course/week/add.do',
                                type: 'POST',
                                data: dt,
                                dataType: 'json',
                                context: this,
                                beforeSend: function(jqXHR) {
                                    othis.attr('disabled',true);
                                },
                                success: function(msg, status) {
                                    var err = msg.err;
                                    if (typeof(err) == 'undefined' || err == '') {
                                        var wk = week_model.clone();
                                        wk.find('.wj-name').text(msg.courseweek.week);
                                        wk.attr('id','week-item-'+msg.courseweek.week);
                                        wk.attr('sq',nwk_index);
                                        wk.find('.wj-show').attr('courseid',crsid);
                                        wk.find('.wj-show').attr('weeknum',msg.courseweek.week);
                                        wk.find('.wj-show').attr('show-file',0);// current state 0  no,1 show
                                        wk.find('.wj-zhankai').hide();
                                        wk.find('.wj-lx').attr('courseid',crsid);
                                        wk.find('.wj-lx').attr('weeknum',msg.courseweek.week);

                                        wk.find('.wj-lx').text(nwk_name);
                                        wk.find('#course-week-file').attr('courseid',crsid);
                                        wk.find('#course-week-file').attr('weeknum',msg.courseweek.week);
                                        wk.find('#course-week-file').on('change', upload_file);
                                        wk.find('.wj-show').on('click',show_week_file);
                                        wk.show();
                                        week_list.find('#add-week-model').before(wk);
                                    } else {
                                        alert(err);
                                    }
                                },
                                error: function(jqXHR, status, err) {
                                    alert(err);
                                    othis.attr('disabled',false);
                                }
                            });
                        });


                        var total = parseInt(courses[i].absenceslim)+parseInt(courses[i].tgper)
                            +parseInt(courses[i].quizper)+parseInt(courses[i].middleper)
                            +parseInt(courses[i].finalper);
                        c_detail.find('#total').text(total);
                        $('.courses-list-wrap').hide();

                        $.ajax({
                            url: '/api/course/week/list.do?crsid='+courses[i].id,
                            type: 'POST',
                            data: '',
                            dataType: 'json',
                            context: this,

                            success: function(msg, status) {
                                var err = msg.err;
                                if (typeof(err) == 'undefined' || err == '') {
                                    var weeks = msg.weeks;
                                    for(var k=0;k<weeks.length;++k){
                                        var wm = week_model.clone();

                                        wm.find('.wj-name').text(weeks[k].week);
                                        wm.attr('id','week-item-'+weeks[k].week);
                                        wm.attr('sq',k);
                                        wm.find('.wj-show').attr('courseid',weeks[k].crsid);
                                        wm.find('.wj-show').attr('weeknum',weeks[k].week);
                                        wm.find('.wj-show').attr('show-file',0);// current state 0  no,1 show
                                        wm.find('.wj-zhankai').hide();
                                        wm.find('.wj-lx').attr('courseid',weeks[k].crsid);
                                        wm.find('.wj-lx').attr('weeknum',weeks[k].week);

                                        wm.find('.wj-lx').text(weeks[k].name);
                                        wm.find('#course-week-file').attr('courseid',weeks[k].crsid);
                                        wm.find('#course-week-file').attr('weeknum',weeks[k].week);
                                        wm.find('#course-week-file').on('change', upload_file);
                                        wm.find('.wj-show').on('click',show_week_file);
                                        wm.show();
                                        week_list.find('#add-week-model').before(wm);
                                    }
                                    week_model.hide();
                                } else {
                                    alert(err);
                                }
                            },
                            error: function(jqXHR, status, err) {
                                alert(err);
                            }
                        });
                        c_detail.show();
                    });

                    course_list.append(cr);
                    cr.show();
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