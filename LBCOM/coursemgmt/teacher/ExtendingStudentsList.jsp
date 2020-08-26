<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=250;
%>
<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
    	int totRecords=0,start=0,end=0,c=0,pages=0,pageNo=0,asgnCount=0;

	String teacherId="",classId="",schoolId="",argSelIds="",studentId="",str_pageNo="",argUnSelIds="",workId="",linkStr="";
	String stuTableName="",teachTableName="",tag="",examType="",validity="",startDate="",dueDate="",docName="";
	Hashtable hsSelIds=null;	
	String typeWise="",randomWise="",versions="",quesList="",createDate="",courseId="",enableMode="",exmTbl="",exmInsTbl;
	Hashtable subsections=null;
	String subsectionId="";
	String query="";
	String flag="",sFlag="";
	int currentPage=0;

	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		con=con1.getConnection();
			
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");

		workId=request.getParameter("workid");
		docName=request.getParameter("docname");

		if(request.getParameter("totrecords").equals(""))
		{ 
			st=con.createStatement();

			rs=st.executeQuery("select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"'");

			rs.next();
			c=rs.getInt(1);
			totRecords=c;
		}
		else
			totRecords=Integer.parseInt(request.getParameter("totrecords"));

		start=Integer.parseInt(request.getParameter("start"));
		c=start+pageSize;
		end=start+pageSize;
		
		if(c>=totRecords)
			end=totRecords;
		currentPage=(start/pageSize)+1;
	}
	catch(SQLException se)
	{
		System.out.println("The exception in ExtendingStudentsList.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ExtendingStudentsList.jsp is....."+e);
	}	
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Assignment Editor</title>


<SCRIPT LANGUAGE="JavaScript">
var studentids=new Array();
	
function validate()
{	
	var obj=document.studentslist;
	var flag=false;
	var stdCount=0;

	for(i=0;i<obj.elements.length;i++)
	{
		if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="selids" && obj.elements[i].checked==true)
		{
			studentids[i]=obj.elements[i].value;
			stdCount=stdCount+1;
		}
	}
	if(stdCount < 1)
	{
		alert("You have to select atleast one student to assign any assignment!!!");
		return false;
	}
	else
	{
		window.location.href="SetExtensionDate.jsp?workid=<%=workId%>&studentids="+studentids;
		return true;
	}
}

function selectAll()
{
	var obj=document.studentslist.selids;
	if(document.studentslist.selectall.checked==true)
	{
		for(var i=0;i<obj.length;i++)
		{
			obj[i].checked=true;
		}
	}
	else
	{
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].value != "<%=classId%>_vstudent")
				obj[i].checked=false;
		}
	}
}

function goNextPrev(s,tot)
{
	var start=s;  
    var totalrecords=tot;		document.location.href="ExtendingStudentsList.jsp?workid=<%=workId%>&start="+start+"&totrecords="+totalrecords+"&docname=<%=docName%>";
}

function gotopage(totrecords,docname)
{
	var page=document.studentslist.page.value;
	if(page==0)
	{
		return false;
	}
	else
	{
		start=(page-1)*<%=pageSize%>;
		document.location.href="ExtendingStudentsList.jsp?workid=<%=workId%>&docname=<%=docName%>&start="+start+"&totrecords="+totrecords;
		return false;
	}
}

