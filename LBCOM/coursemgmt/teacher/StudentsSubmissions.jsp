<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=100;
%>
<%
      Connection con=null;
      Statement st=null,st1=null,st2=null;
      ResultSet rs=null,rs1=null,rs2=null;
      
      String studentId="",teacherId="",schoolId="",workFile="",workId="",cat="",courseName="";
	  String linkStr="",courseId="",docName="",fName="",lName="",emailId="",classId="",remarks="",submsnType="";
	  int totRecords=0,start=0,end=0,c=0,status=0,count=0,alltotRecords=0;
	  int currentPage=0;
	  float maxMarks=0.0f;
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
		submsnType=request.getParameter("submsntype"); //Submission type
		maxMarks=Float.parseFloat(request.getParameter("maxmarks"));
		totRecords=Integer.parseInt(request.getParameter("totrecords"));
		alltotRecords=Integer.parseInt(request.getParameter("alltotrecords"));		
%>
<%
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

		if(submsnType == null)
			submsnType="all";
			
		if(submsnType.equals("all"))
		{
			//rs=st.executeQuery("select student_id,status,submitted_date,submit_count,marks_secured,comments,work_file,remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2 order by status,eval_date Asc LIMIT "+start+","+pageSize);
			
			//rs=st.executeQuery("select distinct d.student_id,d.work_id,d.start_date,d.end_date,d.status,d.submitted_date,d.submit_count,d.eval_date,d.marks_secured,d.stuattachments,d.answerscript,d.remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid and d.status!=5 and s.status=1 where d.work_id='"+workId+"' and d.status >= 2 order by s.fname,s.lname,d.status,d.eval_date Asc LIMIT "+start+","+pageSize);


				// above one commented and added on Apr 19, 2013  -- Santhosh

			rs=st.executeQuery("select distinct d.student_id,d.work_id,d.start_date,d.end_date,d.status,d.submitted_date,d.submit_count,d.eval_date,d.marks_secured,d.stuattachments,d.answerscript,d.remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid and d.status!=5 where d.work_id='"+workId+"' and d.status >= 2 and s.status=1 order by s.fname,s.lname,d.status,d.eval_date Asc LIMIT "+start+","+pageSize);
			
			totRecords=alltotRecords;		
			
		}
		else if(submsnType.equals("pending"))
		{
			//rs=st.executeQuery("select student_id,status,submitted_date,submit_count,marks_secured,comments,work_file,remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2 and status < 4 order by status,eval_date Asc LIMIT "+start+","+pageSize);
			
			//rs=st.executeQuery("select distinct d.student_id,d.work_id,d.start_date,d.end_date,d.status,d.submitted_date,d.submit_count,d.eval_date,d.marks_secured,d.stuattachments,d.answerscript,d.remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid and d.status!=5 where d.work_id='"+workId+"' and d.status >= 2 and d.status < 4 order by s.fname,s.lname,d.status,d.eval_date Asc LIMIT "+start+","+pageSize);

			// above one commented and added on Apr 19, 2013  -- Santhosh

			rs=st.executeQuery("select distinct d.student_id,d.work_id,d.start_date,d.end_date,d.status,d.submitted_date,d.submit_count,d.eval_date,d.marks_secured,d.stuattachments,d.answerscript,d.remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid and d.status!=5 where d.work_id='"+workId+"' and d.status >= 2 and d.status < 4 and s.status=1 order by s.fname,s.lname,d.status,d.eval_date Asc LIMIT "+start+","+pageSize);
			
			int pending=0;
			//rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2 and status < 4");

			rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid where work_id='"+workId+"' and d.status >= 2 and d.status < 4 and s.staus=1");
				if (rs1.next())
					pending=rs1.getInt(1);
			totRecords=pending;
		}
		else if(submsnType.equals("evaluated"))
		{
			//rs=st.executeQuery("select student_id,status,submitted_date,submit_count,marks_secured,comments,work_file,remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 4 order by status,eval_date Asc LIMIT "+start+","+pageSize);

			//rs=st.executeQuery("select distinct d.student_id,d.work_id,d.start_date,d.end_date,d.status,d.submitted_date,d.submit_count,d.eval_date,d.marks_secured,d.stuattachments,d.answerscript,d.remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid and d.status!=5 where d.work_id='"+workId+"' and d.status >= 4 order by s.fname,s.lname,d.status,d.eval_date Asc LIMIT "+start+","+pageSize);

			// above one commented and added on Apr 19, 2013  -- Santhosh

			rs=st.executeQuery("select distinct d.student_id,d.work_id,d.start_date,d.end_date,d.status,d.submitted_date,d.submit_count,d.eval_date,d.marks_secured,d.stuattachments,d.answerscript,d.remarks from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid and d.status!=5 where d.work_id='"+workId+"' and d.status >= 4 and s.status=1 order by s.fname,s.lname,d.status,d.eval_date Asc LIMIT "+start+","+pageSize);

			int eval=0;
			//rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 4");

			rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox d inner join studentprofile s on d.student_id=s.emailid where work_id='"+workId+"' and d.status >= 2 and d.status < 4 and s.staus=1");
				if (rs1.next())
					eval=rs1.getInt(1);
			totRecords=eval;
		}
		start=Integer.parseInt(request.getParameter("start"));
		c=start+pageSize;
		end=start+pageSize;
		if(c>=totRecords)
			end=totRecords;
		currentPage=(start/pageSize)+1;
	}
	catch(SQLException e) 
	{
		ExceptionsFile.postException("StudentsSubmissions.jsp","Operations on database and reading parameters","SQLException",e.getMessage());
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
			ExceptionsFile.postException("StudentsSubmissions.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in StudentSubmissions.jsp is.."+se.getMessage());
		}	
	}	
	catch(Exception e) 
	{
		ExceptionsFile.postException("StudentsSubmissions.jsp","Operations on database and reading parameters","Exception",e.getMessage());
		System.out.println("The Error in StudentsSubmissions.jsp is:"+e);
	}	
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Student Name</title>
<script>

