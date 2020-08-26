<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",dispMsg="",lessonName="",developerId="";
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	developerId=request.getParameter("userid");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
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
<title>Hotschools - Course Builder</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">
<!--

function validate()
{
	var win=window.document.addlesson;
	alert(win.lessonname.value);

	if(trim(win.lessonname.value="") || trim(win.lessonname.value==null))
	{
		alert("Please enter the lesson name");
		window.document.lessonname.focus();
		return false;
	}

}
function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
//-->
</SCRIPT>
</head>

<body >
<form name="addlesson" method="POST" action="AddNewLesson.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&mode=add">
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
			<td width="394" height="30" valign="middle" align="left"><b>Add New Lesson</b></td>
			<td width="394" height="30" valign="middle" align="right">
				<b><a href="CourseUnitLessons.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>">&lt;&lt; Back To Lessons&nbsp;</a></b>&nbsp;
			</td>
		</tr>
        </table>
        <table width="90%" border="0" cellpadding="0" cellspacing="0" class="boarder">
        <tr>
			<th height="86" align="center" valign="top" scope="col">
            <table width="100%" cellspacing="1" cellpadding="3"  border="0" height="151">
            <tbody>
            <tr>
				<td width="794" align="middle" class="Grid_tHeader" height="15" colspan="3" valign="middle">
					<table border="0" cellspacing="0" width="100%">
	                <tr>
						<td width="50%">&nbsp;<%=dispMsg%></td>
			            <td width="50%" align="right"><font color="#000000">Fields marked with * are mandatory</font></td>
					</tr>
					</table>
				</td>
			</tr>
            <tr>
				<td align="left" class="gridhdrNew1 width="256" height="20">
					Course Name <font color="red">*</font>
				</td>
                <td align="middle" class="gridhdrNew1" width="16" height="20" ><p>:</p></td>
				<td align="left" class="gridhdrNew1" width="508" valign="middle" height="20">
					<INPUT class="TextField" style="width:400px;" tabIndex=5 maxLength="50" name="coursename"  value="<%=courseName%>" readonly size="20">
				</td>
			</tr>
            <tr>
				<td align="left" class="gridhdrNew1" width="256" height="20" >
					Unit Name <font color="red">*</font>
				</td>
                <td align="middle" class="gridhdrNew1" width="16" height="20" ><p>:</p></td>
				<td align="left" class="gridhdrNew1" width="508" height="20" valign="middle">
					<INPUT class="TextField" style="width:400px;" value="<%=unitName%>" readonly size="20">
				</td>
			</tr>
            <tr>
				<td align="left" class="gridhdrNew1" width="256" height="20">
					Lesson Name <font color="red">*</font>
				</td>
                <td align="middle" class="gridhdrNew1" width="16" height="20" ><p>:</p></td>
                <td align="left" class="gridhdrNew1" width="508" valign="middle" height="20">
					<INPUT class="TextField" style="width:400px;" tabIndex="5" name="lessonname" value="<%=lessonName%>" size="20">
                   <br/>
                   <input type="checkbox" name="chklst">Save as a Checklist</td>
			</tr>
            <tr>
				<td align="middle" class="gridhdrNew1" width="794" colspan="3" height="28">
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
</form>
</body>
</html>