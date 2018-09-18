<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Google New reCaptcha using Java</title>
</head>
<style type='text/css'>
.field {
  padding:0 0 10px 0;
}

.label {
  padding:3px 0;
  font-weight:bold;
}

.green {
  color:green;
  
}

.red {
  red:red;
}
</style>
<body>
<div style="text-align:center">
 <h1>Google reCaptcha using Java</h1>
</div>
<div style="width:400px;margin:auto">
<% 
String name = request.getParameter("name");
String email = request.getParameter("email");
String verified = request.getParameter("verified");
%>

<div class="field">
<div class="label">Entered Name</div>
<%if(name!=null){ %>
   <div><%=name%></div>
<%}%>
</div>

<div class="field">
<div class="label">Entered Email</div>
<%if(email!=null){ %>
   <div><%=email%></div>
<%}%>
</div>

<div class="field">
<div class="label">Verification status</div>
<%if(verified!=null && verified.equals("true")){ %>
   <div class="green">Entered Input By Human</div>
<%} else {%>
   <div class="red">Entered Input By Human</div>
<%} %>
</div>
</div>
</body>
</html>