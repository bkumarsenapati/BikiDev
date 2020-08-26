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
	String groupName="",ignoredList="",assignedList="",studentTable="",masterTable="",workIdsStr="",categoryId="";

	int widLen=0,sidLen=0,ignoredCount=0,assignedCount=0;
	boolean statusFlag=false;
	Hashtable workIds=null,studentIds=null,catIds=null;
	int k=0;
	float totalPoints=0.0f;
	
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
		sidStr=request.getParameter("studentids");
		startDate=request.getParameter("fromdate");
		dueDate=request.getParameter("lastdate");
		groupName=request.getParameter("groupname");
			
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
		st6=con.createStatement();
		rs=st6.executeQuery("select work_id,category_id from "+masterTable+"");
		while(rs.next())
		{
			catIds.put(rs.getString(1),rs.getString(2));
		}

//work_id,student_id,start_date,end_date,status
//work_id,category_id,doc_name,topic,subtopic,teacher_id,created_date,from_date,modified_date,work_file,max_attempts,marks_total,to_date,mark_scheme,comments,status
		
//lbeyond_c000_c0002_dropbox
//work_id
//student_id
//  status int(1)  (0-Assigned; 1- Exam Paper Seen; 2- Submitted; 3-     ;  4- Evaluated;)

		st=con.createStatement();
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
		
		if(!groupName.equals(""))
		{
			int i=st.executeUpdate("insert into assignment_clusters(school_id,teacher_id,course_id,cluster_name,work_ids,status) values ('"+schoolId+"','"+teacherId+"','"+courseId+"','"+groupName+"','"+workIdsStr+"','1')");
		}
	}
	catch(SQLException se)
	{
		System.out.println("The exception1 in AssignManyToMany.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in AssignManyToMany.jsp is....."+e);
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
			ExceptionsFile.postException("SubmitAssignment.jsp","closing the statement objects","SQLException",se.getMessage());
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
<br>

<table border="1" cellspacing="0" width="500" align="center">
    <tr>
      <td width="64%" height="23" colspan="2" bgcolor="#C0C0C0"><b>
      <font face="Verdana" size="2" color="#003399">&nbsp;Assignments Distribution Summary</font></b></td>
    </tr>
    <tr>
      <td width="28%">&nbsp;</td>
      <td width="36%">&nbsp;</td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Assignments :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=widLen%> </font>
		<font face="Verdana" size="1" color="#800000">
		<a href="#" onclick="listAssignments(); return false;">(LIST)</a></font>
	  </td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Students :</font></td>
      <td width="36%">
      	<font face="Verdana" size="2" color="#800000">&nbsp;<%=sidLen%></font>
      	<font face="Verdana" size="1" color="#800000">
		<a href="#" onclick="listStudents(); return false;">(LIST)</a></font>
      </td>
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
    <tr>
      <td width="28%" align="right">
		<font face="Verdana" size="2" color="black">Assignments are saved to :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=groupName%>&nbsp;</font></td>
    </tr>
    <tr>
      <td width="100%" colspan="2">&nbsp;</td>
    </tr>
    <tr>
      <td width="64%" colspan="2" align="center" rowspan="2" height="34">
      	<font face="Verdana" size="2">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">BACK TO ASSIGNMENTS DISTRIBUTOR</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>


