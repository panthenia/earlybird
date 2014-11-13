
function login() {
    var acc = $('#email').val();
    var pass = $('#passw').val();

    if (acc == '' || pass == '') {
        alert('input account or password');
        return;
    }

    pass = $.sha1(pass);
    var url = '/login.do?acc='+acc+'&pwd='+pass;
    $.getJSON(url,function (data){
        if (data.err == '') {
            $('#email').val('');
            $('#passw').val('');
            switch (data.utype){
                case 1:
                    window.location.href = '../admin/';
                    break;
                case 2:
                    window.location.href = '../supervisor/';
                    break;
                case 3:
                    window.location.href = '../teacher/index.jsp';
                    break;
                case 4: window.location.href = '../student/student.jsp';
                    break;
                default :alert('login error');break;
            }
        }else {
            alert("login error"+data.err);
        }
    });
}
$(document).ready(function () {
    $('#login_button').on('click',login);
    $("body").bind('keyup',function(event) {
        if(event.keyCode==13){
            login();
        }
    });
});
