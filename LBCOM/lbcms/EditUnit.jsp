<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",dispMsg="",unitName="",noOfLessons="",insertAt="",unitId="",developerId="";
	
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	developerId=request.getParameter("userid");
	dispMsg=request.getParameter("dispmsg");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	noOfLessons=request.getParameter("no_of_lessons");
	insertAt=request.getParameter("insert_at");
	if(dispMsg==null)
		dispMsg="";

	if(dispMsg.equals("alreadyexists"))
	{
		dispMsg="<FONT COLOR=red face=verdana size=1>A unit with this name already exists in this course! Please choose another one.</FONT>";
		unitName=request.getParameter("unitname");
		noOfLessons=request.getParameter("no_of_lessons");
		insertAt=request.getParameter("insert_at");
	}
%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--

function validate()
{	
	var win=window.document.editunit;
	win.unitname.value=trim(win.unitname.value);	
	alert(win);
	if((win.unitname.value==null) || (win.unitname.value==""))
	{
		alert("Please enter the unit name");
		window.document.editunit.unitname.focus();
		return false;
	}
	
}
function show_key(the_field)
{
	var the_key="0123456789";
	the_value=the_field.value;
	var the_char;
	var len=the_value.length;
	for(var i=0;i<len;i++){
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1) {
			alert("Enter numbers only");
			the_field.focus();
			return false;
		}
	}
}

//-->

</SCRIPT>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Edit Unit</title>
</head>
<body>
<form name="editunit" action="AddNewUnit.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&mode=edit" method="POST" onsubmit="return validate();">
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>

<table border="0" cellspacing="1" width="60%" height="32" align="center">
<tr>
	<td width="47%" bgcolor="#808080" height="29"><b>
		<font face="Verdana" size="2" color="#FFFFFF">&nbsp;Edit Unit</font></b>
	</td>
    <td width="53%" bgcolor="#808080" height="29" align="right">
		<b><font face="Verdana" size="1" color="#FFFFFF">
		<a href="CourseUnits.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>">BACK TO MENU</a></font></b>&nbsp;
	</td>
</tr>
</table>
<table border="0" cellspacing="1" width="60%" height="162" align="center">
<tr>
	<td width="100%" colspan="2" height="19">&nbsp;<%=dispMsg%></td>
</tr>
<tr>
	<td width="19%" height="22" bgcolor="#B7B7B7">
		<b><font face="Verdana" size="2">&nbsp;Course Name</font></b>
	</td>
    <td width="48%" height="22" bgcolor="#E9E9E9">
		<input type="text" name="T1" size="30" value="<%=courseName%>" readonly>
	</td>
</tr>
<tr>
	<td width="19%" height="22" bgcolor="#B7B7B7">
		<b><font face="Verdana" size="2">&nbsp;Unit Name</font></b>
	</td>
    <td width="48%" height="22" bgcolor="#E9E9E9">
		<input type="text" name="unitname" value="<%=unitName%>" size="30">
	</td>
</tr>
<tr>
	<td width="19%" height="22" bgcolor="#B7B7B7">
		<b><font face="Verdana" size="2">&nbsp;No. of Lessons</font></b>
	</td>
    <td width="48%" height="22" bgcolor="#E9E9E9">
		<input type="text" name="no_of_lessons" value="<%=noOfLessons%>" size="5" onblur="show_key(this);return false;" readonly>
	</td>
</tr>
<tr>
	<td width="19%" height="22" bgcolor="#B7B7B7">
		<b><font face="Verdana" size="2">&nbsp;Insert Unit</font></b>
	</td>
    <td width="48%" height="22" bgcolor="#E9E9E9">
		<select size="1" name="insert_at">
			<option selected value="end">at the end</option>
			<option value="after1">after the unit 1</option>
		</select>
	</td>
</tr>
<tr>
	<td width="19%" height="19">&nbsp;</td>
    <td width="48%" height="19">&nbsp;</td>
</tr>
<tr>
	<td width="67%" height="19" colspan="2" bgcolor="#808080" align="center">
		<input type="submit" value="MODIFY" name="modify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="RESET" name="reset">
	</td>
</tr>
</table>

</form>
</body>
</html>
