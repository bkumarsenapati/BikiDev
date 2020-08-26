<%@page import="java.io.*,java.sql.*"%>
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String schoolId="",schoolIds="";
ResultSet  rs=null;
Connection con=null;
Statement st=null;  
boolean flag=false;

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 
<title></title>

<script language="javascript">
function startListing()
{
	var win=window.document.ListingForm;
	var school=win.school.value;
	var utype=win.utype.value;
	parent.sec.location.href="ListUsers.jsp?school="+school+"&utype="+utype+"&totalrecords=&start=0";
}

</script>
</head>
<body topmargin=4 leftmargin=4>
<form name="ListingForm" id="ListingForm" onsubmit="return startListing()">

<%
	//session=request.getSession();
	//flag=false;
	//String s=(String)session.getAttribute("sessid");
	//if(s==null){
	//		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	//		return;
	//}

	try
	{
		con=db.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select schoolid from school_profile");
%>
<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="100%" colspan="2"><b>
			<font face="Verdana" size="2" color="#008080">Here, you can see the list of teachers, students or school admins from any or all schools.</font></b>
		</td>
	</tr>
	<tr>
		<td width="50%">&nbsp;</td>
		<td width="50%">&nbsp;</td>
	</tr>
</table>

<table border='0' width='100%' cellspacing='0'>
	<tr bgcolor='#EFEFF7'>
		<td align=right bgcolor="#E8CFBF">
        <p align="left"><b>
		<font face="Verdana" size="2"> &nbsp; List all&nbsp;&nbsp;</font>
		
		<select id='utype' name='utype'>
			<!-- <option value='allusers' selected>all users</option>  -->
			<option value='admin' selected>School Admins</option>
			<option value='teacher'>Teachers</option>
			<option value='student'>Students</option>
		</select> <font face="Verdana" size="2">&nbsp;&nbsp;from&nbsp;&nbsp;</font>
		
		<select id="school" name="school">
			<option value="all" selected>All Schools</option>
<%		
		while (rs.next())
		{
%>
			<option value='<%=rs.getString("schoolid")%>'><%=rs.getString("schoolid")%></option>
<%
		}
%>
		</select>.&nbsp;&nbsp;&nbsp;
		
		<input type="button" value="GO" name="search" onclick="startListing()"></p>
       
        </td>
		<tr bgcolor='#EFEFF7' bordercolor='#EFEFF7'>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("SearchMain.jsp","operations on database","Exception",e.getMessage());
    }
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("SearchMain.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

</form>
</body>
</html>