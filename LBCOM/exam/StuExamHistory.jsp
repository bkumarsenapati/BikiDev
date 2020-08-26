<%@page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
String sessid="",studentId="",examId="",examName="",maxAttempts="",schoolId="";
Connection con=null;
Statement st=null;
ResultSet rs=null;
String createdDate="",exmInsTbl="";
String marksScheme="",status1="",count="",totalMarks="",stuTblName="",scheme="";
String shortAnsMarks="";
String statusMsg="";
int totSubm=0,status=0;
boolean flag=false;
%>
<html>
<head>
<link href="admcss.css" rel="stylesheet" type="text/css" />
<title><%=application.getInitParameter("title")%></title>

</head>
<%
String dispPath="";
String version="";
String foreColor="";
String attemptFlag="";
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
		examName=request.getParameter("examname");
		maxAttempts=request.getParameter("maxattempts");
		createdDate=request.getParameter("crdate");
		version=request.getParameter("version");
		attemptFlag=request.getParameter("attemptFlag");
		String teacherId=request.getParameter("teacherid");
		String courseId=request.getParameter("courseid");
		studentId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		con=con1.getConnection();
		st=con.createStatement();
		exmInsTbl=schoolId+"_"+examId+"_"+createdDate.replace('-','_');
		if(maxAttempts.equals("-1")){
			maxAttempts="No limit";
		}
		
		String examType=request.getParameter("examtype");
		scheme=request.getParameter("scheme");
		status1=request.getParameter("status");
		count=request.getParameter("count");
		totalMarks=request.getParameter("totalmarks");

		shortAnsMarks=request.getParameter("shortansmarks");
		stuTblName=schoolId+"_"+studentId;
		
		//dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/";
		dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
//		rs=st.executeQuery("select * from "+exmInsTbl+"  where exam_id='"+examId+"' and student_id='"+studentId+"' and status>=1 order by count desc");
		rs=st.executeQuery("select *,attempt_no from "+exmInsTbl+" et left join teacher_feedback as tf on et.student_id=tf.student_id and et.exam_id=tf.exam_id and et.count=tf.attempt_no and tf.school_id='"+schoolId+"' and tf.course_id='"+courseId+"' and tf.exam_id='"+examId+"' where et.student_id='"+studentId+"' order by count desc");
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
		var win=window.open("HistoryFrames.jsp?examid=<%=examId%>&examame=<%=examName%>&maxattempts=<%=maxAttempts%>&crdate=<%=createdDate%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&version=<%=version%>&submission_no="+count+"&attemptFlag=<%=attemptFlag%>","Result",'left=0,top=0,width=1000,height=800,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');
	      	win.focus();
		window.top.frames['studenttopframe'].stuExamHistoryWin = win;	
         }
}
function disp1(count,fileFlag)
{
	if(fileFlag=="false"){
		alert("Sorry! This feature is not available to this exam.");
        	return false;
	}
	else
	{
		var win=window.open("ResultView.jsp?mode=EVALUATION&schoolid=<%=schoolId%>&studentid=<%=studentId%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&stuTblName=<%=exmInsTbl%>&examid=e0030&examname=Exam 4&examtype=EX&status=2&count=1&securedmarks=4","Result",'left=0,top=0,width=1000,height=800,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');

		//win=window.open("ResultView.jsp?schoolid=<%=schoolId%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&stuTblName=<%=exmInsTbl%>&examid=<%=examId%>&examame=<%=examName%>&studentid=<%=studentId%>&maxattempts=<%=maxAttempts%>&crdate=<%=createdDate%>&version=<%=version%>&submission_no="+count+"&attemptFlag=<%=attemptFlag%>","Result",'left=0,top=0,width=1000,height=800,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');
	      	win.focus();
		window.top.frames['studenttopframe'].stuExamHistoryWin = win;	
         }
}
function openhelp(){
		
	var win=window.open("/LBCOM/exam/ans_status_help.htm","Result",'left=0,top=0,width=500,height=200,toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes');
	      	win.focus();
}
function changestatus(count,fileFlag)
{
	var r;
	if(fileFlag<4){
		r=confirm("Do you want to disable this attempt?")
	}else
		r=true;
	if(r==true)
	window.location="disable_enable_exam.jsp?examid=<%=examId%>&examname=<%=examName%>&maxattempts=<%=maxAttempts%>&crdate=<%=createdDate%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&version=<%=version%>&submission_no="+count+"&status="+fileFlag+"&exmInsTbl=<%=exmInsTbl%>";
	    	
}

function showpapers(attempts,version,student,count,status)
{
		 //alert(attempts);
		// alert(version);
		// alert(student);
		// alert(count);
		// alert(status);
		 var submittedwin=window.open("StuExamPapersFrame.jsp?examid=<%=examId%>&teacherid=<%=teacherId%>&type=student&version="+version+"&attempts="+attempts+"&studentid="+student+"&stuTblName=<%=stuTblName%>&examTable=<%=exmInsTbl%>&examname=<%=examName%>&totalmarks=<%=totalMarks%>&shortansmarks=<%=totalMarks%>&securedmarks=4&examtype=<%=examType%>&scheme=<%=scheme%>&count="+count+"&status="+status,"StudentAnswers","width=1000,height=600,scrollbars=yes,resizable=yes");
		submittedwin.focus();
}
//-->
	function openFeedbackWindow(attempt,marks,mode){
	var feedBackWin=window.open("FeedBack.jsp?mode=S&examid=<%=examId%>&attempt="+attempt+"&studentid=<%=studentId%>&marks="+marks+"&actmode="+mode+"&examname=<%=examName%>","Feedback","width=550,height=235,scrollbars=yes resizable=yes");
	feedBackWin.focus();
	}
