
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
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" onLoad="go('CM');">




    <table border="0" width="101%" cellspacing="1">
      <tr>
        <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><b><font face="Arial" size="2"><!-- <a href="#" onClick="go('courses');return false;"> --><font color="#0a5a74">Courses</font></a>
          &gt;&gt;<font face="Arial" size="2" color="#3994f1">
          <%= courseName%> </font>&gt;&gt; <%= className %></font></b></td>
      </tr>
    </table>



<TR> </TR>
<TABLE width="889"   border="0" cellpadding="0" cellspacing="2" >
<TBODY>
<TR>
<TD width="189" height="23" align="center" valign="top">
   <a href="#" onClick="go('CO'); return false;"><img id="co" src="../images/Courseoutline_A.gif" width="181" height="23" border="0"></a></TD>

<TD width="220" height="23" align="center" valign="top">
    <a href="#" onClick="go('CM'); return false;"><img id="cm" src="../images/Courseoutline_B.gif" width="181" height="23" border="0"></a></TD>

<TD width="223" height="23" align="center" valign="top"><a href="#" onClick="go('AS');return false;"><img id="assgn" src="../images/Courseoutline_C.gif" width="181" height="23" border="0"></a></TD>

<TD width="247" height="23" align="center" valign="top"><a href="#" onclick="go('EX');return false;">
    <img id="assmt" src="../images/Courseoutline_D.gif" width="181" height="23" border="0"><a></TD>
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
		if(tag=="CO")
		{
			document.getElementById("co").src = "images/Courseoutline_A1.gif";
			document.getElementById("cm").src = "images/Courseoutline_B.gif";
			document.getElementById("assgn").src = "images/Courseoutline_C.gif";
			document.getElementById("assmt").src = "images/Courseoutline_D.gif";
		}
		else if(tag=="CM")
		{
			document.getElementById("cm").src = "images/Courseoutline_B1.gif"; 
			document.getElementById("co").src = "images/Courseoutline_A.gif";
			document.getElementById("assgn").src = "images/Courseoutline_C.gif";
			document.getElementById("assmt").src = "images/Courseoutline_D.gif";
		}
	}
	else if (tag=="EX") 
	{
		parent.main.location.href="../../exam/ExamItem.jsp?examtype=all";
		document.getElementById("assmt").src = "images/Courseoutline_D1.gif";
		document.getElementById("cm").src = "images/Courseoutline_B.gif";
		document.getElementById("co").src = "images/Courseoutline_A.gif";
			document.getElementById("assgn").src = "images/Courseoutline_C.gif";
	}
	else if(tag=="AS")	//if the user chooses any one of the PW/AS/HW
	{
		parent.main.location.href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=";
		document.getElementById("assgn").src = "images/Courseoutline_C1.gif";
		document.getElementById("co").src = "images/Courseoutline_A.gif";
		document.getElementById("cm").src = "images/Courseoutline_B.gif"; 
		document.getElementById("assmt").src = "images/Courseoutline_D.gif";
	}	
	return true;
}
//-->
</SCRIPT>

</html>
