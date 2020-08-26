<%@page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=500;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	 
    int totRecords=0,start=0,end=0,c=0;
	int i=0;

	String linkStr="",sortStr="",sortingBy="",sortingType="";

	String sessid="";
	int currentPage=0,maxValue=0,minValue=0,slNo=1,oslNo=1,workId=0;

	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",currentSlide="",slideNo="";
	String schoolId="",schoolPath="",developerId="",slideName="",slideContent="";
	
%>
<%
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	currentSlide=request.getParameter("slideno");
	developerId=request.getParameter("userid");
	
	con=con1.getConnection();
	
	int flag=0;
	start=Integer.parseInt(request.getParameter("start"));
	c=start+pageSize;
	end=start+pageSize;
	currentPage=(start/pageSize)+1;

	try
	{
		st1=con.createStatement();
		st2=con.createStatement();
				
		rs1=st1.executeQuery("select count(*) from lbcms_dev_lesson_content_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slide_no");
		if(rs1.next())
		{
			totRecords=Integer.parseInt(rs1.getString(1));
		}

		if (c>=totRecords)
			end=totRecords;

		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

		rs=st.executeQuery("select *  from lbcms_dev_lesson_content_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slide_no  LIMIT "+start+","+pageSize);
		
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("OrderOfSlides.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
		System.out.println("Exception in OrderOfSlides.jsp is...."+e);
	}	
	catch(Exception e)
	{
		System.out.println("Exception in OrderOfSlides.jsp is...."+e);
		ExceptionsFile.postException("OrderOfSlides.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	}	
%>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Manage Slides</title>
<STYLE TYPE="text/css">
<!--
#dek {POSITION:absolute;VISIBILITY:hidden;Z-INDEX:200;}
//-->
</STYLE>
<style type="text/css">#div1 {position:absolute; top: 100; left: 200; width:200; visibility:hidden}</style>

<SCRIPT LANGUAGE="JavaScript">
function go(start,totrecords)
{	
	location.href="OrderOfSlides.jsp?start="+start+ "&totrecords="+totrecords;
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
		location.href="OrderOfSlides.jsp?start="+start+"&totrecords="+totrecords;	
		return false;
	}
}

function win()
{
	window.opener.location.href="01_01_02.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=1";
	self.close();

}
function toggleDiv(id,flagit) 
{
	if (flagit=="1")
	{
		if (document.layers) document.layers[''+id+''].visibility = "show"
		else if (document.all) document.all[''+id+''].style.visibility = "visible"
		else if (document.getElementById) document.getElementById(''+id+'').style.visibility = "visible"
	}
	else if (flagit=="0")
	{
		if (document.layers) document.layers[''+id+''].visibility = "hide"
		else if (document.all) document.all[''+id+''].style.visibility = "hidden"
		else if (document.getElementById) document.getElementById(''+id+'').style.visibility = "hidden"
	}
}

</script>
</head>

<body bgcolor="#EBF3FB">
<div>
            <script language="javascript" type="text/javascript"> 
            function toggleme(id){
                        var detail = document.getElementById(id);
                        if(detail.style.display == 'block'){
                                    detail.style.display='none';
                        }else{
                                    detail.style.display='block';
                        }           
            }
</script>



<table border="0" cellpadding="0" cellspacing="0" width="100%" background="images/CourseHome_01.gif">
<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="475" height="70">
		<img src="images/hscoursebuilder.gif" width="194" height="70" border="0">
	</td>
    <td width="493" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="296" height="70" border="0">
    </td>
</tr>
<tr>
	<!-- <td width="100%" height="28" colspan="3" background="images/TopStrip-bg.gif"> -->
	<td width="100%" height="28" colspan="3" bgcolor="#A53C00">
  <div align="right">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tr>
			<td width="90%" align="right"><p><a href="#" onclick="viewUserManual();return false;"><font color="white">User Manuals</font></a></p></td>
			<td>&nbsp;&nbsp;&nbsp;</td>
			<td width="10%" align="left"><a href="Logout.jsp"><font color="white">Logout</font></a></td>
		</tr>
		
		</table>
    </div>
	</td>
</tr>
<tr>
	
	<td width="100%" height="495" colspan="3" background="images/bg2.gif" align="center" valign="top">
		<p align="center">&nbsp;</p>
		<div align="center"> 


<table width="80%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="40%" align="left" height="20" bgcolor="#D7D7D7"><font color="#000080">&nbsp;<b><%=courseName%></b></font></td>
<td width="40%" align="right" height="20" bgcolor="#D7D7D7"><a href="01_01_02.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=1"><font color="blue">&lt;&lt; Back To Manage Slides&nbsp;</font></a></td>
</tr>
</table>
<table width="80%" border="0" cellspacing="0" cellpadding="0">
<hr>
<tr>
	<td width="33%" align="left">
		<font size="2" face="verdana" color="#000080"><%=courseName%>>><%=unitName%>>><%=lessonName%>>>Slides <%=(start+1)%> - <%=end%> of <%=totRecords%>&nbsp;&nbsp;</font>
	</td>
	<td align="center" width="33%">
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
	<td align='right' width="33%">
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
<table border="1" cellpadding="1" cellspacing="0" bordercolor="white" width="80%" bgcolor="#EBF3FB">
  <tr>
  	<td width="3%" align="center" bgcolor="#C0C0C0">&nbsp;</td> 
    <td width="14%" bgcolor="#C0C0C0"><b>
    <font face="Verdana" size="2" color="#003399">&nbsp;&nbsp;Slide No</font></b></td>
	<td width="80%" align="center" bgcolor="#C0C0C0">&nbsp;</td>
	<td width="3%" align="center" bgcolor="#C0C0C0">&nbsp;</td>
	<td width="94%" align="center" bgcolor="#C0C0C0">&nbsp;</td>
	
  </tr>
<%
		if(totRecords==0)
		{
%>
			<tr>
				<td width='100%' bgcolor='#C2CCE0' colspan="3" height='21'>
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
			slNo=Integer.parseInt(rs.getString("slide_no"));
			workId=slNo;
			slideName="Slide "+workId;
			slideContent=rs.getString("slide_content");

			//slideContent=slideContent.replaceAll("&#39;","&#92;&#39;");
			//slideContent=slideContent.replaceAll("\"","&#34;");
			//slideContent=slideContent.replaceAll("\"","&#92;&#34;");			
			

%>  
  <form name="ordering<%=i%>" method="POST" action="OrderOfSlides2.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>">
  <tr bgcolor="#EEEEEE" onMouseover="bgColor='#cccccc'" onMouseOut="bgColor='#EEEEEE'">
     <td width="3%"><font face="Verdana" size="2" color="#003399"><strong>&nbsp;<%=i%></strong></font></td>
	
	 <p style="margin-left: 25px;"><td width="31%"><font face="Verdana" size="2">&nbsp;<a onclick="toggleme('slidedesc<%=workId%>');return false;" href="#" id="readme" class="bullet"><%=slideName%>&nbsp;View</a></font></td></p>
	
	 <td width="94%"><div style="display: none;" id="slidedesc<%=workId%>">&nbsp;<%=slideContent%></div></td>


	 
	<td width="94%"><select name="cv"><option value="">Select</option>
	<%
	  int x=0;

	  rs2=st2.executeQuery("select * from lbcms_dev_lesson_content_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slide_no");
		while(rs2.next())
		{
			oslNo=Integer.parseInt(rs2.getString("slide_no"));
			x++;
%>			<option value="<%=oslNo%>"><%=x%></option>
<%		}
%>
	</select>

	</td>
	
	<input type="hidden" value="<%=slNo%>" name="av" WIDTH="4">
	<input type="hidden" value="<%=workId%>" name="workid" WIDTH="4">
	<input type="hidden" value="<%=slideName%>" name="docname" WIDTH="4">
	<td width="94%" bgcolor="#EEEEEE"><input type="submit" value="Update" name="sb" WIDTH="4"></td>
</tr>

  </form>
    
<%
		
		}
	%>
	<tr><td>&nbsp;</td><td align="center"><input type=button onClick="win();" value="Close this window"></td></tr>
<%
	}
	catch(Exception e)
	{
		System.out.println("OrderOfSlides.jsp operations on database Exception"+e.getMessage());
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
			ExceptionsFile.postException("OrderOfSlides.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}
%>  	

</table>


</body>

</html>