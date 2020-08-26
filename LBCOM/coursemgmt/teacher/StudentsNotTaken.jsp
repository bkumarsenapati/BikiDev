<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=25;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
      
	String studentId="",teacherId="",schoolId="",workFile="",workId="",categoryId="",cat="",courseName="";
	String linkStr="",bgColor="",courseId="",docName="",fName="",lName="",emailId="",classId="",remarks="";
	int totrecords=0,start=0,end=0,c=0,maxMarks=0,status=0,count=0,currentPage=0;
%>
<%    
	try  
	{   
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		teacherId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		courseName=(String)session.getAttribute("coursename");
		courseId=(String)session.getAttribute("courseid");
		classId=(String)session.getAttribute("classid");

		cat=request.getParameter("cat"); 
		workId=request.getParameter("workid");
		totrecords=Integer.parseInt(request.getParameter("totrecords"));
			
		con=con1.getConnection();
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		st1=con.createStatement();
		st2=con.createStatement();
		rs2=st2.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
		if(rs2.next())
		{
			docName=rs2.getString("doc_name");
			
		}
		rs2.close();
		start=Integer.parseInt(request.getParameter("start"));
		c=start+pageSize;
		end=start+pageSize;
			
		if (c>=totrecords)
			end=totrecords;
		currentPage=(start/pageSize)+1;
		
		//rs=st.executeQuery("select student_id from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status <= 1 order by student_id asc LIMIT "+start+","+pageSize);

		//rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid where d.work_id='"+workId+"' and d.status <= 1 order by s.fname,s.lname asc LIMIT "+start+","+pageSize);--------------January 08,2008.----------
		
		rs=st.executeQuery("select distinct(student_id),work_id,start_date,end_date,submitted_date,submit_count,eval_date,marks_secured,stuattachments,answerscript from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid where d.work_id='"+workId+"' and d.status <= 1 order by s.fname,s.lname asc LIMIT "+start+","+pageSize);

	}
	catch(SQLException e) 
	{
		ExceptionsFile.postException("ShowStudentFile.jsp","Operations on database and reading parameters","SQLException",e.getMessage());
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("StudentsNotTaken.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in StudentsNotTaken.jsp is..."+se.getMessage());
		}	
	}	
	catch(Exception e) 
	{
		ExceptionsFile.postException("StudentsNotTaken.jsp","Operations on database and reading parameters","Exception",e.getMessage());
		System.out.println("The Error in StudentsNotTaken.jsp is:"+e);
	}	
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Student Name</title>
<SCRIPT LANGUAGE="JavaScript">

function go(start,totrecords,cat)
{		
	location.href="StudentsNotTaken.jsp?cat="+cat+"&workid=<%=workId%>&totrecords="+totrecords+"&start="+start;
	return false;
}

function gotopage(totrecords,cat)
{
	var page=document.studentslist.page.value;
	if(page==0)
	{
		return false;
	}
	else
	{
		start=(page-1)*<%=pageSize%>;
		location.href="StudentsNotTaken.jsp?workid=<%=workId%>&start="+start+"&totrecords="+totrecords+"&cat="+cat;	
		return false;
	}
}

function submitScore(wid,sid)
{		
	if(confirm("Are you sure that you want to award points for an assignment which is not submitted by the student?"))
	{
		location.href="TakeAssignment.jsp?workid="+wid+"&studentid="+sid;
		return false;
	}
}
</script>
<link href="admcss.css" rel="stylesheet" type="text/css" />
</head>

<body > 
<form name="studentslist">

<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor1.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>

<hr>

<table border="0" cellpadding="0" cellspacing="0"  width="100%" height="25">
  <tr>
    <td class="gridhdr">&nbsp;Assignment Name :</td>
    <td class="gridhdr">&nbsp;<%=docName%></td>
  </tr>
</table>
<%

if(totrecords!=0)
{
%>
<table border="0" cellpadding="0" cellspacing="0" bordercolor="white" width="100%">
<tr>
	<td width="33%" align="left">
		<font size="2" color="#000080" face="verdana">Students <%= (start+1) %> - <%= end %> of <%=totrecords%>
	</td>
	<td width="34%" align="center">
		<font color="#000080" size="2" face="verdana">
<%
	if(start==0 ) 
	{ 
		if(totrecords>end)
		{
			out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"','"+cat+"');return false;\"> Next</a>&nbsp;&nbsp;");
		}
		else
			out.println("Previous | Next &nbsp;&nbsp;");
	}
	else
	{
		linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totrecords+"','"+cat+"');return false;\">Previous</a> |";
		
		if(totrecords!=end)
		{
			linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"','"+cat+"');return false;\"> Next</a>&nbsp;&nbsp;";
		}
		else
			linkStr=linkStr+" Next&nbsp;&nbsp;";
		out.println(linkStr);
	}	
%>
	  </font></td>
	  <td width="33%" align="right">
		<font color="#000080" size="2" face="verdana">Goto Page&nbsp;		
<%
		int index=1;
	    int str=0;
	    int noOfPages=0;
		if((totrecords%pageSize)>0)
		    noOfPages=(totrecords/pageSize)+1;
		else
			noOfPages=totrecords/pageSize;
	
		out.println("<select name='page' onchange=\"gotopage('"+totrecords+"','"+cat+"');return false;\"> ");
		while(index<=noOfPages)
		{
			
			if(index==currentPage)
			{
				out.println("<option value='"+index+"' selected>"+index+"</option>");
			}
			else
			{
				out.println("<option value='"+index+"'>"+index+"</option>");
			}
			index++;
			str+=pageSize;
		}
%>
		</select>
		</font>
	  </td>
  </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" bordercolor="white" width="100%" >
  <tr>
    <td class="gridhdr">&nbsp;</td>
    <td class="gridhdr">Student Name</td>
    <td class="gridhdr">Student ID</td>
    <td class="gridhdr">&nbsp;</td>
  </tr>
<%
}
	if (totrecords<=0) 
	{
%>
		<tr>
			<td width="2%" align="left"  colspan="4">
			<font face="Verdana" size="2" color="#003399">&nbsp;There are no students available.</font></td>
		</tr>
<%
		return;
	}	
%>
<%
	try
	{
		while(rs.next())
		{
			studentId=rs.getString("student_id");

			rs1=st1.executeQuery("select fname,lname,emailid from studentprofile where emailid='"+studentId+"' and schoolid='"+schoolId+"'");

			if(rs1.next()) 
			{
				fName=rs1.getString("fname");
				lName=rs1.getString("lname");
				emailId=rs1.getString("emailid");
			}
%>

  <tr>
    <td class="griditem">
		<a href="#" onClick="submitScore('<%=workId%>','<%=emailId%>');return false;">
			<img src="../images/ieval.gif"  border="0" TITLE="Submit points">
		</a>
	</td>
    <td class="griditem"><%=fName+" "+lName%></td>
    <td class="griditem"><%=emailId%></td>
    <td class="griditem">&nbsp;</td>
  </tr>
<%          
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("StudentsNotTaken.jsp","operations on database","Exception",e.getMessage());
		System.out.println("Exception in StudentsNotTaken.jsp is...."+e);
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
			ExceptionsFile.postException("StudentsNotTaken.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("The error in StudentsNotTaken.jsp is..."+se.getMessage());
		}
    }
%> 

</table>
</form>
</body>
</html>
