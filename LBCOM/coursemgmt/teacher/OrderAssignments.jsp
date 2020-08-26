<%@page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=500;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	 
    int totRecords=0,start=0,end=0,c=0,stuStatus=0,tot=0;
	int i=0;

	String linkStr="",sortStr="",sortingBy="",sortingType="";

	String sessid="",cat="",courseId="",schoolId="",teacherId="",courseName="",classId="",workId="",status="",slNo="";
	int currentPage=0,maxValue=0,minValue=0;
%>
<%
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	con=con1.getConnection();
	
	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");
	courseName=(String)session.getAttribute("coursename");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");		

	start=Integer.parseInt(request.getParameter("start"));
	//totRecords=Integer.parseInt(request.getParameter("totrecords"));

	c=start+pageSize;
	end=start+pageSize;
	
	currentPage=(start/pageSize)+1;

	try
	{
		st1=con.createStatement();
		st2=con.createStatement();

		rs1=st1.executeQuery("select max(slno) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where status < 2");
		if(rs1.next())
		{
			maxValue=Integer.parseInt(rs1.getString(1));
		}

		rs1=st1.executeQuery("select min(slno) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where status < 2");
		if(rs1.next())
		{
			minValue=Integer.parseInt(rs1.getString(1));
		}

		rs1=st1.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and status < 2");
		if(rs1.next())
		{
			totRecords=Integer.parseInt(rs1.getString(1));
		}

		if (c>=totRecords)
			end=totRecords;

		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

		rs=st.executeQuery("select slno,work_id,doc_name,category_id,to_date from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and status < 2 order by slno LIMIT "+start+","+pageSize);
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("OrderAssignments.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
		System.out.println("Exception in OrderAssignments.jsp is...."+e);
	}	
	catch(Exception e)
	{
		System.out.println("Exception in OrderAssignments.jsp is...."+e);
		ExceptionsFile.postException("OrderAssignments.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	}	
%>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<link href="admcss.css" rel="stylesheet" type="text/css" />
<title>New Page 1</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function go(start,totrecords)
{	
	location.href="OrderAssignments.jsp?start="+start+ "&totrecords="+totrecords;
	return false;
}

function gotopage(totrecords)
{
	var page=document.ordering.page.value;
	if(page==0)
	{
		return false;
	}
	else
	{
		start=(page-1)*<%=pageSize%>;
		location.href="OrderAssignments.jsp?start="+start+"&totrecords="+totrecords;	
		return false;
	}
}

function moveUp(slno,wid)
{
	var page=document.ordering.page.value;
	start=(page-1)*<%=pageSize%>;
	if(slno==<%=minValue%>)
	{
		alert("You cannot move this further up!!!");
		return false;
	}
	else
	{
		parent.main.location.href="ChangeOrder.jsp?slno="+slno+"&workid="+wid+"&move=up&start="+start;
	}
}

function moveDown(slno,wid)
{
	var page=document.ordering.page.value;
	start=(page-1)*<%=pageSize%>;
	if(slno==<%=maxValue%>)
	{
		alert("You cannot move this further down!!!");
		return false;
	}
	else
	{
		parent.main.location.href="ChangeOrder.jsp?slno="+slno+"&workid="+wid+"&move=down&start="+start;
	}
}
function validate(a,b)
{
	//b=document.ordering.ovalue2.value;
	alert(a);
	alert(b);
	parent.main.location.href="/LBCOM/coursemgmt/teacher/OrderAssignments2.jsp";
	
}
-->

</script>
</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor2.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
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
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#EBF3FB" width="100%" bgcolor="#C0C0C0">
<tr>
<td width="100%" height="24">&nbsp;</td>
</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="33%" align="left"><font size="2">
		Assignments <%=(start+1)%> - <%=end%> of <%=totRecords%>&nbsp;&nbsp;</font>
	</td>
	<td align="center" width="33%"><font size="2">
		
<%
		if(start==0 ) 
		{ 
			if(totRecords>end)
			{
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+"','"+totRecords+"');return false;\"> Next</a>&nbsp;&nbsp;");
			}
			else
				out.println("Previous | Next &nbsp;&nbsp;");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+"','"+totRecords+"');return false;\">Previous</a> |";
			
			if(totRecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+"','"+totRecords+"');return false;\"> Next</a>&nbsp;&nbsp;";
			}	
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);
		}	
%>
		</font>
	</td>
	<td align='right' width="33%"><font size="2">
		Goto Page&nbsp;
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
<table border="0" cellpadding="1" cellspacing="0" width="100%">
  <tr>
   <!--  <td width="3%" align="center" bgcolor="#C0C0C0">
		<IMG SRC="images/up_arrow.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Move Up" align="middle">
	</td>
    <td width="3%" align="center" bgcolor="#C0C0C0">
		<IMG SRC="images/down_arrow.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Move Down" align="middle">
	</td>-->
	<td class="gridhdr">
		<!-- <IMG SRC="images/down_arrow.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Move Down" align="middle"> -->
	</td> 
    <td class="gridhdr">
   &nbsp;&nbsp;Assignment Name</td>
	<td class="gridhdr">
		<!-- <IMG SRC="images/down_arrow.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Move Down" align="middle"> -->
	</td>
	<td class="gridhdr">
		<!-- <IMG SRC=">
		<!-- <IMG SRC="images/down_arrow.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Move Down" align="middle"> -->
	</td>
	
  </tr>
<%
		if(totRecords==0)
		{
%>
			<tr>
				<td width='100%'  colspan="3" height='21'>
					<font face='verdana' color='black' size='2'>There are no assignments available.</font>
				</td>
			</tr>
<%
		}		
%>
<%
	try
	{
		while(rs.next())
		{
			i++;
			slNo=rs.getString("slno");
			workId=rs.getString("work_id");
%>

  <form name="ordering<%=i%>" method="POST" action="OrderAssignments2.jsp">
  <tr>
   <!--  <td width="3%" align="center" bgcolor="#EEEEEE">
		<a href="#" onclick="return moveUp('<%=slNo%>','<%=workId%>');">
			<IMG SRC="images/up_arrow.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Move Up" align="middle">
		</a>
	</td>
    <td width="3%" align="center" bgcolor="#EEEEEE">
		<a href="#" onclick="return moveDown('<%=slNo%>','<%=workId%>');">
			<IMG SRC="images/down_arrow.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Move Down" align="middle">
		</a>
	</td> -->
     <td class="griditem">&nbsp;<%=i%></strong></td>
	 <td class="griditem">&nbsp;<%=rs.getString("doc_name")%></td>
	<td class="griditem"><select name="cnt"><option value="">Select</option>
	<%
	  int x=0;
	  rs2=st2.executeQuery("select slno from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and status<2 order by slno");
		while(rs2.next())
		{
			x++;
%>			<option value="<%=rs2.getString("slno")%>"><%=x%></option>
<%		}
%>
	</select>

	</td>
	<input type="hidden" value="<%=slNo%>" name="ovalue2" WIDTH="4">
	<input type="hidden" value="<%=workId%>" name="workid" WIDTH="4">
	<input type="hidden" value="<%=rs.getString("doc_name")%>" name="docname" WIDTH="4">
	<td class="griditem"><input type="submit" value="Update" name="sb" WIDTH="4"></td>
  </tr>
  </form>
<%
		}
	}
	catch(Exception e)
	{
		System.out.println("OrderAssignments.jsp operations on database Exception"+e.getMessage());
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
			ExceptionsFile.postException("OrderAssignments.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}
%>  	

</table>


</body>

</html>