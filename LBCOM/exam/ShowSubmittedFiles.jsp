<%@ page language="Java" import="java.sql.*,java.io.File,exam.CalTotalMarks"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	File f=null;
	String examId=null;
	String examName=null;
	String createDate=null;
	String schoolId=null;
	String tableName=null;

	String status="";
	CalTotalMarks tm=null;
	float totalMarks=0.0f,shortAnsMarks=0.0f;
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
		createDate=request.getParameter("createdate");
		tableName=schoolId+"_"+examId+"_"+createDate.replace('-','_');
		
		String examType=request.getParameter("examtype");
		String scheme=request.getParameter("scheme");

		String teacherId=(String)session.getAttribute("emailid");
		String courseId=(String)session.getAttribute("courseid");
		String path=application.getInitParameter("schools_path");
		path=path+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/answersScriptFile.html";
		f=new File(path);
		boolean flag=false;
		if(!f.exists())
		{
			flag=false;
		}
		else
		{
			flag=true;
			con=con1.getConnection();
			st=con.createStatement();
			rs=st.executeQuery("select max(count) as attempts,student_id,version,submit_date,count,status from "+tableName+" where status>0 group by student_id order by student_id");

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
//-->
</SCRIPT>
</HEAD>

<BODY>
<center>
<table border="0" width="100%" bordercolorlight="#000000" cellspacing="1" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td bgcolor="#C2CCE0" height="21" align="left"><font face="arial" size="2" color="#000080"><%=examName%></td>
	</tr>
</table>
	<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		
		<td width="200"  bgcolor="#CECBCE" align="center" height="21"><b><font size="2" face="Arial" color="#000080">Student Name
		 </font></b></td>
		<td width="50"  bgcolor="#CECBCE" align="center" height="21"><b><font size="2" face="Arial" color="#000080"> Attempts </font></b></td>
		<td width="200"  bgcolor="#CECBCE" align="center" height="21"><b><font size="2" face="Arial" color="#000080">Version</font></b></td>

	</tr>
<% 
		if(flag)
		{
			if(!rs.next()){%>
			<tr>
				<td width='100%' colspan='3' bgcolor='#E7E7E7' height='21'>
					<font size='2' face='Arial'>No Submitted Files.</td>
			</tr>	
			
			<%
			}else{
				do{
	%>
					<tr>
						<td width='200' bgcolor='#E7E7E7' height='21'>
						<font size='2' face='Arial'><a href="javascript://" onclick="showpapers('<%=rs.getString("attempts")%>','<%=rs.getString("version")%>','<%=rs.getString("student_id")%>','<%=rs.getString("count")%>','<%=rs.getString("status")%>');return false;"><%=rs.getString("student_id")%></a>
						<td width='200' bgcolor='#E7E7E7' height='21'>
							<font size='2' face='Arial'><A HREF="/LBCOM/exam/teach_StuExamHistory.jsp?examid=<%=examId%>&examname=<%=examName%>&maxattempts=<%=rs.getString("attempts")%>&crdate=<%=createDate%>&studentid=<%=rs.getString("student_id")%>&courseid=c0001&version=<%=rs.getString("version")%>&stupassword="><%=rs.getString("attempts")%></A>
						<td width='200' bgcolor='#E7E7E7' height='21'>
							<font size='2' face='Arial'><%=rs.getString("version")%>
					</tr>
	<%			}while(rs.next());
			}
						
		}else{
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
		System.out.println("SQLException in ShowSubmittedFiles.jsp is "+se);
	}
	catch(Exception e)
	{
		System.out.println("Exception in ShowSubmittedFiles.jsp is "+e);
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
			System.out.println("SQLException in ShowSubmittedFiles.jsp while closing the connection is "+se);
		}
	}
%>

</table>
</center>
</BODY>
</HTML>
