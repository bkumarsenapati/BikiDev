<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs9=null;

	String courseId="",courseName="",studentName="",questionId="",questionBody="",questionType="",SEAnswer="";
	String studentId="",ansStr="",correctAns="",maxPoints="",correctAnstoken="";
	String schoolId="",teacherId="",classId="";
	String crctAns="",crctAns1="",qnColor="";
	String chkStatus="";
	int i=0;

	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();

		schoolId=(String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		studentName=(String)session.getAttribute("studentname");
		
		courseId=request.getParameter("courseid");
		studentId=request.getParameter("studentid");
		courseName=request.getParameter("coursename");

		rs1=st1.executeQuery("select answer_string from pretest_student_material_distribution where course_id='"+courseId+"' and student_id='"+studentId+"'");

		if(rs1.next())
		{
			ansStr=rs1.getString("answer_string");
		}
		if(ansStr ==null || ansStr .equals("null"))
		{
			ansStr ="";
		}
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Evaluated Student Submission</title>
<script>
function viewAnswer(courseid,questionid)
{
var aw=window.open("../ViewSEQAnswer.jsp?courseid="+courseid+"&studentid=<%=studentId%>&questionid="+questionid,"Document1","resizable=no,scrollbars=yes,width=800,height=500,toolbars=no");
//window.location.href="../ViewSEQAnswer.jsp?courseid="+courseid+"&studentid=<%=studentId%>&questionid="+questionid;
}
</script>
</head>

<body>
<form name="distribution">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0" height="72">
  <tr>
    <td width="100%" colspan="3" height="32" bgcolor="#934900" align="center">
		<b><font face="Verdana" size="2" color="#FFFFFF"><%=courseName%> - Pretest</font></b>
	</td>
  </tr>
  <tr>
    <td width="33%" height="19" align="left">
		<font face="Verdana" size="2" color="#934900"><b>&nbsp;Course : </b></font>
		<font face="Verdana" size="2" color="#000080"><%=courseName%></font>
	</td>
	<%
			rs9=st2.executeQuery("select sum(`pretest`.`max_points`) as maxp,count(`pretest`.`max_points`) as cp  from pretest where course_id='"+courseId+"' and status='1' ");
			int totalQuetions=0;
			while(rs9.next())
				{
				maxPoints=rs9.getString("maxp");
				totalQuetions =rs9.getInt("cp");
				}
	%>
    <td width="33%" height="19">&nbsp;</td>
    <td width="34%" height="19" align="right">
		<font face="Verdana" size="2" color="#934900"><b>Maximum Points :</b></font>
		<font face="Verdana" size="2" color="#000080"><%=maxPoints%></font>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="33%" height="19" align="left">
		<font face="Verdana" size="2" color="#934900"><b>&nbsp;Student Name :</b></font>
		<font face="Verdana" size="2" color="#000080"><%=studentName%></font>
	</td>
    <td width="33%" height="19">&nbsp;</td>
    <td width="34%" height="19" align="right">
		<font face="Verdana" size="2" color="#934900"><b>Total No. of Questions :</b></font>
		<font face="Verdana" size="2" color="#000080"><%=totalQuetions%></font>&nbsp;
	</td>
  </tr>
  </table>
<hr color="#934900" size="3">
<%
	rs2=st2.executeQuery("select * from pretest where course_id='"+courseId+"' and status='1' ORDER BY question_id");

		while(rs2.next())
		{
			questionId=rs2.getString("question_id");
			i++;
			questionBody=rs2.getString("question_body");
			questionBody=questionBody.replaceAll("&#39;","\'");
			questionBody=questionBody.replaceAll("&#34;","\"");

			questionType=rs2.getString("question_type");
			correctAns=rs2.getString("correct_answer");

		if(questionType.equals("ma"))
		{
			int s=correctAns.length();
			if(s>=8)
			{
			StringTokenizer optTokens=new StringTokenizer(correctAns,",");
			while(optTokens.hasMoreTokens())
			{
			correctAnstoken=optTokens.nextToken();
			if(crctAns1!="")
						{
				crctAns1=crctAns1+","+questionId+":"+correctAnstoken;
				crctAns=crctAns1;
						}else
						{
					crctAns1=questionId+":"+correctAnstoken;
					crctAns=crctAns1;
						}
			}	
			}
		}
		else
		{
			crctAns=questionId+":"+correctAns;
		}

			if(ansStr.indexOf(crctAns)!=-1)
			{
				qnColor="green";
				chkStatus="checked";
			}
			else
			{
				qnColor="red";
				chkStatus="";
			}
			if(questionType.equals("seq"))
			{
				qnColor="#646464";
				chkStatus="";
			}
			if(questionType.equals("fib"))
			{
				qnColor="#646464";
				chkStatus="";
			}

			rs=st.executeQuery("select answer_text from pretest_attachments where course_id='"+courseId+"' and student_id='"+studentId+"' and question_id='"+questionId+"'");
				while(rs.next())
				{
					SEAnswer=rs.getString("answer_text");
					SEAnswer=SEAnswer.replaceAll("&#39;","\'");
					SEAnswer=SEAnswer.replaceAll("&#34;","\"");
				}
			
%>
	<table border="1" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
	<tr bgcolor="#6666999">
		<td width="2%" align="center" bgcolor="<%=qnColor%>"><b><font face="Verdana" size="2" color="#FFFFFF"><%=i%></font></b></td>
		<td width="98%" colspan="2" align="left"><font face="Verdana" size="2" color="#FFFFFF">&nbsp;<%=questionBody%></font></td>
	</tr>
	</table>
	<table border="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">

<%
	
			if(questionType.equals("mc"))
			{
%>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1"
		<%if(ansStr.indexOf(questionId+":option1")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs2.getString("option1")%></font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" <%if(ansStr.indexOf(questionId+":option2")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs2.getString("option2")%></font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option3" <%if(ansStr.indexOf(questionId+":option3")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs2.getString("option3")%></font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option4" <%if(ansStr.indexOf(questionId+":option4")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs2.getString("option4")%></font></td>
	</tr>

<%
			}
			else if(questionType.equals("ma"))
			{
%>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="checkbox" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" <%if(ansStr.indexOf(questionId+":option1")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs2.getString("option1")%></font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="checkbox" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" <%if(ansStr.indexOf(questionId+":option2")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs2.getString("option2")%></font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="checkbox" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option3" <%if(ansStr.indexOf(questionId+":option3")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs2.getString("option3")%></font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="checkbox" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option4" <%if(ansStr.indexOf(questionId+":option4")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs2.getString("option4")%></font></td>
	</tr>
<%
			}
			else if(questionType.equals("tf"))
			{
%>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" <%if(ansStr.indexOf(questionId+":option1")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2">True</font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" <%if(ansStr.indexOf(questionId+":option2")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2">False</font></td>
	</tr>
<%
			}
			else if(questionType.equals("yn"))
			{
%>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" <%if(ansStr.indexOf("option1")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2">Yes</font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" <%if(ansStr.indexOf("option2")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2">No</font></td>
	</tr>
<%
			}
			else if(questionType.equals("seq"))
			{
							
%>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center">&nbsp;</td>
	    <td width="80%"><a href="#" onclick="viewAnswer('<%=courseId%>','<%=questionId%>');return false;">
				<font size="2" face="verdana" color="#003366">View Answer</font></a>
		</td>
	</tr>
<%
	SEAnswer="";
			}
			else if(questionType.equals("fib"))
			{
%>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center">&nbsp;</td>
	    <td width="80%"><font face="Verdana" size="2"><%=SEAnswer%></font></td>
	</tr>
<%
	SEAnswer="";
			}	
%>
	</table>
	<hr>
<%
		}
	}
  	catch(SQLException se)
	{
		System.out.println("Error in EvaluateStudentExampaper.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in EvaluateStudentExampaper.jsp : pretest -" + e.getMessage());
	}
	finally
	{
		try
		{
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(st4!=null)
				st4.close();
			if(st5!=null)
				st5.close();

			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of EvaluateStudentExampaper.jsp : pretest -"+se.getMessage());
		}
	}
%>
    </td>
  </tr>
</table>
</form>
</body>
</html>