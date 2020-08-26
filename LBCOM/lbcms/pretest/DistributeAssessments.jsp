<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@page import = "exam.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null;
	ResultSet rs=null,rs1=null;
	
    
	String courseId="",type="",classId="",schoolId="",widStr="",sidStr="",id="",teacherId="",wId="",sId="",startDate="",dueDate="";
	String ignoredList="",assignedList="",studentTable="",masterTable="",workIdsStr="",categoryId="";

	int assignLength=0,assessLength=0,sidLen=0,ignoredCount1=0,ignoredCount2=0,assignedCount1=0,assignedCount2=0;
	boolean statusFlag=false;
	Hashtable workIds=null,studentIds=null,catIds=null;
	int i=0,k=0,totalPoints=0;
	int maxAttempts=0,grading=0,examStatus=0,verNo=1;
	float examTotal=0.0f; 
	String examInstTbl="";
	boolean flag=false,act=false;
	String quesList="",dbString="",studentId="",examType="",qryStr="",lidStr="",unitStr="",asgnStr="";
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
		lidStr=request.getParameter("lessonids");
		//lidStr="DL0974,DL0976,DL0977,DL0978,DL0979,DL0980,DL0981,DL0982,DL0983,DL0984,DL0985,DL0986,DL0988,DL0989,DL0990,DL3617,DL3619,DL3620,DL4308,DL5318,DL5323,DL0991,DL0992,DL0993,DL0994,DL0995,DL0996,DL0997,DL0998,DL0999,DL1000,DL1001,DL1002,DL1003,DL1004,DL1005,DL1006,DL1044,DL1045,DL1046,DL1047,DL1048,DL1049,DL1050,DL1051,DL1052,DL1053,DL1054,DL1055,DL1056,DL1057,DL1058,DL1059,DL1060,DL1061,DL1062,DL1063,DL3621,DL3624,DL3626,DL3627,DL3628,DL3629,DL3630,DL4309,DL5484,DL1007,DL1008,DL1009,DL1010,DL1011,DL1012,DL1013,DL1014,DL1015,DL1016,DL1017,DL1018,DL1019,DL1020,DL1021,DL1022,DL1023,DL1024,DL1025,DL1026,DL1027,DL1028,DL1029,DL1030,DL1031,DL1032,DL1033,DL1034,DL1035,DL1036,DL1037,DL1038,DL1039,DL1040,DL1041,DL1042,DL1043,DL3633,DL3634,DL3635,DL3636,DL3637,DL3638,DL3639,DL4310,DL1065,DL1066,DL1067,DL1068,DL1069,DL1070,DL1071,DL1072,DL1073,DL1074,DL1075,DL1076,DL3466,DL3642,DL4311,DL2694,DL3380,DL3381,DL3387,DL3388,DL3389,DL3390,DL3401,DL3426,DL3427,DL3428,DL3429,DL3470,DL3505,DL3625,DL3632,DL4518,DL3459,DL3463,DL3506,DL3507,DL3508,DL3509,DL3510,DL3511,DL3512,DL3513,DL3514,DL3515,DL3518,DL3519,DL3520,DL3521,DL3522,DL3616,DL3618,DL3622,DL3623,DL4519,DL3631,DL3640,DL3641,DL3647,DL3648,DL3649,DL3650,DL3651,DL3652,DL3653,DL3654,DL3656,DL3661,DL3662,DL3663,DL3664,DL3665,DL3666,DL3667,DL3668,DL3669,DL3672,DL3673,DL3674,DL3675,DL3676,DL3678,DL3679,DL3681,DL3682,DL3683,DL4521,DL3753,DL3755,DL3758,DL3759,DL3760,DL3762,DL3764,DL3766,DL3767,DL3768,DL3770,DL3772,DL3773,DL3774,DL3777,DL3778,DL3779,DL3780,DL3781,DL3782,DL3784,DL3785,DL4523,DL4524,DL3684,DL3685,DL3687,DL3688,DL3689,DL3690,DL3691,DL3694,DL3695,DL3696,DL3698,DL3699,DL3700,DL3701,DL3702,DL3703,DL3704,DL3705,DL3706,DL3707,DL3708,DL3709,DL3710,DL3732,DL3733,DL3734,DL3735,DL3736,DL3737,DL3738,DL3739,DL3740,DL3741,DL3742,DL3743,DL3744,DL3746,DL3747,DL3748,DL3751,DL3752,DL4522,DL5661";

		unitStr=request.getParameter("unitids");
		asgnStr=request.getParameter("asgnids");
		assignLength=Integer.parseInt(request.getParameter("asgncount"));  
		assignedCount2=Integer.parseInt(request.getParameter("assignedcount"));
		ignoredCount2=Integer.parseInt(request.getParameter("ignoredcount"));

		session.putValue("htSelStuIds",sidStr);
		//htSelStuIds=sidStr;
		startDate=request.getParameter("startdate");
		dueDate=request.getParameter("duedate");

		//maxAttempts= Integer.parseInt(request.getParameter("multipleattempts"));
		maxAttempts=-1;
		//grading= Integer.parseInt(request.getParameter("grading"));
		grading=0;
			
		//studentTable=schoolId+"_"+classId+"_"+courseId+"_dropbox";
		masterTable="exam_tbl";
		
		workIds=new Hashtable();
		studentIds=new Hashtable();
		catIds=new Hashtable();
		StringTokenizer widTokens=new StringTokenizer(widStr,",");
		String testStr="",testStr1="";

		while(widTokens.hasMoreTokens())
		{
			id=widTokens.nextToken();
			workIds.put(id,id);
			if(testStr.indexOf(id)==-1)
			{
				if(i==0)
				{
					testStr=id;
				}
				else
					testStr=testStr+","+id;
				i++;
			}
		}
		i=0;
		StringTokenizer asgnTokens=new StringTokenizer(asgnStr,",");

		while(asgnTokens.hasMoreTokens())
		{
			id=asgnTokens.nextToken();
			if(testStr1.indexOf(id)==-1)
			{
				if(i==0)
				{
					testStr1=id;
				}
				else
					testStr1=testStr1+","+id;
				i++;
			}
		}
		i=0;
		
		StringTokenizer sidTokens=new StringTokenizer(sidStr,",");
		while(sidTokens.hasMoreTokens())
		{
			id=sidTokens.nextToken();
			studentIds.put(id,id);
			
		}

		assessLength = workIds.size();	
		sidLen = studentIds.size();	
		st6=con.createStatement();
		st7=con.createStatement();
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
				ignoredCount1++;
				
			}
			if(flag==false)
			{
									
				qryStr="insert into "+examInstTbl+"(exam_id,student_id,ques_list,count,status,version,password) values('"+wId+"','"+studentId+"','"+quesList+"',0,0,"+verNo+",'');";
				st1.executeUpdate(qryStr);

				qryStr="insert into "+schoolId+"_"+studentId+"(exam_id,exam_status,count,version,exam_password,max_attempts) values('"+wId+"',0,0,"+verNo+",'',"+maxAttempts+");";
				st1.executeUpdate(qryStr);

				st1.executeUpdate("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+schoolId+"','"+studentId+"','"+courseId+"','"+examType+"','"+wId+"','0000-00-00',0,"+examTotal+",0,"+examStatus+")");
				assignedCount1++;
				
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

		i=st7.executeUpdate("update pretest_student_material_distribution set lesson_ids='"+lidStr+"',unit_ids='"+unitStr+"',assignment_ids='"+testStr1+"',assessment_ids='"+testStr+"',status='2' where course_id='"+courseId+"' and student_id='"+studentId+"'");

		response.sendRedirect("SaveStudentCourse.jsp?asgncount="+assignLength+"&assignedcount="+assignedCount2+"&ignoredcount="+ignoredCount2+"&assmtcount="+assessLength+"&assmtassignedcount="+assignedCount1+"&assmtignoredcount="+ignoredCount1+"&studentids="+sidStr+"&startdate="+startDate+"&duedate="+dueDate);

		
	}
	catch(SQLException se)
	{
		System.out.println("The exception1 in DistributeAssessments.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception234567890 in DistributeAssessments.jsp is....."+e);
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
			ExceptionsFile.postException("DistributeAssessments.jsp","closing the statement objects","SQLException",se.getMessage());
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
	<tr bgcolor="#934900">
		<td width="100%" colspan="2">&nbsp;<font face="Verdana" size="2" color="white"><b>&nbsp;Assignments Distribution Summary</b></font></td>
	</tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Assignments :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assignLength%></font></td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Name of the Student :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=sidStr%></font></td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No of Successful Assignings :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assignedCount2%></font>
<%
	if(assignedCount2 < 0) // once we write the ListAssignedOnes.jsp we will change the condition to > .
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
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=ignoredCount2%></font>
<%
	if(ignoredCount2 < 0)	// once we write the ListAssignedOnes.jsp we will change the condition to > .
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
<br>
<table border="1" cellspacing="0" width="500" align="center">
   <tr bgcolor="#934900">
		<td width="100%" colspan="2">&nbsp;<font face="Verdana" size="2" color="white"><b>&nbsp;Assessments Distribution Summary</b></font></td>
	</tr>
    <tr>
      <td width="28%">&nbsp;</td>
      <td width="36%">&nbsp;</td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Assessments :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assessLength%> </font>
		<!-- <font face="Verdana" size="1" color="#800000">
		<a href="#" onclick="listAssessments(); return false;">(LIST)</a></font> -->
	  </td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Students :</font></td>
      <td width="36%">
      	<font face="Verdana" size="2" color="#800000">&nbsp;<%=sidLen%></font>
      	<!-- <font face="Verdana" size="1" color="#800000">
		<a href="#" onclick="listStudents(); return false;">(LIST)</a></font> -->
      </td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No of Successful Assignings :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assignedCount1%></font>
<%
	if(assignedCount1 < 0) // once we write the ListAssignedOnes.jsp we will change the condition to > .
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
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=ignoredCount1%></font>
<%
	if(ignoredCount1 < 0)	// once we write the ListAssignedOnes.jsp we will change the condition to > .
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
      <td width="100%" colspan="2">&nbsp;</td>
    </tr>
    <tr>
      <td width="64%" colspan="2" align="center" rowspan="2" height="34">
      	<font face="Verdana" size="2">
		<a href="ListOfStudents.jsp">Back to Student List</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>


