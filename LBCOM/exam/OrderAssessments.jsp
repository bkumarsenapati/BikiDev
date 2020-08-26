<%@page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=500;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	 
    int totRecords=0,start=0,end=0,c=0,stuStatus=0,tot=0;
	int i=0,j;

	String linkStr="",sortStr="",sortingBy="",sortingType="";

	String sessid="",cat="",courseId="",schoolId="",teacherId="",courseName="",classId="",workId="",status="";
	int currentPage=0,maxValue=0,minValue=0,slNo=1,oslNo=1;

	String examName="",queryString="";
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
	int flag=0;
	start=Integer.parseInt(request.getParameter("start"));
	c=start+pageSize;
	end=start+pageSize;
	currentPage=(start/pageSize)+1;

	try
	{
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();

		rs1=st1.executeQuery("select count(*) from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"'");
		if(rs1.next())
		{
			totRecords=Integer.parseInt(rs1.getString(1));
		}

		if (c>=totRecords)
			end=totRecords;

		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

		rs=st.executeQuery("select slno,exam_id,exam_name  from exam_tbl  where  course_id='"+courseId+"' and  teacher_id='"+teacherId+"' and school_id='"+schoolId+"' order by slno  LIMIT "+start+","+pageSize);
		
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("OrderAssignments.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
		System.out.println("Exception in OrderAssignments.jsp is...."+e);
	}	
	catch(Exception e)
	{
		System.out.println("Exception in OrderAssessments.jsp is...."+e);
		ExceptionsFile.postException("OrderAssessments.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	}	
%>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link href="admcss.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>OrderAssessments</title>
<SCRIPT LANGUAGE="JavaScript">
function go(start,totrecords)
{	
	location.href="OrderAssessments.jsp?start="+start+ "&totrecords="+totrecords;
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
		location.href="OrderAssessments.jsp?start="+start+"&totrecords="+totrecords;	
		return false;
	}
}
</script>
</head>

<body>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<hr>
<tr>
	<td width="33%" align="left"><font size="2">
		Assessments <%=(start+1)%> - <%=end%> of <%=totRecords%>&nbsp;&nbsp;</font>
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
<table border="0" cellpadding="1" cellspacing="0" bordercolor="white" width="100%" >
  <tr>
  	<td class="gridhdr">&nbsp;</td> 
    <td class="gridhdr">
    &nbsp;&nbsp;Assessment Name</td>
	<td class="gridhdr">&nbsp;</td>
	<td class="gridhdr">&nbsp;</td>
	
  </tr>
<%
		if(totRecords==0)
		{
%>
			<tr>
				<td width='100%' colspan="3" height='21'>
					<font face='verdana' color='black' size='2'>There are no assessments available.</font>
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
			slNo=Integer.parseInt(rs.getString("slno"));
			workId=rs.getString("exam_id");
			examName=rs.getString("exam_name");
			examName=examName.replaceAll("\"","&#34;");
			examName=examName.replaceAll("\'","&#39;");
			

%>  
  <form name="ordering<%=i%>" method="POST" action="OrderAssessments2.jsp">
  <tr>
     <td class="griditem">&nbsp;<%=i%></td>
	 <td class="griditem">&nbsp;<%=examName%></td>
	<td class="griditem"><select name="cv"><option value="">Select</option>
	<%
	  int x=0;

	  rs2=st2.executeQuery("select slno from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"' and  teacher_id='"+teacherId+"' order by slno");
		while(rs2.next())
		{
			oslNo=Integer.parseInt(rs2.getString("slno"));
			x++;
%>			<option value="<%=oslNo%>"><%=x%></option>
<%		}
%>
	</select>

	</td>
	
	<input type="hidden" value="<%=slNo%>" name="av" WIDTH="4">
	<input type="hidden" value="<%=workId%>" name="workid" WIDTH="4">
	<input type="hidden" value="<%=examName%>" name="docname" WIDTH="4">
	<td class="griditem"><input type="submit" value="Update" name="sb" WIDTH="4"></td>
  </tr>
  </form>
<%
		}
	}
	catch(Exception e)
	{
		System.out.println("OrderAssessments.jsp operations on database Exception"+e.getMessage());
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
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("OrderAssessments.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}
%>  	

</table>


</body>

</html>