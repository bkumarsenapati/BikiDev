<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String schoolId="",courseId="",questionCount="",questionId="",questionBody="",questionType="";
	int i=0;

	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		courseId=(String)session.getAttribute("courseid");
		schoolId=(String)session.getAttribute("Login_school");

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
	function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}
//-->
</SCRIPT>
</head>

<body>
<form method="POST" action="--WEBBOT-SELF--">
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="images/CourseHome_01.gif">
<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="475" height="70">
		<img src="../images/hscoursebuilder.gif" width="194" height="70" border="0">
	</td>
    <td width="493" height="70" align="right">
		<img src="../images/mahoning-Logo.gif" width="296" height="70" border="0">
    </td>
</tr>
<tr>
	<!-- <td width="100%" height="28" colspan="3" background="images/TopStrip-bg.gif"> -->
	<td width="100%" height="28" colspan="3" bgcolor="#A53C00">
  <div align="right">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tr>
			<td width="90%" align="right"><p><a href="#" onclick="viewUserManual();return false;"><font color="white">User Manuals</font></a></p></td>
			<td>&nbsp;&nbsp;&nbsp;</td>
			<td width="10%" align="left"><a href="../Logout.jsp"><font color="white">Logout</font></a></td>
		</tr>
		
		</table>
    </div>
	</td>
</tr>
</table>

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
    <td width="40%" align="center">
    	<font face="Verdana" size="2" color="#934900">1 - <%=questionCount%> of <%=questionCount%> Questions</font>
    </td>
	<td width="15%" align="center">
		<a href="ListOfStudents.jsp" style="text-decoration: none">
			<font face="Verdana" size="2">List of Students</font>
		</a>
    </td>
    <td width="15%" align="center">
		<a href="CreateQuestion.jsp" style="text-decoration: none">
			<font face="Verdana" size="2">New Question</font>
		</a>
	</td>
	<td width="10%" align="center">
		<font face="Verdana" size="2"><a href="QuestionMapping.jsp" style="text-decoration: none">Map</a></font>
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
		while(rs.next())
		{
			questionId=rs.getString("question_id");
			i++;
			questionBody=rs.getString("question_body");
			//if(questionBody.length() > 50)
			//	questionBody=questionBody.substring(0,50)+".......";
			questionType=rs.getString("question_type");
			if(questionType.equals("mc"))
				questionType="Multiple Choice";
			else if(questionType.equals("ma"))
				questionType="Multiple Answer";
			else if(questionType.equals("yn"))
				questionType="Yes or No";
			else if(questionType.equals("tf"))
				questionType="True or False";
			else if(questionType.equals("fib"))
				questionType="Fill in the Blanks";
			else if(questionType.equals("mtf"))
				questionType="Match the Following";
			else if(questionType.equals("seq"))
				questionType="Short or Essay";
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
		if(Integer.parseInt(questionCount) == 0)
		{
%>
  <tr>
    <td width="100%" colspan="6">
		<font face="Verdana" size="1">There are no questions in the pretest.</font></td>
  </tr>
<%
		}
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