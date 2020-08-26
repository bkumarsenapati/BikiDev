<%@page import = "java.sql.*,java.util.Date,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",developerId="",courseName="",standard="";

	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}

	courseId=request.getParameter("courseid");
	developerId=request.getParameter("userid");
	courseName=request.getParameter("coursename");
	standard=request.getParameter("standard");
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Add New Standard</title>
</head>

<body>
<form method="POST" action="AddCurriculumStandard.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>">
<center>
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="59%" height="102">
    <tr>
      <td width="100%" colspan="2" height="40"><b>
      <font face="Verdana" size="2" color="#000080">Add New Standard</font></b></td>
    </tr>
    <tr>
      <td width="25%" height="36"><b>
      <font face="Verdana" size="2" color="#FF0000">Standard :</font></b></td>
      <td width="80%" height="36">
        <font face="Verdana"><b>
        <textarea rows="3" name="standard" cols="36"></textarea><font size="2">
        </font></b></font>
      </td>
    </tr>
    <tr>
      <td width="100%" colspan="2" height="26">
      <p align="center"><font face="Verdana"><b><input type="submit" value="Submit" name="B1"><font size="2">&nbsp;
      </font><input type="reset" value="Reset" name="B2"></b></font></td>
    </tr>
  </table>
  </center>
</form>
</body>
</html>