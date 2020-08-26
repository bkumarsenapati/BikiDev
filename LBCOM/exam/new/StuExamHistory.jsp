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
		dispPath=(String)session.getAttribute("schoolpath")+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
		//dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/";
//		dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
		rs=st.executeQuery("select * from "+exmInsTbl+"  where exam_id='"+examId+"' and student_id='"+studentId+"' and status>=1 order by count desc");


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
         }
}
//-->
</SCRIPT>

<body>
 <center>
  <table border="1" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td colspan="2" bgcolor="#E08040" align="left"><b><font face="Arial" size="2">&nbsp;Submission History of <%=examName%></td>
	<td colspan="2" bgcolor="#E08040" align="right"><b><font face="Arial" size="2">Maximum Attempts Allowed :&nbsp;<%=maxAttempts%>&nbsp;</td>
  </tr>
	<tr>
	   <td width="10%" bgcolor="#dbd9d5"><b><font face="Arial" color="#000080" size="2">No
       <td width="17%" bgColor="#dbd9d5"><b><font face="Arial" color="#000080" size="2">&nbsp;Date
        Attempted/Submitted</font></b></td>
       <td width="11%" bgColor="#dbd9d5"><b><font face="Arial" color="#000080" size="2">&nbsp;Score</font></b></td>
     </tr>

<%
	String path="";
	while(rs.next()){
		flag=true;
		//path=dispPath+"/"+rs.getString("count")+"/"+rs.getString("count")+".html";
		path=dispPath;
		status=rs.getInt("status");

		if(status==1)    // pending for evaluation
			foreColor="#800080";
		else if(status==2)  // evaluated 
			foreColor="green";
		else				// not submitted properly, just attempted
			foreColor="gray";


		
%>
    <tr>
	  
	  <td width="10%" bgColor="#e7e7e7"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<a href="javascript://" onclick="disp('<%=rs.getString("count")%>');return false;"><font color="<%=foreColor%>"><%=rs.getString("count")%></a></td>	
      <td width="17%" bgColor="#e7e7e7"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<%=rs.getString("submit_date")%></td>
      <td width="11%" bgColor="#e7e7e7"><font face="Arial" color="<%=foreColor%>" size="2">&nbsp;<%=rs.getString("marks_secured")%></td>
	 </tr>
<%	}
	if(!flag)
		out.println("<tr><td colspan='4' bgcolor='#e7e7e7' align='center'><b><font face='Arial' color='#ff7b4f' size='2'>No Submissions done so far</font></td></tr>");
	%>
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
<SCRIPT LANGUAGE="JavaScript">
<!--

//-->
</SCRIPT>

</body>
</html>
