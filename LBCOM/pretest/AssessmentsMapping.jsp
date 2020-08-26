<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	
	String schoolId="",teacherId="",classId="",examId="";
	String courseId="",questionId="",questionBody="",unitId="",unitName="",assessId="",assessName="",assessName2="";
	int i=0;
	String bgColor="";
	String unitIds="",assessIds="",chkUStatus="",chkAStatus="";

	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");	
	questionId=request.getParameter("questionid");
	examId=request.getParameter("examid");
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Pretest</title>

<script>
var checked=new Array();
var unchecked=new Array();

function submitForm()
{
	var selid=new Array();
	with(document.pretest)
	{
		
		for(var i=0,j=0; i < elements.length; i++) 
		{
			if(elements[i].type == 'checkbox' && elements[i].name == 'selids' && elements[i].checked==true)
			{
				selid[j++]=elements[i].value;								
			}
		}
		
	}
	if (j>0)
	{
		window.location.href="SaveAssessments.jsp?schoolid=<%=schoolId%>&examid=<%=examId%>&courseid=<%=courseId%>&questionid=<%=questionId%>&selids="+selid;
		return false;
    }
	else
	{
        alert("Please select the file(s) to be assigned");
         return false;
    }
}
</script>
</head>
<body>
<%
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();

		rs=st.executeQuery("select * from pretest_lms where  school_id='"+schoolId+"' and exam_id='"+examId+"' and course_id='"+courseId+"' and q_id='"+questionId+"'");
		if(rs.next())
		{
			questionBody=rs.getString("q_body");
			unitIds=rs.getString("unit_ids");
			
			if(unitIds==null || unitIds.equals("null"))
			{
				unitIds="";
			}
			else
			{
				//System.out.println("unitIds not null");
			}
			
			assessIds=rs.getString("assessment_ids");
			if(assessIds==null || assessIds.equals("null"))
			{
				assessIds="";
			}
			else{
				//System.out.println("lessonIds not null");
			}
		}
		
%>

<form name="pretest" method="POST" onSubmit="return submitForm();">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="35">
  <tr>
    <td width="25%" bgcolor="#934900" height="25">
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<b>Pretest - Assessments Mapping</b></font></td>
    <td width="25%" align="center" bgcolor="#934900" height="25">&nbsp;</td>
    <td width="25%" align="right" bgcolor="#934900" height="25">
		<b><font face="Verdana" size="2"><a href="QuestionMapping.jsp?schoolid=<%=schoolId%>&examid=<%=examId%>&courseid=<%=courseId%>">
		<font color="#FFFFFF">Back to Mapping</font></a></font></b>&nbsp;
	</td>
  </tr>
  <tr>
    <td width="75%" align="center" colspan="3" height="16"><hr></td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
<tr>
    <td width="33%" colspan="3" height="19">
    <b><font face="Verdana" size="2" color="#FF0000">Selected Questions</font></b></td>
  </tr>
  <tr>
    <td width="33%" colspan="3" height="19">
    <font face="Verdana" size="2" color="#000080"><%=questionBody%></font></td>
  </tr>
   <tr>
    <td width="33%" colspan="3" height="19"><hr></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="red" width="100%">
	<tr>
		<td width="178%" bgcolor="#DA5C3D" colspan="5" align="right">
	        <input type="submit" value="Save the Changes" name="B1">
		</td>
	</tr>
	</table>
<%
		int x=0,y=0;

		rs=st.executeQuery("Select * from exam_tbl where teacher_id='"+teacherId+"' and  course_id='"+courseId +"' and school_id='"+schoolId+"'");
		while(rs.next())
		{
%>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="green" width="100%">

<%
			y++;
			i++;
			if(i%2==0)
				bgColor="#E0E0E0";
			else
				bgColor="#FFFFFF";
			assessId=rs.getString("exam_id");
			assessName=rs.getString("exam_name");
			assessName2="";
			if(assessIds.indexOf(assessId)!=-1)
			{
				chkAStatus="checked";
			}
			else
			{
				chkAStatus="";
			}
%>
	<tr bgcolor="<%=bgColor%>">
		<td width="2%"><input type="checkbox" name="selids" value="<%=assessId%>" <%=chkAStatus%>></td>
		<td width="46%"><font face="Verdana" size="1"><%=assessName%></font></td>
		<td width="4%">&nbsp;</td>

	</tr>
<%
			}	
%>
	</table>
	<hr>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
    <tr>
		<td width="178%" bgcolor="#DA5C3D" colspan="5" align="right">
			<input type="submit" value="Save the Changes" name="B2">
		</td>
	</tr>
	</table>
<%
	}
  	catch(SQLException se)
	{
		System.out.println("Error in AssessmentsMapping.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in AssessmentsMapping.jsp : pretest -" + e.getMessage());
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
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of AssessmentsMapping.jsp : pretest -"+se.getMessage());
		}
	}
%>
</form>
</body>
</html>