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
<title>Student One</title>
</head>

<body>
<form name="grstudselectfrm" id='gr_stud_id'><BR>
<div align="center">
  <center>
<%
	
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet  rs=null,rs1=null;
	boolean flag=false;

	String teacherId=request.getParameter("userid");
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
    <td width="50%" height="28"><font face="Arial" size="2"><b>&nbsp;<font color="#FFFFFF">Summary By Category</font></b></font></td>
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
<table border="0" cellspacing="0" width="95%" id="AutoNumber1" bgcolor="#429EDF" height="26" style="border-collapse: collapse" bordercolor="#111111" cellpadding="5">
  <tr>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
	<select size="1" style="width:200px" id="grade_id" name="gradeid"  onchange="change(this.value)">
    <option value="no" selected>Select Course</option>
<%		
		while (rs.next())
		{
%>
			<option value='<%=rs.getString("course_id")%>'>&nbsp;&nbsp;<%=rs.getString("course_name")%></option>
<%
		flag=true;
		}
%>
    </select></td>
<%
	if(flag==false){
		out.println("<td align='center'>Students are not available yet. </td></tr></table>");
		return;
	}
%>
    <td width="30%" height="23" colspan="2" bgcolor="#96C8ED">
    <p align="right"> <select id='student_id' style="width:200px" name='studentid' onchange='goReulsts(this)'>
	          <option value='none' selected>Select Student</option></select>
	</td>
  </tr>
  
</table>
  </center>
</div>
<br>
	<font face="Arial" size="2"><center>Please select a course.</center></font>
		<hr color="#429EDF" width="95%" size="1">
<br>
</form>
</body>
<%
	out.println("<script>\n");  
	
	out.println("var students=new Array();\n");
	rs.close();
	rs1=st1.executeQuery("select grade, username, fname, lname from studentprofile where schoolid='"+schoolId+"'  and crossregister_flag in(0,1,2) and grade= any(select distinct(class_id) from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"')");
	int i=0,j=1;
	while (rs1.next()) 
	{
		out.println("students["+i+"]=new Array('"+rs1.getString("grade")+"','"+rs1.getString("username")+"','"+rs1.getString("fname")+" "+rs1.getString("lname")+"');\n"); 
		i++;
		j++;
	}
	
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("SummaryByCategory.jsp","operations on database","Exception",e.getMessage());
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
			ExceptionsFile.postException("SummaryByCategory.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>
<script language="javascript">

function getstudents(id)
{
	clear1();
	var j=1;
	var i;
	
	for (i=0;i<students.length;i++)
	{
		if(students[i][0]==id)
		{
			document.grstudselectfrm.studentid[j]=new Option(students[i][2],students[i][1]);
			j=j+1;
		}
	} 
}
function goReulsts(obj)
{
       	var gradeObj=document.qtnselectfrm.gradeid;
		var studentObj=document.qtnselectfrm.studentid;
		var mode=obj.value;
		var classid=gradeObj.value;
		var studentid=studentObj.value;
		if (mode=="session")
			parent.sec.location.href="BySession.jsp?classid="+classid+"&studentid="+studentid;
	        if (mode=="day")
			parent.sec.location.href="ByDay.jsp?classid="+classid+"&studentid="+studentid;
		if (mode=="week")
			parent.sec.location.href="ByWeek.jsp?classid="+classid+"&studentid="+studentid;
		if (mode=="month")
			parent.sec.location.href="ByMonth.jsp?classid="+classid+"&studentid="+studentid;
	}
function change(grade1)
{
	if(grade1!='no')
	{
		grades=grade1
			document.location.href="SummaryByCategory2.jsp?userid=<%=teacherId%>&courseid="+grade1;
	}
	else
	{
		alert("Select Grade")
		grades='no';
		location.href="SummaryByCategory.jsp?userid=<%=teacherId%>";						
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