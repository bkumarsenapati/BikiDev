<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	String schoolId="",classId="",courseId="",studentId="",workId="",masterTable="",assignmentName="";		
	int sCount=0;
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		schoolId = (String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		workId=request.getParameter("workid");
		studentId=request.getParameter("studentid");
		assignmentName=request.getParameter("asgnname");
		masterTable=schoolId+"_"+classId+"_"+courseId+"_dropbox";
				
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		
		int i=st.executeUpdate("delete from "+masterTable+" where work_id='"+workId+"' and student_id='"+studentId+"'");

		int j=st1.executeUpdate("delete from "+schoolId+"_cescores where work_id='"+workId+"' and user_id='"+studentId+"'");

		if(i > 0 && j > 0)
			response.sendRedirect("ShowStudentsList.jsp?wid="+workId+"&asgnname="+assignmentName);
	}
	catch(SQLException se)
	{
		System.out.println("The exception in ListAssignments.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ListAssignments.jsp is....."+e);
	}	
%>
