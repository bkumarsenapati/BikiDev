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

	String sessid="",cat="",courseId="",courseName="",workId="",status="";
	int currentPage=0,maxValue=0,minValue=0,slNo=1,oslNo=1;

	String examName="",queryString="",developerId="",tblName="";
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
		
	courseName=request.getParameter("cname");
	developerId=request.getParameter("uid");
	courseId=request.getParameter("courseid");
	tblName=request.getParameter("tname");
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
		
		rs1=st1.executeQuery("select count(*) from "+tblName+" where course_id='"+courseId+"'");
		if(rs1.next())
		{
			totRecords=Integer.parseInt(rs1.getString(1));
		}

		if (c>=totRecords)
			end=totRecords;

		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

		rs=st.executeQuery("select slno,assgn_no,assgn_name  from "+tblName+"  where  course_id='"+courseId+"' order by slno  LIMIT "+start+","+pageSize);
		
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
<title>OrderAssignments</title>
<SCRIPT LANGUAGE="JavaScript">
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
function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}

</script>
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" /> 
</head>

<body  >
<table width="100%"  cellpadding="0" cellspacing="0"  >

<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="368" height="70">
		<img src="images/logo.png" width="368" height="101" border="0">
	</td>
    <td> <a href="#" onClick="viewUserManual();return false;"><img src="images/helpmanaual.png" border="0" style="margin-left:320px;"></a></td>
    <td width="423" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="208" height="70" border="0">
    </td>
</tr></table>
    </div>
	</td>
</tr>
<tr>
	
	<td width="100%" height="495" colspan="3" background="images/bg2.gif" align="center" valign="top">
		
		<div align="center"> 



<table width="90%"  cellspacing="0" cellpadding="0">
<tr>
<td width="40%" align="left" height="20" class="gridhdrNew"><font >&nbsp;<b><%=courseName%></b></font></td>
<td width="80%" align="right" height="20" class="gridhdrNew"><a href="ViewAssignInfo.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>"><font color="blue">&lt;&lt; Back To Manage Assignments&nbsp;</font></a></td>
</tr>
</table>
<table width="90%"  cellspacing="0" cellpadding="0">
<hr>
<tr>
	<td width="33%" align="left" class="gridhdrNew1">
		<font size="2" face="verdana" >Assessments <%=(start+1)%> - <%=end%> of <%=totRecords%>&nbsp;&nbsp;</font>
	</td>
	<td align="center" width="33%" class="gridhdrNew1">
		<font color="#000080" face="verdana" size="2">
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
	<td align='right' width="33%" class="gridhdrNew1">
		<font face="verdana" size="2" color="#000080">Goto Page&nbsp;
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
<table cellpadding="1" cellspacing="0"  width="90%" >
  <tr>
  	<td width="1%" align="center" class="gridhdrNew1">&nbsp;</td> 
    <td width="94%" class="gridhdrNew1"><b>
    <font face="Verdana" size="2" class="gridhdrNew1">&nbsp;&nbsp;Assessment Name</font></b></td>
	<td width="3%" align="center" class="gridhdrNew1">&nbsp;</td>
	<td width="94%" align="center" class="gridhdrNew1">&nbsp;</td>
	
  </tr>
<%
		if(totRecords==0)
		{
%>
			<tr>
				<td width='100%' class="gridhdrNew1" colspan="3" height='21'>
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
			workId=rs.getString("assgn_no");
			examName=rs.getString("assgn_name");
			examName=examName.replaceAll("\"","&#34;");
			examName=examName.replaceAll("\'","&#39;");
			

%>  
  <form name="ordering<%=i%>" method="POST" action="OrderAssignments2.jsp?courseid=<%=courseId%>&cname=<%=courseName%>&uid=<%=developerId%>&tname=<%=tblName%>">
  <tr class="gridhdrNew1" onMouseover="bgColor='#cccccc'" onMouseOut="bgColor='#EEEEEE'">
     <td width="3%" class="gridhdrNew1"><font face="Verdana" size="2" ><strong>&nbsp;<%=i%></strong></font></td>
	 <td width="91%" class="gridhdrNew1"><font face="Verdana" size="2">&nbsp;<%=examName%></font></td>
	<td width="94%" class="gridhdrNew1"><select name="cv"><option value="">Select</option>
	<%
	  int x=0;

	  rs2=st2.executeQuery("select slno from "+tblName+" where course_id='"+courseId+"' order by slno");
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
	<td width="94%" class="gridhdrNew1"><input type="submit" value="Update" name="sb" WIDTH="4"></td>
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
			ExceptionsFile.postException("OrderAssignments.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}
%>  	

</table>


</body>

</html>