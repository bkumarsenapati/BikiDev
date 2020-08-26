<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.StringTokenizer" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolId="",createFlag="",editFlag="",distributeFlag="";
	Connection con=null;
	Statement st=null;
	int i=0;
%>
<%
	try
	{
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}	
		con=con1.getConnection();
		st=con.createStatement();
		session=request.getSession(true);
		schoolId = (String)session.getAttribute("schoolid");
		
		createFlag=request.getParameter("create");
		editFlag=request.getParameter("edit");
		distributeFlag=request.getParameter("distribute");
		i=st.executeUpdate("update school_profile set course_createflag='"+createFlag+"',course_editflag='"+editFlag+"', course_distributeflag='"+distributeFlag+"' where schoolid='"+schoolId+"' and status=1");

		if(i>0)
		{
			response.sendRedirect("CourseManager.jsp");
		}
		else
		{
			System.out.println("there is an error");
		}
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("EditCourse.jsp","operations on database","SQLException",se.getMessage());	 
		System.out.println("Error in AdminEditCourse.jsp : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("EditCourse.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error in AdminEditCourse.jsp :  -" + e.getMessage());
	}

	finally     //closes all the database connections at the end
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AdminEditCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Error in AdminEditCourse.jsp :"+se.getMessage());
		}
	}
%>
<html>
<head>
<title></title>
</head>
<body>
</body>
</html>