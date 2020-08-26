<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",dispMsg="",unitName="",noOfLessons="",insertAt="",developerId="";
	
	
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

<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">
<!--

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
function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}

//-->

</SCRIPT>
<meta http-equiv="Content-Language" content="en-us">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Add A New Unit</title>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<form method="POST" action="AddNewUnit.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>&mode=add">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteBgClass" >

<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="368" height="70">
		<img src="images/logo.png" width="368" height="101" border="0">
	</td>
    <td> <a href="#" onClick="viewUserManual();return false;"><img src="images/helpmanaual.png" border="0" style="margin-left:320px;"></a></td>
    <td width="423" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="208" height="70" border="0">
    </td>
</tr>
  </table>
<br/>
<table border="0" cellspacing="1" width="85%" height="32" align="center">
<tr class="gridhdrNew">
	<td width="47%"  height="29">
	&nbsp;Add A New Unit
	</td>
    <td width="53%" height="29" align="right">
		<font face="Verdana" size="1" color="#FFFFFF">
		<a href="CourseUnits.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>"><< Back to Units</a>&nbsp;
	</td>
</tr>
</table>

<table border="0" cellspacing="1" width="85%" height="162" align="center" bgcolor="#FFFFFF">
<tr>
				<td align="middle" class="Grid_tHeader" height="15" colspan="3" valign="middle">
				  <table border="0" cellspacing="0" width="100%">
	                <tr>
						<td width="50%">&nbsp;<%=dispMsg%></td>
			            <td width="50%" align="right"><font color="#000000">Fields marked with <font color="red">*</font> are mandatory</font></td>
					</tr>
					</table>
				</td>
	</tr>
<tr>
	<td width="412" height="22" class="gridhdrNew1" >
		&nbsp;Course Name	</td>
    <td width="440" height="22" class="gridhdrNew1">
		<input type="text" name="T1" size="30" style="width:300px;" value="<%=courseName%>" readonly>
	</td>
</tr>
<tr>
	<td width="412" height="22" class="gridhdrNew1" >
		&nbsp;Unit Name<font color="red">*</font>	</td>
    <td width="440" height="22" class="gridhdrNew1" >
		<input type="text" name="unitname" value="<%=unitName%>" style="width:300px;" size="30">
	</td>
</tr>
<tr>
	<td width="412" height="22" class="gridhdrNew1" >
		&nbsp;No. of Lessons<font color="red">*</font>	</td>
    <td width="440" height="22" class="gridhdrNew1">
		<input type="text" name="no_of_lessons" style="width:300px;" value="<%=noOfLessons%>" size="5" onBlur="show_key(this);return false;">
	</td>
</tr>
<tr>
	<td width="412" height="22" class="gridhdrNew1" >
		&nbsp;Insert Unit	</td>
    <td width="440" height="22" class="gridhdrNew1">
	  <select size="1" name="insert_at" style="width:300px;">
			<option selected value="end">at the end</option>
			<option value="after1">after the unit 1</option>
		</select>
	</td>
</tr>

<tr>
	<td height="19" colspan="2" class="gridhdrNew1" align="center" >
		<input type="submit" value="SUBMIT" class="button" name="B1"> 
		<input type="reset" value="RESET" class="button" name="B2">
	</td>
</tr>
</table>

</form>
</body>
</html>