function go(s,tot)
{
	var start=s; 
	var totalrecords=tot;	
	
	document.location.href="StudentsSubmissions.jsp?submsntype=<%=submsnType%>&cat=<%=cat%>&workid=<%=workId%>&totrecords="+totalrecords+"&start="+start+"&maxmarks=<%=maxMarks%>&alltotrecords=<%=alltotRecords%>";
		
}
function gotopage(totrecords)
{
	var page=document.submissions.page.value;
	
	if(page==0)
	{
		return false;
	}
	else
	{
		start=(page-1)*<%=pageSize%>;
		
	 document.location.href="StudentsSubmissions.jsp?submsntype=<%=submsnType%>&cat=<%=cat%>&workid=<%=workId%>&totrecords="+totrecords+"&start="+start+"&maxmarks=<%=maxMarks%>&alltotrecords=<%=alltotRecords%>";
		return false;
	}
}


function goSubmissionType()
{
	var stype=document.submissions.submntype.value;
	parent.main.location.href="StudentsSubmissions.jsp?submsntype="+stype+"&cat=<%=cat%>&workid=<%=workId%>&totrecords=<%=totRecords%>&start=0&maxmarks=<%=maxMarks%>&alltotrecords=<%=alltotRecords%>";
	return false;
}
</script>
</head>

<body bgcolor="#EBF3FB"> 
<form name="submissions">

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
<table border="1" cellpadding="0" cellspacing="0" bordercolor="white" width="100%" bgcolor="#C0C0C0">
<tr>
	<td width="50%">
		<b><font face="Verdana" size="2" color="#003399">&nbsp;Assignment Name :&nbsp;</font></b>
		<font face="Verdana" size="2" color="black"><%=docName%></font>
	</td>
	<td width="50%" align="right">
		<font face="Verdana" size="2">
			<select size="1" name="submntype" onchange="goSubmissionType(); return false;">
				<option value="pending" selected>Submissions Pending for Evaluation</option>
			    <option value="evaluated">Evaluated Submissions</option>
			    <option value="all">All Submissions</option>
		    </select>
		</font>
	</td>
</tr>
</table>
<script>
	document.submissions.submntype.value="<%=submsnType%>";
</script>
<%
if(totRecords!=0)
{
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="33%" align="left">
		<font size="2" face="verdana" >Students <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</font>
	</td>
	<td align="center" width="34%">
		<font color="#000080" face="verdana" size="2">
<%
		if(start==0 ) 
		{ 
			if(totRecords>end)
			{
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"');return false;\"> Next</a>&nbsp;&nbsp;");
			}
			else
				out.println("Previous | Next &nbsp;&nbsp;");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"');return false;\">Previous</a> |";
			
			if(totRecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"');return false;\"> Next</a>&nbsp;&nbsp;";
			}	
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);
		}	
