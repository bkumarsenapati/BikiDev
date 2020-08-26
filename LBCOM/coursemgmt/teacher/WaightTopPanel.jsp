
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
	//WaightBox.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
	classId=request.getParameter("classid");
	String courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	className=request.getParameter("classname");
	String mode=request.getParameter("mode");
%>


<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0"><meta name="author" content="Think-And-Learn.com">
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">




    <table border="0" width="100%" cellspacing="1">
      <tr>
        <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><b><font face="Arial" size="2"><font color="#800080">Courses</font>
          &gt;&gt;<font face="Arial" size="2" color="#800080">
          <%= courseName%> </font>&gt;&gt;Item Categories </font></b></td>

		  <!-- <td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><b><font face="Arial" size="2"><a href="#" onclick="go('courses');return false;"><font color="#800080">Courses</font></a>
          &gt;&gt;<font face="Arial" size="2" color="#800080">
          <%= courseName%> </font>&gt;&gt;Item Categories </font></b></td> -->
      </tr>
    </table>


<table align="center" border="0" cellpadding="1" cellspacing="1" width="100%" >
<tr>
<td width="750">

<TABLE   border="0" cellspacing="2" cellpadding="0" >
<TBODY>
<TR>
<TD height="23" align="center" valign="middle">
<SELECT NAME="" onchange="go(this.value); return false;">
<option value='no'>select</option>
<option value='CO'>Course Info</option>
<option value='CM'>Course material</option>
<option value='AS'>Assignments</option>
<option value='EX'>Assessments</option>
</SELECT>
<!-- 
   <a href="#" onclick="go('CO'); return false;"><img src="../images/Courseoutline_B.gif" width="118" height="23" border="0"></a>
</TD>

<TD height="23" align="center" valign="top">
    <a href="#" onclick="go('CM'); return false;"><img src="../images/Coursematerial_B.gif" width="118" height="23" border="0"></a></TD>

<TD height="23" align="center" valign="middle">                        
    <a href="#" onclick="go('AS');return false;"><img src="../images/Assignments_B.gif" width="118" height="23" border="0"></a>
</TD>

<TD height="23" align="center" valign="top">
    <a href="#" onclick="go('EX');return false;"><img src="../images/Testsexams_B.gif" width="118" height="23" border="0"><a> -->
</TD>


</TBODY></TABLE></td>
    </tr>
</table>
<INPUT TYPE="hidden" name=mode id=mode value="<%=mode%>">
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	var classId='<%= classId %>';
	var courseName='<%= courseName %>';
	function go(tag){
		if(tag=="courses")									//if the user wants to go the courses list
			window.parent.location.href="CoursesList.jsp";
		if(tag=="no")									//if the user wants to go the courses list
			parent.main.location.href="about:blank";
		else { //if the user chooses any one of the CO/CM/RB/MI
			parent.main.location.href="AllCategoriesList.jsp?coursename=<%=courseName%>&classid=<%=classId%>&courseid=<%=courseId%>&classname=<%=className%>&schema=Main&type="+tag+"";
		}
		return true;
	}
//-->
</SCRIPT>
</html>