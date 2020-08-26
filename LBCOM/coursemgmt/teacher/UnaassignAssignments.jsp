<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	String schoolId="",classId="",courseId="",studentId="",workId="",masterTable="",assignmentName="",id="";		
	int sCount=0;
	Hashtable workIds=null,studentIds=null;
	String widStr ="",sId="",sidStr="";
	int i=0,j=0;
		int widLen=0,sidLen=0,insertedCount=0,updatedCount=0;
	
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

		sidStr=request.getParameter("studentids");
		widStr=request.getParameter("workids");
		System.out.println("	Unassign Assignments sidStr..."+sidStr+"...widStr..."+widStr);
		
		workIds=new Hashtable();
		studentIds=new Hashtable();

		StringTokenizer widTokens=new StringTokenizer(widStr,",");
		
		while(widTokens.hasMoreTokens())
		{
			id=widTokens.nextToken();
			workIds.put(id,id);
		}
		
		StringTokenizer sidTokens=new StringTokenizer(sidStr,",");
		while(sidTokens.hasMoreTokens())
		{
			id=sidTokens.nextToken();
			studentIds.put(id,id);
		}

		sidLen = studentIds.size();	
		masterTable=schoolId+"_"+classId+"_"+courseId+"_dropbox";


		con=con1.getConnection();

		
		
		

		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			workId=(String)e1.nextElement();
			for(Enumeration e2 = studentIds.elements() ; e2.hasMoreElements() ;)
			{
				sId=(String)e2.nextElement();

				System.out.println("delete from "+masterTable+" where work_id='"+workId+"' and student_id='"+sId+"'");
				
					st=con.createStatement();
					st1=con.createStatement();
					i=st.executeUpdate("delete from "+masterTable+" where work_id='"+workId+"' and student_id='"+sId+"'");

					j=st1.executeUpdate("delete from "+schoolId+"_cescores where work_id='"+workId+"' and user_id='"+sId+"'");
					st1.close();
					st.close();
				
			}
		}

		if(i > 0 && j > 0)
			response.sendRedirect("AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=");
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
