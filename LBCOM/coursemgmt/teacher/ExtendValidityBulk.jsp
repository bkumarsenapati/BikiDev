<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=10;
%>
<%
	Connection con=null;
	Statement st1=null,st2=null,st3=null,st5=null;
	ResultSet rs1=null;
	PreparedStatement ps=null;
    
	String courseId="",type="",classId="",schoolId="",workId="",sidStr="",id="",teacherId="",sId="",startDate="",dueDate="";
	String groupName="",updatedList="",insertedList="",studentTable="",masterTable="",workIdsStr="";

	int widLen=0,sidLen=0,insertedCount=0,updatedCount=0;
	boolean statusFlag=false;
	Hashtable workIds=null,studentIds=null;
	String widStr ="";
	
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
		workIds=new Hashtable();
		sidStr=request.getParameter("studentids");
		dueDate=request.getParameter("lastdate");
			
		studentTable=schoolId+"_"+classId+"_"+courseId+"_dropbox";
		masterTable=schoolId+"_"+classId+"_"+courseId+"_workdocs";
		
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

		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			workId=(String)e1.nextElement();
			for(Enumeration e2 = studentIds.elements() ; e2.hasMoreElements() ;)
			{
				statusFlag=false;
				sId=(String)e2.nextElement();
					
				st1=con.createStatement();
				System.out.println("select status from "+studentTable+" where work_id='"+workId+"' and student_id='"+sId+"'");
				rs1=st1.executeQuery("select status from "+studentTable+" where work_id='"+workId+"' and student_id='"+sId+"'");				
				while(rs1.next())
				{
					
					
					System.out.println("update "+studentTable+" set end_date='"+dueDate+"' where work_id='"+workId+"' and student_id='"+sId+"'");
					st2=con.createStatement();
					int i=st2.executeUpdate("update "+studentTable+" set end_date='"+dueDate+"' where work_id='"+workId+"' and student_id='"+sId+"'");
					statusFlag=true;
					updatedList=updatedList+sId+","+workId+";";
					updatedCount++;

					System.out.println("update "+schoolId+"_cescores set end_date='"+dueDate+"' where work_id='"+workId+"' and user_id='"+sId+"'");
					st5=con.createStatement();
					st5.executeUpdate("update "+schoolId+"_cescores set end_date='"+dueDate+"' where work_id='"+workId+"' and user_id='"+sId+"'");


					//System.out.println("EtendValidity.jsp...: Only Due date has passed");
					st5.close();
					st2.close();
				}
				st1.close();
			
				if(statusFlag==false)
				{
					//System.out.println("EtendValidity.jsp...: This entry is not there!");
					insertedList=insertedList+sId+","+workId+";";
					insertedCount++;
				}
			}
		}
	}
	catch(SQLException se)
	{
		System.out.println("The exception1 in ExtendValidity.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ExtendValidity.jsp is....."+e);
	}	
%>
<html>
<head>

<script>
function listAssignments()
{
	window.open("ListAssignments.jsp?workids=<%=widStr%>&tblname=<%=masterTable%>","Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
}

function listStudents()
{
	window.open("ListStudents.jsp?sidstr=<%=sidStr%>","Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
}
</script>
</head>

<body bgcolor="#EBF3FB"> 

<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor1.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>

<hr>
<BR>
<BR>
<BR>
      <font face="Verdana" size="2" color="black">&nbsp;
	  The due date of the <a href="#" onclick="listAssignments(); return false;"><b><%=sidLen%></b> assignment(s)</a> has been extended to <%=dueDate%> for <a href="#" onclick="listStudents(); return false;"><b><%=sidLen%></b> student(s)</a> successfully.</font>
</body>
</html>


