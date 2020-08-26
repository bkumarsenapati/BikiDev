<%@ page language="Java" import="java.sql.*,java.io.*,java.lang.*,exam.CalTotalMarks"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	File f=null;
	String examId=null;
	String examName=null;
	String createDate=null;
	String schoolId=null;
	String tableName=null;

	String status="",genExamPath="",schoolPath="";
	CalTotalMarks tm=null;
	float totalMarks=0.0f,shortAnsMarks=0.0f;
	int eCredit=0;
%>
<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	try
	{
		schoolId=(String)session.getAttribute("schoolid");
		examId=request.getParameter("examid");
		examName=request.getParameter("examname");
		session.setAttribute("examname", examName);
		createDate=request.getParameter("createdate");
		tableName=schoolId+"_"+examId+"_"+createDate.replace('-','_');
		//System.out.println("tableName....."+tableName);
		session.setAttribute("stuTblName",tableName);
				
		String examType=request.getParameter("examtype");
		String scheme=request.getParameter("scheme");

		String teacherId=(String)session.getAttribute("emailid");
		String courseId=(String)session.getAttribute("courseid");
		String path1=application.getInitParameter("schools_path");
		String path=path1+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/answersScriptFile.html";
		f=new File(path);

		con=con1.getConnection();
		st=con.createStatement();
		

		// Extra Credit Points logic follows here - Temp

		st1=con.createStatement();
		rs1=st1.executeQuery("select * from category_item_master where course_id='"+courseId+"' and item_id='"+examType+"' and school_id='"+schoolId+"'");
		if(rs1.next())
		{
			eCredit=rs1.getInt("grading_system");					
		}
		
		genExamPath=path1+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/1.html";
		if(eCredit==2)
		{
			InputStream in = new FileInputStream(genExamPath);
			BufferedInputStream bin = new BufferedInputStream(in); 
			DataInputStream din = new DataInputStream(bin); 
			StringBuffer sb=new StringBuffer(); 
			
		while(din.available()>0) 
		{
		
			sb.append(din.readLine()); 
			
		} 
	
		try
		{    
			PrintWriter pw = new PrintWriter(new FileOutputStream(genExamPath));// save file 
			sb=sb.replace(310,382,"<script language='javascript' src='/LBCOM/common/avaluation.js'></script>");
			pw.println(sb.toString()); 
			pw.close(); 
		}
		
		catch(IOException e)
		{ 
			e.getMessage(); 
		} 
         in.close(); 
		bin.close(); 
		din.close(); 
		
		}
		/*
		else
		{
			//genExamPath=path1+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/1.html";
			
		InputStream in = new FileInputStream(genExamPath);
		BufferedInputStream bin = new BufferedInputStream(in); 
		DataInputStream din = new DataInputStream(bin); 
		StringBuffer sb=new StringBuffer(); 

		while(din.available()>0) 
		{ 
		
			sb.append(din.readLine()); 
		} 
	
		try
		{    
			PrintWriter pw = new PrintWriter(new FileOutputStream(genExamPath));// save file 
			sb=sb.replace(310,382,"<script language='javascript' src='/LBCOM/common/evaluation.js'></script>");
			pw.println(sb.toString()); 
			pw.close(); 
		}
		
		catch(IOException e)
		{ 
			e.getMessage(); 
		} 
		in.close(); 
		bin.close(); 
		din.close(); 
		
		}

		
		st1.close();
		rs1.close();



		// Upto here

*/


		boolean flag=false;
		if(!f.exists())
		{
			flag=false;
		}
		else
		{
			flag=true;
			
			//rs=st.executeQuery("select max(count) as attempts,student_id,version,submit_date,count,status from "+tableName+" where status>0 group by student_id order by student_id");
			
			//System.out.println("select sum(status) as attempts,student_id,version,submit_date,count,status from "+tableName+" where status=1 group by student_id,status order by student_id");

			rs=st.executeQuery("select sum(status) as attempts,student_id,version,submit_date,count,status from "+tableName+" where status=1 group by student_id,status order by student_id");


			tm=new CalTotalMarks();
			totalMarks=tm.calculate(examId,schoolId);
		}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> Hotschools.net </TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function showpapers(attempts,version,student,count,status)
	{
		 var submittedwin=window.open("ExamPapersFrame.jsp?examid=<%=examId%>&type=student&version="+version+"&attempts="+attempts+"&studentid="+student+"&stuTblName=<%=tableName%>&examname=<%=examName%>&totalmarks=<%=totalMarks%>&shortansmarks=<%=totalMarks%>&examtype=<%=examType%>&scheme=<%=scheme%>&count="+count+"&status="+status,"StudentAnswers","width=1000,height=600,scrollbars=yes,resizable=yes");
		submittedwin.focus();
	}
	function showpapers1(attempts,version,student,count,status)
	{
		 var submittedwin=window.open("ExamPapersFrame1.jsp?examid=<%=examId%>&type=student&version="+version+"&attempts="+attempts+"&studentid="+student+"&stuTblName=<%=tableName%>&examname=<%=examName%>&totalmarks=<%=totalMarks%>&shortansmarks=<%=totalMarks%>&examtype=<%=examType%>&scheme=<%=scheme%>&count="+count+"&status="+status,"StudentAnswers","width=1000,height=600,scrollbars=yes,resizable=yes");
		submittedwin.focus();
	}
		function showevaluation(attempts,version,student,count,status)
	{
		 var submittedwin=window.open("/LBCOM/instevaluation?examid=<%=examId%>&type=student&version="+version+"&attempts="+attempts+"&studentid="+student+"&stuTblName=<%=tableName%>&examname=<%=examName%>&totalmarks=<%=totalMarks%>&shortansmarks=<%=totalMarks%>&examtype=<%=examType%>&scheme=<%=scheme%>&count="+count+"&status="+status,"StudentEvaluation","width=1000,height=600,scrollbars=yes,resizable=yes");
		submittedwin.focus();
	}
	function PretestRes(attempts,version,student,count,status)
	{
		 var submittedwin=window.open("Pretest_Student_Response.jsp?teacherid=<%=teacherId%>&examid=<%=examId%>&type=student&version="+version+"&attempts="+attempts+"&studentid="+student+"&stuTblName=<%=tableName%>&examname=<%=examName%>&totalmarks=<%=totalMarks%>&shortansmarks=<%=totalMarks%>&examtype=<%=examType%>&scheme=<%=scheme%>&count="+count+"&status="+status,"StudentAnswers","width=1000,height=600,scrollbars=yes,resizable=yes");
		submittedwin.focus();
	}
	function benchMarkAss(attempts,version,student,count,status)
	{
		 var submittedwin=window.open("StudentPerformance.jsp?teacherid=<%=teacherId%>&examid=<%=examId%>&type=student&version="+version+"&attempts="+attempts+"&studentid="+student+"&stuTblName=<%=tableName%>&examname=<%=examName%>&totalmarks=<%=totalMarks%>&shortansmarks=<%=totalMarks%>&examtype=<%=examType%>&scheme=<%=scheme%>&count="+count+"&status="+status,"StudentAnswers","width=1000,height=600,scrollbars=yes,resizable=yes");
		submittedwin.focus();
	}
//-->
</SCRIPT>
</HEAD>

<BODY>
<center>
<table border="0" width="100%" bordercolorlight="#000000" cellspacing="1" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td bgcolor="#C2CCE0" height="21" align="left"><font face="arial" size="2" color="#000080">Assessment Name: <b><%=examName%></b></td>
	</tr>
</table>
	<table width="90%" border="0" cellspacing="1" cellpadding="0">
	<tr>		
		<td width="200"  bgcolor="#CECBCE" align="center" height="21"><b><font size="2" face="Arial" color="#000080">Full Name (Username)
		 </font></b></td>
		 <td width="200"  bgcolor="#CECBCE" align="center" height="21"><b><font size="2" face="Arial" color="#000080">Evaluation
		 </font></b></td>
		<td width="50"  bgcolor="#CECBCE" align="center" height="21"><b><font size="2" face="Arial" color="#000080">Attempts History </font></b></td>
		<!-- <td width="100"  bgcolor="#CECBCE" align="center" height="21"><b><font size="2" face="Arial" color="#000080">Pretest Evaluation</font></b></td>
		<td width="100"  bgcolor="#CECBCE" align="center" height="21"><b><font size="2" face="Arial" color="#000080">Benchmark</font></b></td> -->

	</tr>
<% 
	
	int pending=0;
	if(flag)
		{
						
			while(rs.next())
			{
				
%>
				<tr>
					
					<%

						String studentId=rs.getString("student_id");
						st2=con.createStatement();
						rs2=st2.executeQuery("select * from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"'");
						if(rs2.next())
						{
							%>
								<td width='200' bgcolor='#E7E7E7' height='21' align="center">
								<font size='2' face='Arial'>
									 <!-- <a href="javascript://" onclick="showpapers('<%=rs.getString("attempts")%>','<%=rs.getString("version")%>','<%=rs.getString("student_id")%>','<%=rs.getString("count")%>','<%=rs.getString("status")%>');return false;"><%=rs.getString("student_id")%></a> -->
									 <%=rs2.getString("lname")%>&nbsp;<%=rs2.getString("fname")%>&nbsp;(<%=studentId%>)
									
								</td>
							<%
						}
						rs2.close();
						st2.close();
					%>
					
					<%
						if(schoolId.equals("achievebeyond") || schoolId.equals("pgsummer")){
						%>
						<td width='200' bgcolor='#E7E7E7' height='21' align="center">
							<font size='2' face='Arial'>
							 <a href="javascript://" onclick="showpapers('<%=rs.getString("attempts")%>','<%=rs.getString("version")%>','<%=rs.getString("student_id")%>','<%=rs.getString("count")%>','<%=rs.getString("status")%>');return false;" title="Evaluate">Evaluate</a>
							
						</td>
						<%
						}else if(schoolId.equals("lbpghs") || schoolId.equals("training") || schoolId.equals("pghighschool")){
						%>
					
							
							<td width='200' bgcolor='#E7E7E7' height='21' align="center">
								<font size='2' face='Arial'>
								<a href="javascript://" onclick="showevaluation('<%=rs.getString("attempts")%>','<%=rs.getString("version")%>','<%=rs.getString("student_id")%>','<%=rs.getString("count")%>','<%=rs.getString("status")%>');return false;"><!-- <%=rs.getString("student_id")%> -->Evaluate</a>
							</td>
						<%
						}else{
						%>
					
							<td align="center" width='100' bgcolor='#E7E7E7' height='21'>
								<font size='2' face='Arial'><a href="javascript://"onclick="benchMarkAss('<%=rs.getString("attempts")%>','<%=rs.getString("version")%>','<%=rs.getString("student_id")%>','<%=rs.getString("count")%>','<%=rs.getString("status")%>');return false;"><%=rs.getString("version")%>
							</td>
						<%
						}
						%>
					
					
					<td align="center" width='50' bgcolor='#E7E7E7' height='21'>
						<font size='2' face='Arial'><A HREF="/LBCOM/exam/teach_StuExamHistory.jsp?examid=<%=examId%>&examname=<%=examName%>&maxattempts=<%=rs.getString("attempts")%>&crdate=<%=createDate%>&studentid=<%=rs.getString("student_id")%>&courseid=c0001&version=<%=rs.getString("version")%>&stupassword="><%=rs.getString("attempts")%></A>
					</td>
					<!-- <td align="center" width='200' bgcolor='#E7E7E7' height='21'>
					<font size='2' face='Arial'><a href="javascript://" onclick="showpapers1('<%=rs.getString("attempts")%>','<%=rs.getString("version")%>','<%=rs.getString("student_id")%>','<%=rs.getString("count")%>','<%=rs.getString("status")%>');return false;"><%=rs.getString("student_id")%></a>
					</td> -->
					
					<!-- <td align="center" width='100' bgcolor='#E7E7E7' height='21'>
						<font size='2' face='Arial'><a href="javascript://"onclick="PretestRes('<%=rs.getString("attempts")%>','<%=rs.getString("version")%>','<%=rs.getString("student_id")%>','<%=rs.getString("count")%>','<%=rs.getString("status")%>');return false;"><%=rs.getString("version")%>
					</td>
					<td align="center" width='100' bgcolor='#E7E7E7' height='21'>
						<font size='2' face='Arial'><a href="javascript://"onclick="benchMarkAss('<%=rs.getString("attempts")%>','<%=rs.getString("version")%>','<%=rs.getString("student_id")%>','<%=rs.getString("count")%>','<%=rs.getString("status")%>');return false;"><%=rs.getString("version")%>
					</td> -->
				</tr>
<%
			pending++;
			}
			if(pending==0)
			{

			%>
			<tr>
				<td width='100%' colspan='3' bgcolor='#E7E7E7' height='21'>
					<font size='2' face='Arial' color="red"> There are no pending Assessments to evaluate.</font></td>
			</tr>	   
			<%
			}
		}
		else
		{
			
%>
			<tr>
				<td width='100%' colspan='3' bgcolor='#E7E7E7' height='21'>
					<font size='2' face='Arial'>This feature is not available to this exam.</td>
			</tr>	   
<%
		}
	}
	catch(SQLException se)
	{
		System.out.println("SQLException in Show_Pending_ass.jsp is "+se);
	}
	catch(Exception e)
	{
		System.out.println("Exception in Show_Pending_ass.jsp is "+e);
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			if(f!=null)
				f=null;
		}
		catch(SQLException se)
		{
			System.out.println("SQLException in Show_Pending_ass.jsp while closing the connection is "+se);
		}
	}
%>

</table>
</center>
</BODY>
</HTML>
