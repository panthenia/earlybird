/**
 * Created by p on 2014/9/23.
 */
function fill_item(item,grd) {
    item.find('.user-logo').attr('src',grd.stuphoto);
    grd.stunameen.length > 0 ? item.find('.user-name').text(grd.stunameen):item.find('.user-name').text(grd.stuname);
    item.find('.user-score').text(' = '+grd.teamGrades[grd.teamGrades.length-1].grade);
}
function init_students() {
    $.ajax({
        url: '/api/coursegrade/team/list.do?rcid='+$('#crsid').text(),
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success:function (msg){
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {

                var grades = msg.coursegrades;
                var glen = grades.length;
                //alert('student num='+glen);
                    //= grades.length;
                var box_num = Math.ceil(glen/15);
                //alert('box_num='+box_num);

                for(var i=0;i<box_num;++i){
                    var box_tem = $('#box-model').clone();
                    var left_box = box_tem.find('.user-list-left');
                    var mid_box = box_tem.find('.user-list-mid');
                    var right_box = box_tem.find('.user-list-right');

                    box_tem.attr('id','box-'+i);
                    var lmr = 0;
                    var start = i * 15;
                    //alert('start='+start);
                    for(var k = 0;k < 15 && start+k <glen;++k,++lmr){
                        if(lmr < 5){//left插入
                            var aitem = left_box.find('#left-item-model').clone();
                            aitem.attr('id','left-item'+(start+k));
                            fill_item(aitem,grades[start+k]);
                            aitem.show();
                            left_box.find('#left-item-model').after(aitem);
                        }else if(lmr < 10 && lmr > 4){//mid插入
                            var aitem = mid_box.find('#mid-item-model').clone();
                            aitem.attr('id','mid-item'+(start+k));
                            fill_item(aitem,grades[start+k]);
                            aitem.show();
                            mid_box.find('#mid-item-model').after(aitem);
                        }else if(lmr > 9 ){//right插入
                            var aitem = right_box.find('#right-item-model').clone();
                            aitem.attr('id','right-item'+(start+k));
                            fill_item(aitem,grades[start+k]);
                            aitem.show();
                            right_box.find('#right-item-model').after(aitem);
                        }
                    }
                    box_tem.show();
                    $('#box-model').before(box_tem);
                }
            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });

}
$(document).ready(function () {

    init_students();
});