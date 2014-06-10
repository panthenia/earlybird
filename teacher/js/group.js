/**
 * Created by p on 2014/5/31.
 */
$(document).ready(function () {
    $('input.btn_03').on('click', function () {
        $(this).hide();
        $('.group_right').show();

    });
    $('.btn_02').on('click',group_bypeople);
    $("input.text_01").keyup(function(){
        $(this).val($(this).val().replace(/\D|^0/g,''));
    }).bind("paste",function(){
        $(this).val($(this).val().replace(/\D|^0/g,''));
    }).css("ime-mode", "disabled");
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
function group_bypeople() {
    var clzid = $(this).attr('clzid');
    var crsid = $(this).attr('crsid');
    var num = $('input.text_01').val();

    if(num.length < 1){
        alert('input the number of group');
        return;
    }

    window.location.href = 'score.jsp?'+'clzname='+$('#clzname').text()+'&grade='+$('#clzgrade').text()+"&crsid="+crsid+"&clzid="+clzid+"&gnum="+num;
}