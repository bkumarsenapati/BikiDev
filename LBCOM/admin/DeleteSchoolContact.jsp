<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
</head>

<body>
 
<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
  String firstname,schoolname;
  Connection con;Statement st;
   
%>


<%
   firstname=request.getParameter("firstname"); 
   schoolname=request.getParameter("schoolname");
  
  
   try
    {
		con = con1.getConnection();       
    st=con.createStatement();
    String query="delete from schoolregistration where firstname='"+firstname+"' and schoolname='"+schoolname+"'";
	int i=st.executeUpdate(query);
    response.setHeader("Refresh", "2;URL=SchoolContacts.jsp?totrecords=&start=0");
         
   }
catch(Exception e)
{
	ExceptionsFile.postException("DeleteSchoolContact.jsp","Operations on database ","Exception",e.getMessage());
  out.println(e);
}
finally
{
 try{
	 if(con!=null && !con.isClosed())
		 con.close();
 }catch(Exception e){
	 ExceptionsFile.postException("DeleteSchoolContact.jsp","closing connection object","Exception",e.getMessage());
	 System.out.println("Connection close failed");
 }
 
}
%>
</body>
</html>

