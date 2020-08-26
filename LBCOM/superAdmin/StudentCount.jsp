<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	String facilityName=request.getParameter("fname");
	String facilityId=request.getParameter("fid");
	String totalStudents=request.getParameter("count");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>

<body bgcolor="#FAF4F1">
<form method="POST" action="UpdateStudentCount.jsp?fid=<%=facilityId%>">

<p>&nbsp;</p>
<p>&nbsp;</p>

<div align="center">
  <center>
  <table border="0" cellspacing="1" width="60%">
    <tr>
      <td width="38%" height="27" bgcolor="#C28256">
      <font face="Verdana" size="2">&nbsp;</font><b><font face="Verdana" size="2">Student 
      Licenses</font></b></td>
      <td width="62%" height="27" bgcolor="#C28256">
      <p align="right">
      <font face="Verdana" size="2">&nbsp;</font><b><a href="FacilityHome.jsp" style="text-decoration: none"><font color="#FFFFFF" face="Verdana" size="1">&lt;&lt;</font><font color="#FFFFFF" face="Verdana" size="2">Back</font></a></b></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2">
      <font face="Verdana" size="2">&nbsp;Name of the Facility</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2">
                  
          <font face="Verdana" size="2"><%=facilityName%></font></td>
    </tr>
    <tr>
      <td width="38%" height="19" bgcolor="#DDB9A2">
      <font face="Verdana" size="2">&nbsp;Facility ID</font></td>
      <td width="62%" height="19" bgcolor="#EEDDD2">
                  
          <font face="Verdana" size="2"><%=facilityId%></font></td>
    </tr>
		<tr>
			<td width="38%" height="19" bgcolor="#DDB9A2">
				<font face="Verdana" size="2">&nbsp;Enter the number of Licenses</font>
			</td>
			<td width="62%" height="19" bgcolor="#EEDDD2">
				<input type="text" name="count" value="<%=totalStudents%>" size="20">
			</td>
    </tr>
    </table>
  </center>
</div>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="60%">
    <tr>
      <td width="100%" height="19" bgcolor="#C28256">
      <p align="center"><input type="submit" value="Submit" name="B1">&nbsp;&nbsp;
      <input type="reset" value="Reset" name="B2"></td>
    </tr>
  </table>
  </center>
</div>
</form>
</body>

</html>