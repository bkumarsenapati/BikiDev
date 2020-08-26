<!DO12/12/2004CTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--
	/**
	 *Displays a form where the user can browse for a file to submit & give any comments to the teacher */ 
-->
<HTML>
<%@ page import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String date=null,time=null;
    String workId=null,categoryId=null,status=null,comments=null,schoolId=null,classId=null,courseId=null,studentId=null,topicId=null,subTopicId=null,edFileName=null;
	StringTokenizer wFile=null,mSecured=null;
	int submitCount=0;
	float maxPoints=0.0f;
	String docName="";
%>
<%
	int wfile=0,msecured=0;
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
		
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	try
	{
		schoolId = (String)session.getAttribute("schoolid");
		classId = (String)session.getAttribute("classid");
		courseId = (String)session.getAttribute("courseid");

		con=con1.getConnection();
		st=con.createStatement();
	
		studentId = request.getParameter("studentid");
		workId=request.getParameter("workid");
    	
		rs=st.executeQuery("select category_id,doc_name,topic,subtopic,instructions,marks_total,curtime() time,curdate() date from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
		if(rs.next())
		{
			categoryId=rs.getString("category_id");			
			docName=rs.getString("doc_name");
			topicId=rs.getString("topic");
			subTopicId=rs.getString("subtopic");
			maxPoints=Float.parseFloat(rs.getString("marks_total"));
			time=rs.getString("time");
			date=rs.getString("date");
			date=date.substring(2,date.length());
		}
	
		StringBuffer s=new StringBuffer(date+time);
	
		int i;
		while(((i=s.indexOf("-"))!=-1)||((i=s.indexOf(":"))!=-1))
			s.replace(i,i+1,"");
	
		if(submitCount==0)
			edFileName="1_"+workId+s.toString();
		else
			edFileName=(submitCount+1)+"_"+workId+s.toString();
	}
	catch(Exception e)
	{
		System.out.println("Exception iin TakeAssignment.jsp is..."+e);
		ExceptionsFile.postException("TakeAssignment.jsp","Operations on database","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("SubmitButton.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println("Exception in TakeAssignment.jsp is..."+se.getMessage());
		}
	}
%>

<head><title></title>
</head>
<SCRIPT LANGUAGE="JavaScript" src="../teacher/validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var flag;
  
function validate() 
{
	var win=document.sub;
	var max=<%=maxPoints%>;
	
	if(win.points.value > max || win.points.value == "")
	{
			alert("Maximum points should be less than or equal to "+max);
			win.points.focus();
			return false;
	}
	if(trim(win.teachercomments.value)=="")
	{
		alert("Please enter comments!");
		win.teachercomments.focus();
		return false;
	}
	if(trim(win.stuworkfile.value)=="") 
	{
		if(confirm("Are you sure that you want to proceed with out submitting a document?")==true)
		{
			win.stuworkfile.focus();
			return true;
		}
		else
			win.stuworkfile.focus();
			return false;
			
	}
	
	replacequotes();
}

function show_key(the_value)
{
	var the_key="0123456789";
	var the_char;
	var len=the_value.length;
	if(the_value=="")
		return false;
	for(var i=0;i<len;i++)
	{
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1)
			return false;
	}
}

function checkBrowse()
{
	if(trim(document.sub.stuworkfile.value)!="")
	{
		alert("You have already selected a document.");
		return false;
	}
}
	
function cleardata()
{
	document.sub.reset();
	return false;
}
</SCRIPT>

<BODY topmargin="3" leftmargin="3" bgcolor="#EBF3FB">
<form name="sub"  enctype="multipart/form-data" method="post" action="SubmitScore.jsp?studentid=<%=studentId%>&workid=<%=workId%>&cat=<%=categoryId%>" onsubmit="return validate();">

<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor1.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>
<hr>
<center>
<table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" width="70%">
  <tr>
    <td width="100%" height="28" bgcolor="#C0C0C0"><b>
    <font face="Verdana" size="2" color="#003399">&nbsp;Submit Score</font></b></td>
  </tr>
  <tr>
    <td width="100%" height="12">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" height="12" align="right">
		<b><font face="Verdana" size="2" color="#0000FF">
		<a href="#" onclick="history.go(-1); return false;">&lt;&lt;BACK TO STUDENTS LIST</a>
		</font></b>
	</td>
  </tr>
</table>

<br>

<table border="1" cellspacing="1" width="70%">
  <tr>
    <td width="40%" height="19" align="right"><font face="Verdana" size="2">Name of the Assignment :</font></td>
    <td width="60%" height="19"><font face="Verdana" size="2">&nbsp;<%=docName%></font></td>
  </tr>
  <tr>
    <td width="40%" height="19" align="right"><font face="Verdana" size="2">Name of the Student :</font></td>
    <td width="60%" height="19"><font face="Verdana" size="2">&nbsp;<%=studentId%></font></td>
  </tr>
  <tr>
    <td width="40%" height="10" align="right"><font face="Verdana" size="2">Upload Document :</font></td>
    <td width="60%" height="10"><input type="file" name="stuworkfile" size="20" onclick="return checkBrowse();"></td>
  </tr>
  <tr>
    <td width="40%" height="11" align="right"><font face="Verdana" size="2">Enter Points :</font></td>
    <td width="60%" height="11">
		<input type="text" name="points" size="20">
		<font face="verdana" size="1" color="brown">(Max. Points :<b><%=maxPoints%></b>)</font>
	</td>
  </tr>
  <tr>
    <td width="40%" height="61" align="right" valign="top"><font face="Verdana" size="2">Comments :<br>
    <br>
    </font><font face="Verdana" size="1">(Please mention the reason why do you need to submit the score for this student?)</font></td>
    <td width="60%" height="61"><textarea rows="5" name="teachercomments" cols="40"></textarea></td>
  </tr>
  <tr>
    <td width="40%" height="19">&nbsp;</td>
    <td width="60%" height="19">&nbsp;</td>
  </tr>
  <tr>
	<td width="100%" colspan="2" align="center">
		<input type="submit" value="PROCEED">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="CANCEL">
	</td>
  </tr>
</table>
</center>
</form>
</BODY>
</HTML>
