

$(document).ready(function () {
    $('#login_button').on('click', function () {
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
                    case 1: alert('login as admin');break;
                    case 2: alert('login as supvisor');break;
                    case 3:
                        window.location.href = '../teacher/index.jsp';
                        break;
                    case 4: window.location.href = '../student/student.jsp';break;
                    default :alert('login error');break;
                }
            }else {
                alert("login error"+data.err);
            }
        });
    });
});
