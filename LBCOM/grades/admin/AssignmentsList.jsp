<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String schoolId="",teacherId="",courseId="",courseName="";
	String studentId="",category="",preference="";
	String catId="",catName="",catType="",markId="";
	String sortStr="",sortingBy="",sortingType="";

	ResultSet rs=null,rs1=null,rs2=null;
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	int asgnCount=0;
	String startDate="",endDate="";

	

	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		sortingBy=request.getParameter("sortby");
	    sortingType=request.getParameter("sorttype");

		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		schoolId = (String)session.getAttribute("schoolid");
		//teacherId = (String)session.getAttribute("emailid");
		courseId=request.getParameter("courseid");
		if(courseId == null)
			courseId="selectcourse";   
		
		category=request.getParameter("category");
		if(category == null)
			category="selectany";

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();

		rs=st.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and status>0 order by course_id");	
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Assignments List Page</title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goCourse()
{
	var crsid=document.assignmentslist.courselist.value;
	var cat=document.assignmentslist.category.value;
	parent.main.location.href="AssignmentsList.jsp?courseid="+crsid+"&category="+cat;

}

function goCategory()
{
	var cat=document.assignmentslist.category.value;
	var crsid=document.assignmentslist.courselist.value;
	parent.main.location.href="AssignmentsList.jsp?courseid="+crsid+"&category="+cat;
}
//-->
</SCRIPT>
</head>

<body>
<form name="assignmentslist" method="POST" action="--WEBBOT-SELF--"><BR>

