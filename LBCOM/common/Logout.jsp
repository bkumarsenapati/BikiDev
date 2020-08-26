<%@ page language="java" import="java.io.*,java.sql.*,java.util.*,javax.servlet.http.*, javax.servlet.*,java.lang.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head>
<title></title>
</head> 
<body bgcolor='ffffff'>
<%!
	Connection con=null;
	Statement st=null;
	int i=0;
%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0); 
%>
<%
	String baseURL="/LBCOM/SignOut.jsp";
	String userType=null;
	String teacherId=(String)session.getAttribute("emailid");
	String schoolId=(String)session.getAttribute("schoolid");
	String sessionId=(String)session.getAttribute("sessid");
	if(sessionId==null)
	{
		  out.println("<html><script> top.location.href='/LBCOM/'; \n </script></html>");
	 	  return;
	}
        userType = (String)session.getAttribute("logintype");
		System.out.println("teacherId..."+teacherId+"...schoolId..."+schoolId+"....sessionId..."+sessionId);
	try
	{	
		if(userType.equals("teacher"))
		{
			con = con1.getConnection();
			st = con.createStatement();
			i = st.executeUpdate("update usage_teach_detail set end_time=curtime() where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and session_id='"+sessionId+"'");

		}
		session.invalidate();
		

		if(request.getParameter("redirect")==null){
			if(userType.equals("admin"))
//				response.sendRedirect("/LBCOM/schoolAdmin/logout.html");
				response.sendRedirect(baseURL);
			if(userType.equals("teacher"))
				response.sendRedirect(baseURL);
			if(userType.equals("student"))
				response.sendRedirect(baseURL);		
		}else{
			response.sendRedirect("../");
	          }

	}
	catch(SQLException se)
	{
	      ExceptionsFile.postException("Logout.jsp","Operations on database","SQLException",se.getMessage());		
		  System.out.println("TeacherLogout.jsp"+se);
	}
	finally
	{
	try
	{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
		
	}catch(Exception e)
	{
		ExceptionsFile.postException("Teacher Logout.jsp","Closing the connection objects ","Exception",e.getMessage());
		out.println(e.getMessage());               
	}
}

%>
</body></html>
