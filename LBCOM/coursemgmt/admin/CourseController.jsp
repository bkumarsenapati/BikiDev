<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.StringTokenizer" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolId="",createFlag="",editFlag="",distributeFlag="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String crtValue="",editValue="",distValue="";
	String crtText="",editText="",distText="";
%>
<%
	try
	{
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}	
		con=con1.getConnection();
		st=con.createStatement();
		session=request.getSession(true);
		schoolId = (String)session.getAttribute("schoolid");

		rs=st.executeQuery("select course_createflag,course_editflag,course_distributeflag from school_profile where schoolid='"+schoolId+"' and status=1");
		while(rs.next())
		{
			crtValue=rs.getString("course_createflag");
			editValue=rs.getString("course_editflag");
			distValue=rs.getString("course_distributeflag");
		}
		if(crtValue.equals("1"))
			crtText="checked";
		if(editValue.equals("1"))
			editText="checked";
		if(distValue.equals("1"))
			distText="checked";
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("EditCourse.jsp","operations on database","SQLException",se.getMessage());	 
		System.out.println("Error in AdminEditCourse.jsp : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("EditCourse.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error in AdminEditCourse.jsp :  -" + e.getMessage());
	}

	finally     //closes all the database connections at the end
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AdminEditCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Error in AdminEditCourse.jsp :"+se.getMessage());
		}
	}
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Course Controller</title>
<script>
function allowEdition()
{
	if(document.controller.edit.checked==true)
		window.document.controller.edit.value=1;
	else
		window.document.controller.edit.value=0;
}

function allowCreation()
{
	if(document.controller.create.checked==true)
		window.document.controller.create.value=1;
	else
		window.document.controller.create.value=0;
}

function allowDistribution()
{
	if(document.controller.distribute.checked==true)
		window.document.controller.distribute.value=1;
	else
		window.document.controller.distribute.value=0;
}

</script>
</head>

<body>
<form name="controller" method="POST" action="Controller.jsp">
<p align="right">
	<a href='javascript:history.go(-1);'><font face="Arial" size="2"><b>Back</b></font></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<br>
<center>
<table border="0" cellpadding="0" cellspacing="1" width="50%">
	<tr>
	    <td colspan="2" width="100%" height="22" align="left">
		<font face="Arial" size="2" color="#800000"><b>Course Controller</b></font></td>
	</tr>
	<tr>
		<td width="3%" height="21">
			<input type="checkbox" name="create" onclick="allowCreation()" value="1" <%=crtText%>>
		</td>
		<td width="54%" height="21"><font face="Arial" size="2">Allow teachers to create and delete Courses</font></td>
	</tr>
	<tr>
		<td width="3%" height="20">
			<input type="checkbox" name="edit" onclick="allowEdition()" value="1" <%=editText%>></td>
		<td width="54%" height="20"><font face="Arial" size="2">Allow teachers to edit the Courses</font></td>
	</tr>
	<tr>
		<td width="3%" height="20">
			<input type="checkbox" name="distribute" onclick="allowDistribution()" value="1" <%=distText%>></td>
		<td width="54%" height="20"><font face="Arial" size="2">Allow teachers to distribute the courses to students</font></td>
	</tr>
	<tr>
		<td width="3%" height="7">&nbsp;</td>
	    <td width="54%" height="7">&nbsp;</td>
  </tr>
  <tr>
    <td width="3%" height="11"></td>
    <td width="54%" height="11" align="left">
		<input type="submit" value="Submit" name="B1">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="Reset" name="B2">
	</td>
  </tr>
</table>
</center>
<input type="hidden" name="create" value="0">
<input type="hidden" name="edit" value="0">
<input type="hidden" name="distribute" value="0">
</form>
</body>

</html>