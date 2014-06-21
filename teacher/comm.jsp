<%@ page import="com.atm.model.User"%>
<%@ page import="com.atm.model.Semester"%>
<%@ page import="com.atm.util.Utils"%>
<%
  User cu = Utils.getCurUser(request);
  if (cu.getId() == null || cu.getId() == 0) {
    request.setAttribute("msg", Utils.ERR_PLEASELOGIN);
    request.getRequestDispatcher("/error.jsp").forward(request, response);
    return;
  }

  String username = cu.getName();
  if (username.equals("")) {
    username = cu.getAcc();
  }
  
  Semester cs = Utils.getCurSem(request);
%>
