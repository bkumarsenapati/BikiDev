<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<jsp:setProperty name="db" property="*"/>
<%@page import="java.io.*,java.sql.*,java.util.*,java.util.StringTokenizer,exam.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
	Vector questions=null;
		ExamFunctions ef=null;
	String schoolId="",classId="",courseId="",questionCount="",questionId="",questionBody="",questionType="";
	String lessonsStatus="",asgnStatus="",assessStatus="";
	String lessonsColor="red",asgnColor="red",assessColor="red";
	String devCourseId="";
	String cDate="",examId="",qtnTable="",quesList="",qId="",examTable="";
	int i=0;
	boolean flag=false;

	try
	{
		
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		

		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		schoolId=(String)session.getAttribute("Login_school");
		examId=request.getParameter("examid");
		

		qtnTable=schoolId+"_"+classId+"_"+courseId+"_quesbody";

		questions=new Vector(2,1);
		ef=new ExamFunctions();
		
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Welcome to Pretest Module!</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function deleteQuestion(questionid)
{
	if(confirm("Are you sure that you want to delete the question?")==true)
	{
		location.href="DeleteQuestion.jsp?mode=delete&questionid="+questionid;
		return false;
	}
	else
		return false;
}

function editQuestion(questionid)
{
	if(confirm("Are you sure that you want to edit the question?")==true)
	{
		location.href="EditQuestion.jsp?mode=edit&questionid="+questionid;
		return false;
	}
	else
		return false;
}
//-->
</SCRIPT>
</head>

<body>
<form method="POST" action="--WEBBOT-SELF--">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="41">
  <tr>
    <td width="25%" height="25" bgcolor="#934900">
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<b>Pretest</b></font></td>
    <td width="25%" align="center" height="25" bgcolor="#934900">&nbsp;</td>
    <td width="25%" align="center" height="25" bgcolor="#934900">&nbsp;</td>
  </tr>
  <tr>
    <td width="75%" align="center" colspan="3" height="16"><hr></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="red" width="100%">
<tr>
	<td width="10%">
		<font color="#934900" face="Verdana" size="1">&lt;&lt; </font>
		<font face="Verdana" size="2">Prev</font>
	</td>
	<td width="10%" align="center">
		<font face="Verdana" size="2"><a href="QuestionMapping.jsp" style="text-decoration: none">Map</a></font>
	</td>
    <td width="40%" align="center">
    	<font face="Verdana" size="2" color="#934900"><!-- 1 - <%=questionCount%> of <%=questionCount%> Questions --></font>
    </td>
	<td width="15%" align="center">
		<a href="ListOfStudents.jsp" style="text-decoration: none">
			<font face="Verdana" size="2"><!-- List of Students --></font>
		</a>
    </td>
    <td width="15%" align="center">
		<a href="CreateQuestion.jsp" style="text-decoration: none">
			<font face="Verdana" size="2"><!-- New Question --></font>
		</a>
	</td>
	
    <td width="10%" align="right">
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
		
		rs=st.executeQuery("select * from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"'");
		if(rs.next())
		{
			quesList=rs.getString("ques_list");
		}
		rs.close();
		
		ef.setObjects(quesList);
		questions=ef.getQuestions();
		ListIterator iter = questions.listIterator();
			try
			{
			while (iter.hasNext()) 		//reteriving question ids
			{
				lessonsColor="red";
				asgnColor="red";
				assessColor="red";
				st3=con.createStatement();
				st4=con.createStatement();
				qId=(String)iter.next();
				rs1=st1.executeQuery("select * from "+qtnTable+" where q_id='"+qId+"' ORDER BY q_id");
				if(rs1.next())
				{
					questionId=rs1.getString("q_id");

					//questionBody=QuestionFormat.getQString(rs1.getString("q_body"),50);
					
					
					questionBody=rs1.getString("q_body");
					int spacePos1 = questionBody.indexOf("####");
					int spacePos2 = questionBody.indexOf("@@EndQBody");
										
					questionBody=questionBody.substring( spacePos1+4, spacePos2);
					questionBody=questionBody.replaceAll("\'","&#39;");
					
					////// Upto here

					rs3=st3.executeQuery("select * from pretest_lms where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and q_id='"+questionId+"'");
					if(rs3.next())
					{
						//devCourseId=rs.getString("cb_courseid");
						flag=true;
						
					}
					if(flag==false)
					{
						int j=st4.executeUpdate("insert into pretest_lms(school_id,course_id,exam_id,q_id,q_body) values ('"+schoolId+"','"+courseId+"','"+examId+"','"+questionId+"','"+questionBody+"')");
					}
					
					questionType=rs1.getString("q_type");
					if(questionType.equals("0"))
						questionType="Multiple choice";
					if(questionType.equals("1"))
						questionType="Multiple answers";
					if(questionType.equals("2"))
						questionType="Yes/No";
					if(questionType.equals("3"))
						questionType="Fill in the blanks";
					if(questionType.equals("4"))
						questionType="Matching";
					if(questionType.equals("5"))
						questionType="Ordering";
					if(questionType.equals("6"))
						questionType="Short/Essay-type";
					i++;

					rs2=st2.executeQuery("select * from pretest_lms where school_id='"+schoolId+"' and exam_id='"+examId+"' and course_id='"+courseId+"' and q_id='"+qId+"'  ORDER BY q_id");
					if(rs2.next())
					{
					
						
						//if(questionBody.length() > 50)
							//questionBody=questionBody.substring(0,50)+".......";

						lessonsStatus=rs2.getString("lesson_ids");
						
						if(lessonsStatus == null || lessonsStatus =="")
							lessonsColor="red";
						else
							lessonsColor="green";

						asgnStatus=rs2.getString("assignment_ids");
						if(asgnStatus == null || asgnStatus=="")
							asgnColor="red";
						else
							asgnColor="green";

						assessStatus=rs2.getString("assessment_ids");
						if(assessStatus == null || assessStatus=="")
							assessColor="red";
						else
							assessColor="green";
						devCourseId=rs2.getString("cb_courseid");
						if(devCourseId==null || devCourseId=="")
						{
							devCourseId="selectcourse";
						}
					}
					
%>
	<tr>
		<td width="2%" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
		<td width="3%" align="center" bgcolor="<%=lessonsColor%>">
	<a href="MaterialMapping.jsp?courseid=<%=courseId%>&examid=<%=examId%>&questionid=<%=questionId%>&schoolid=<%=schoolId%>&devcourseid=<%=devCourseId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">CM</font>
			</a>
		</td>
		<td width="3%" align="center" bgcolor="<%=asgnColor%>">
			<a href="AssignmentsMapping.jsp?courseid=<%=courseId%>&examid=<%=examId%>&questionid=<%=questionId%>&schoolid=<%=schoolId%>&devcourseid=<%=devCourseId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">AS</font>
			</a>
		</td>
		<td width="3%" align="center" bgcolor="<%=assessColor%>">
			<a href="AssessmentsMapping.jsp?courseid=<%=courseId%>&examid=<%=examId%>&questionid=<%=questionId%>&schoolid=<%=schoolId%>&devcourseid=<%=devCourseId%>" style="text-decoration: none">
				<font face="Verdana" size="1" color="#FFFFFF">EX</font>
			</a>
		</td>
		<td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font>&nbsp;</td>
		<td width="64%"><font face="Verdana" size="2">&nbsp;<%=questionBody%></font></td>
		<td width="17%" align="center"><font face="Verdana" size="2"><%=questionType%></font>&nbsp;</td>
	</tr>
<%
		}
			st3.close();
			st4.close();
		
		}
	}
	catch(Exception e)
	{
		System.out.println("Error:  in QuestionMapping.jsp : pretest -" + e.getMessage());
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
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(st4!=null)
				st4.close();
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