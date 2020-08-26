<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
    String teacherId=request.getParameter("userid");
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	String schoolId="";

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
	
		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("SELECT * from marking_admin where schoolid='"+schoolId+"'");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">   
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>MarkingPeriods</title>
<style>A:hover {
	COLOR: red
}
A {
	TEXT-DECORATION: none
}</style>
</head>

<body><BR>
<!-- <p align="right"><a href="#print">
<img border="0" src="images/print.jpg" width="52" height="51"></a></p> -->
<div align="center">
<table border="0" bordercolor="#111111" width="90%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">
		<b><font face="Arial" size="2" color="#FFFFFF">Marking Periods</font></b>
	</td>
    <td width="50%" height="24" align="right">
		<a href="javascript:window.print()"><img border="0" src="images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a>&nbsp;&nbsp;
		<a href="index.jsp?userid=<%=teacherId%>"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
</div>
<br>
<div align="center">
<table border="1" cellpadding="2" width="90%" bordercolorlight="#96C8ED" bordercolordark="#96C8ED">
<tr>
	<td width="50%" bgcolor="#96C8ED">
		<b>
		<font face="Arial" size="2">&nbsp;&nbsp;Marking Period</font> </b>
	</td>
	<td width="25%" bgcolor="#96C8ED" align="center">
		<p align="center"><b>
		<font face="Arial" size="2">Start Date</font> </b>
	</td>
	<td width="25%" bgcolor="#96C8ED" align="center">
		<p align="center"><b>
		<font face="Arial" size="2">End Date</font> </b>
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
					<font face="Arial" size="2">&nbsp;&nbsp;<%=rs.getString("m_name")%></font> &nbsp;</td>
				<td width="25%" align="center">
					<font face="Arial" size="2"><%=rs.getString("s_date")%></font> &nbsp;</td>
				<td width="25%" align="center">
					<font face="Arial" size="2"><%=rs.getString("e_date")%></font> &nbsp;</td>
			</tr>
<%
		}	
		if(i==0)
		{
%>
			<tr>
				<td width="100%" colspan="3">
					<font face="Arial" size="2">There are no Marking Periods.</font>
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
		ExceptionsFile.postException("MarkingPeriods.jsp","operations on database","SQLException",se.getMessage());
		System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("MarkingPeriods.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	}

	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("MarkingPeriods.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
%>
</body>
</html>