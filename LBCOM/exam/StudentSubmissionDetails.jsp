<%@ page language="Java" import="java.sql.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>

<%
	String schoolId=null,studentId=null,examId=null,examName="",attemptNo=null,totalMarks=null,marksSecured=null,status=null;
	String statusMsg="";
	String feedBack="";
	String mode="EVALUATION";	//default mode is EVALUATION
	String examType="";
	String sName="";
	
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	boolean fbFlag=false;
	
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	try
	{
		schoolId=(String)session.getValue("schoolid");
		studentId=request.getParameter("studentid");	
		examId=request.getParameter("examid");
		examName=request.getParameter("examname");
		examType=request.getParameter("examtype");
		attemptNo=request.getParameter("attempt");
		status=request.getParameter("status");
		mode=request.getParameter("mode");
							
		totalMarks=(String)session.getValue("totalMarks");

		String evalStatus=(String)session.getValue("evalStatus");
		String submStatus=(String)session.getValue("submStatus");
		String fbStatus=(String)session.getValue("fbStatus");
		
		if(submStatus!=null)
		{
			if(submStatus.equals("done"))
			{
				status="1";
				session.setAttribute("submStatus","");
			}
		}
		if(evalStatus!=null)
		{
			if(evalStatus.equals("done"))
			{
				marksSecured=(String)session.getValue("marksSecured");
				session.setAttribute("evalStatus","");
			}
			else
			{
				marksSecured=request.getParameter("securedmarks");
			}
		}
		if(fbStatus!=null)
		{
			if(fbStatus.equals("done"))
			{
				marksSecured=(String)session.getValue("marksSecured");
				status=(String)session.getValue("status");
				session.setAttribute("fbStatus","");
			}
		}

		if(marksSecured==null)
		{
			marksSecured=request.getParameter("securedmarks");
		}
		con=con1.getConnection();
		st=con.createStatement();
		rs=st.executeQuery("select fname,lname from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"'");
		if(rs.next())
		{
			sName=rs.getString("fname")+" "+rs.getString("lname");
		}
		rs=st.executeQuery("select feed_back from teacher_feedback where school_id='"+schoolId+"' and exam_id='"+examId+"' and student_id='"+studentId+"' and attempt_no='"+attemptNo+"'");
		if(rs.next())
		{
			feedBack=rs.getString(1);
		}

		if(feedBack.equals(""))
			fbFlag=false;
		else
			fbFlag=true;
	}
	catch(SQLException se)
	{
		System.out.println("SQLException in StudentSubmissionDetails.jsp is "+se);
	}
	catch(Exception e)
	{
		System.out.println("Exception in StudentSubmissionDetails.jsp is "+e);
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
			System.out.println("SQLException in StudentSubmissionDetails.jsp while closing the connection is "+se);
		}
	}
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
<script>

function load()
{
	var oldpoints=0;
	for(var i=1;i<=parent.frames["mid_f"].qIds.length;i++)
	{
		if(parent.frames["mid_f"].qType[i-1]==6)
		{
			var qid=parent.frames["mid_f"].qIds[i-1];
			qid="M"+qid;
			parent.mid_f.document.getElementById(qid).style.visibility="visible";
			oldpoints=oldpoints+Number(parent.mid_f.document.getElementById(qid).value);
									 
		}
	}
	parent.fb_f.location="EvaluateSubmission.jsp?mode=reeval&studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=attemptNo%>&opoints="+oldpoints;
}

//-->
</SCRIPT>

</head>

<!-- <body onload="load()"> -->
<body>
<hr>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="lightyellow" width="100%" height="53">
<tr>
	<!--  <td width="14%" height="16" align="left"><b>
		<font face="Verdana" size="2" color="#0000FF">&nbsp;Student Name&nbsp;&nbsp;&nbsp;: </font></b></td>
    <td width="26%" height="16">
		<font face="Verdana" size="2" color="#FF0000"><%=sName%></font></td> -->
    <td width="16%" height="16" align="right"><b>
		<font face="Verdana" size="2" color="#0000FF">&nbsp;Assessment Name :</font></b></td>
    <td width="39%" height="16">
		<font size="2" face="Verdana" color="#FF0000"><%=examName%></font></td>
		<td width="14%" height="19" align="left"><b>
    <font face="Verdana" size="2" color="#0000FF">&nbsp;Submission No&nbsp; :</font></b></td>
    <td width="26%" height="19"><font face="Verdana" size="2" color="#FF0000"><%=attemptNo%></font></td>
</tr>
<tr>
    
    <td width="16%" height="19" align="right"><b>
    <font size="2" face="Verdana" color="#0000FF">&nbsp;Points Secured :</font></b></td>
<%
		if(status.equals("1") || status.equals("5"))	//1= Not evaluated; 5= student attempted and disabled
		{
%>
			<td width="39%" height="19">
				<font color="#FF0000" face="Verdana" size="2"><%=marksSecured%>/<%=totalMarks%>
				<font color="GREEN" face="Verdana" size="2">&nbsp;&nbsp;(Pending for Evaluation)</font>
			</td>
<%		
		}
		else if(status.equals("2") || status.equals("6"))
		{
			if(mode.equals("view"))
			{
%>
				<td width="39%" height="19">
					<font color="#FF0000" face="Verdana" size="2">	<%=marksSecured%>/<%=totalMarks%>
					<font color="GREEN" face="Verdana" size="2">&nbsp;&nbsp;(Already Evaluated)</font>
				</td>
<%
			}
			else
			{
%>
				<td width="39%" height="19">
					<font color="#FF0000" face="Verdana" size="2">	<%=marksSecured%>/<%=totalMarks%>
					<font color="GREEN" face="Verdana" size="2">
					<!-- <a href="javascript://" onclick="reEvaluate(); return false;">Evaluate Once Again</a> --></font>
					<font color="GREEN" face="Verdana" size="2">&nbsp;&nbsp;(Already Evaluated)
					<!-- <a href="EvaluateSubmission.jsp?studentid=<%=studentId%>&examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&status=<%=status%>&count=<%=attemptNo%>" title="Click here to edit the feedback">(EDIT)</a> -->
					</font>
				</td>
<%
			}
		}	
		else if(status.equals("3") || status.equals("7"))
		{
%>
			<td width="39%" height="19">
				<font color="#FF0000" face="Verdana" size="2">Student opened but not submitted the assessment.</font>
			</td>
<%
		}	
%>
</tr>
<tr>
<%
		if(fbFlag)
		{
%>
			<td width="16%" height="19"  align="right">
				<b><font face="Verdana" size="2" color="#0000FF">&nbsp;Feedback :</font></b>
				
			</td>
			<td width="86%" colspan="3" height="16">
				<font face="Verdana" size="2" color="#FF0000"><%=feedBack%></font>
			</td>
<%
		}
		else
		{
%>
			<td width="16%" height="19"  align="right">
				<b><font face="Verdana" size="2" color="#0000FF">&nbsp;Feedback :</font></b>
				
			</td>
			<td width="86%" colspan="3" height="19">
				<font face="Verdana" size="2" color="#FF0000">Feedback is not available.</font>
			</td>
<%
		}	
%>
</tr>
</table>
</body>
</html>

