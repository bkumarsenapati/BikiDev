<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
	ResultSet rs=null,rs1=null;
	PreparedStatement ps=null,ps1=null;
    
	String courseId="",type="",classId="",schoolId="",widStr="",sidStr="",id="",teacherId="",wId="",sId="",startDate="",dueDate="";
	String ignoredList="",assignedList="",studentTable="",masterTable="",workIdsStr="",categoryId="",lessonStr="",unitStr="";

	int widLen=0,sidLen=0,ignoredCount=0,assignedCount=0;
	boolean statusFlag=false;
	Hashtable workIds=null,studentIds=null,catIds=null;
	int k=0;
	float totalPoints=0.0f;

	String assessStr="";
	
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
		assessStr=request.getParameter("assessids");
		sidStr=request.getParameter("studentids");
		lessonStr=request.getParameter("lessonids");
		
		unitStr=request.getParameter("unitids");
		
		studentTable=schoolId+"_"+classId+"_"+courseId+"_dropbox";
		masterTable=schoolId+"_"+classId+"_"+courseId+"_workdocs";
		workIds=new Hashtable();
		studentIds=new Hashtable();
		catIds=new Hashtable();
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

		widLen = workIds.size();	
		sidLen = studentIds.size();	

		st=con.createStatement();
		
		rs=st.executeQuery("select curdate(),DATE_FORMAT(last_date,'%Y-%m-%d') from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'");

		boolean b=rs.next();
		startDate=rs.getString(1);
		dueDate=rs.getString(2);
		rs.close();
		
		st6=con.createStatement();
		
		rs=st6.executeQuery("select work_id,category_id from "+masterTable+"");
		while(rs.next())
		{
			catIds.put(rs.getString(1),rs.getString(2));
		}

