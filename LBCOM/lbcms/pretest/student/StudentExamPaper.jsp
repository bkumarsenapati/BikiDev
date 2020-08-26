<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null,st2=null;
	ResultSet rs=null,rs9=null;
	String schoolId="",studentName="",courseId="",courseName="",studentId="",questionId="",questionBody="",questionType="",maxPoints="";
	int i=0;

	try
	{
		schoolId=(String)session.getAttribute("schoolid");
		studentId=(String)session.getAttribute("emailid");
		studentName=(String)session.getAttribute("studentname");

		con=con1.getConnection();
		st=con.createStatement();
		st2=con.createStatement();
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		
		rs=st.executeQuery("select * from pretest where course_id='"+courseId+"' and status='1' ORDER BY question_id");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title><%=courseName%> - Pretest</title>
<script language="JavaScript" type="text/javascript" src="wysiwyg/q_wysiwyg.js"></script> 
<script>
var checked=new Array();
var unchecked=new Array();

function validate()
{
	var selid=new Array();
	var selid1=new Array();
	var selid2=new Array();
	var selid3=new Array();

	with(document.exampaper)
	{		
		for(var i=0,j=0,k=0,l=0,m=0; i < elements.length; i++) 
		{
			selid1[m]="";
			selid2[k]="";
			selid3[l]="";

			if(elements[i].type == 'radio' && elements[i].checked==true)
			{
				selid[j++]=elements[i].value;
			}
			else if(elements[i].type == 'checkbox' && elements[i].checked==true)
			{
				selid1[m++]=elements[i].value;
				//selid1[m++]=selid1[m++]+","+elements[i].value;
			}
			else if(elements[i].type=="textarea")
			{
				//selid2[k]=selid2[k]+elements[i].name+" ANSWER IS:::";
				//selid2[k]=selid2[k]+elements[i].value;
				//selid2[k]=selid2[k]+"ENDS HERE.";
				
				selid2[k]=selid2[k]+ document.getElementById("wysiwyg" + elements[i].id).contentWindow.document.body.innerHTML;//elements[i].value;
				selid2[k]=selid2[k]+"xxxxxx";
				k++;
				selid3[l]=selid3[l]+elements[i].id;
				selid3[l]=selid3[l]+"yyyyyy";
				l++;
			}
			
		}
		var ansstr=selid+","+selid1;
	}
	if (j>0)
	{
		window.location.href="SaveStudentSubmission.jsp?courseid=<%=courseId%>&studentid=<%=studentId%>&ansstr="+ansstr+"&attachments="+selid2+"&qids="+selid3;
		return false;
    }
}
function putanswer(opt)
{
	document.exampaper.elements[opt].checked=true;
}
</script>
</head>

<body>
<form name="exampaper" method="POST" onSubmit="return validate();">
<%
			rs9=st2.executeQuery("select sum(`pretest`.`max_points`) as maxp,count(`pretest`.`max_points`) as cp  from pretest where course_id='"+courseId+"' and status='1' ");
			int totalQuetions=0;
			while(rs9.next())
				{
				maxPoints=rs9.getString("maxp");
				totalQuetions =rs9.getInt("cp");
				}
%>
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
		while(rs.next())
		{
			questionId=rs.getString("question_id");
			i++;
			questionBody=rs.getString("question_body");
			questionBody=questionBody.replaceAll("&#39;","\'");
			questionBody=questionBody.replaceAll("&#34;","\"");

			questionType=rs.getString("question_type");
%>
	<table border="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
	<tr>
		<td width="2%"><input type="checkbox" name="quesid<%=questionId%>" value="<%=questionId%>"></td>
	    <td width="2%" align="center"><b><font face="Verdana" size="2" color="#FF0000"><%=i%></font></b></td>
		<td width="96%" colspan="3" align="left"><font face="Verdana" size="2" color="#FF0000">&nbsp;<%=questionBody%></font></td>
	</tr>

<%
			if(questionType.equals("mc"))
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" onclick="putanswer('quesid<%=questionId%>')"></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs.getString("option1")%></font></td>
		<td width="14%" align="right"><font face="Verdana" size="1">Points: <%=rs.getString("max_points")%></font>&nbsp;</td>
	</tr>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" onclick="putanswer('quesid<%=questionId%>')"></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs.getString("option2")%></font></td>
		<td width="14%" align="right"><font face="Verdana" size="1">Negative Points : <%=rs.getString("negative_points")%></font>&nbsp;</td>
	</tr>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option3" onclick="putanswer('quesid<%=questionId%>')"></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs.getString("option3")%></font></td>
		<td width="14%">&nbsp;</td>
	</tr>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option4" onclick="putanswer('quesid<%=questionId%>')"></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs.getString("option4")%></font></td>
		<td width="14%">&nbsp;</td>
	</tr>

<%
			}
			else if(questionType.equals("ma"))
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="checkbox" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" onclick="putanswer('quesid<%=questionId%>')"></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs.getString("option1")%></font></td>
		<td width="14%" align="right"><font face="Verdana" size="1">Points: <%=rs.getString("max_points")%></font>&nbsp;</td>
	</tr>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="checkbox" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" onclick="putanswer('quesid<%=questionId%>')"></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs.getString("option2")%></font></td>
		<td width="14%" align="right"><font face="Verdana" size="1">Negative Points : <%=rs.getString("negative_points")%></font>&nbsp;</td>
	</tr>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="checkbox" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option3" onclick="putanswer('quesid<%=questionId%>')"></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs.getString("option3")%></font></td>
		<td width="14%">&nbsp;</td>
	</tr>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center"><input type="checkbox" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option4" onclick="putanswer('quesid<%=questionId%>')"></td>
	    <td width="80%"><font face="Verdana" size="2"><%=rs.getString("option4")%></font></td>
		<td width="14%">&nbsp;</td>
	</tr>
<%
			}
			else if(questionType.equals("tf"))
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center">
			<input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" onclick="putanswer('quesid<%=questionId%>')">
		</td>
		<td width="80%" align="left">
			<font face="Verdana" size="2">True</font>&nbsp;&nbsp;&nbsp;
		</td>
	   <td width="14%" align="right"><font face="Verdana" size="1">Points: <%=rs.getString("max_points")%></font>&nbsp;</td>
	</tr>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center">
			<input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" onclick="putanswer('quesid<%=questionId%>')">
		</td>
		<td width="80%" align="left">
			<font face="Verdana" size="2">False</font>&nbsp;&nbsp;&nbsp;
		</td>
	   <td width="14%" align="right"><font face="Verdana" size="1">Negative Points: <%=rs.getString("negative_points")%></font>&nbsp;</td>
	</tr>
