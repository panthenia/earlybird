/**
 * Created by p on 2014/5/31.
 */
$(document).ready(function () {
    init_courses();
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
function start_score() {
    window.location.href = 'group.jsp'+"?crsid="+$(this).attr('crsid')+"&clzid="+$(this).attr('clzid')+"&name="+$(this).attr('clzname')+"&grade="+$(this).attr('clzgrade')+'&schid='+$('#schid').text();
}
function init_courses() {
    var url_to = '/api/regcourse/list.do';
    var data_to = 'semid='+$('#semid').text()+'&schid='+$('#schid').text()+'&teaid='+$('#userid').text();
    //alert(data_to);
    $.ajax({
        url: url_to,
        type: 'POST',
        data: data_to,
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {

                var classes = msg.regcourses;
                var rows = Math.ceil(classes.length/4);
                var content = $('.content');

                var row_model = content.find('.select-group');
                var class_model = row_model.find('.select-group-child');

                for(var i=1;i<=rows;++i){
                    var c_row = row_model.clone();
                    $('.content').append(c_row);
                    c_row.show();
                    c_row.find('.select-group-child').hide();
                    for(var ci=(i*4-4);ci<(i*4);++ci)
                        if(ci<classes.length){
                            var c_c = class_model.clone();
                            c_c.find('.group-img-title').find('h1').text(classes[ci].crsname);
                            c_c.find('.group-img-title').find('p').text(classes[ci].semname);
                            c_c.find('.select-group-child-img').find('img').attr('src',classes[ci].logo);
                            c_c.find('.select-group-child-button').attr('clzid',classes[ci].clzid);
                            c_c.find('.select-group-child-button').attr('crsid',classes[ci].crsid);
                            c_c.find('.select-group-child-button').attr('clzname',classes[ci].crsname);
                            c_c.find('.select-group-child-button').attr('clzgrade',classes[ci].semname);
                            c_c.find('.select-group-child-button').on('click',start_score);
                            c_row.append(c_c);
                            c_c.show();
                        }
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