function showAssignments(sid)
{
	window.open("ShowAssignmentsList.jsp?studentid="+sid,"Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
}
</SCRIPT>
</head>

<body bgcolor="#EBF3FB"> 
<form name="studentslist" method="post">
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
			<IMG SRC="images/asgn_distributor2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>
<hr>
<%
		if(totRecords != 0)
		{
%>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="white" width="100%" bgcolor="#EBF3FB">
<tr>
	<td width="100%" height="24" align="left">
		<input type="image" src="images/extendvalidity.png" onclick="validate(); return false;"><font face="verdana" size="2" color="#003399"><B><!-- <%=docName%> --></B></font>
	</td>
</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td width="33%">
		<font face="Verdana" size="2" color="#000080">Students <%=(start+1)%> - <%=end%> of <%=totRecords%></font>
	</td>
    <td width="34%" align="center">
		<font color="#000080" face="verdana" size="2">
<%
		if(start==0 )
		{ 
			if(totRecords>end)
			{
				out.println("Previous | <a href=\"#\" onclick=\"goNextPrev("+(start+pageSize)+","+totRecords+")\"> Next</a>&nbsp;");
			}
			else
				out.println("Previous | Next ");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=\"goNextPrev("+(start-pageSize)+","+totRecords+")\">Previous</a> |";
			if(totRecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick=\"goNextPrev("+(start+pageSize)+","+totRecords+")\"> Next</a>";
			}
			else
				linkStr=linkStr+" Next";
			out.println(linkStr);
		}	
	
%>
		</font>
	</td>
	<td align='right' width="33%">
		<font color="#000080" face="verdana" size="2">Goto Page&nbsp;
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
	<td width="1%" bgcolor="#C0C0C0" height="21">
		<input type="checkbox" name="selectall" onclick="javascript:selectAll()" title="Select or deselect all students">
	</td>
	<td width="35%" bgcolor="#C0C0C0" height="21"><b>
		<font face="Verdana" size="2" color="#003399">&nbsp;Student Name</font></b>
	</td>
	<td width="34%" bgcolor="#C0C0C0" height="21"><b>
		<font face="Verdana" size="2" color="#003399">&nbsp;Student ID</font></b>
	</td>
	<td width="15%" bgcolor="#C0C0C0" height="21" align="center"><b>
		<font face="Verdana" size="2" color="#003399">Start Date</font></b>
	</td>
	<td width="15%" bgcolor="#C0C0C0" height="21" align="center"><b>
		<font face="Verdana" size="2" color="#003399">Due Date</font></b>
	</td>
</tr>
<%
		}
		if(totRecords == 0)
		{
%>
			<tr>
				<td width="100%" colspan="5"  bgcolor="#EFEFEF" height="21">
					<font face="Verdana" size="2">This particular assignment has not been assigned to any student so far.</font>
				</td>
			</tr>
			</table>
<%
			return;
		}	
%>
<%
		try
		{
			st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);	
			st1=con.createStatement();

			rs=st.executeQuery("select distinct(student_id),start_date,end_date from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' order by student_id LIMIT "+start+","+pageSize);

			while(rs.next())
			{		
				out.println("<tr>");
 				studentId=rs.getString("student_id");
				startDate=rs.getString("start_date");
				dueDate=rs.getString("end_date");
			
				rs1=st1.executeQuery("select fname,lname from studentprofile where schoolid='"+schoolId+"' and username='"+studentId+"' order by fname,lname");
				if(rs1.next())
				{
%>
				<td width="1%" height="18" bgcolor="#EFEFEF">
					<font size="2" face="Arial"><input  type="checkbox" name="selids" value="<%=studentId%>"></font>
				</td>
				<td width="35%" height="20" bgcolor="#EFEFEF">
					<font face="Verdana" size="2" color="#003366">&nbsp;<%=rs1.getString("fname")+" "+ rs1.getString("lname")%></font>
				</td>
				<td width="34%" height="20" bgcolor="#EFEFEF">
					<font face="Verdana" size="2" color="#003366">&nbsp;<%=studentId%></font>
				</td>
				<td width="15%" height="21" align="center" bgcolor="#EFEFEF">
					<font face="Verdana" size="2" color="#003366"><%=startDate%></font></td>
				<td width="15%" height="21" align="center" bgcolor="#EFEFEF">
					<font face="Verdana" size="2" color="#003366"><%=dueDate%></font></td>
			</tr>
<%          
				}
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ExtendingStudentsList.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Exception in the try block of ExtendingStudentsList.jsp is...."+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("ExtendingStudentsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println("Exception in ExtendingStudentsList.jsppp iss..."+se.getMessage());
			}
		}
%>  
<tr>
	<td colspan=8 align="left">&nbsp;</td>
</tr>
<tr>
	<td colspan=8 align="left"><input type="image" src="images/extendvalidity.png" onclick="validate(); return false;"><font face="verdana" size="2" color="#003399"><B><!-- <%=docName%> --></B></font></td>
</tr>
</table>
</form>
</body>
</html>
