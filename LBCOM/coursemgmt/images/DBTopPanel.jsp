
<!--  Displays and provides link for the  contents of the Courseware Manager -->

<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="",courseName="",className="";
%>
<%
	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	classId=(String)session.getAttribute("classid");
	courseName=(String)session.getAttribute("coursename");
	className=(String)session.getAttribute("classname");
%>


<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0"><meta name="author" content="Think-And-Learn.com">
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">




    <table border="0" width="100%" cellspacing="1">
      <tr>
        <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><b><font face="Arial" size="2"><a href="#" onClick="go('courses');return false;"><font color="#ed1f24">Courses</font></a>
          &gt;&gt;<font face="Arial" size="2" color="#3994f1">
          <%= courseName%> </font>&gt;&gt; <%= className %></font></b></td>
      </tr>
    </table>




<TABLE width="978"   border="0" cellpadding="0" cellspacing="2" >
<TBODY>
<TR>
<TD width="173" height="23" align="center" valign="top">
   <a href="#" onClick="go('CO'); return false;"><img src="../images/Courseoutline_A.gif" width="173" height="23" border="0"></a></TD>

<TD width="239" height="23" align="center" valign="top">
    <a href="#" onClick="go('CM'); return false;"><img src="../images/Courseoutline_B.gif" width="180" height="23" border="0"></a></TD>

<TD width="261" height="23" align="center" valign="top"><a href="#" onClick="go('AS');return false;"><img src="../images/Courseoutline_C.gif" width="180" height="23" border="0"></a></TD>

<TD width="295" height="23" align="center" valign="top">
    <img src="../images/Courseoutline_D.gif" width="180" height="23" border="0"><a href="#" onclick="go('EX');return false;"><a></TD>
</TBODY></TABLE>
</body>

<SCRIPT LANGUAGE="JavaScript">
<!--
var classId='<%= classId %>';
var courseName='<%= courseName %>';

function go(tag)
{
	if(tag=="courses")		//if the user wants to go the courses list
	{
		window.parent.location.href="CoursesList.jsp";
	}
	else if ((tag=="CO")||(tag=="CM"))	//if the user chooses any one of the CO/CM/RB/MI
	{ 
		parent.main.location.href="DropBoxItemCourse.jsp?type="+tag;
	}
	else if (tag=="EX") 
	{
		parent.main.location.href="../../exam/ExamItem.jsp?examtype=all";
	}
	else if(tag=="AS")	//if the user chooses any one of the PW/AS/HW
	{
		parent.main.location.href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=";
	}	
	return true;
}
//-->
</SCRIPT>

</html>
