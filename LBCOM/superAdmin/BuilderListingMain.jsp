<%@page import="java.io.*,java.sql.*"%>
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String schoolId="",schoolIds="";
ResultSet  rs=null,rs9=null;
Connection con=null;
Statement st=null,st9=null;  
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
	var ctype=win.ctype.value;
	parent.sec.location.href="BuilderListUsers.jsp?school="+school+"&utype="+utype+"&ctype="+ctype+"&totalrecords=&start=0";
}

function createCB()
{
	parent.sec.location.href="createbuilder.jsp";
}

</script>
</head>
<body topmargin=4 leftmargin=4>
<form name="ListingForm" id="ListingForm">
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
		st9=con.createStatement();

		rs=st.executeQuery("select schoolid from school_profile");
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="38">
	<tr>
		<td width="50%" height="19" valign="bottom"><b>
			<font face="Verdana" size="2" color="#008080">Here, you can create a new account in the Course Builder<IMG SRC="images/arrow.gif" width="40" height="15" border="0"></font></b>
	</td>
		<td width="50%" height="19"> <b>
		
		<input type="button" value="CREATE" name="search" onclick="createCB()" style="width: 70; height: 20"></td>	</tr>
	<tr>
		
		<td width="100%" colspan="2" height="19"><b>
			<font face="Verdana" size="2" color="#008080">Here, you can see the list of teachers from any or all schools.</font></b>
		</td>

	</tr>
</table>
<BR>

<table border='0' width='100%' cellspacing='0'>
	<tr bgcolor='#EFEFF7'>
		<td align=right bgcolor="#E8CFBF">
        <p align="left"><b>
		<font face="Verdana" size="2"> &nbsp; List all&nbsp;&nbsp;</font>
		
		<select id='utype' name='utype' readonly>
			<!-- <option value='allusers' selected>all users</option>  -->
			<option value='teacher' selected>Teachers</option>
			<!-- <option value='teacher'>Teachers</option>
			<option value='student'>Students</option> -->
		</select>
		<font face="Verdana" size="2"> &nbsp;Courses List&nbsp;&nbsp;</font>
		
		<select id='ctype' name='ctype' readonly>
		<option id='ctype' name='ctype' selected>Select Course</option>
<%
			rs9=st9.executeQuery("select course_id,course_name from lbmcs_dev_course_master");
		while (rs9.next())
		{
%>
		<option value='<%=rs9.getString("course_id")%>'><%=rs9.getString("course_name")%></option>
<%
		}
%>
		</select>
		<font face="Verdana" size="2">&nbsp;&nbsp;from&nbsp;&nbsp;</font>
		
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