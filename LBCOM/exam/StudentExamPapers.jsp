<%@ page language="Java" import="java.sql.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>

<%
	String examId=null,studentId=null,schoolId=null,teacherId=null,courseId=null,stuTblName="",examName="",mode="";
	String examType="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String version="0";
	int attempts=0;
	String submissionNo="";
	int status=0,count=0;
	float marks=0.0f;
	String bgColor="";

	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	try
	{
		schoolId=(String)session.getAttribute("schoolid");
		teacherId=(String)session.getAttribute("emailid");
		studentId=request.getParameter("studentid");
		courseId=(String)session.getAttribute("courseid");
		examId=request.getParameter("examid");
		examName=request.getParameter("examname");
		examType=request.getParameter("examtype");
		
		stuTblName=(String)session.getAttribute("stuTblName");
		version=(String)session.getAttribute("version");
		
		submissionNo=(String)session.getAttribute("submissionNo");
			
		attempts=Integer.parseInt(submissionNo);
		
		con=con1.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select count,marks_secured,status,attempt_no from "+stuTblName+" et left join teacher_feedback as tf on et.student_id=tf.student_id and et.exam_id=tf.exam_id and et.count=tf.attempt_no and tf.school_id='"+schoolId+"' and tf.course_id='"+courseId+"' and tf.exam_id='"+examId+"' where et.student_id='"+studentId+"' and et.status<8 order by count");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">

<SCRIPT LANGUAGE="JavaScript">
var attemptNo;
var no_att=0;
<!--
function showFile(attempt,marks,mode,status)
{
	attemptNo=attempt;

	var filePath="../schools/<%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=examId%>/<%=version%>.html";
	parent.mid_f.location.href=filePath;		
	parent.top_f.location.href="../schools/<%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=examId%>/top.html";
	parent.btm_f.location.href="../schools/<%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=examId%>/responses/<%=studentId%>/"+attempt+"/"+attempt+".html";
	
	parent.fb_f.location.href="SubmissionDetails.jsp?mode=view&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&attempt="+attempt+"&status="+status+"&securedmarks="+marks;

	//The following code is used to set the attempt number and the marks obtained in that attempt in the ModeSelector.jsp
	parent.modeframe.location.href="ModeSelector.jsp?mode=VIEW&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status="+status+"&count="+attempt+"&securedmarks="+marks;

	return false;
}
function changestatus(count,fileFlag)
{
	var r;
	if(no_att==1){
		alert("You Can't delete This attempt");
		return false;
	}
	if(fileFlag<4){
		r=confirm("Do you want to delete this attempt?")
	}
	if((r==true)||(fileFlag>4))		
	window.location="disable_enable_exam.jsp?examid=<%=examId%>&examname=<%=examName%>&maxattempts=0&crdate=-&studentid=<%=studentId%>&courseid=<%=courseId%>&version=<%=version%>&submission_no="+count+"&status="+fileFlag+"&exmInsTbl=<%=stuTblName%>&mode=del";	
	return false;
}
//-->
</SCRIPT>
</HEAD>

<BODY>
<table width="98" cellspacing=0 height="550" >
<tr>
	<td valign="top">
		<table width="98" cellspacing=1>
		<tr>
			<td bgcolor="#C2CCE0" colspan="3" align="center">
				<font face="Arial" size="2"><b><%=studentId%></b></font></td>
		</tr>
		<tr>
			<!-- <td width="15" bgcolor="#C2CCE0" height="20"></td> -->
			<td width="100" bgcolor="#C2CCE0" colspan="3" height="20" align="center"><b>
				<font face="Arial" size="1"><b>Attempts (Points)</b></font></b>
			</td>
		</tr>
<%
	String ss="",se="";
	int no_att=0;
	while(rs.next())
	{
		no_att++;
		count=rs.getInt("count");
		status=rs.getInt("status");
		marks=rs.getFloat("marks_secured");

		// Added By Rajesh from here
		if((status==3 )||(status==7))
			bgColor="#F3F3F3";
		else if((status==2)||(status==6))
			bgColor="#EAFFEA";
		else
			bgColor="#FFDDDD";

		ss="";
		se="";
		if(status>4)
		{
			ss="<STRIKE>";
			se="</STRIKE>";
		}
		// Added By Rajesh upto here.

/*		if(status==3)
			bgColor="#F3F3F3";
		else if(status==2)
			bgColor="#EAFFEA";
		else
			bgColor="#FFDDDD";
*/
%>
		<tr>
<%		
		if(rs.getString("attempt_no")==null)
			mode="add";
		else
			mode="edit";
%>
		<td bgcolor="#C2CCE0" colspan="1" height="20" align="center">
				<IMG SRC="images/idelete.gif" WIDTH="19" HEIGHT="19" BORDER="0" ALT="Delete this attempt" onclick="changestatus(<%=count%>,<%=status%>);return false;">
		</td>
		<td colspan="2" bgColor="<%=bgColor%>" align='left'>
			<%=ss%><font face='arial' size='2' color="#800000"'><b>&nbsp;
			<a href="javascript://" onclick="return showFile(<%=count%>,<%=marks%>,'<%=mode%>','<%=status%>');"><%=count%></a></b>
			&nbsp;<b>( <%=marks%> )</b></font><%=se%>
		</td>
	</tr>
<%
	}
	if(no_att ==1)
	{
		out.println("<script language='javascript'>no_att=1; \n </script>");
	}
		
	if(attempts >=1)
	{
		out.println("<script language='javascript'> \n showFile(\'"+submissionNo+"\',\'"+marks+"\',\'"+mode+"\',\'"+status+"\'); \n </script>");
	}
%>

		</table>
	</td>
</tr>
</table>
<iframe name=del height=1 width=1></iframe>
</BODY>
</HTML>

<%
	}
	catch(SQLException se)
	{
		System.out.println("SQLException in StudentExamPapers.jsp is "+se);
	}
	catch(Exception e)
	{
		System.out.println("Exception in StudentExamPapers.jsp is "+e);
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("SQLException in StudentExamPapers.jsp while closing the connection is "+se);
		}
	}
%>

