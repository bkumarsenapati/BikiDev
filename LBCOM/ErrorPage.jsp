
<%@ page isErrorPage="true" %>
<%@page import ="java.io.*,coursemgmt.ExceptionsFile"%>

<html>
<head>
<title><%=application.getInitParameter("title")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<p> <img src="images/hsn/logo.gif" > 
</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="#999999" bgcolor="#003366" height="14" align="center">
  <tr>
    <td bordercolor="#CCCCCC" bgcolor="#003366" height="14">&nbsp;</td>
  </tr>
</table>

<p>&nbsp;</p>
<%
	out.println("	");
	PrintWriter pw = response.getWriter();
	exception.printStackTrace(pw);
	out.println("\n");

%>
<h1><font face="Arial" size="2">&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</font><font face="Arial" color="#FF0000" size="4">Exception Page</font></h1>
<p><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font color="#003366"><b>There is an exception raised by your application.</b></font></font></p>
<p><font face="Arial" size="2" color="#003366"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
May be you are not eligible to access that page or that page may have been removed or may be temporarily unavailable.</b></font></p>
<p><font face="Arial" size="2" color="#003366"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Your browser will be automatically redirected to the main page.</b></font></p>
<p><br>
<br>
<br>
</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="#999999" bgcolor="#003366" align="center">
  <tr>
    <td bordercolor="#CCCCCC" bgcolor="#003366">&nbsp;</td>
  </tr>
</table>

</body>
</html>
