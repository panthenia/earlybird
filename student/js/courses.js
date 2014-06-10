/**
 * Created by p on 2014/5/17.
 * 找出学期
 * 根据学期找去相应课程
 */
$(document).ready(function(){
    init_semester();
    $('#course-search').on('click',fresh_course);
    $('#student-name').text($('#username').text());
    $('#student-sid').text($('#usernum').text());
    $('#student-class').text($('#classname').text());
});
function fresh_course(){
    var c_id = $('#course-select').val();
    var s_id = $('#semester-select').val();
    var course_table = $('#course-table');

    if(c_id == -1 && s_id == -1){
        course_table.find("tr").show();
    }
    if(c_id == -1 && s_id != -1){
        course_table.find("tr[sem-id='"+s_id+"']").show();
        course_table.find("tr[sem-id!='"+s_id+"']").hide();
    }
    if(c_id != -1 && s_id == -1){
        course_table.find("tr[id='"+c_id+"']").show();
        course_table.find("tr[id!='"+c_id+"']").hide();
    }
    if(c_id != -1 && s_id != -1){
        course_table.find("tr").show();
        course_table.find("tr[sem-id!='"+s_id+"']").hide();
        course_table.find("tr[id!='"+c_id+"']").hide();
    }
    course_table.find("tr[id='course-title']").show();

}
function get_course(sem_id) {
    var url = '/api/coursegrade/'+$('#userid').text()+'/list.do?semid='+sem_id;

    var course_table = $('#course-table');
    var course_select = $('#course-select');
    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        beforeSend: function(jqXHR) {
            //course_table.find("tr[id!='course-title']").remove();
        },
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var grds = msg.coursegrades;

                for(var i=0;i<grds.length;++i){
                    var tr = $('#course-title').clone();
                    tr.attr('id',grds[i].id);
                    tr.attr('sem-id',sem_id);
                    tr.find('#course').text(grds[i].crsname);
                    tr.find('#absence').text(grds[i].absences);
                    tr.find('#class-atm').text(grds[i].tg);
                    tr.find('#quiz-aver').text(grds[i].quiz);
                    tr.find('#mid').text(grds[i].middle);
                    tr.find('#final').text(grds[i].final);
                    tr.find('#total').text(grds[i].total);
                    $('#course-title').after(tr);
                    course_select.append("<option value='"+grds[i].id+"'>"+grds[i].crsname+"</option>");
                }
            } else {
                //alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            //alert(err);
        },
        complete: function(jqXHR, status) {

        }
    });
}
function init_semester() {
    var sem_select = $('#semester-select');

    $.ajax({
        url: '/api/semester/list.do',
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        beforeSend: function(jqXHR) {
            sem_select.empty();
            sem_select.append("<option value='-1'>ALL</option>");
            $('#course-select').empty();
            $('#course-select').append("<option value='-1'>ALL</option>");
        },
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var sems = msg.semesters;
                for(var i=0;i<sems.length;++i){
                    sem_select.append("<option value='"+sems[i].id+"'>"+sems[i].name+"</option>");
                    get_course(sems[i].id);
                }

            } else {
                //alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            //alert(err);
        },
        complete: function(jqXHR, status) {

        }
    });
}