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
	parent.sec.location.href="ClassList.jsp?schoolid="+school;
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

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="100%" colspan="2"><b>
			<font face="Verdana" size="2" color="#008080">Here you will get the class wise reports! Selecting a school will display you all the classes in that particular school.</font></b>
		</td>
	</tr>
	<tr>
		<td width="50%">&nbsp;</td>
	    <td width="50%">&nbsp;</td>
	</tr>
</table>

<table border='0' width='100%' cellspacing='0'>
	<tr bgcolor='#EFEFF7'>
		<td height="20" align="left" bgcolor="#EDD9CB"><b>
			<font face="Verdana" size="2"> &nbsp; Generate Reports for&nbsp;&nbsp;</font>
			<select id="school" name="school">
				<!-- <option value="all" selected>All Schools</option> -->
<%		
		while (rs.next())
		{
%>
				<option value='<%=rs.getString("schoolid")%>'><%=rs.getString("schoolid")%></option>
<%
		}
%>
			</select>.&nbsp;&nbsp;&nbsp;
		
			<input type="button" value="GO" name="search" onclick="startListing()">
		</td>
	</tr>

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
</table>
</form>
</body>
</html>