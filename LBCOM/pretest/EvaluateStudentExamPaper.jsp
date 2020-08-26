<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;

	String courseId="",questionId="",questionBody="",questionType="";
	String studentId="",studentName="",ansStr="",correctAns="",correctAnstoken="";
	String schoolId="",teacherId="",classId="";
	String lessonId="",lessonName="",asgnId="",asgnName="",assessId="",assessName="",attachments="",FIBanswer="";
	String crctAns="",crctAns1="",qnColor="";
	String lessonIds="",asgnIds="",assessIds="",unitId="",unitName="";
	String chkStatus="";
	String distributedIds="";
	String cbCourseId="";
	int i=0,status=0;

	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();
		
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");	
		studentId=request.getParameter("studentid");
		studentName=request.getParameter("studentname");

		rs1=st1.executeQuery("select answer_string,attachments,lesson_ids,assignment_ids,assessment_ids,status from pretest_student_material_distribution where school_id='"+schoolId+"' and course_id='"+courseId+"' and student_id='"+studentId+"'");
		if(rs1.next())
		{
			ansStr=rs1.getString("answer_string");
			attachments=rs1.getString("attachments");
			status=rs1.getInt("status");
			if(status==2)
			{
			distributedIds=rs1.getString("lesson_ids")+","+rs1.getString("assignment_ids")+","+rs1.getString("assessment_ids");
			}
		}
		if(ansStr == null || ansStr .equals("null"))
		{
			ansStr ="";
		}
		if(attachments == null || attachments .equals("null"))
		{
			attachments ="";
		}

		rs2=st2.executeQuery("select * from pretest where course_id='"+courseId+"' and status='1' ORDER BY question_id");

		//1:option4,2:option3,3:option3,4:option3,5:option3,13:option3
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Evaluate Student Submission</title>

<script>

function distribute()
{
	var lid=new Array();
	var uid=new Array();
	var asgnid=new Array();
	var assessid=new Array();

	with(document.distribution)
	{
		for(var i=0,j=0; i < elements.length; i++) 
		{
			if(elements[i].type == 'checkbox' && elements[i].checked==true)
			{
				if(elements[i].name == 'lids')
				{
					lid[j++]=elements[i].value;								
				}
				else if(elements[i].name == 'uids')
				{
					uid[j++]=elements[i].value;								
				}
				else if(elements[i].name == 'asgnids' )
				{
					asgnid[j++]=elements[i].value;								
				}
				else if(elements[i].name == 'assessids' )
				{
					assessid[j++]=elements[i].value;								
				}
			}
		}
	}
	if (j>0)
	{
		window.location.href="MakeDistribution1.jsp?courseid=<%=courseId%>&studentids=<%=studentId%>&unitids="+uid+"&lessonids="+lid+"&workids="+asgnid+"&assessids="+assessid;
		return false;
    }
	else
	{
		alert("Please select the file(s) to be assigned");
		return false;
    }
}
function viewAnswer(courseid,questionid)
{
	window.open("ViewSEQAnswer.jsp?courseid="+courseid+"&studentid=<%=studentId%>&questionid="+questionid,"Document","resizable=no,scrollbars=yes,width=800,height=500,toolbars=no");
}
</script>
</head>

<body>
<form name="distribution" method="POST" onSubmit="return distribute();">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="35">
  <tr>
    <td width="25%" bgcolor="#934900" height="25">
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<b>Pretest - Evaluation</b></font></td>
    <td width="25%" align="center" bgcolor="#934900" height="25">&nbsp;</td>
    <td width="25%" align="right" bgcolor="#934900" height="25">
		<b><font face="Verdana" size="2"><a href="ListOfStudents.jsp">
		<font color="#FFFFFF">Back to Students List</font></a></font></b>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="75%" align="center" colspan="3" height="16"><hr></td>
  </tr>
