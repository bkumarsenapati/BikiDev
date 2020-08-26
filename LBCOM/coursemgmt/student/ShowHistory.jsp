<%@page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
String schoolId="",classId="",courseId="",studentId="",sessid="",workId="",max="",workFile="",categoryId="",temp="",date="";
Connection con=null;
Statement stmt=null;
ResultSet rs=null;
int totSubm=0,maxAttempts=0;
String submtCount="",attachments="",docName="";
boolean flag=false;
%>
<html>
<head>
<title><%=application.getInitParameter("title")%></title>
<link href="admcss.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%
flag=false;
try{
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	else{
		workId=request.getParameter("workid");
		docName=request.getParameter("docname");
		maxAttempts=Integer.parseInt(request.getParameter("maxattempts"));
		categoryId=request.getParameter("category");
		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		classId=(String)session.getAttribute("classid");
		studentId=(String)session.getAttribute("emailid");

		con=con1.getConnection();
		stmt=con.createStatement();
		rs=stmt.executeQuery("select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status>=2 and status!=5");
		if(rs.next())
			totSubm=rs.getInt(1);
		rs=stmt.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status>=2 and status!=5 order by submitted_date");
		if(maxAttempts!=-1)
			temp=Integer.toString(maxAttempts);
		else
			temp="No Limit";

%>

<table width="100%" height="62" border="0" cellpadding="0" cellspacing="0">
<tr>
	
	<td ><font size="2"><b>
		&nbsp;Submission History</b></font>
	</td>
    <td >&nbsp;
		
	</td>
	<td >
		<a href="javascript:history.back();">
			<font size="2">BACK TO ASSIGNMENTS HOME</font>
		</a>
	</td>

</tr>
<tr>
	<td ><font size="2">Assignment Name:&nbsp;<%=docName%></font></td>
	<td >&nbsp;</td>
	<td >
			<font size="2">Maximum Attempts Allowed :&nbsp;<%=temp%></font>
	</td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%" >
<tr>
	<td class="gridhdr">
		S.No.
	</td>
    <td class="gridhdr">
		&nbsp;Submission
	</td>
	
	<td class="gridhdr">
		&nbsp;Submission Date
	</td>
    <td class="gridhdr">
		Evaluation Date
	</td>
    <td class="gridhdr">
		Secured Points
	</td>
    <td class="gridhdr">
		Remarks
	</td>
</tr>

<%
	int i=0;
	while(rs.next())
	{
		flag=true;
		i++;
		workId=rs.getString("work_id");
		workFile=rs.getString("answerscript");
		date=rs.getString("eval_date");
		if(date==null)
			date="0000-00-00";
		if(date.equals("0000-00-00"))
			date="Not Evaluated";
		max=workFile.substring(workFile.indexOf('_')+1,workFile.length());
		max=max.substring(max.indexOf('_')+1,max.length());
		submtCount=rs.getString("submit_count");
		attachments=rs.getString("stuattachments");
%>

	<tr>
		<td class="griditem">
			<%=i%>
		</td>
		<td class="griditem">
			
			&nbsp;<a href="javascript://" onClick="return showFile('<%=workId%>','<%=submtCount%>');">
			Work File</a>
		</td>

		<td class="griditem">
			&nbsp;<%=rs.getString("submitted_date")%>
		</td>
		<td class="griditem">
			&nbsp;<%=date%>
		</td>
		<td class="griditem">
			&nbsp;<%=rs.getString("marks_secured")%>
		</td>
		<td class="griditem">
							&nbsp;<a href="javascript://" onClick="return showRemark('<%=rs.getString("remarks")%>','<%=application.getInitParameter("title")%>');">Remarks</a>
			
		</td>
    </tr>
<%	
	}
	if(!flag)
		out.println("<tr><td colspan='7' align='left'><b><font face='verdana' size='2'>There are no submissions so far.</font></td></tr>");
%>

</table>
<%
	}
}
catch(Exception e){
	ExceptionsFile.postException("ShowHistory.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
	System.out.println("Exception raised "+e);
}finally{
	try{
			if(stmt!=null)
				stmt.close();
			if(con!=null && !con.isClosed())
				con.close();
			
	}catch(SQLException se){
			ExceptionsFile.postException("ShowHistory.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
	}

}

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function showFile(wid,subcount)
{

	parent.contents.location.href="/LBCOM/coursemgmt/student/AssignmentHistory.jsp?workid="+wid+"&submit_count="+subcount;
	
	return false;
}
function showAttachFile(attachfile,cat)
{
	window.open("<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=studentId%>/coursemgmt/<%=courseId%>/"+cat+"/"+attachfile,"Document","width=750,height=600,scrollbars");

}
function showRemark(remark,title1)
{
   if(remark=="null")
		remark="No Remarks";
	var newWin=window.open('','TeacherRemarks',"resizable=no,toolbars=no,scrollbar=yes,width=250,height=225,top=275,left=300");
	//opener.window.top.frames['studenttopframe'].stuAsgnTeacherRemarkWin = newWin;
	newWin.document.writeln("<html><head><title>Teacher Remarks</title></head><body><font face='verdana' size=2 color='blue'><u>Teacher Remarks</u></font><br><font face='verdana' size=2>"+remark+"</font></body></html>");
}

//-->
</SCRIPT>

</body>
</html>