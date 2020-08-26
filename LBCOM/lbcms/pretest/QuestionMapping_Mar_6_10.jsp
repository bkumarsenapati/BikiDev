<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String courseId="",questionCount="",questionId="",questionBody="";
	String lessonsStatus="",asgnStatus="",assessStatus="";
	String lessonsColor="green",asgnColor="green",assessColor="green";
	int i=0;

	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		courseId=(String)session.getAttribute("courseid");
		
		rs=st.executeQuery("select count(*) from pretest where course_id='"+courseId+"'");
		if(rs.next())
			questionCount=rs.getString(1);

		rs=st.executeQuery("select * from pretest where course_id='"+courseId+"' ORDER BY question_id");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Pretest - Question Map</title>
</head>

<body>
<form method="POST" action="--WEBBOT-SELF--">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="35">
  <tr>
    <td width="25%" bgcolor="#934900" height="25">
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<b>Pretest - Question Map</b></font></td>
    <td width="25%" align="center" bgcolor="#934900" height="25">&nbsp;</td>
    <td width="25%" align="right" bgcolor="#934900" height="25">
		<b><font face="Verdana" size="2"><a href="index.jsp">
		<font color="#FFFFFF">Back to Pretest</font></a></font></b>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="75%" align="center" colspan="3" height="16"><hr></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="24%"><font color="#934900"><font face="Verdana" size="1">&lt;&lt; </font><font face="Verdana" size="2">Prev</font></font></td>
    <td width="49%" align="center">
    	<font face="Verdana" size="2" color="#934900">1 - <%=questionCount%> of <%=questionCount%> Questions</font>
    </td>
    <td width="18%" align="center">
		<a href="CreateQuestion.jsp" style="text-decoration: none"><font face="Verdana" size="2">New Question</font></a>
	</td>
    <td width="9%" align="right">
    	<font color="#934900"><font face="Verdana" size="2">Next </font><font face="Verdana" size="1">&gt;&gt;</font></font>
    </td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
  <tr>
    <td width="2%" align="center" bgcolor="#CE6700">&nbsp;</td>
    <td width="3%" align="center" bgcolor="#CE6700">
    <font face="Verdana" size="1" color="#FFFFFF">CM</font></td>
    <td width="3%" align="center" bgcolor="#CE6700">
    <font face="Verdana" size="1" color="#FFFFFF">AS</font></td>
    <td width="3%" align="center" bgcolor="#CE6700">
    <font face="Verdana" size="1" color="#FFFFFF">EX</font></td>
    <td width="2%" align="center" bgcolor="#CE6700">
    &nbsp;</td>
    <td width="64%" bgcolor="#CE6700"><b>
    <font face="Verdana" size="2" color="#FFFFFF">&nbsp;Title of the Question</font></b></td>
    <td width="17%" align="center" bgcolor="#CE6700"><b>
    <font face="Verdana" size="2" color="#FFFFFF">Question Type</font></b></td>
  </tr>
<%
		while(rs.next())
		{
			questionId=rs.getString("question_id");
			i++;
			questionBody=rs.getString("question_body");
			//if(questionBody.length() > 50)
				//questionBody=questionBody.substring(0,50)+".......";

			lessonsStatus=rs.getString("lesson_ids");
			if(lessonsStatus == null || lessonsStatus =="")
				lessonsColor="red";
			else
				lessonsColor="green";

			asgnStatus=rs.getString("assignment_ids");
			if(asgnStatus == null || asgnStatus=="")
				asgnColor="red";
			else
				asgnColor="green";

			assessStatus=rs.getString("assessment_ids");
			if(assessStatus == null || assessStatus=="")
				assessColor="red";
			else
				assessColor="green";
%>
	<tr>
		<td width="2%" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
		<td width="3%" align="center" bgcolor="<%=lessonsColor%>">
			<a href="MaterialMapping.jsp?courseid=<%=courseId%>&questionid=<%=questionId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">CM</font>
			</a>
		</td>
		<td width="3%" align="center" bgcolor="<%=asgnColor%>">
			<a href="AssignmentsMapping.jsp?courseid=<%=courseId%>&questionid=<%=questionId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">AS</font>
			</a>
		</td>
		<td width="3%" align="center" bgcolor="<%=assessColor%>">
			<a href="AssessmentsMapping.jsp?courseid=<%=courseId%>&questionid=<%=questionId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">EX</font>
			</a>
		</td>
		<td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font>&nbsp;</td>
		<td width="64%"><font face="Verdana" size="2">&nbsp;<%=questionBody%></font></td>
		<td width="17%" align="center"><font face="Verdana" size="2"><%=rs.getString("question_type")%></font>&nbsp;</td>
	</tr>
<%
		}	  
		if(Integer.parseInt(questionCount) ==0)
		{
%>
  <tr>
    <td width="100%" colspan="7">
		<font face="Verdana" size="1">There are no questions in the pretest.</font></td>
  </tr>
<%
		}
	}
  	catch(SQLException se)
	{
		System.out.println("Error in QuestionMapping.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in QuestionMapping.jsp : pretest -" + e.getMessage());
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
			System.out.println("Error:  in finally of QuestionMapping.jsp : pretest -"+se.getMessage());
		}
	}
%> 
</table>
</body>
</html>