</table>
<%
		while(rs2.next())
		{
			cbCourseId=rs2.getString("cb_courseid");
			questionId=rs2.getString("question_id");
			i++;
			questionBody=rs2.getString("question_body");
			questionBody=questionBody.replaceAll("&#39;","\'");
			questionBody=questionBody.replaceAll("&#34;","\"");

			questionType=rs2.getString("question_type");
			correctAns=rs2.getString("correct_answer");

			lessonIds=rs2.getString("lesson_ids");
			if(lessonIds==null || lessonIds.equals("null"))
			{
				lessonIds="";
			}

			asgnIds=rs2.getString("assignment_ids");
			if(asgnIds==null || asgnIds.equals("null"))
			{
				asgnIds="";
			}

			assessIds=rs2.getString("assessment_ids");
			if(assessIds==null || assessIds.equals("null"))
			{
				assessIds="";
			}
	
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
				chkStatus="";
			}
			else
			{
				qnColor="red";
				chkStatus="checked";
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
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" <%if(ansStr.indexOf(questionId+":option1")!=-1){%>checked<%}%>></td>
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
			else if(questionType.equals("yn"))
			{
%>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" <%if(ansStr.indexOf(questionId+":option1")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2">Yes</font></td>
	</tr>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" <%if(ansStr.indexOf(questionId+":option2")!=-1){%>checked<%}%>></td>
	    <td width="80%"><font face="Verdana" size="2">No</font></td>
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
			else if(questionType.equals("fib"))
			{
				rs=st.executeQuery("select answer_text from pretest_attachments where course_id='"+courseId+"' and student_id='"+studentId+"' and question_id='"+questionId+"' ");
			while(rs.next())
			{
				FIBanswer=rs.getString("answer_text");
				FIBanswer=FIBanswer.replaceAll("&#39;","\'");
				FIBanswer=FIBanswer.replaceAll("&#34;","\"");

%>
	<tr>
	    <td width="5%">&nbsp;</td>
		<td width="90%"><font face="Verdana" size="2"><%=FIBanswer%></font></td>
		<td width="5%">&nbsp;</td>
	</tr>
	<!-- <tr>
	    <td width="2%">&nbsp;</td>
		<td width="20%"><font face="Verdana" size="2"><%=rs2.getString("option2")%></font></td>
		<td width="78%">&nbsp;</td>
	</tr> -->
<%
			}
			}
			else if(questionType.equals("seq"))
			{
%>
	<tr>
	    <td width="2%">&nbsp;</td>
		<td width="98%" align="left">
			<a href="#" onclick="viewAnswer('<%=courseId%>','<%=questionId%>');return false;">
				<font size="2" face="verdana" color="#003366">View Answer</font>
			</a>
		</td>
	</tr>
<%
			}	
%>
	</table>
	<hr>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
 <tr>
	<td width="2%">&nbsp;</td>
    <td width="98%" colspan="2"><b><font face="Verdana" size="2" color="#934900">Course Material</font></b></td>
  </tr>
<%
			int j=0;
			rs=st.executeQuery("select * from dev_units_master where course_id='"+cbCourseId+"' order by unit_id");
			while(rs.next())
			{
			unitId=rs.getString("unit_id");
			unitName=rs.getString("unit_name");
			j=0;
			//rs3=st3.executeQuery("select * from dev_lessons_master where course_id='"+courseId+"'");
			rs3=st3.executeQuery("select * from dev_lessons_master where course_id='"+cbCourseId+"' and unit_id='"+unitId+"' order by lesson_id");
			while(rs3.next())
			{
				lessonId=rs3.getString("lesson_id");
				lessonName=rs3.getString("lesson_name");

				if(status==2)
				{
					if(distributedIds.indexOf(lessonId)!=-1)
					{
						chkStatus="checked";
					}
					else
					{
						chkStatus="";
					}
				}

				if(lessonIds.indexOf(lessonId)!=-1)
				{
					if(j==0)
					{
%>
<tr>
		<td width="2%">&nbsp;</td>
		 <td width="2%"><input type="checkbox" name="uids" value="<%=unitId%>" <%=chkStatus%>></td>
	    <!-- <td width="96%"><font face="Verdana" size="2"><%=lessonName%></font></td> -->
		<td width="96%"><font face="Verdana" size="2"><%=unitName%></font></td>
</tr>
<%	
					}
					j++;
					
%>
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="2%"><input type="checkbox" name="lids" value="<%=lessonId%>" <%=chkStatus%>></td>
	    <!-- <td width="96%"><font face="Verdana" size="2"><%=lessonName%></font></td> -->
		<td width="96%"><font face="Verdana" size="2"><%=lessonName%></font></td>
	</tr>
<%
				}
			}
			}
			if(j==0)
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2">&nbsp;
			<font face="Verdana" size="2"><i>There are no lessons associated with this question.</i></font>
		</td>
	</tr>
<%
			}
%>
	</table>
	<hr>

	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2"><b><font face="Verdana" size="2" color="#934900">Assignments</font></b></td>
	</tr>

<%
			int k=0;
			rs4=st4.executeQuery("Select work_id,doc_name from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and status < 2 order by slno");
			while(rs4.next())
			{
				asgnId=rs4.getString("work_id");
				asgnName=rs4.getString("doc_name");

				if(status==2)
				{
				if(distributedIds.indexOf(asgnId)!=-1)
								{
									chkStatus="checked";
								}
								else
								{
									chkStatus="";
								}
				}
							
				if(asgnIds.indexOf(asgnId)!=-1)
				{
					k++;
					
%>
  <tr>
	<td width="2%">&nbsp;</td>
    <td width="2%"><input type="checkbox" name="asgnids" value="<%=asgnId%>" <%=chkStatus%>></td>
    <td width="96%"><font face="Verdana" size="2"><%=asgnName%></font></td>
  </tr>
<%
				}
			}
			if(k==0)
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2">&nbsp;
			<font face="Verdana" size="2"><i>There are no assignments associated with this question.</i></font>
		</td>
	</tr>
<%
			}	
%>
	</table>
	<hr>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2"><b><font face="Verdana" size="2" color="#934900">Assessments</font></b></td>
	</tr>

<%
			int l=0;
			rs5=st5.executeQuery("Select exam_id,exam_name from exam_tbl where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and school_id='"+schoolId+"'");
			while(rs5.next())
			{
				assessId=rs5.getString("exam_id");
				assessName=rs5.getString("exam_name");

				if(status==2)
				{
				if(distributedIds.indexOf(assessId)!=-1)
								{
									chkStatus="checked";
								}
								else
								{
									chkStatus="";
								}
				}
				if(assessIds.indexOf(assessId)!=-1)
				{
					l++;
%>
  <tr>
	<td width="2%">&nbsp;</td>
    <td width="2%"><input type="checkbox" name="assessids" value="<%=assessId%>" <%=chkStatus%>></td>
    <td width="96%"><font face="Verdana" size="2"><%=assessName%></font></td>
  </tr>
<%
				}
			}
			if(l==0)
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
		<td width="98%" colspan="2">&nbsp;
			<font face="Verdana" size="2"><i>There are no assessments associated with this question.</i></font>
		</td>
	</tr>
<%
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
 
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="74">
      <tr>
        <td width="52%" height="19">&nbsp;</td>
      </tr>
      <tr>
        <td width="52%" bgcolor="#934900" height="36">
        <p align="center"><input type="submit" value="MAKE THE DISTRIBUTION" name="B1">&nbsp;&nbsp;&nbsp;
        <input type="reset" value="Reset" name="B2"></td>
      </tr>
      <tr>
        <td width="52%" height="19">&nbsp;</td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</form>
</body>
</html>