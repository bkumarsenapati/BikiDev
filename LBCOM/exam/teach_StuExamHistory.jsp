<%@page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
String sessid="",studentId="",examId="",examName="",maxAttempts="",schoolId="";
Connection con=null;
Statement st=null;
ResultSet rs=null;
String createdDate="",exmInsTbl="";
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
		examName=request.getParameter("examname");
		maxAttempts=request.getParameter("maxattempts");
		createdDate=request.getParameter("crdate");
		version=request.getParameter("version");
		String teacherId=(String)session.getAttribute("emailid");
		String courseId=request.getParameter("courseid");
		studentId=request.getParameter("studentid");
		schoolId=(String)session.getAttribute("schoolid");
		con=con1.getConnection();
		st=con.createStatement();
		exmInsTbl=schoolId+"_"+examId+"_"+createdDate.replace('-','_');
		if(maxAttempts.equals("-1")){
			maxAttempts="No limit";
		}
		//dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/";
		dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
		//rs=st.executeQuery("select * from "+exmInsTbl+"  where exam_id='"+examId+"' and student_id='"+studentId+"' and status>=1 order by count desc");
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
<body topmargin="5">
 <center>
  <table border="1" cellpadding="0" cellspacing="0" width="878" style="border-collapse: collapse" bordercolor="#111111" height="46">
  <tr>
	<td colspan="2" bgcolor="#429EDF" align="left" width="236" height="16"><b><font face="Arial" size="2" color="white">&nbsp;Submission&nbsp;History&nbsp;of&nbsp;<%=examName%></td>
	
	<td colspan="2" bgcolor="#429EDF" align="left" width="236" height="16"><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript://" onclick="return openhelp()"><font color="white" size="2" face="Arial">Help!</font></a> </td>


	<td colspan="3" bgcolor="#429EDF" align="right" width="639" height="16"><b><font face="Arial" color="white" size="2">Maximum Attempts Allowed :&nbsp;<%=maxAttempts%>&nbsp;</td>
  </tr>
	<tr>
		<td bgcolor="#dbd9d5" height="16" ></td>
	   	<td width="215" bgcolor="#dbd9d5" height="16"><b><font face="Arial" color="#000080" size="2">&nbsp;No</font></b></td>
		<td width="215" bgColor="#dbd9d5" height="16"><b><font face="Arial" color="#000080" size="2">&nbsp;Date
        Attempted/Submitted</font></b></td>
       	<td width="108" bgColor="#dbd9d5" height="16"><b><font face="Arial" color="#000080" size="2">&nbsp;Score</font></b></td>
	   	<td align=center width="317" bgColor="#dbd9d5" height="16"><b><font face="Arial" color="#000080" size="2">&nbsp;Feedback</font></b></td>
  </tr>
<%
	String path="";	
	int i=0;
	if(!rs.next()){
		out.println("<tr><td colspan='4' bgcolor='#e7e7e7' align='center'><b><font face='Arial' color='#ff7b4f' size='2'>No Submissions done so far</font></td></tr>");
		return;
	}else{

		do{
		//path=dispPath+"/"+rs.getString("count")+"/"+rs.getString("count")+".html";
		if(i==0){
			i++;
			if((rs.getString("submit_date")==null)&&(rs.isLast())){
			out.println("<tr><td colspan='4' bgcolor='#e7e7e7' align='center'><b><font face='Arial' color='#ff7b4f' size='2'>No Submissions done so far</font></td></tr>");
			break;
			}
		}
		path=dispPath;
		status=rs.getInt("status");
		if((status==1)||(status==5))    // pending for evaluation
			foreColor="#800080";
		else if((status==2)||(status==6))  // evaluated 
			foreColor="green";
		else if((status==3 )||(status==7))				// not submitted properly, just attempted
			foreColor="gray";
		
%>
<%
	String strike1="",strike2="",checked="";
if(status>=4 && status<=8){
	strike1="<strike>";
	strike2="</strike>";
}
if(status<4){
	checked="checked";
}
%>
			<tr> 			
				<td bgColor="#e7e7e7" height="12" align=center >
				<%if(status==8){%>
					<font face="Wingdings 3" onclick="changestatus(<%=rs.getString("count")%>,<%=status%>,'undo');return false;" style="cursor:pointer" >O</font>
					<!-- <INPUT TYPE="image" SRC="images/restore.gif" name="af" width="15" height="10"> -->
				<%}else{%>
					<INPUT TYPE="checkbox" NAME="test" onclick="changestatus(<%=rs.getString("count")%>,<%=status%>,'e_d');return false;" <%=checked%>>	
				<%}%>
				</td>	
				<td width="215" bgColor="#e7e7e7" height="12"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<font color="<%=foreColor%>"><%=strike1%><%=rs.getString("count")%><%=strike2%></a></td>	
				<td width="215" bgColor="#e7e7e7" height="12"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<%=strike1%><%=rs.getString("submit_date")%><%=strike2%></td>
				<td width="108" bgColor="#e7e7e7" height="12"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<%=strike1%><%=rs.getString("marks_secured")%><%=strike2%></td>			
				<td width="317" bgColor="#e7e7e7" align=center height="12">
			<%
			if(status==8){
				out.println("Deleted by teacher");
			}else
				if(rs.getString("attempt_no")!=null)
					out.println("<a href='#' onclick='openFeedbackWindow(\""+rs.getString("count")+"\",\""+rs.getString("marks_secured")+"\",\"edit\");return false;'><font face='Arial' color='"+foreColor+"' size='2'>feedback</a>");
				else
					out.println("-");
%> &nbsp;</td>
	 </tr>
<%}while(rs.next());


}

%>
  </table>
  </center>
<%
	}
}
catch(Exception e){
	System.out.println(e);
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