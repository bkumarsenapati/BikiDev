<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<jsp:setProperty name="db" property="*"/>
<%@page import="java.io.*,java.sql.*,java.util.*,java.util.StringTokenizer,exam.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	Vector questions=null;
		ExamFunctions ef=null;
	String schoolId="",classId="",courseId="",questionCount="",questionId="",questionBody="",questionType="";
	String cDate="",examId="",qtnTable="",quesList="",qId="",examTable="";
	int i=0;

	try
	{
		
		con=con1.getConnection();
		st=con.createStatement();

		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		schoolId=(String)session.getAttribute("Login_school");
		examId=request.getParameter("examid");
		cDate=request.getParameter("cdate");
		cDate=cDate.replaceAll("-","_");

		qtnTable=schoolId+"_"+classId+"_"+courseId+"_quesbody";

		examTable=schoolId+"_"+examId+"_"+cDate;
		questions=new Vector(2,1);
		ef=new ExamFunctions();

		System.out.println("examId..."+examId+"....cDate..."+cDate+"...qtnTable.."+qtnTable);

		
			

		
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
    <td width="2%" align="center" bgcolor="#CE6700">&nbsp;</td>
    <td width="2%" align="center" bgcolor="#CE6700">&nbsp;</td>
    <td width="2%" align="center" bgcolor="#CE6700" valign="middle">&nbsp;</td>
    <!-- <td width="2%" align="center" bgcolor="#CE6700"><font face="Verdana" size="1" color="#FFFFFF">I</font></td> -->
    <td width="60%" bgcolor="#CE6700"><b>
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
		System.out.println("questionList..."+quesList);
		ef.setObjects(quesList);
		questions=ef.getQuestions();
		ListIterator iter = questions.listIterator();
			try
			{
			while (iter.hasNext()) 		//reteriving question ids
			{
				qId=(String)iter.next();
				rs=st.executeQuery("select * from "+qtnTable+" where q_id='"+qId+"' ORDER BY q_id");
		while(rs.next())
		{
			questionId=rs.getString("q_id");
			i++;
			questionBody=QuestionFormat.getQString(rs.getString("q_body"),50);;
			if(questionBody.length() > 50)
				questionBody=questionBody.substring(0,50)+".......";
			questionType=rs.getString("q_type");
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
%>

  <tr>
    <td width="2%" align="center"><font face="Verdana" size="1"><b><input type="checkbox" name="C1" value="ON"></b></font></td>
    <td width="2%" align="center"><font face="Verdana" size="1"><%=i%></font>&nbsp;</td>
    <td width="2%" align="center" bgcolor="#EEEEEE">
		<a href="#" onclick="javascript:return editQuestion('<%=questionId%>')"><img border="0" src="images/idedit.gif" TITLE="Edit" width="19" height="21"></a></td>
      <td width="2%" align="center" bgcolor="#EEEEEE">
		<a href="#" onclick="javascript:return deleteQuestion('<%=questionId%>')"><img border="0" src="images/idelete.gif" TITLE="Delete" width="19" height="21"></a></td>
    <!-- <td width="2%" align="center"><font size="1" face="Verdana">I</font></td> -->
    <td width="60%"><font face="Verdana" size="2">&nbsp;<%=questionBody%></font></td>
    <td width="17%" align="center"><font face="Verdana" size="2"><%=questionType%></font>&nbsp;</td>
  </tr>
<%
		}	  

		
			}
			}
			catch(Exception e) 
			{
				System.out.println("Exception in third block in Pretest--Index.jsp"+e.getMessage());
			}
			System.out.println("qId..."+qId);

	}
	
  	catch(SQLException se)
	{
		System.out.println("Error in index.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in index.jsp : pretest -" + e.getMessage());
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
			System.out.println("Error:  in finally of index.jsp : pretest -"+se.getMessage());
		}
	}
%>
 
</table>
</form>
</body>
</html>