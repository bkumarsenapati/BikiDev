<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	String schoolId="",teacherId="",teacherName="";

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		schoolId = (String)session.getAttribute("schoolid");
		teacherId = (String)session.getAttribute("emailid");
		teacherName = (String)session.getAttribute("firstname");
	
		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select * from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and status>0");
%>

<html>

<head>   
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Course List Page</title>
<style>A:hover {
	COLOR: red
}
A {
	TEXT-DECORATION: none
}</style>
</head>

<body>

<div align="center"><BR>
<center>
<table border="0" cellpadding="0" cellspacing="0" width="90%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">&nbsp; <b>
    <font face="Arial" size="2" color="#FFFFFF">List of Courses</font></b></td>
    <td width="50%" height="24" align="right"><a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a>&nbsp;&nbsp;
	<a href="index.jsp?userid=<%=teacherId%>"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="1" cellpadding="2" width="90%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED">
<tr>
	<!-- <td width="2%" bgcolor="#C2E0F5">&nbsp;</td> -->
	<td width="58%" bgcolor="#C2E0F5">
		<font face="Arial" size="2"><b>Course Name</b></font>
	</td>
	<td width="20%" align="center" bgcolor="#C2E0F5">
		<font face="Arial" size="2"><b>Start Date</b></font>
	</td>
	<td width="20%" align="center" bgcolor="#C2E0F5">
		<font face="Arial" size="2"><b>End Date</b</font>
	</td>
</tr>
<%
		while(rs.next())
		{
%>
			<tr>
				<!-- <td width="2%">
					<a href="#print">
						<img border="0" src="images/iedit.gif">
					</a>
				</td> -->
				<td width="58%">
					<font face="Arial" size="2"><%=rs.getString("course_name")%></font> &nbsp;</td>
				<td width="20%" align="center">
					<font face="Arial" size="2"><%=rs.getString("CREATE_date")%></font> &nbsp;</td>
				<td width="20%" align="center">
					<font face="Arial" size="2"><%=rs.getString("last_date")%></font> &nbsp;</td>
			</tr>
<%
		}	
%>
</table>
</center>
</div>
<%
	}	
	catch(SQLException se)
	{
		ExceptionsFile.postException("CoursesList.jsp","operations on database","SQLException",se.getMessage());
		System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("CoursesList.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("CoursesList.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
%>
</body>
</html>