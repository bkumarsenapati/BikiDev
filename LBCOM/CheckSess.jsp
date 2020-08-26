<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>
<html>
<head>

<title>Student Boards</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<SCRIPT LANGUAGE="JavaScript">
function popup(url){
	window.open(url,"Document","width=800,height=400,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
	//window.refresh();
}
</SCRIPT>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="0">


<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int i=0,j=0;
	String userId="",schoolId="",emailId="",webinarId="";

%>
<%	
	
	try
	{
		
		//userId=(String)session.getAttribute("emailid");
		//schoolId=(String)session.getAttribute("schoolid");
		//emailId=userId+"@"+schoolId;
		schoolId=request.getParameter("facilityid");
		emailId=request.getParameter("userid");
		webinarId=request.getParameter("wid");
		//System.out.println("CESS...schoolId..."+schoolId+"emailId...."+emailId+"webinarId..."+webinarId);



		
%>


<form name= "wh" method="post" action="/LBCOM/CheckSession.jsp">

<table border="0">
<tr>
<td>
    
	<input type="hidden" name="facilityid" value="<%=schoolId%>">
	<input type="hidden" name="userid" value="<%=emailId%>">
	<input type="hidden" name="wid" value="<%=webinarId%>">

</td>
</tr>
</table>
 <script>
	 document.wh.submit(0);
 </script>
		
<%
	}
	catch(Exception e)
	{
		System.out.println("Exception in StudentBoardsDB.jsp is..."+e.getMessage());
		ExceptionsFile.postException("StudentBoardsDB.jsp","displaying","Exception",e.getMessage());
	}
	finally
	{
		try
		{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("StudentBoardsDB.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}
		
	}
	
	
%>
</form>
</body>
</html>