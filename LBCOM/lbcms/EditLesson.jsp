<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",dispMsg="",lessonName="",lessonId="",developerId="";
	
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	developerId=request.getParameter("userid");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");

	dispMsg=request.getParameter("dispmsg");
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}

	if(dispMsg==null)
		dispMsg="";

	if(dispMsg.equals("alreadyexists"))
	{
		dispMsg="<FONT COLOR='white' face='verdana' size='1'>A lesson with this name already exists in this unit! Please choose another one.</FONT>";
		lessonName=request.getParameter("lessonname");
	}
%>

<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--

function validate()
{
	var win=window.document.editlesson;
	win.lessonname.value=trim(win.lessonname.value);	
	if((win.lessonname.value=="") ||(win.lessonname.value==null))
	{
		alert("Please enter the unit name");
		window.document.lessonname.lessonname.focus();
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
function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}


//-->

</SCRIPT>
	<title>Edit Lessons</title>
	<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
</head>

<body>
<form name="editlesson"action="AddNewLesson.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&mode=edit" method="POST">
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

<tr>
	<td width="100%" height="495" colspan="3" background="images/bg2.gif" align="center" valign="top">&nbsp;
	<div align="center"> 
		<table width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr class="gridhdrNew">
			<td width="13" height="30" valign="middle" align="left">&nbsp;</td>
			<td width="394" height="30" valign="middle" align="left"><b>Edit Lesson</b></td>
			<td width="394" height="30" valign="middle" align="right">
				<b><a href="CourseUnitLessons.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>">&lt;&lt; Back To Lessons&nbsp;</a></b>&nbsp;
			</td>
		</tr>
        </table>
        <table width="90%" border="0" cellpadding="0" cellspacing="0" class="boarder">
        <tr>
			<th height="86" align="center" valign="top" scope="col">
            <table width="100%" cellspacing="1" cellpadding="3"  border="0">
            <tbody>
            <tr>
				<td width="794" align="middle" class="gridhdrNew1" height="28" colspan="3" valign="middle">
					<table border="0" cellspacing="0" width="100%">
	                <tr>
						<td width="50%">&nbsp;<%=dispMsg%></td>
			            <td width="50%" align="right"><font color="#000000">Fields marked with * are mandatory</font></td>
					</tr>
					</table>
				</td>
			</tr>
            <tr>
				<td align="left" class="gridhdrNew1" width="256" height="22" >
					Course Name <font color="red">*</font>
				</td>
                <td align="middle" class="gridhdrNew1" width="16" height="22" ><p>:</p></td>
				<td align="left" class="gridhdrNew1" width="508" valign="middle" height="22">
					<INPUT class="TextField" tabIndex=5 maxLength="50" name="coursename" style="width:400px;"  value="<%=courseName%>" readonly size="20">
				</td>
			</tr>
            <tr>
				<td align="left" class="gridhdrNew1" width="256" height="22">
					Unit Name <font color="red">*</font>
				</td>
                <td align="middle" class="gridhdrNew1" width="16" height="22"><p>:</p></td>
				<td align="left" class="gridhdrNew1" width="508" height="22" valign="middle">
					<INPUT class="TextField" value="<%=unitName%>" style="width:400px;" readonly size="20">
				</td>
			</tr>
            <tr>
				<td align="left" class="gridhdrNew1" width="256" height="22" >
					Lesson Name <font color="red">*</font>
				</td>
                <td align="middle" class="gridhdrNew1" width="16" height="22" ><p>:</p></td>
                <td align="left" class="tr-subrow" width="508" valign="middle" height="22">
					<INPUT class="TextField" tabIndex="5" name="lessonname" style="width:400px;" value="<%=lessonName%>" size="20">
                    <br/>
                   <input type="checkbox" name="chklst" value="on">Save as a Checklist</td>
			</tr>
            <tr>
				<td align="middle" class="gridhdrNew1" width="794" colspan="3" height="35">
					<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" height="28">
                    <tr>
						<td width="794" align="center" valign="middle">
							<INPUT class="button" tabIndex="19"  type="submit" value="Save"> 
							<INPUT class="button" tabIndex="21" type="reset" value="Clear">
						</td>
					</tr>
                    </table>
				</td>
			</tr>
            </tbody>
            </table>
            </th>
            </tr>
            </table>
		</div>
        </td>
    </tr>
</table>
</body>
</html>