<div align="center">
<center>
<table border="0" cellpadding="0" cellspacing="0" width="90%" bgcolor="#429EDF" height="24">
  <tr>
    <td width="50%" height="24">&nbsp; <b>
    <font face="Arial" size="2" color="#FFFFFF">Assignments List</font></b></td>
     <td width="50%" height="24" align="right">
	<%
	if(!category.equals("selectany")){
	%><a href="javascript:window.print()"><img border="0" src="../images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a><%}%>&nbsp;&nbsp;
		
		<a href="index.jsp?userid=<%=schoolId%>"><IMG src="../images/back.png" width="22" height="22" BORDER="0" ALT="&lt;&lt;&nbsp;Back"></a>&nbsp;
	</td>
  </tr>
</table>
  </center>
</div>
<br>
<div align="center">
  <center>
<table border="0" width="90%" bgcolor="#429EDF" height="26" bordercolor="#111111">
  <tr>
    <td width="30%" height="23" bgcolor="#96C8ED">
		<select id="courselist" style="width:200px" name="courselist" onchange="goCourse(); return false;">
			<option value="selectcourse" selected>Select Course</option>
<%
				while(rs.next())
				{
					courseName=rs.getString("course_name");
					out.println("<option value='"+rs.getString("course_id")+"'>"+courseName+"</option>");
				}
				rs.close();
%>
		</select>
		<script>
			document.assignmentslist.courselist.value="<%=courseId%>";	
		</script>
	</td>
	<td width="30%" height="23" colspan="2" bgcolor="#96C8ED" align="right">
		<select id="category" style="width:200px" name="category" onchange="goCategory(); return false;">
			<option value="selectany" selected>Select Category</option>
<%
			rs=st.executeQuery("select item_id,item_des from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and (category_type='AS' || category_type='EX') order by item_des");
			
			while(rs.next())
			{
				catId=rs.getString(1);
				catName=rs.getString(2);
				out.println("<option value='"+catId+"'>"+catName+"</option>");
			}
			rs.close();

			rs1=st1.executeQuery("SELECT * from marking_admin where schoolid='"+schoolId+"'");
			
			while(rs1.next())
			{
				markId=rs1.getString("m_id");
				out.println("<option value='"+markId+"'>"+rs1.getString("m_name")+"</option>");
				
			}
			rs1.close();
%>
		</select>
		<script>
			document.assignmentslist.category.value="<%=category%>";
		</script>
	</td>
</tr>
<tr>
    <td width="60%" height="23" colspan="3" bgcolor="#FFFFFF">
    <hr color="#F16C0A"></td>
</tr>
</table>

<table border="1" cellspacing="1" width="90%" bordercolorlight="#E6F2FF">
<tr>
	<!-- <td width="38%" align="left" bgcolor="#96C8ED" height="25"> -->
	<!-- <td width="3%" bgcolor="#C0C0C0" align="center" valign="middle">&nbsp;</td> -->
	<%
		rs1=st1.executeQuery("select category_type from category_item_master where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+category+"'");
	
		if(rs1.next())
		{
			catType=rs1.getString(1);
		}
		rs1.close();	
	if(category.length()>2 && !category.equals("selectany"))
		{		
		catType="MARK";
		}
		else{
			
			if(catType.equals(""))
			catType="EX";
		}
		
		
%>

	<%
	if (sortingType==null)
			sortingType="A";
if (sortingBy==null || sortingBy.equals(""))
		{
	        if(catType.equals("AS"))
				sortStr="slno";
				else if(catType.equals("EX"))
				sortStr="exam_id";
				else if(catType.equals("MARK"))
				sortStr="slno";

			sortingBy="slno";
			sortingType="D";
		}
		else
		{
			if(sortingBy.equals("slno"))
				{
				if(catType.equals("AS"))
				sortStr="doc_name";
				else if(catType.equals("EX"))
				sortStr="exam_name";
				else if(catType.equals("MARK"))
				sortStr="exam_name";
				}
			else if (sortingBy.equals("md"))
				sortStr="from_date";
			if(sortingType.equals("A"))
			{
				sortStr=sortStr+" asc";
			}
			else
			{
				sortStr=sortStr+" desc";
			}
		}
	String bgColorDoc="#C0C0C0",bgColorDate="#C0C0C0";
			if(sortingBy.equals("slno"))
			{
				bgColorDoc= "#9D9D9D";     
			}
			if(sortingBy.equals("md"))	 
			{
				bgColorDate= "#858585";   
			} 
%>	 
			<td width="25%" bgcolor='<%=bgColorDoc%>' align="left" height="21">
<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="AssignmentsList.jsp?sortby=slno&sorttype=A&courseid=<%=courseId%>&category=<%=category%>&status=" target="_self">
					<img border="0" src="../images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="AssignmentsList.jsp?sortby=slno&sorttype=D&courseid=<%=courseId%>&category=<%=category%>&status=" target="_self">
					<img border="0" src="../images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>	
		<b><font face="Arial" size="2">Activity Name</font></b>
	</td>
    <td width="25%" align="center" bgcolor="<%=bgColorDate%>" height="25">
	<%  
			if((sortingType.equals("D"))&&(sortingBy.equals("md")))
			{
%>  
				<a href="AssignmentsList.jsp?&sortby=md&sorttype=A&courseid=<%=courseId%>&category=<%=category%>&status=" target="_self">
<img border="0" src="../images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>     
				<a href="AssignmentsList.jsp?sortby=md&sorttype=D&courseid=<%=courseId%>&category=<%=category%>&status=" target="_self">
<img border="0" src="../images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>
		<b><font face="Arial" size="2">Start Date</font></b>
	</td>
    <td width="22%" align="center" bgcolor="#C0C0C0" height="25">
		<b><font face="Arial" size="2">End Date</font></b>
	</td>
    <td width="15%" align="center" bgcolor="#C0C0C0" height="25">
		<b><font face="Arial" size="2">Max Points</font></b>
	</td>
</tr>



<%
	
		System.out.println("category...."+category);
		if(catType.equals("AS"))
		{
			
			rs2=st2.executeQuery("select doc_name,from_date,to_date,marks_total from "+schoolId+"_C000_"+courseId+"_workdocs where category_id='"+category+"' and status < 2 order by "+sortStr+"");
		}
		else if(catType.equals("EX"))
		{
			
			
			rs2=st2.executeQuery("select distinct e.exam_name,e.from_date,e.to_date,c.total_marks from exam_tbl e,`"+schoolId+"_cescores` c where e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_id=c.work_id and e.exam_type='"+category+"' order by e."+sortStr+"");
		}
		else if(catType.equals("MARK"))
		{
			
			//out.println("select doc_name as exam_name,from_date,to_date,marks_total as total_marks from "+schoolId+"_C000_"+courseId+"_workdocs where category_id in ( Select category_id from mp_cescores where m_id='" + category + "') and status < 2 order by "+sortStr+"");


			System.out.println("***********************select doc_name as exam_name,from_date,to_date,marks_total as total_marks from "+schoolId+"_C000_"+courseId+"_workdocs   where work_id in ( Select work_id  from mp_cescores where m_id='" + category + "') and status < 2)  Union (select distinct e.exam_name,e.from_date,e.to_date,c.total_marks from exam_tbl e,`"+schoolId+"_cescores` c where e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_id=c.work_id and e.exam_id in  ( Select work_id  from mp_cescores where m_id='" + category + "')) ");


			rs2=st2.executeQuery("(select doc_name as exam_name,from_date,to_date,marks_total as total_marks from "+schoolId+"_C000_"+courseId+"_workdocs   where work_id in ( Select work_id  from mp_cescores where m_id='" + category + "') and status < 2)  Union (select distinct e.exam_name,e.from_date,e.to_date,c.total_marks from exam_tbl e,`"+schoolId+"_cescores` c where e.school_id='"+schoolId+"' and e.course_id='"+courseId+"' and e.exam_id=c.work_id and e.exam_id in  ( Select work_id  from mp_cescores where m_id='" + category + "')) ");



			}

		while(rs2.next())
		{
			
			asgnCount=asgnCount+1;
			startDate=rs2.getString(2);
			if(startDate==null || startDate.equals(""))
			{
				 startDate="-";
			}
			endDate=rs2.getString(3);
			if(endDate==null || endDate.equals(""))
			{
				endDate="Not Assigned";
			}

			
%>
			<tr>
				<td width="38%">
					<font face="Arial" size="2"><%=rs2.getString(1)%></font> &nbsp;</td>
				<td width="25%" align="center">
					<font size="2" face="Arial"><%=startDate%></font> &nbsp;</td>
				<td width="22%" align="center">
					<font face="Arial" size="2"><%=endDate%></font> &nbsp;</td>
				<td width="15%" align="center">
					<font face="Arial" size="2"><%=rs2.getString(4)%></font> &nbsp;</td>
			</tr>
<%
		}
		rs2.close();
		
		if(asgnCount == 0)
		{
			if(courseId.equals("selectcourse"))
			{
%>
			<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2">Please select any course.</font>
				</td>
			</tr>
<%
			}
			else if(category.equals("selectany"))
			{
%>
			<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2">Please select any Category.</font>
				</td>
			</tr>
<%
			}
			else
			{
%>
			<tr>
				<td width="100%" colspan="5">
					<font face="Arial" size="2">There are no assignments in this category.</font>
				</td>
			</tr>
<%
			}
		}
	}	
	catch(Exception e)
	{
		out.println("Error: General-" + e);
		System.out.println("Error:  -" + e.getMessage());
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
		catch(SQLException se){
			ExceptionsFile.postException("AssignmentsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>

</table>
</center>
</div>
</form>
</body>
</html>