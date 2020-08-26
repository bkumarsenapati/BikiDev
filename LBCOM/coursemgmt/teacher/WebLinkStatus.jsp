<%@page import = "java.io.*,java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.*,common.*,utility.Utility" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	
	Connection con=null;
	ResultSet rs=null;
	PreparedStatement ps=null;
	Statement st=null;
    
	String mode="",webTitle="";
	String schoolId="",teacherId="",courseId="";
	String classId="",courseName="",className="";
	String docName="",folderName="",catId="",workId="";
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/coursedeveloper/logout.html'; \n </script></html>");
		return;
	}

	try
	{	 
		
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		folderName=(String)session.getAttribute("foldername");
		docName=(String)session.getAttribute("docname");
		classId=request.getParameter("classid");
		courseName=request.getParameter("courname");	
		className=request.getParameter("classname");
		catId=request.getParameter("cat");
		workId=request.getParameter("workid");
		mode=request.getParameter("mode");
		webTitle=request.getParameter("title");	
						
		con=con1.getConnection();
		st=con.createStatement();
				
			int i=0;
		
		if(mode.equals("yes"))
		{	
			i=st.executeUpdate("update courseweblinks set status=0 where course_id='"+courseId+"' and school_id='"+schoolId+"' and title='"+webTitle+"'");
			
		}
		else if(mode.equals("no"))
		{
			i=st.executeUpdate("update courseweblinks set status=1 where course_id='"+courseId+"' and school_id='"+schoolId+"' and title='"+webTitle+"'");
			
		}
		st.close();
	
		
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in LMSCourse.jsp is....."+e);
	}
	finally
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
				System.out.println("The exception2 in LMSCourse.jsp.jsp is....."+se.getMessage());
			}
		}
%>
	<script>
	window.location.href="WeblinksList.jsp?courname=<%=courseName%>&courseid=<%=courseId%>&foldername=<%=workId%>&docname=<%=docName%>&tag=u&cat=<%=catId%>&workid=<%=workId%>";
			</script>
