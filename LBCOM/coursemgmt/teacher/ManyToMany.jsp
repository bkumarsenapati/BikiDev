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
    	int totRecords=0,start=0,end=0,c=0,pages=0,pageNo=0,asgnCount=0,currentPage=0;
	String teacherId="",classId="",schoolId="",argSelIds="",studentId="",str_pageNo="",argUnSelIds="",workIds="",linkStr="";
	String stuTableName="",teachTableName="",tag="",examType="",validity="";
	Hashtable hsSelIds=null;	
	String typeWise="",randomWise="",versions="",quesList="",createDate="",courseId="",enableMode="",exmTbl="",exmInsTbl;
	Hashtable subsections=null;
	String subsectionId="";
	String query="";
	String flag="",sFlag="";

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

		workIds=request.getParameter("workids");
		validity=request.getParameter("validity");
		if(validity == null)
			validity="";

		sFlag=request.getParameter("sflag"); //students first flag

		if(sFlag == null)
			sFlag="slast";
				
		if(request.getParameter("totrecords").equals(""))
		{ 
			st=con.createStatement();
			rs=st.executeQuery("select count(*) from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.status=1");
			
			rs.next();
			c=rs.getInt(1);
			if(c!=0 )
			{			
				totRecords=c;
			}
			else
			{
				out.println("<html><head></head><body topmargin=2 leftmargin=2><table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' ><tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Student are not found. </font></b></td></tr></table></form></body></html>");	
				return;
			}
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
		System.out.println("The exception in ManyToMany.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in AsmtStudentList.jsp is....."+e);
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
		var sf='<%=sFlag%>';
		
		if(sf == 'sfirst')
		{
			window.location.href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=&sflag=sfirst&studentids="+studentids;
			return true;
		}
		else
		{
			if('<%=validity%>' == 'extend')  // This is used to extend the validity of the assignments bulkly.
			{
				window.location.href="SetExtensionDate.jsp?workids=<%=workIds%>&studentids="+studentids;
				return true;
			}
			else
			{
				window.location.href="SelectDates.jsp?workids=<%=workIds%>&studentids="+studentids;
				return true;
			}
		}
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
    var totalrecords=tot;
	document.location.href="ManyToMany.jsp?workids=<%=workIds%>&start="+start+"&totrecords="+totalrecords;
}

function gotopage(totrecords)
{
	var page=document.studentslist.page.value;
	if(page==0)
	{
		return false;
	}
	else
	{
		start=(page-1)*<%=pageSize%>;
		parent.main.location.href="ManyToMany.jsp?workids=<%=workIds%>&start="+start+"&totrecords="+totrecords;
		return false;
	}
}

function showAssignments(sid)
{
	window.open("ShowAssignmentsList.jsp?studentid="+sid,"Document","resizable=no,scrollbars=yes,width=550,height=400,toolbars=no");
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

<table border="1" cellpadding="0" cellspacing="0" bordercolor="white" width="100%" bgcolor="#EBF3FB">
<tr>
<td width="100%" height="24" align="left"><input type="image" src="images/distribute.png" onclick="validate(); return false;"></td>
</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" width="100%">
<tr>

	<td width="33%" align="left">
		<font face="Verdana" size="2" color="#000080">Students <%=(start+1)%> - <%=end%> of <%=totRecords%></font>
	</td>
    <td width="34%" align="center">
	<font face="Verdana" size="2" color="#000080">
<%
		if(start==0)
		{ 
			
			if(totRecords>end)
			{
				out.println("Previous | <a href=\"#\" onclick=\"goNextPrev("+(start+pageSize)+","+totRecords+");return false;\"> Next</a>&nbsp;");
			}
			else
				out.println("Previous | Next ");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=\"goNextPrev("+(start-pageSize)+","+totRecords+");return false;\">Previous</a> |";
			if(totRecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick=\"goNextPrev("+(start+pageSize)+","+totRecords+");return false;\"> Next</a>";
			}
			else
				linkStr=linkStr+" Next";
			out.println(linkStr);
		}	
%>
		</font>
	</td>
    <td align='right' width="33%">
		<font face="Verdana" size="2" color="#000080">Goto Page&nbsp;
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
	<td width="24%" bgcolor="#C0C0C0" height="21"><b>
		<font face="Verdana" size="2" color="#003399">&nbsp;Student Name</font></b>
	</td>
	<td width="40%" bgcolor="#C0C0C0" height="21"><b>
		<font face="Verdana" size="2" color="#003399">&nbsp;Student ID</font></b>
	</td>
	<td width="35%" bgcolor="#C0C0C0" height="21" align="center"><b>
		<font face="Verdana" size="2" color="#003399">No. of Assignments</font></b>
	</td>
</tr>

<%
		try
		{
			st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);	
			st1=con.createStatement();

			rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.status=1 order by s.subsection_id,fname,lname LIMIT "+start+","+pageSize);

			while(rs.next())
			{		
				out.println("<tr>");
 				studentId=rs.getString("emailid");

				rs1=st1.executeQuery("select count(distinct work_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where student_id='"+studentId+"' and status !=2");
				if (rs1.next())
					asgnCount=rs1.getInt(1);

%>
				<td bgcolor="#EEEEEE" width="1%" height="18"><input type="checkbox" name="selids" value="<%=studentId%>"></td>
				<td width="24%" height="20" bgcolor="#EEEEEE">
					<font face="Verdana" size="2" color="#003366"><%=rs.getString("fname")+" "+ rs.getString("lname")%></font>
				</td>
				<td width="40%" height="20" bgcolor="#EEEEEE">
					<font face="Verdana" size="2" color="#003366"><%=studentId%></font>
				</td>
				<td width="35%" height="20" align="center" bgcolor="#EEEEEE">
					<font size="2" face="verdana" color="#003366">
						<a href="#" onclick="showAssignments('<%=studentId%>');return false;"><u><%=asgnCount%></u></a>
					</font>
				</td>
			</tr>
<%          
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AsmtStudentList.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Exception in the try block is...."+e);
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
				ExceptionsFile.postException("AsmtStudentList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println("Exception in AsmtStudentList.jsppp iss..."+se.getMessage());
			}
		}
%>  
<tr>
	<td colspan=8 align="left">&nbsp;</td>
</tr>
<tr>
	<td colspan=8 align="left"><input type="image" src="images/distribute.png" onclick="validate(); return false;"></td>
</tr>
</table>
</form>
</body>
</html>