<%
			}
			else if(questionType.equals("yn"))
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center">
			<input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option1" onclick="putanswer('quesid<%=questionId%>')">
		</td>
		<td width="80%" align="left">
			<font face="Verdana" size="2">Yes</font>&nbsp;&nbsp;&nbsp;
		</td>
	   <td width="14%" align="right"><font face="Verdana" size="1">Points: <%=rs.getString("max_points")%></font>&nbsp;</td>
	</tr>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="2%" align="center">
			<input type="radio" id="<%=questionId%>" name="<%=questionId%>" value="<%=questionId%>:option2" onclick="putanswer('quesid<%=questionId%>')">
		</td>
		<td width="80%" align="left">
			<font face="Verdana" size="2">No</font>&nbsp;&nbsp;&nbsp;
		</td>
	    <td width="14%" align="right"><font face="Verdana" size="1">Negative Points: <%=rs.getString("negative_points")%></font>&nbsp;</td>
	</tr>
<%
			}
			else if(questionType.equals("seq"))
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="82%" colspan="2">
        <textarea name="<%=questionId%>_seq" id="<%=questionId%>" rows="8" cols="80"></textarea>
		<script language="JavaScript">
		generate_wysiwyg('<%=questionId%>');
		</script>
		</td>
	    <td width="14%" align="right" valign="top">
			<font face="Verdana" size="1">Points: <%=rs.getString("max_points")%>&nbsp;
			<br>Negative Points: <%=rs.getString("negative_points")%></font>&nbsp;
		</td>
	</tr>
<%
			}
			else if(questionType.equals("fib"))
			{
%>
	<tr>
		<td width="2%">&nbsp;</td>
	    <td width="2%">&nbsp;</td>
		<td width="82%" colspan="2"><textarea name="<%=questionId%>_fib" id="<%=questionId%>" rows="2" cols="80"></textarea>
		<script language="JavaScript">
		generate_wysiwyg('<%=questionId%>');
		</script>
		</td>
	    <td width="14%" align="right" valign="top">
			<font face="Verdana" size="1">Points: <%=rs.getString("max_points")%>&nbsp;
			<br>Negative Points: <%=rs.getString("negative_points")%></font>&nbsp;
		</td>
	</tr>
<%
			}
%>
	<tr>
		<td width="100%" colspan="5">&nbsp;</td>
	</tr>
</table>
<%
		}
	}
  	catch(SQLException se)
	{
		System.out.println("Error in index.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error: in pretest/student/StudentExamPaper.jsp : pretest -" + e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally pretest/student/StudentExamPaper.jsp : pretest -"+se.getMessage());
		}
	}
%>
 
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="74">
      <tr>
        <td width="52%" height="19">&nbsp;</td>
      </tr>
      <tr>
        <td width="52%" bgcolor="#934900" height="36" align="center">
			<input type="submit" value="Submit" name="B1">
			<!-- &nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" name="B2">  -->
		</td>
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