<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ include file="comm.jsp"%>
<%
  String rcid = request.getParameter("id");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
<%@ include file="meta.jsp"%>
    <script>
jQuery(function() {
  $(document).ready(function() {
    initHtml();
  });

  $('#btn_export').click(function() {
    var url_to = '/api/coursegrade/export.do';
    var data_to = 'rcid=<%=rcid%>';

    $.ajax({
      url: url_to,
      type: 'POST',
      data: data_to,
      dataType: 'json',
      context: this,
      beforeSend: function(jqXHR) {
        $(this).attr('disabled', true);
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
  });
  
  $('#btn_print').click(function() {
    window.print();
  });
  
  $('#btn_edit').click(function() {
    window.location.href='registersedit.jsp?id=<%=rcid%>';
  });
  
  $('#btn_back').click(function() {
    window.location.href='registerslist.jsp';
  });
});

function initHtml() {
  initRegister();
}

function initRegister() {
  var url_to ='/api/coursegrade/list.do';
  var data_to = 'rcid=<%=rcid%>';

  $.ajax({
    url: url_to,
    type: 'POST',
    data: data_to,
    dataType: 'json',
    async: false,
    beforeSend: function(jqXHR) {
      $('tr[id^=tr_]').remove();
    },
    success: function(msg, status) {
      var err = msg.err;
      if (typeof(err) == 'undefined' || err == '') {
        var rc = msg.regcourse;
        $('#ifbar_semname').text(rc.semname);
        $('#ifbar_clzname').text(rc.clzname);
        $('#ifbar_crsname').text(rc.crsname);
        $('#ifbar_teaname').text(rc.teaname);
        
        var cgs = msg.coursegrades;
        for (var i = 0; i < cgs.length; i++) {
          var tr = $('#temp_tr').clone();
          tr.attr('id', 'tr_'+i);
          tr.show();

          tr.find('#td_num').text(cgs[i].stunum);
          tr.find('#td_name').text(cgs[i].stuname);
          tr.find('#td_absences').text(cgs[i].absences);
          tr.find('#td_tg').text(cgs[i].tg);
          tr.find('#td_quiz').text(cgs[i].quiz);
          tr.find('#td_perf').text(cgs[i].perf);
          tr.find('#td_middle').text(cgs[i].middle);
          tr.find('#td_final').text(cgs[i].final);
          tr.find('#td_total').text(cgs[i].total);

          $('#temp_tr').before(tr);
        }
      } else {
        //alert(err);
      }
    },
    error: function(jqXHR, status, err) {
      //alert(err);
    }
  });
}
    </script>
  </head>
  <body>
    <div class="container">
<%@ include file="topbar.jsp"%>
      <div class="main clearfix">
        <div class="cont">
          <div class="titA">
            <h2>Register view</h2>
            <div class="operatebar fr">
              <span id="btn_export"><i class="function_icon ico-export"></i>Export</span>
              <span id="btn_print"><i class="function_icon ico-print"></i>Print</span>
              <span id="btn_edit"><i class="function_icon ico-edit"></i>Edit</span>
            </div>
          </div>
          <div class="searchbar">
            <span class="fr lh30" id="ifbar_semname"></span>
            <span class="f18" id="ifbar_clzname"></span>
            <span class="f18 ml10" id="ifbar_crsname"></span>
            <span class="f18 ml10" id="ifbar_teaname"></span>

          </div>

          <table class="tableB">
            <tr>
              <th style="width:70px">Student<br>Number</th>
              <th style="width:140px">Name</th>
              <th style="width:70px">Absence</th>
              <th style="width:70px">Class ATM</th>
              <th style="width:70px">Quiz<br>Average</th>
              <th style="width:70px">Per-<br>formance</th>
              <th style="width:70px">Mid<br>Exam</th>
              <th style="width:70px">Final<br>Exam</th>
              <th style="width:70px">Total</th>
            </tr>
            <tr id="temp_tr" style="display: none;">
              <td id="td_num"></td>
              <td id="td_name"></td>
              <td id="td_absences"></td>
              <td id="td_tg"></td>
              <td id="td_quiz"></td>
              <td id="td_perf"></td>
              <td id="td_middle"></td>
              <td id="td_final"></td>
              <td id="td_total"></td>
            </tr>
          </table>

          <div class="row pb10" >
            <strong class="toc" id="btn_back"><i class="function_icon ico-back"></i>Back</strong>
          </div>
        </div>
      </div>
    </div>
  </body>
<script>
    function back() {
        history.back();
    }
</script>
</html>
