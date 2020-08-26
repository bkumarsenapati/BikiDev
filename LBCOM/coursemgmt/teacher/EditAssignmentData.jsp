<%@page import = "java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String topic="",subtopic="",marksTotal="",maxAttempts="";
	String  workId="",categoryId="",docName="",teacherId="",createdDate="",modifiedDate="",sectionId="", fromDate=""; 
	String deadLine="",cat="",courseId="",topicId="",subtopicId="",schoolId="",classId="",year="",mm="",dd="",sessid="";
	int submit=0,markScheme=0,tdays=0,cdays=0,eval=0;
	char c;
	java.util.Date date=null,toDate=null;
	int i=0;
	
	try
	{
		sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		con=con1.getConnection();
		st=con.createStatement();

		teacherId = (String)session.getAttribute("emailid");
		courseId=(String)session.getAttribute("courseid");
		schoolId = (String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		sectionId=(String)session.getAttribute("classid");
			
		categoryId=request.getParameter("cat");

		docName=request.getParameter("docname");
		topic=request.getParameter("topicid");
		subtopic=request.getParameter("subtopicid");
		marksTotal=request.getParameter("totalmarks");
		maxAttempts=request.getParameter("maxattempts");
		markScheme=Integer.parseInt(request.getParameter("markscheme"));
		workId=request.getParameter("workid");
			
		if(topic==null)
			topic="";
		if(subtopic==null)
			subtopic="";
		
		i=st.executeUpdate("update "+schoolId+"_cescores set total_marks="+marksTotal+" where work_id='"+workId+"' and school_id='"+schoolId+"' and total_marks!="+marksTotal);

		i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set doc_name='"+docName+"',topic='"+topic+"',subtopic='"+subtopic+"',modified_date=curdate(),max_attempts="+maxAttempts+",marks_total="+marksTotal+",mark_scheme="+markScheme+" where work_id='"+workId+"'");
						
		String dbString="update "+schoolId+"_activities set Activity_name='"+docName+"'where activity_id='"+workId+"'" ;
		
		st.executeUpdate(dbString);

		if(i>0)
		{
			response.sendRedirect("AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=");
		}
		else
		{
			out.println("Transaction failed. Internal server error. Please try later.");
			out.close();
		}
	}
	catch(SQLException e)
	{
		System.out.println("The Error: SQL - "+e.getMessage());
	}
	catch(Exception e)
	{
		out.println(e);
		System.out.println("The Error: General - "+e.getMessage());
	}
%>
