<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	String schoolId="",teacherId="";

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

		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("SELECT * from class_grades where schoolid='"+schoolId+"' order by minimum desc");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Grading Schema Page</title>
<style>A:hover {
	COLOR: red
}
A {
	TEXT-DECORATION: none
}</style>
</head>

<body>

<div align="center"><BR>
<table border="0" bordercolor="#111111" width="70%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">
		<b><font face="Verdana" size="2" color="#FFFFFF">Grading Schema</font></b>
	</td>
    <td width="50%" height="24" align="right">
	<a href="javascript:window.print()"><img border="0" src="images/print.jpg" width="20" height="15" BORDER="0" ALT="Print"></a>&nbsp;&nbsp;
		
		<a href="index.jsp?userid=<%=teacherId%>"><IMG SRC="images/back.jpg" WIDTH="20" HEIGHT="15" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
</div>
<br>
<div align="center">
<table border="1" cellpadding="2" width="70%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED">
<tr>
	<td width="50%" bgcolor="#96C8ED" align="center">
		<b><font face="Verdana" size="2">Grade Code</font></b>
	</td>
	<td width="50%" bgcolor="#96C8ED" align="center">
		<b><font face="Verdana" size="2">Minimum Percentage</font></b>
	</td>
</tr>
<%
		int i=0;
		while(rs.next())
		{
			i=i+1;
%>
			<tr>
				<td width="50%">
					<font face="Verdana" size="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs.getString("grade_code")%></b></font>&nbsp;</td>
				<td width="50%" align="center">
					<font face="Verdana" size="2"><%=rs.getString("minimum")%></font> &nbsp;</td>
			</tr>
<%
		}	
		if(i==0)
		{
%>
			<tr>
				<td width="100%" colspan="2">
					<font face="Verdana" size="2">No grading schema available.</font>
				</td>
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
		try
		{
			if(st!=null)
				st.close();
		
			if(con!=null && !con.isClosed())
				con.close();
			
		
		}catch(SQLException se){
			ExceptionsFile.postException("CoursesList.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
%>
</body>
</html>