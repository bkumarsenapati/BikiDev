<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@page import = "exam.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
	ResultSet rs=null,rs1=null;
	
    
	String courseId="",type="",classId="",schoolId="",widStr="",sidStr="",id="",teacherId="",wId="",sId="",startDate="",dueDate="";
	String groupName="",ignoredList="",assignedList="",studentTable="",masterTable="",workIdsStr="",categoryId="";

	int widLen=0,sidLen=0,ignoredCount=0,assignedCount=0;
	boolean statusFlag=false;
	Hashtable workIds=null,studentIds=null,catIds=null;
	int k=0,totalPoints=0;
	int maxAttempts=0,grading=0,examStatus=0,verNo=1;
	float examTotal=0.0f; 
	String examInstTbl="";
	boolean flag=false,act=false;
	String quesList="",dbString="",studentId="",examType="",qryStr="";
	Hashtable htSelStuIds=null;	
	String fromTime="00:00:00",toTime="00:00:00",examEndDate="";
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
		session.putValue("htSelStuIds",sidStr);
		//htSelStuIds=sidStr;
		startDate=request.getParameter("fromdate");
		dueDate=request.getParameter("lastdate");
		groupName=request.getParameter("groupname");
		maxAttempts= Integer.parseInt(request.getParameter("multipleattempts"));
		grading= Integer.parseInt(request.getParameter("grading"));
			
		//studentTable=schoolId+"_"+classId+"_"+courseId+"_dropbox";
		masterTable="exam_tbl";
		
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
		rs=st6.executeQuery("select exam_id,exam_type from "+masterTable+"");
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

		
		
		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			wId=(String)e1.nextElement();
			
			//workIdsStr=workIdsStr+","+wId;
			CalTotalMarks calc=new CalTotalMarks();	
			examTotal=calc.calculate(wId,schoolId);
			rs=st.executeQuery("select create_date,to_date,exam_type,status,mul_attempts  from exam_tbl where school_id='"+schoolId+"' and exam_id='"+wId+"'");
			if(rs.next()){
				examInstTbl=schoolId+"_"+wId+"_"+rs.getString("create_date").replace('-','_');
				examType=rs.getString("exam_type");
				examStatus=rs.getInt("status");
				maxAttempts=maxAttempts;
				examEndDate=rs.getString("to_date");
				
			}
		rs.close();
		rs=st.executeQuery("select * from "+schoolId+"_"+wId+"_versions_tbl");
		if(rs.next()){
			quesList=rs.getString("ques_list");
			verNo=rs.getInt("ver_no");
		}	
		rs.close();
		if(examStatus==2)
			examStatus=0;
		
		// -----------------> Assessments assigning
		
		for(Enumeration e2 = studentIds.elements() ; e2.hasMoreElements() ;)
		{
			studentId=(String)e2.nextElement();
			//studentId=(String)htSelStuIds.get(stuIds.nextElement());	
			rs=st.executeQuery("select work_id from "+schoolId+"_cescores where school_id='"+schoolId+"' and work_id='"+wId+"' and user_id='"+studentId+"'");
			if(rs.next())
			{
				flag=true;
			}
			else
			{
				flag=false;
				rs.close();
				qryStr="delete from "+examInstTbl+" where exam_id='"+wId+"' and student_id='"+studentId+"'";
				st1.executeUpdate(qryStr);
				qryStr="delete from "+schoolId+"_"+studentId+" where exam_id='"+wId+"'";
				st1.executeUpdate(qryStr);
				
			}
			if(flag==true){
				qryStr="update "+schoolId+"_cescores set report_status='"+examStatus+"' where school_id='"+schoolId+"' and work_id='"+wId+"' and user_id='"+studentId+"'";
				st1.executeUpdate(qryStr);
				ignoredCount++;
				
			}
			if(flag==false)
			{
									
				qryStr="insert into "+examInstTbl+"(exam_id,student_id,ques_list,count,status,version,password) values('"+wId+"','"+studentId+"','"+quesList+"',0,0,"+verNo+",'');";
				st1.executeUpdate(qryStr);

				qryStr="insert into "+schoolId+"_"+studentId+"(exam_id,exam_status,count,version,exam_password,max_attempts) values('"+wId+"',0,0,"+verNo+",'',"+maxAttempts+");";
				st1.executeUpdate(qryStr);

				st1.executeUpdate("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+schoolId+"','"+studentId+"','"+courseId+"','"+examType+"','"+wId+"','0000-00-00',0,"+examTotal+",0,"+examStatus+")");
				assignedCount++;
				
			}
		}// end of students while
	
	//  Assessments assigning upto here
		

	// ----------------> Make Available start here
	
			for(Enumeration e3 = studentIds.elements() ; e3.hasMoreElements() ;)
			{
				sId=(String)e3.nextElement();
				rs=st.executeQuery("select activity_id from "+schoolId+"_activities where course_id='"+courseId+"' and activity_id='"+wId+"'");				
				if(rs.next())
				{
					act=true;
				}
				else
				{
					act=false;
				}
				rs.close();
				st.clearBatch();
				if(examEndDate==null)
				{
					dbString="update exam_tbl set password=0,from_date='"+startDate+"',to_date='"+dueDate+"',from_time='"+fromTime+"',to_time='"+toTime+"',mul_attempts="+maxAttempts+",grading="+grading+",status=1 where exam_id='"+wId+"' and school_id='"+schoolId+"'";
					
				}
				else
				{
					dbString="update exam_tbl set password=0,to_date='"+dueDate+"',from_time='"+fromTime+"',to_time='"+toTime+"',mul_attempts="+maxAttempts+",grading="+grading+",status=1 where exam_id='"+wId+"' and school_id='"+schoolId+"'";

				}
				st.addBatch(dbString);				
				if(act==false)
				{
					dbString="insert into "+schoolId+"_activities (SELECT exam_id,exam_name,'EX' as exam_type,'QZ' as exam_sub_type,course_id,from_date,to_date FROM exam_tbl where exam_id='"+wId+"' and school_id='"+schoolId+"')";
					st.addBatch(dbString);
				}
				else
				{
					dbString="update "+schoolId+"_activities set t_date='"+dueDate+"' where activity_id='"+wId+"'" ;
					st.addBatch(dbString);				
				}
				// Individual dates start here
					dbString="update "+schoolId+"_"+sId+" set start_date='"+startDate+"',end_date='"+dueDate+"' where exam_id='"+wId+"'";
					st.addBatch(dbString);
				// Upto here
				rs=st.executeQuery("select * from coursewareinfo_det as cd inner join "+examInstTbl+" as eInst on cd.student_id=eInst.student_id where school_id='"+schoolId+"' and course_id='"+courseId+"'");
				while(rs.next())
				{
					
					if(maxAttempts==-1)
						st.addBatch("update "+schoolId+"_"+sId+" set max_attempts="+maxAttempts+" where exam_id='"+wId+"'");
					else
						st.addBatch("update "+schoolId+"_"+sId+" set max_attempts="+maxAttempts+" where exam_id='"+wId+"' and count<="+maxAttempts);					
					
					rs1=st1.executeQuery("select work_id from "+schoolId+"_cescores where school_id='"+schoolId+"' and course_id='"+courseId+"' and work_id='"+wId+"' and user_id='"+sId+"'");				
					if(!rs1.next())
					{
						
						st.addBatch("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status,end_date) values('"+schoolId+"','"+sId+"','"+courseId+"','"+examType+"','"+wId+"','0000-00-00',0,"+examTotal+",0,1,'"+dueDate+"')");
						
						
					}
					else
					{
						dbString="update "+schoolId+"_cescores set end_date='"+dueDate+"' where work_id='"+wId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"' and user_id='"+sId+"'" ;
						st.addBatch(dbString);
						
					}
					rs1.close();
				}
				rs.close();
				dbString="update "+schoolId+"_cescores set report_status=1 where work_id='"+wId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"' and report_status!=2" ;
				st.addBatch(dbString);	
				st.executeBatch();
															
			}
		}
		
	}
	catch(SQLException se)
	{
		System.out.println("The exception1 in DistributeManyToMany.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in DistributeManyToMany.jsp is....."+e);
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
function listAssessments()
{
	window.open("ListAssessments.jsp?workids=<%=widStr%>&tblname=<%=masterTable%>","Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
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
<hr>
<br>

<table border="1" cellspacing="0" width="500" align="center">
    <tr>
      <td width="64%" height="23" colspan="2" bgcolor="#C0C0C0"><b>
      <font face="Verdana" size="2" color="#003399">&nbsp;Assessments Distribution Summary</font></b></td>
    </tr>
    <tr>
      <td width="28%">&nbsp;</td>
      <td width="36%">&nbsp;</td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Assessments :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=widLen%> </font>
		<font face="Verdana" size="1" color="#800000">
		<a href="#" onclick="listAssessments(); return false;">(LIST)</a></font>
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
		<font face="Verdana" size="2" color="black">Assessments are saved to :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=groupName%>&nbsp;</font></td>
    </tr>
    <tr>
      <td width="100%" colspan="2">&nbsp;</td>
    </tr>
    <tr>
      <td width="64%" colspan="2" align="center" rowspan="2" height="34">
      	<font face="Verdana" size="2">
		<a href="/LBCOM/exam/ExamsList.jsp?totrecords=&start=0&examtype=<%=examType%>">BACK TO ASSESSMENTS LIST</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>


