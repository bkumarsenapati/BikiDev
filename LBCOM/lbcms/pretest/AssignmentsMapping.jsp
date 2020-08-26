<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;

	String schoolId="",teacherId="",classId="";
	String courseId="",questionId="",questionBody="",unitId="",unitName="",asgnId="",asgnName="",asgnName2="";
	int i=0;
	String bgColor="";
	String unitIds="",asgnIds="",chkUStatus="",chkAStatus="";
	
	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");	
	questionId=request.getParameter("questionid");
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
		window.location.href="SaveAssignments.jsp?courseid=<%=courseId%>&questionid=<%=questionId%>&selids="+selid;
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

		rs=st.executeQuery("select * from pretest where course_id='"+courseId+"' and question_id='"+questionId+"'");
		if(rs.next())
		{
			questionBody=rs.getString("question_body");
			
			unitIds=rs.getString("unit_ids");
			
			if(unitIds==null || unitIds.equals("null"))
			{
				unitIds="";
			}
			else
			{
				//System.out.println("unitIds not null");
			}
			
			asgnIds=rs.getString("assignment_ids");
			if(asgnIds==null || asgnIds.equals("null"))
			{
				asgnIds="";
			}
			{
				//System.out.println("lessonIds not null");
			}
		}
%>

<form name="pretest" method="POST" onSubmit="return submitForm();">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="35">
  <tr>
    <td width="25%" bgcolor="#934900" height="25">
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<b>Pretest - Assignments Mapping</b></font></td>
    <td width="25%" align="center" bgcolor="#934900" height="25">&nbsp;</td>
    <td width="25%" align="right" bgcolor="#934900" height="25">
		<b><font face="Verdana" size="2"><a href="QuestionMapping.jsp?courseid=<%=courseId%>">
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
	<td width="178%" bgcolor="#DA5C3D" colspan="5" align="right" onclick="submitForm()">
		<input type="submit" value="Save the Changes" name="B1">
	</td>
</tr>
</table>
<%
		int x=0,y=0;

		rs=st.executeQuery("Select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and status < 2 order by slno");
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
				asgnId=rs.getString("work_id");
				asgnName=rs.getString("doc_name");
				asgnName2="";
				if(asgnIds.indexOf(asgnId)!=-1)
				{
					chkAStatus="checked";
				}
				else
				{
					chkAStatus="";
				}
%>
	<tr bgcolor="<%=bgColor%>">
		<td width="2%"><input type="checkbox" name="selids" value="<%=asgnId%>" <%=chkAStatus%>></td>
		<td width="46%"><font face="Verdana" size="1"><%=asgnName%></font></td>
		<td width="4%">&nbsp;</td>

	</tr>
<%
			}	
%>
	</table>
	<hr>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
    <tr>
		<td width="178%" bgcolor="#DA5C3D" colspan="5" align="right" onclick="submitForm()">
			<input type="submit" value="Save the Changes" name="B2">
		</td>
	</tr>
	</table>
<%
	}
  	catch(SQLException se)
	{
		System.out.println("Error in AssignmentsMapping.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in AssignmentsMapping.jsp : pretest -" + e.getMessage());
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
			System.out.println("Error:  in finally of AssignmentsMapping.jsp : pretest -"+se.getMessage());
		}
	}
%>
</form>
</body>
</html>