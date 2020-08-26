<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	PreparedStatement ps=null;
    
	String courseId="",type="",classId="",schoolId="",widStr="",workIdsStr="",id="",teacherId="",wId="",startDate="",dueDate="",clusterName="";

	int widLen=0;

	Hashtable workIds=null;
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		con=con1.getConnection();
			
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		teacherId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");

		widStr=request.getParameter("workids");
		startDate=request.getParameter("fromdate");
		dueDate=request.getParameter("lastdate");
		clusterName=request.getParameter("clustername");
				
		workIds=new Hashtable();
		
		StringTokenizer widTokens=new StringTokenizer(widStr,",");
		
		while(widTokens.hasMoreTokens())
		{
			id=widTokens.nextToken();
			workIds.put(id,id);
		}
		
		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			wId=(String)e1.nextElement();
			workIdsStr=workIdsStr+"#"+wId;
		}

				
		st=con.createStatement();

		int i=st.executeUpdate("insert into assignment_clusters(school_id,teacher_id,course_id,cluster_name,work_ids,start_date,due_date,status) values('"+schoolId+"','"+teacherId+"','"+courseId+"','"+clusterName+"','"+workIdsStr+"','"+startDate+"','"+dueDate+"','1')");

		if(i == 1)
		{
			response.sendRedirect("AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=");			
		}
		else
		{
			out.println("Failed");
		}
	}
	catch(SQLException se)
	{
		System.out.println("The exception in SaveCluster.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in SaveCluster.jsp is....."+e);
	}	
%>
<html>
<head>
</head>
<body>
<p>&nbsp;</p>
<p>&nbsp;</p>
<center>
<table border="1" cellspacing="1" width="500">
    <tr>
      <td width="50%">1&nbsp;</td>
      <td width="50%">2&nbsp;</td>
    </tr>
    <tr>
      <td width="50%">3&nbsp;</td>
      <td width="50%">4&nbsp;</td>
    </tr>
</table>
<br>
</center>
</body>
</html>


