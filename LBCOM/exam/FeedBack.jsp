<%@ page language="Java" import="java.sql.*,exam.CalTotalMarks"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>

<%
	String examId=null,studentId=null,schoolId=null,teacherId=null,courseId=null,examName="",feedBack="",mode="",actMode="";
	String bgColor1="#ECEEF9",bgColor2="#F8F8FC";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int attempt=0;
	float marksSecured=0.0f;
	String marks=null;
	CalTotalMarks cm;
	float totalMarks=0.0f;
	String sName="";
	String status="";

	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	try
	{
		cm=new CalTotalMarks();
		mode=request.getParameter("mode");
		actMode=request.getParameter("actmode");
		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		examId=request.getParameter("examid");
		examName=request.getParameter("examname");
		studentId=request.getParameter("studentid");	
		attempt=Integer.parseInt(request.getParameter("attempt"));
		marksSecured=Float.parseFloat(request.getParameter("marks"));
		marks=request.getParameter("markssecured");
		
		totalMarks=cm.calculate(examId,schoolId);

		con=con1.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select fname,lname from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"'");
		
		if(rs.next())
		{
			sName=rs.getString("fname")+" "+rs.getString("lname");
		}
		
		if(actMode.equals("edit")||actMode.equals(""))
		{
			rs=st.executeQuery("select feed_back from teacher_feedback where school_id='"+schoolId+"' and exam_id='"+examId+"' and student_id='"+studentId+"' and attempt_no="+attempt);

			if(rs.next())
			{
				feedBack=rs.getString("feed_back");
			}
			
			if(feedBack.equals(""))
			{
				actMode="add";
			}
			else
				actMode="edit";
		}

	
		if (mode.equals("T")) 
		{
			bgColor1="#ECEEF9";
			bgColor2="#F8F8FC";
		}
		else
		{
			bgColor1="#D9D6CA";
			bgColor2="#FBF4EC";
		}
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title><%=application.getInitParameter("title")%></title>
<script language="javascript" src="../validationscripts.js"></script> 
<script>

function validate()
{
	var fb=frm.feedback.value;
	if(trim(fb)=='')
	{
		if(!confirm("Do you want to give the feedback later?"))
		{
			frm.feedback.focus();
			return false;
		}
	}
	replacequotes();
}

function fbLater()
{
	if(confirm("Are you sure that you want to give the feedback later?"))
	{
		document.feedback.feedback.value="";
		window.feedback.action='/LBCOM/FeedBackAction?mode=view';		
		window.feedback.submit();
	}
}


function notifyByMail()
{
	if(document.getElementById("notify").checked==true)
	{
		parent.messageBody="\Student Name : <%=sName%>\nAssessment Name : <%=examName%>\nSubmission No : <%=attempt%>\nPoints Secured : <%=marks%> / <%=totalMarks%>\nFeedback :"+document.feedback.fb.value+" \n";

		parent.toAddress='<%=studentId%>@<%=schoolId%>';
		
		parent.subject='Feedback for <%=examName%>';
		
		var mailwindow;
		mailwindow=window.open("ComposeFeedback.jsp","ComposeFeedback","width=850,height=500,scrollbars=no resizable=no");
		mailwindow.focus();
	}

	document.feedback.action='/LBCOM/FeedBackAction?mode=view';		
	document.feedback.submit();
}

</script>
</head>

<body topmargin=1 leftmargin=1>

<form name="feedback">
<hr>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="lightyellow" width="100%">
<tr>
	<td width="21%" height="19" align="right">
		<font face="verdana" size="2" color="#0000FF"><b>Assessment Name&nbsp;:</b></font></td> 
	<td width="45%" height="19">
		<font face="verdana" size="2" color="#FF0000">&nbsp;<%=examName%></font></td>
	<td width="12%" align="right">
		<font face="verdana" size="2" color="#0000FF"><b>Submission :</b></font></td>
	<td width="15%"  align="left">
		<font face="verdana" size="2" color="#FF0000">&nbsp;<%=attempt%> (<%=marks%> / <%=totalMarks%>)</font>
	</td>
</tr>
<tr>
	<td width="21%" valign="top" align="right">
		<font face="verdana" size="2" color="#0000FF"><b>Feedback&nbsp;:</b></font>
	</td> 
<% 
	if(mode.equals("T")) 
	{
		if(actMode.equals("add"))
		{
%>
			<td colspan="3" width="79%" valign="top">
				<font face="verdana" size="2">
				<textarea rows="3" cols="90" id="fb" name="feedback">Add your feedback here.</textarea>
			</td>
			</tr>
<% 
		}
		else
		{
%>
			<td colspan="3" width="79%" valign="top">
				<font face="verdana" size="2"><textarea rows="2" cols="90" name="feedback" id="fb"><%=feedBack%></textarea>
			</td>
<%
		}
	}
	else
	{
%>
	<td colspan="3" width="79%" valign="top">
		<font face="verdana" size="2">
		<textarea rows="2" cols="90" name="feedback" id="fb" readonly><%=feedBack%></textarea></font>
	</td>
</tr>
<% 
	}
%>
<% 
	if(mode.equals("T"))
	{
		session.setAttribute("fbStatus","done");
		session.setAttribute("marksSecured",marks);
		status=request.getParameter("status");
		session.setAttribute("status",status);
%> 
		<tr>
		<td width="21%">
			<input type="checkbox" name="notify" id="notify" value="1">
			<font face="verdana" size="2" color="#0000FF"><b>Notify by Mail</font>
		</td>
		<td width="79%" colspan="3" align="center">
			<input type='button' name='Submit' value='SUBMIT FEEDBACK' onclick="notifyByMail()">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type='button' name='Submit' value='FEEDBACK LATER' onclick="fbLater()">
		</td>

		<input type="hidden" name="examid" value="<%=examId%>">
		<input type="hidden" name="examname" value="<%=examName%>">
		<input type="hidden" name="studentid" value="<%=studentId%>">
		<input type="hidden" name="marks" value="<%=marksSecured%>">
		<input type="hidden" name="attempt" value="<%=attempt%>">
	</td>
</tr>
<% 
	}
	else
	{
%>
<tr>
	<td colspan="4"><input type='button' name='close' value='Close' onclick='window.close();'></td> 
</tr>
<% 
	}
%>
</table>
</form>
</body>
</html>

<%
	}
	catch(SQLException se)
	{
		System.out.println("SQLException in FeedBack.jsp is "+se);
	}
	catch(Exception e)
	{
		System.out.println("Exception in FeedBack.jsp is "+e);
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
			System.out.println("SQLException in FeedBack.jsp while closing the connection is "+se);
		}
	}
%>

