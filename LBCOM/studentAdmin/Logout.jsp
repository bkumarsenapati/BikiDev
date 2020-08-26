<%@ page language="java" import="java.io.*,java.sql.*,java.util.*,javax.servlet.http.*, javax.servlet.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head>
<title></title>
</head> 
<body bgcolor='ffffff'>
<%
	Connection con=null;
	Statement st=null;
%>
<%
session=request.getSession(true);
response.setContentType("text/html");
String sessionId=(String)session.getAttribute("sessid");
if(sessionId==null){
	out.println("<html><script> top.location.href='/LBCOM/'; \n </script></html>");
	return;
}
String userId=(String) session.getAttribute("emailid");
String schoolId=(String)session.getAttribute("schoolid");
String appPath=application.getInitParameter("app_path");
try
{
	con = con1.getConnection();
	st = con.createStatement();
	String queryOne = "delete from session_details where session_id='"+sessionId+"'";
	st.executeUpdate(queryOne);
	st.executeUpdate("delete from netmeetinfo where userid='"+userId+"' and schoolid='"+schoolId+"' and type='student'");
	File sessDir=new File(appPath+"/sessids/"+sessionId+"_"+userId);
	if(sessDir.isDirectory()){
			String sessFiles[]=sessDir.list();

			for (int i=0;i<sessFiles.length;i++) {
					File sessFile=new File (appPath+"/sessids/"+sessionId+"_"+userId+"/"+sessFiles[i]);
					sessFile.delete();
		   }
		   sessDir.delete();
	}else{
		
	}

	session.invalidate();
//	response.sendRedirect("logout.html");
}
catch(Exception e)
{
	ExceptionsFile.postException("Logout.jsp","Invalidating the session","Exception",e.getMessage());
   	out.println(e);               
}
finally{
	try{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
		//response.sendRedirect("logout.html");
		if(request.getParameter("redirect")==null){
			response.sendRedirect("logout.html");
		}else{
			response.sendRedirect("../");
		}
	}catch(Exception e)
	{
		ExceptionsFile.postException("student Logout.jsp","Closing the connection objects ","Exception",e.getMessage());
		out.println(e.getMessage());               
	}
}

%>
</body></html>
