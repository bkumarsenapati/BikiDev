
<!--  Displays and provides link for the  contents of the Courseware Manager -->

<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String classId="",courseName="",className="",test="";
%>
<%
	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	//WaightBox.jsp?coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+classname;
%>
<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0"><meta name="author" content="Think-And-Learn.com">
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<table align="center" border="0" cellpadding="1" cellspacing="1" width="100%" >
<tr>
<td width="750">
<TABLE   border="0" cellspacing="2" cellpadding="0" >
<TBODY>
<TR>
<TD height="23" align="center" valign="middle">
<SELECT NAME="" onchange="go(this.value); return false;">
<option value='no'>select</option>
<option value='CO'>Course outline</option>
<option value='CM'>Course material</option>
<option value='AS'>Assignments</option>
<option value='EX'>Assessments</option>
</SELECT>
</TD>
</TBODY></TABLE></td>
    </tr>
</table>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function go(tag){
		if(tag=="no")									//if the user wants to go the courses list
			parent.main.location.href="about:blank";
		else { //if the user chooses any one of the CO/CM/RB/MI
			parent.main.location.href="AllCategoriesList.jsp?type="+tag+"";
		}
		return true;
	}
//-->
</SCRIPT>
</html>