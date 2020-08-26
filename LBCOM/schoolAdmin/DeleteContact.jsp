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

<%
  String user="",cemail="",schoolid="",schoolId="";
  Connection con=null;Statement st=null;
   
%>


<%
   session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if (sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
   schoolId=(String)session.getAttribute("schoolid");

   user=request.getParameter("userid");
   schoolid=request.getParameter("schoolid");
   cemail=request.getParameter("cemail");
  
   try
    {
		con = con1.getConnection();       
    st=con.createStatement();
    String query="delete from contacts where userid='"+user+"' and contactemail='"+cemail+"' and school_id='"+schoolId+"'";
    int i=st.executeUpdate(query);
    response.setHeader("Refresh", "2;URL=../schoolAdmin/Contacts.jsp?userid="+user+"&schoolid="+schoolid);
         
   }
catch(Exception e)
{
	ExceptionsFile.postException("DeleteContact.jsp","Operations on database ","Exception",e.getMessage());
  out.println(e);
}
finally
{
 try{
	 if(con!=null)
		 con.close();
 }catch(Exception e){
	 ExceptionsFile.postException("DeleteContact.jsp","closing connection object","Exception",e.getMessage());
	 System.out.println("Connection close failed");
 }
 
}
%>
</body>
</html>

