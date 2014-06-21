<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ include file="comm.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
<%@ include file="meta.jsp"%>
    <script>
jQuery(function() {
    $('#btn_search').click(function () {
        if ($('#text_search').val().trim() == '') {
            $('li[id^=li_]').each(function () {
                $(this).show();
            });
        } else {
            $('li[id^=li_]').each(function () {
                if ($(this).find('#li_name').text().toLowerCase().indexOf($('#text_search').val().toLowerCase()) != -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    });
    $(document).ready(function () {
        init_courses();
    });
    $('#btn_back').click(function () {
        window.location.href = 'select.jsp';
    });
});

function init_courses() {
    var url_to = '/api/regcourse/list.do';
    var data_to = 'semid=' + $('#semid').text() + '&schid=' + $('#schid').text() + '&teaid=' + $('#userid').text();
    //alert(data_to);
    $.ajax({
        url: url_to,
        type: 'POST',
        data: data_to,
        dataType: 'json',
        async: false,
        success: function (msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {

                var classes = msg.regcourses;
                for (var i = 0; i < classes.length; i++) {
                    var li = $('#temp_li').clone();
                    li.attr('id', 'li_' + i);
                    li.show();

                    li.find('#li_name').text(classes[i].clzname);
                    li.find('#crs_name').text(classes[i].crsname);
                    li.find('#li_tea').text(classes[i].teaname);
                    li.find('#btn_view').attr('rcsid', classes[i].id);
                    li.find('#btn_view').click(function () {
                        window.location.href = 'registersview.jsp?id=' + $(this).attr('rcsid');
                    })
                    $('#temp_li').before(li);
                }
            } else {
                alert(err);
            }
        },
        error: function (jqXHR, status, err) {
            alert(err);
        }
    });
}


    </script>
  </head>
  <body>
  <p id="userid" style="display:none"><%= cu.getId() %>
  </p>
<%Semester sm = Utils.getCurSem(request);
    int semid;
    if (sm == null)
        semid = 0;
    else semid = sm.getId();
%>
  <p id="semid" style="display:none"><%= semid %>
  </p>
  <p id="schid" style="display:none"><%=cu.getSchid()%>
    <div class="container">
<%@ include file="topbar.jsp"%>
      <div class="main clearfix">
        <div class="cont">
          <div class="titA">
            <h2>Registers List</h2>
          </div>
          <div class="searchbar">
            <div class="fr">
                <span><%= sm.getName()%></span>
            </div>
            <div class="searchbox_w360">
              <input id="text_search" value="Class" class="inp" type="text" name="">
              <input id="btn_search" class="btn ico-search" type="submit" value="">
            </div>
          </div>

          <ul class="ulA">
            <li id="temp_li" style="display: none;">
              <div class="operatebar">
                <span id="btn_view"><i class="function_icon ico-view"></i>View</span>
              </div>

              <span class="fb" id="li_name"></span>
              <span class="fb" id="crs_name"></span>
              <span class="cGray" id="li_tea"></span>
            </li>
          </ul>
            <div class="row pb10">
                <strong class="toc" id="btn_back"><i class="function_icon ico-back"></i>Back</strong>
            </div>
        </div>
      </div>
    </div>

  </body>
</html>