//  status int(1)  (0-Assigned; 1- Exam Paper Seen; 2- Submitted; 3-     ;  4- Evaluated;)

		
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();

		ps=con.prepareStatement("insert into "+studentTable+"(work_id,student_id,start_date,end_date,status) values(?,?,?,?,?)");
		
		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			wId=(String)e1.nextElement();
			workIdsStr=workIdsStr+","+wId;

			for(Enumeration e2 = studentIds.elements() ; e2.hasMoreElements() ;)
			{
				statusFlag=false;
				sId=(String)e2.nextElement();
				
				rs=st.executeQuery("select status from "+studentTable+" where work_id='"+wId+"' and student_id='"+sId+"'");
				if(rs.next())
				{
					statusFlag=true;
					st3.executeUpdate("update "+studentTable+" set start_date= '"+startDate+"',end_date= '"+dueDate+"' where work_id='"+wId+"' and student_id='"+sId+"'");
					// s1-w1,w2,w3;s2-w1,w2,w3;
					ignoredList=ignoredList+sId+","+wId+";";
					ignoredCount++;

					st5.executeUpdate("update "+schoolId+"_cescores set end_date='"+dueDate+"' where work_id='"+wId+"' and user_id='"+sId+"'");
				}
				rs.close();

				if(statusFlag==false)
				{
					ps.setString(1,wId);
					ps.setString(2,sId);
					ps.setString(3,startDate);
					ps.setString(4,dueDate);				
					ps.setString(5,"0");
					ps.executeUpdate();
					assignedList=assignedList+sId+","+wId+";";
					assignedCount++;

					st1.executeUpdate("update "+masterTable+" set status= '1' where work_id='"+wId+"' and status= '0'");
				}
			}
		}
		
		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			wId=(String)e1.nextElement();
			workIdsStr=workIdsStr+","+wId;
			categoryId=(String)catIds.get(wId);
					
			for(Enumeration e2 = studentIds.elements() ; e2.hasMoreElements() ;)
			{
				statusFlag=false;
				sId=(String)e2.nextElement();

				// added by Santhosh due to "Points possible" are getting 0 in the table 'schoolId_cescores'

				rs1=st4.executeQuery("select marks_total from "+masterTable+" where work_id='"+wId+"'");
				if(rs1.next())
				{
					totalPoints=Float.parseFloat(rs1.getString("marks_total"));
					
				}
				
				// upto here

				rs=st2.executeQuery("select status from "+schoolId+"_cescores where school_id='"+schoolId+"' and user_id='"+sId+"' and course_id='"+courseId+"' and work_id='"+wId+"'");

				if(rs.next())
				{
					System.out.println("This entry is there already");
				}
				else
				{
					ps1=con.prepareStatement("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,end_date) values(?,?,?,?,?,?,?,?,?,?)");
					
					ps1.setString(1,schoolId);
					ps1.setString(2,sId);
					ps1.setString(3,courseId);
					ps1.setString(4,categoryId);
					ps1.setString(5,wId);
					ps1.setString(6,"0000-00-00");
					ps1.setString(7,"0.00");
					ps1.setFloat(8,totalPoints);
					ps1.setString(9,"0");
					ps1.setString(10,dueDate);
					ps1.executeUpdate();
					//flag=true;
				}
			}
		}
		
		response.sendRedirect("DistributeAssessments.jsp?asgncount="+widLen+"&assignedcount="+assignedCount+"&ignoredcount="+ignoredCount+"&studentids="+sidStr+"&workids="+assessStr+"&asgnids="+widStr+"&lessonids="+lessonStr+"&unitids="+unitStr+"&startdate="+startDate+"&duedate="+dueDate);

		
	}
	catch(SQLException se)
	{
		System.out.println("The exception123456 in MakeDistribution1.jsp.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in MakeDistribution1.jsp is....."+e);
	}
	finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();                //finally close the statement object
			if(st2!=null)
				st2.close(); 
			if(st3!=null)
				st3.close(); 
			if(st4!=null)
				st4.close(); 
			if(st5!=null)
				st5.close();
			if(st6!=null)
				st6.close();
			if(ps!=null)
				ps.close();
			if(ps1!=null)
				ps1.close(); 
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("MakeDistribution1.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
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

function listAssignedOnes()
{
	window.open("ListAssignedOnes.jsp?assignedstr=<%=assignedList%>","Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
}

function listIgnoredOnes()
{
	window.open("ListIgnoredOnes.jsp?ignoredstr=<%=ignoredList%>","Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
}
</script>
</head>
<body> 
<form name="MD1" method="POST">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="35">
  <tr>
    <td width="25%" bgcolor="#934900" height="25">
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<b>Pretest Distribution Summary</b></font></td>
    <td width="25%" align="center" bgcolor="#934900" height="25">&nbsp;</td>
    <td width="25%" align="right" bgcolor="#934900" height="25">
		<b><font face="Verdana" size="2"><a href="index.jsp">
		<font color="#FFFFFF">Back to Pretest</font></a></font></b>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="75%" align="center" colspan="3" height="16"><hr></td>
  </tr>
</table>
	<table border="1" cellspacing="0" width="500" align="center">
	<tr bgcolor="#934900">
		<td width="100%" colspan="2">&nbsp;<font face="Verdana" size="2" color="white"><b>Assignments</b></font></td>
	</tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Assignments :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=widLen%></font></td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Name of the Student :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=sidStr%></font></td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No of Successful Assignings :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assignedCount%></font>
<%
	if(assignedCount < 0) // once we write the ListAssignedOnes.jsp we will change the condition to > .
	{
%>
      	<font face="Verdana" size="1" color="#800000"><a href="#" onclick="listAssignedOnes(); return false;">&nbsp;(LIST)</a></font>
<%
	}	
%>
		</td>
    </tr>
	<tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No of Altered Assignings :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=ignoredCount%></font>
<%
	if(ignoredCount < 0)	// once we write the ListAssignedOnes.jsp we will change the condition to > .
	{
%>
      	<font face="Verdana" size="1" color="#800000"><a href="igndlist">&nbsp;(LIST)</a></font>
<%
	}
%>
	  </td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Start Date :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=startDate%></font></td>
    </tr>
	<tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Due Date :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=dueDate%></font></td>
    </tr>
</table>
</center>
</form>
</body>
</html>


