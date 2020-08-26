<%@page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile,java.text.DecimalFormat"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
String sessid="",studentId="",examId="",examName="",maxAttempts="",schoolId="",teacherId="",courseId="";
Connection con=null;
Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
String createdDate="",exmInsTbl="",strndId="",fName="",lName="";
int totSubm=0,status=0;
boolean flag=false;
%>
<html>
<head>
<title><%=application.getInitParameter("title")%></title>

</head>
<%
String dispPath="";
String version="";
String foreColor="";
flag=false;
try{
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	else{

		examId=request.getParameter("examid");
		System.out.println("examId..."+examId);
		examName=request.getParameter("examname");
		System.out.println("examName..."+examName);
		maxAttempts=request.getParameter("attempts");
		System.out.println("maxAttempts..."+maxAttempts);
		
		teacherId=(String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		System.out.println("courseId..."+courseId);
		studentId=request.getParameter("studentid");
		schoolId=(String)session.getAttribute("schoolid");
		con=con1.getConnection();
		st=con.createStatement();
		exmInsTbl=schoolId+"_"+examId+"_"+createdDate.replace('-','_');
		if(maxAttempts.equals("-1")){
			maxAttempts="No limit";
		}
		System.out.println("maxAttempts..."+maxAttempts);
		//dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/";
		dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
		//rs=st.executeQuery("select * from "+exmInsTbl+"  where exam_id='"+examId+"' and student_id='"+studentId+"' and status>=1 order by count desc");
		System.out.println("select * from pretest_unit_lesson_level where exam_id='"+examId+"'");
		st5=con.createStatement();
		rs5=st5.executeQuery("select * from studentprofile where username='"+studentId+"' and schoolid='"+schoolId+"'");
		if(rs5.next())
		{
			fName=rs5.getString("fname");
			lName=rs5.getString("lname");
		}
		rs5.close();
		st5.close();


		rs=st.executeQuery("select * from pretest_unit_lesson_level where exam_id='"+examId+"'");
%>

<body topmargin="5">
 <center>
  <table style="border-collapse: collapse" height="46" border="1" bordercolor="#111111" cellpadding="0" cellspacing="0" width="900">
  <tr>
	<td colspan="2" align="Left" height="16" bgcolor="#429EDF"><b><font face="Arial" color="white" size="2"><P>&nbsp;Student Name:&nbsp;<%=lName%>&nbsp;<%=fName%> <br>&nbsp;Student ID:&nbsp;<%=studentId%>&nbsp;</td>
	<td colspan="3" align="center" height="16" bgcolor="#429EDF"><b><font face="Arial" color="white" size="2">&nbsp;Submission&nbsp;History&nbsp;of:&nbsp;<%=examName%></td>
  </tr>
	</table><BR>
	 <table style="border-collapse: collapse" height="46" border="1" bordercolor="#111111" cellpadding="0" cellspacing="0" width="900">
	 <tr>
		<td colspan="2" align="center" height="22" bgcolor="#429EDF" width="336"><b><font face="Arial" color="white" size="2">Unit Name > Lesson Name / (Standard ID)</font></td>
		<td colspan="2" align="center" height="22" bgcolor="#429EDF" >&nbsp;<b><font face="Arial" color="white" size="2">Total Questions&nbsp;</font></td>
		<td colspan="2" align="center" height="22" bgcolor="#429EDF" >&nbsp;<b><font face="Arial" color="white" size="2">Total Points&nbsp;</font></td>
		<td colspan="2" align="center" height="22" bgcolor="#429EDF" >&nbsp;<b><font face="Arial" color="white" size="2">Points Earned&nbsp;</font></td>
		<td colspan="2" align="center" height="22" bgcolor="#429EDF" >&nbsp;<b><font face="Arial" color="white" size="2">Required Mastery (%)&nbsp;</font></td>
		<td colspan="2" align="center" height="22" bgcolor="#429EDF" >&nbsp;<b><font face="Arial" color="white" size="2">Secured Percent (%)&nbsp;</font></b></td>
	</tr>

<%
	String lessonId="",noOfQue="",lessonName="",unitId="",unitName="",colorCode="red";
	float totMarks=0.0f,secMarks=0.0f,passCriteria=0.0f,securedPercentage=0.0f;
	boolean flg=false;

	while(rs.next())
		{
			lessonId=rs.getString("lesson_id");
			noOfQue=rs.getString("no_of_ques");
			totMarks=rs.getFloat("tot_marks");
			passCriteria=rs.getFloat("pass_criteria");
			st1=con.createStatement();
			System.out.println("select sum(secured_marks) as sum1 FROM pretest_lesson_secured_marks where exam_id='"+examId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' and student_id='"+studentId+"' group by lesson_id");

			rs1=st1.executeQuery("select sum(secured_marks) as sum1 FROM pretest_lesson_secured_marks where exam_id='"+examId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' and student_id='"+studentId+"' and lesson_id='"+lessonId+"' group by lesson_id");
			if(rs1.next())
			{
				secMarks=Float.parseFloat(rs1.getString("sum1"));

			}
			rs1.close();
			st1.close();
			st2=con.createStatement();
			rs2=st2.executeQuery("select lesson_name,unit_id from lbcms_dev_lessons_master where lesson_id='"+lessonId+"'");
			if(rs2.next())
			{
				lessonName=rs2.getString("lesson_name");
				unitId=rs2.getString("unit_id");
				
			}
			rs2.close();
			st2.close();
			st3=con.createStatement();
			rs3=st3.executeQuery("select unit_id,unit_name from lbcms_dev_units_master where unit_id='"+unitId+"'");
			if(rs3.next())
			{
				unitName=rs3.getString("unit_name");
				
			}
			rs3.close();
			st3.close();

			st4=con.createStatement();
			//System.out.println("select * from lbcms_dev_cc_standards_lessons where course_id='"+courseId+"' and lesson_id='"+lessonId+"'");
			rs4=st4.executeQuery("select * from lbcms_dev_cc_standards_lessons where lesson_id='"+lessonId+"'");
			if(rs4.next())
			{
				strndId=rs4.getString("standard_code");
				
			}
			rs4.close();
			st4.close();

			securedPercentage=(secMarks/totMarks)*100;
			DecimalFormat df = new DecimalFormat("###.##");
			if(securedPercentage>=passCriteria)
			{
				colorCode="green";

			}
			else
			{
				colorCode="red";
			}
		%>
			<tr>
			<td colspan="2" align="Left" height="22" bgcolor="white">&nbsp;<font face="Arial" size="2"><%=unitName%>&nbsp;>&nbsp;<%=lessonName%><BR>&nbsp;<%=strndId%></font></td>
			<td colspan="2" align="center" height="22"><font face="Arial" size="2"><%=noOfQue%></font></td>
			<td colspan="2" align="center" height="22"><font face="Arial" size="2"><%=totMarks%></font></td>
			<td colspan="2" align="center" height="22"><font face="Arial" color="blue" size="2"><%=secMarks%></font></td>
			<td colspan="2" align="center" height="22" ><font face="Arial" size="2"><%=passCriteria%></font></td>
			<td colspan="2" align="center" height="22"><font face="Arial" color="red" size="2"><font color="<%=colorCode%>"><%= df.format(securedPercentage)%></font></td>
			</tr>
			<%
				flg=true;			
		}
		if(flg==false)
		{
			%>
			<tr>
			<td colspan="2" bgcolor="white" align="center" width="900" height="16"><b>There are no submissions available so far.</td>
			</tr>
			<%

		}

}

%>
	
  </table>
  </center>
<%
	}
	catch(Exception e){
	System.out.println(e);
	ExceptionsFile.postException("StuExamHistory.jsp","operations on database and reading parameters","Exception",e.getMessage());
	
	
}finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("StuExamHistory.jsp","closing statement and connection  objects","SQLException",se.getMessage());

		}

    }
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function disp(count,fileFlag)
{
	if(fileFlag=="false"){
		alert("Sorry! This feature is not available to this exam.");
        	return false;
	}
	else
	{
		var win=window.open("HistoryFrames.jsp?examid=<%=examId%>&examame=<%=examName%>&maxattempts=<%=maxAttempts%>&crdate=<%=createdDate%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&version=<%=version%>&submission_no="+count,"Result",'left=0,top=0,width=1000,height=800,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');
	      	win.focus();
		window.top.frames['studenttopframe'].stuExamHistoryWin = win;	
         }
}
function openhelp(){
		
	var win=window.open("/LBCOM/exam/ans_status_help.htm","Result",'left=0,top=0,width=500,height=200,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');
	      	win.focus();
}
function changestatus(count,fileFlag,mode)
{
	var r;
	if(fileFlag<4){
		r=confirm("Do you want to delete this attempt?")
	}
	if((r==true)||(fileFlag>4))		
	window.location="disable_enable_exam.jsp?examid=<%=examId%>&examname=<%=examName%>&maxattempts=<%=maxAttempts%>&crdate=<%=createdDate%>&studentid=<%=studentId%>&courseid=<%=courseId%>&version=<%=version%>&submission_no="+count+"&status="+fileFlag+"&exmInsTbl=<%=exmInsTbl%>&mode="+mode+"";	
	return false;
}
//-->
	function openFeedbackWindow(attempt,marks,mode){
	var feedBackWin=window.open("FeedBack.jsp?mode=S&examid=<%=examId%>&attempt="+attempt+"&studentid=<%=studentId%>&marks="+marks+"&actmode="+mode+"&examname=<%=examName%>","Feedback","width=550,height=235,scrollbars=yes resizable=yes");
	feedBackWin.focus();
	}
</SCRIPT>
</body>
</html>