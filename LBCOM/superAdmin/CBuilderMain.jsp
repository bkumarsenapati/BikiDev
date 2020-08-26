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
	//alert(school);
	//var utype=win.utype.value;
	var utype="teacher";
	var ctype=win.ctype.value;
	if(!ctype=="")
	{
		parent.sec.location.href="BuilderListUsers.jsp?school="+school+"&schoolid="+school+"&utype="+utype+"&ctype="+ctype+"&totalrecords=&start=0";
	}
	else
	{
		alert("Please a course!");
		return false;
	}
}

function createCB()
{
	parent.sec.location.href="UpdateUser.jsp";
}

</script>
</head>
<body topmargin=4 leftmargin=4>
<form name="ListingForm">
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

		
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="38">
	<!-- <tr>
		<td width="50%" height="19" valign="bottom"><b>
			<font face="Verdana" size="2" color="#008080">Create a new account in the Course Builder<IMG SRC="images/arrow.gif" width="40" height="15" border="0">
			<input type="button" value="Manage Users" name="search" onclick="createCB()" style="width: 100; height: 20">
			</font></b>
	</td>
		<td width="50%" height="19"> <b>
		
		</td>	</tr> -->
<!-- 	<tr>
		
		<td width="100%" colspan="2" height="19"><b>
			<font face="Verdana" size="2" color="#008080">Teachers from any or all schools.</font></b>
		</td>

	</tr> -->
</table>
<BR>

<table border='0' width='100%' cellspacing='0'>
	<tr bgcolor='#EFEFF7'>
		<td align=right bgcolor="#E8CFBF">
        <p align="left"><b>
		<!-- <font face="Verdana" size="2"> &nbsp; List all&nbsp;&nbsp;</font>
		
		<select id='utype' name='utype' readonly>
			<option value='allusers' selected>all users</option>  
			<option value='teacher' selected>Teachers</option>
			<option value='teacher'>Teachers</option>
			<option value='student'>Students</option> 
		</select> -->
		<font face="Verdana" size="2"> &nbsp;Available Courses &nbsp;&nbsp;</font>
		
		<select id='ctype' name='ctype' readonly>
		<option id='ctype' name='ctype' value="" selected>Select Course</option>
<%
		
		rs9=st9.executeQuery("select course_id,course_name from lbcms_dev_course_master order by course_name");
		while (rs9.next())
		{
%>
		<option value='<%=rs9.getString("course_id")%>'><%=rs9.getString("course_name")%></option>
<%
		}
		rs9.close();
		st9.close();
%>
		</select>
		<font face="Verdana" size="2">&nbsp;&nbsp;from&nbsp;&nbsp;</font>
		
		<select id="school" name="school">
			<option value="all" selected>All Schools</option>
<%		
		rs=st.executeQuery("select schoolid from school_profile");
		while (rs.next())
		{
%>
			<option value='<%=rs.getString("schoolid")%>'><%=rs.getString("schoolid")%></option>
<%
		}
		rs.close();
		st.close();
%>
		</select>.&nbsp;&nbsp;&nbsp;
		
		<input type="button" value="GO" name="search" onclick="startListing();"></p>
       
        </td>

<tr bgcolor='#EFEFF7' bordercolor='#EFEFF7'>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CBuilderMain.jsp","operations on database","Exception",e.getMessage());
    }
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st9!=null)
				st9.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CBuilderMain.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

</form>
</body>
</html>