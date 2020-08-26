<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";

	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	developerId=request.getParameter("userid");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>You have successfully created the lesson</title>
<script>
function previewLesson()
{
	window.open("01_01_01_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>","Document","resizable=yes,scrollbars=yes,width=350,height=350,toolbars=no");
}

</script>
</head>

<body>

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="40%" id="AutoNumber1">
    <tr>
      <td width="100%" colspan="4">&nbsp;</td>
    </tr>
    <tr>
      <td width="8%">
      <p align="center"><font face="Verdana" size="2">&nbsp;</font></td>
      <td width="79%" colspan="3"><font color="#000080" face="Verdana" size="2">
      <b>You have successfully created the lesson!</b></font></td>
    </tr>
    <tr>
      <td width="100%" colspan="4">&nbsp;</td>
    </tr>
    <tr>
      <td width="1%">
      <p align="center"><b><font face="Verdana" size="2">&nbsp;</font></b></td>
      <td width="27%" align="left">
		<b><font face="Verdana" size="1"><a href="#" onclick="previewLesson(); return false;">PREVIEW</a></font></b>
	  </td>
      <td width="42%">
      <p align="right"><b><font face="Verdana" size="1">
      <a href="CourseUnitLessons.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>">GO TO THE LESSONS HOME</a></font></b></td>
      <td width="10%">&nbsp;</td>
    </tr>
  </table>
  </center>
</div>

</body>

</html>
