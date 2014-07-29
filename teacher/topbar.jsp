<script type="text/javascript">
jQuery(function() {
  $(document).ready(function() {
    initTopbarHtml();
  });

  $('#logout').click(function() {
    var url_to = '/logout.do';
    var data_to = '';

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
          parent.location.href = '/';
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

  $('.topbar .ico-option').bind('click',function(){
      $('.topbar .option_tip').show();
  });
  $('body').bind('click',function(){
      $('.topbar .option_tip').hide();
  });
  $('.topbar .ico-option, .topbar .option_tip').bind('click',function(event){
      event.stopPropagation();
  });
});

function initTopbarHtml() {
  window.setInterval(function(){
    $.ajax({
      url: '/ping.do',
      type: 'POST',
      data: '',
      dataType: 'json',
      context: this,
      success: function(msg, status) {
        var err = msg.err;
        if (typeof(err) == 'undefined' || err == '') {
        } else {
          alert(err);
          parent.location.href = '/';
        }
      },
      error: function(jqXHR, status, err) {
        //alert(err);
      }
    });
  }, 300000);
}
</script>
<div class="topbar">
  <div class="logo">
    <img src="images/logo.png"/>
  </div>
  <div class="icons">
    <span><%=username%></span>
    <span><a href=""><i class="topbar_icon ico-user"></i></a></span>
    <span><a href=""><i class="topbar_icon ico-msg"></i><i id="msg_num" class="msg_num">0</i></a></span>
    <span class="option">
    <i class="topbar_icon ico-option"></i>
    <em class="option_tip">
      <a href="edit.jsp">Profile Settings</a>
      <a href="###" id="logout">Logout</a><i class="i_arrow"></i><i class="i_arrow_bd"></i>
    </em>
    </span>
  </div>
</div>
