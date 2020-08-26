<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Overall Summary</title>
</head>

<body>
<form name="grstudselectfrm" id='gr_stud_id'><BR>
<div align="center">
  <center>
<%
	
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet  rs=null,rs1=null,rs2=null;
	boolean flag=false;
	String cId="";

	String teacherId=request.getParameter("userid");
	String courseId=request.getParameter("courseid");
	String schoolId=(String)session.getValue("schoolid");   
	
	if(schoolId==null){
			out.println("<font face='Arial' size='2'><b>Your session has expired. Please Login again... <a href='#' onclick=\"top.location.href='/LBCOM/'\">Login.</a></b></font>");
			return;
	}
  try
	 {
		con=con1.getConnection();	
		st=con.createStatement();
		st1=con.createStatement();
		rs=st.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and status>0 order by course_id");
%>
<table border="0" cellspacing="0" width="95%" id="AutoNumber3" bgcolor="#429EDF" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="28">
  <tr>
    <td width="50%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">Student Overall Summary Report</font></b></font></td>
	<td width="50%" height="24" align="right">
	<a href="index.jsp?userid=<%=teacherId%>"><IMG SRC="images/back.png" WIDTH="22" HEIGHT="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" cellpadding="5" cellspacing="0"  width="95%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" >
  <tr>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
	<select style="width:200px"size="1" id="grade_id" name="gradeid"  onchange="change(this.value)">

<%		
		while(rs.next())
		{
			cId=rs.getString("course_id");
			if(cId.equals(courseId))
			{
%>
				<option value='<%=cId%>' selected>&nbsp;&nbsp;<%=rs.getString("course_name")%>&nbsp;</option>
<%			}
			else
			{
%>			
				<option value='<%=cId%>'>&nbsp;&nbsp;<%=rs.getString("course_name")%>&nbsp;</option>
<%			}
		
		}
%>
    </select></td>
<%
	rs1=st1.executeQuery("select grade, username, fname, lname from studentprofile where schoolid='"+schoolId+"'  and crossregister_flag in(0,1,2) and username= any(select distinct(student_id) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' ORDER BY fname,lname)");
	

%>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
    <p align="right"><select id='student_id' style="width:200px" name='studentid' onchange='goResults(this.value)'>
	<option value="no" selected>Select Student</option>
	<option value='allstudents'>List All Students</option>
<%	
	while (rs1.next()) 
	{
%>		
		<option value='<%=rs1.getString("username")%>'>&nbsp;&nbsp;<%=rs1.getString("fname")%> &nbsp;&nbsp;<%=rs1.getString("lname")%></option>
		
<%
	flag=true;
	}
%>	
	</select>
<%
	if(flag==false)
	{
		out.println("<td align='center'>Students are not available yet. </td></tr></table>");
		return;
	}
%>
</td>	
  </tr>
</table>
  </center>
</div>
<div align="center">
  <center>

  </center>
</div>
<font face="Arial" size="2"><center>Please select a student.</center></font>
			<hr color="#429EDF" width="95%" size="1">
<br>

</form>
</body>
<%
	
	 }
	catch(Exception e)
	{
		ExceptionsFile.postException("OverallSummary2.jsp","operations on database","Exception",e.getMessage());
    }
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			ExceptionsFile.postException("OverallSummary2.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>
<script language="javascript">

function goResults(obj)
{
       	var gradeObj=document.grstudselectfrm.gradeid;
		var studentObj=document.grstudselectfrm.studentid;
		var cid=gradeObj.value;
		var studentid=studentObj.value;
		document.location.href="OverallSummary3.jsp?userid=<%=teacherId%>&courseid="+cid+"&sid="+studentid;
		
	}
function change(grade1)
{
	if(grade1!='no')
	{
		grades=grade1
		document.location.href="OverallSummary2.jsp?userid=<%=teacherId%>&courseid="+grade1;
	}
	else
	{
		
		grades='no';
		location.href="OverallSummary2.jsp?userid=<%=teacherId%>&courseid="+grade1;						
	}
}
function clear1() {
		var i;
		var temp=document.grstudselectfrm.studentid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}

</script>
</html>