</SCRIPT>
<body topmargin="5">
 <center>
  <table border="0" cellpadding="0" cellspacing="0" width="878" style="border-collapse: collapse"  height="46">
  <tr>
	<td colspan="2"  align="left" width="236" height="16"><font face="Arial" size="2" >&nbsp;Submission&nbsp;History&nbsp;of&nbsp;<%=examName%></td>
	
	<td colspan="2" align="center" width="236" height="21"><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript://" onClick="return openhelp()" style="cursor: pointer;cursor: hand;" color="green"><font size="2" face="Arial" >Help!</font></a> </td>


	<td colspan="3" align="right" width="639" height="21"><font face="Arial" size="2" >Maximum Attempts Allowed :&nbsp;<%=maxAttempts%>&nbsp;</td>
  </tr>
	<tr>
		<td class="gridhdr">&nbsp;</td>
	   	<td class="gridhdr">&nbsp;Sno.</td>
		<td class="gridhdr">&nbsp;Date
        Attempted/Submitted</td>
       	<td class="gridhdr">&nbsp;View Result</td>
		<td class="gridhdr">&nbsp;</td>
	   	<td class="gridhdr">&nbsp;Status</td>
  </tr>
<%
	String path="";	
	int i=0;
	while(rs.next()){
		//path=dispPath+"/"+rs.getString("count")+"/"+rs.getString("count")+".html";
		if(i==0){
			i++;
			if((rs.getString("submit_date")==null)&&(rs.isLast())){
			out.println("<tr><td colspan='5'  align='center'><b><font face='Arial' color='#ff7b4f' size='2'></font>&nbsp;</td></tr><tr><td colspan='5'  align='center'><b><font face='Arial' color='#34526C' size='2'>There are no submissions so far</font></td></tr><tr><td colspan='5'  align='center'><b><font face='Arial' color='#ff7b4f' size='2'></font>&nbsp;</td></tr>");
			break;
			}
		}
		path=dispPath;
		status=rs.getInt("status");
		if((status==1)||(status==5))   // pending for evaluation
		{

			foreColor="#800080";
			statusMsg="Pending for evaluation";
		}
		else if((status==2)||(status==6))  // evaluated 
		{
			foreColor="green";
			statusMsg="Evaluated";
		}
		else if((status==3 )||(status==7))				// not submitted properly, just attempted
		{
			foreColor="gray";
			statusMsg="Student opened but not submitted the assessment.";
		}
		
		
%>
<tr>	  
 			
			<%if(status>=4){%>
			<td class="griditem">
            <INPUT TYPE="checkbox" NAME="test" onClick="changestatus(<%=rs.getString("count")%>,<%=status%>);return false;">		
			</td>	
 			<td class="griditem">&nbsp;<a href="javascript://" onClick="disp('<%=rs.getString("count")%>');return false;"><strike><%=rs.getString("count")%></strike></a></td>	
			<td class="griditem">&nbsp;<strike><%=rs.getString("submit_date")%></strike></td>
			<!-- <td width="108" bgColor="#e7e7e7" height="12"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<strike><%=rs.getString("marks_secured")%></strike></td>	 -->
			<td class="griditem">&nbsp;<a href="#" onClick="showpapers('<%=count%>','<%=rs.getString("version")%>','<%=studentId%>','<%=count%>','<%=rs.getString("status")%>');return false;"><%=rs.getString("marks_secured")%></a></td>
			
			<%}else{%>
				<td class="griditem">
					<INPUT TYPE="checkbox" NAME="test" onClick="changestatus(<%=rs.getString("count")%>,<%=status%>);return false;" checked>	
				</td>	
				<td width="199"  height="12"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<a href="javascript://" onClick="disp('<%=rs.getString("count")%>');return false;"><font color="<%=foreColor%>"><%=rs.getString("count")%></a></td>	
				<td width="212"  height="12" align="center"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<%=rs.getString("submit_date")%></td>
				<!-- <td width="108" bgColor="#e7e7e7" height="12"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<a href="javascript://" onclick="disp1('<%=rs.getString("count")%>');return false;"><%=rs.getString("marks_secured")%></td> -->
				 <td width="50"  height="21" align="center" title="View Result & Feedback">&nbsp;<b><a href="#" onClick="showpapers('<%=count%>','<%=rs.getString("version")%>','<%=studentId%>','<%=count%>','<%=rs.getString("status")%>');return false;"><font size="2" face="Arial" color="<%=foreColor%>"><%=rs.getString("marks_secured")%></a></font></b></td>
			<%}%>
			
  			<td>&nbsp;</td>
			<td width="317" align="left" height="12">
			<font face='Arial' size='2'>
<%
			if(rs.getString("attempt_no")!=null)
			{
				//System.out.println("##### ***status..."+status+"....statusMsg..."+statusMsg);
				//out.println("<a href='#' onclick='openFeedbackWindow(\""+rs.getString("count")+"\",\""+rs.getString("marks_secured")+"\",\"edit\");return false;'><font face='Arial' color='"+foreColor+"' size='2'>feedback</a>");
				%>
				<font face='Arial' size='2'><%=statusMsg%></font>
				<%
			}
			else
				out.println(statusMsg);
%> &nbsp;</font></td>
	 </tr>
<%}%>
  </table>
  </center>
<%
	}
}
catch(Exception e){
	ExceptionsFile.postException("StuExamHistory.jsp","operations on database and reading parameters","Exception",e.getMessage());
	
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("StuExamHistory.jsp","closing statement and connection  objects","SQLException",se.getMessage());

		}

    }
%>
</body>
</html>