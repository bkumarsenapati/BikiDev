<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
	String courseId="",questionId="",questionBody="",unitId="",unitName="",lessonId="",lessonName="",lessonName2="";
	int i=0;
	String bgColor="";
	String unitIds="",lessonIds="",chkUStatus="",chkLStatus="";
	String devCourseId="",cId="";
	String schoolId="",examId="",qId="";
	boolean flag=false;

	courseId=request.getParameter("courseid");
	questionId=request.getParameter("questionid");
	
	schoolId=request.getParameter("schoolid");
	examId=request.getParameter("examid");
	devCourseId=request.getParameter("devcourseid");	
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Pretest</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goCourse()
{
	var devCourseId=document.pretest.courselist.value;
	window.location="MaterialMapping.jsp?courseid=<%=courseId%>&examid=<%=examId%>&questionid=<%=questionId%>&schoolid=<%=schoolId%>&devcourseid="+devCourseId;

}

var checked=new Array();
var unchecked=new Array();

function submitForm()
{
	var selid=new Array();
	var devCourseId=document.pretest.courselist.value;
	
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
		window.location.href="SaveUnitsLessons.jsp?schoolid=<%=schoolId%>&examid=<%=examId%>&courseid=<%=courseId%>&cbcourseid="+devCourseId+"&questionid=<%=questionId%>&selids="+selid;
			return false;
    }
	else
	{
        alert("Please select the file(s) to be assigned");
         return false;
    }
}
function mtrlmap(opt)
{
	document.pretest.elements[opt].checked=true;
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
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();		
		if(devCourseId == null)
			devCourseId="selectcourse";
		
		rs2=st2.executeQuery("select * from pretest_lms where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"' and q_id='"+questionId+"'");
		if(rs2.next())
		{
			
			questionBody=rs2.getString("q_body");
			unitIds=rs2.getString("unit_ids");
			
			if(unitIds==null || unitIds.equals("null"))
			{
				unitIds="";
				
			}
			else
			{
				//System.out.println("unitIds not null");
			}
			lessonIds=rs2.getString("lesson_ids");
			if(lessonIds==null || lessonIds.equals("null"))
			{
				lessonIds="";
			}
			{
				//System.out.println("lessonIds not null");
			}
			
		}
		rs2.close();
		st2.close();
%>

<form name="pretest" method="POST" onSubmit="return submitForm();">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" height="35">
  <tr>
    <td width="25%" bgcolor="#934900" height="25">
    <font color="#FFFFFF" face="Verdana" size="2">&nbsp;<b>Pretest - Material Mapping</b></font></td>
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
<%
	rs3=st3.executeQuery("select * from dev_course_master where status=1");
	if(devCourseId.equals("selectcourse"))
	{
%>
		<td width="50%" height="23" bgcolor="#96C8ED">
		<select id="courselist" style="width:200px" name="courselist" onchange="goCourse(); return false;">
			<option value="selectcourse" selected>Select Course</option>
<%
	                
              while(rs3.next())
				{
				  
					out.println("<option value='"+rs3.getString("course_id")+"'>"+rs3.getString("course_name")+"</option>");
				}
				
	}
	else
	{
		
%>
		<td width="50%" height="23" bgcolor="#96C8ED">
		<select id="courselist" style="width:200px" name="courselist" onchange="goCourse(); return false;">
			<option value="selectcourse" selected>Select Course</option>
<%
	                
            while(rs3.next())
			{
				cId=rs3.getString("course_id");
				if(cId.equals(devCourseId))
				{
					  out.println("<option value='"+rs3.getString("course_id")+"' selected>"+rs3.getString("course_name")+"</option>");
				}
				else
				{
					out.println("<option value='"+rs3.getString("course_id")+"'>"+rs3.getString("course_name")+"</option>");

				}

			}
				
	}

%>
		</select>
		<script>
			document.catsummary.courselist.value="<%=courseId%>";	
		</script>
	</td>
		<td width="50%" bgcolor="#96C8ED" colspan="4" align="right">
	        <input type="submit" value="Save the Changes" name="B1">
		</td>
	</tr>
	<tr>
		<td width="178%" bgcolor="#FFFFFF" colspan="5">&nbsp;</td>
	</tr>
	</table>
<%
	if(!devCourseId.equals("selectcourse"))
	{
					
		int x=0,y=0;
		
		rs5=st5.executeQuery("select * from dev_units_master where course_id='"+devCourseId+"' order by unit_id");
		while(rs5.next())
		{
			unitId=rs5.getString("unit_id");
			//out.println("unitId is............"+unitId);
			unitName=rs5.getString("unit_name");
			i=0;
			x++;
			y=0;
			if(unitIds.indexOf(unitId)!=-1)
			{
				chkUStatus="checked";
			}
			else
			{
				chkUStatus="";
			}
			
%>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="green" width="100%">
	<tr>
		<td width="2%" bgcolor="#C0C0C0">
			<input type="checkbox" name="selids" value="<%=unitId%>" title="Select all Lessons in the Unit" <%=chkUStatus%>>
		</td>
		<td width="176%" colspan="4" bgcolor="#C0C0C0"><b><font face="Verdana" size="1"><%=unitName%></font></b></td>
	</tr>
<%
	
			rs1=st1.executeQuery("select * from dev_lessons_master where course_id='"+devCourseId+"' and unit_id='"+unitId+"' order by lesson_id");
			while(rs1.next())
			{
				y++;
				i++;
				if(i%2==0)
					bgColor="#E0E0E0";
				else
					bgColor="#FFFFFF";
				lessonId=rs1.getString("lesson_id");
				lessonName=rs1.getString("lesson_name");
				lessonName2="";
				if(lessonIds.indexOf(lessonId)!=-1)
				{
					chkLStatus="checked";
				}
				else
				{
					chkLStatus="";
				}
%>
	<tr bgcolor="<%=bgColor%>">
		<td width="2%"><input type="checkbox" name="selids" value="<%=lessonId%>" onclick="mtrlmap('<%=unitId%>')" <%=chkLStatus%>></td>
		<td width="90%"><font face="Verdana" size="1"><%=lessonName%></font></td>
		<td width="8%">&nbsp;</td>

	</tr>
<%
			}	
%>
	</table>
	<hr>
<%
		}	
		
%>

	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
    <tr>
		<td width="178%" bgcolor="#DA5C3D" colspan="5" align="right" onclick="submitForm()">
			<input type="submit" value="Save the Changes" name="B2">
		</td>
	</tr>
	</table>
<%
	}
	}
  	catch(SQLException se)
	{
		System.out.println("Error in MaterialMapping.jsp : pretest : SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("Error:  in MaterialMapping.jsp : pretest -" + e.getMessage());
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
			if(st5!=null)
				st5.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of MaterialMapping.jsp : pretest -"+se.getMessage());
		}
	}
%>
</form>
</body>
</html>