%>
		</font>
	</td>
	<td align='right' width="33%">
		<font face="verdana" size="2">Goto Page&nbsp;
<%
		int index=1;
	    int str=0;
	    int noOfPages=0;
		if((totRecords%pageSize)>0)
		    noOfPages=(totRecords/pageSize)+1;
		else
			noOfPages=totRecords/pageSize;
	
		out.println("<select name='page' onchange=\"gotopage('"+totRecords+"');return false;\"> ");
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

<table border="1" cellpadding="0" cellspacing="0" bordercolor="white" width="100%">
  <tr>
    <td width="3%" align="center" bgcolor="#C0C0C0">&nbsp;</td>
    <td width="37%" align="center" bgcolor="#C0C0C0"><b>
    <font face="Verdana" size="2" color="#003399">Student Name</font></b></td>
    <td width="25%" align="center" bgcolor="#C0C0C0"><b>
    <font face="Verdana" size="2" color="#003399">Student ID</font></b></td>
    <td width="15%" align="center" bgcolor="#C0C0C0"><b>
    <font face="Verdana" size="2" color="#003399">Submitted On</font></b></td>
    <td width="20%" align="center" bgcolor="#C0C0C0"><b>
    <font face="Verdana" size="2" color="#003399">Submission Number</font></b></td>
  </tr>
<%
}
	try
	{
		int x=0;
		while(rs.next())
		{
			
			workFile=rs.getString("answerscript");
			studentId=rs.getString("student_id");
			status=rs.getInt("status");
			remarks=rs.getString("remarks");
			count=rs.getInt("submit_count");
			String evalStatusStr="";
			x=x+1;
			if(submsnType.equals("all"))
			{
				if(status>=4)
				{
					evalStatusStr="<font size='1' face='verdana' color='green'>(Already Evaluated)</font>";
				}
				else
				{
					evalStatusStr="<font size='1' face='verdana' color='red'>(Pending for Evaluation)</font>";
				}
			}
			
			rs1=st1.executeQuery("select fname,lname,emailid from studentprofile where emailid='"+studentId+"' and schoolid='"+schoolId+"' order by fname,lname");
			
			if(rs1.next()) 
			{
				fName=rs1.getString("fname");
				lName=rs1.getString("lname");
				emailId=rs1.getString("emailid");
			}
			String filePath="../../hsndata/data/schools/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+cat+"/"+workFile;
%>
  <tr>
    <td width="3%" align="center">
		<a href="Evaluator.jsp?workid=<%=workId%>&cat=<%=cat%>&totrecords=<%=totRecords%>&status=<%=status%>&studentid=<%=studentId%>&maxmarks=<%=maxMarks%>&marks=<%=rs.getString("marks_secured")%>&comments=<%=rs.getString("stuattachments")%>&remarks=<%=remarks%>&submitdate=<%=rs.getDate("submitted_date")%>&count=<%=count%>&submsntype=<%=submsnType%>&alltotrecords=<%=alltotRecords%>">
		<img border="0" src="../images/ieval.gif" TITLE="Evaluate Submission"></a>
	</td>
    <td width="37%"><font face="Verdana" size="2"><%=fName+" "+lName%></font></td>
    <td width="25%"><font face="Verdana" size="2"><%=emailId%></font></td>
    <td width="15%" align="center"><font face="Verdana" size="2"><%=rs.getDate("submitted_date")%></font></td>
    <td width="20%" align="center"><font face="Verdana" size="2"><%=count%></font>&nbsp;<%=evalStatusStr%></td>
  </tr>
<%          
		}
	
		if(x==0)
		{
%>
			<tr>
				<td width="100%" colspan="5" align="left" bgcolor="white">
					<font face="verdana" size="2">There are no submissions pending for evaluation.</font>
				</td>
			</tr>
<%
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("StudentsSubmissions.jsp","operations on database","Exception",e.getMessage());
		System.out.println("Exception in StudentsSubmissions.jsp is..."+e);
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
			ExceptionsFile.postException("StudentsSubmissions.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in StudentsSubmissions.jsp is..."+se.getMessage());
		}

    }

%> 
  </table>

</form>
</body>

</html>