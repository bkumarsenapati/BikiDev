<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=250;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	 
    int totRecords=0,start=0,end=0,c=0,stuStatus=0,tot=0;
	String cat="",linkStr="",schoolId="",teacherId="",courseName="",classId="",workId="",status="",workFlag="",bgColor="";
	String checked="",courseId="",forecolor="",topicId="",subtopicId="",topic="",subtopic="",sessid="";
	String sortStr="",sortingBy="",sortingType="",sFlag="",studentIds="";
	Hashtable hsSelIds=null;
	boolean flag=false;
	int currentPage=0;
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
	cat=request.getParameter("cat");
	status=request.getParameter("status");
	sortingBy=request.getParameter("sortby");
	sortingType=request.getParameter("sorttype");
	
	sFlag=request.getParameter("sflag");
	if(sFlag == null)
		sFlag="slast";

	if(sFlag.equals("sfirst"))
	{
		studentIds=request.getParameter("studentids");
	}

	st1=con.createStatement();
	try
	{
		
		rs1=st1.executeQuery("select count(*) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' ");

		if(rs1.next())
			tot=rs1.getInt(1);
		rs1.close();
	}
	catch(SQLException se){
		ExceptionsFile.postException("Assignment Evaluator .jsp","operations on database","SQLException",se.getMessage());	 
			System.out.println("Error: SQL -***************st1" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("Assignment Evaluator.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -********************st1" + e.getMessage());

	}
	finally{
		try{
		        if(st1!=null)
				st1.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("Assignment Evaluator.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Assignment Editor</title>
<!-- <link href="../../style.css" rel="stylesheet" type="text/css" /> -->
<link href="admcss.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">

var workids=new Array();

function go(start,totrecords,cat,sortby,sorttype)
{	
	parent.main.location.href="AssignmentEvaluator.jsp?start="+start+"&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;
	return false;
}

function gotopage(totrecords,cat,sortby,sorttype)
{
	var page=document.fileslist.page.value;
	if(page==0)
	{
		return false;
	}
	else
	{
		start=(page-1)*<%=pageSize%>;
		parent.main.location.href="AssignmentEvaluator.jsp?start="+ start+ "&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;	
		return false;
	}
}

function selectAll()
{
	if(document.fileslist.selectall.checked==true)
	{
		with(document.fileslist) 
		{
			for(var i=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'selids')
					elements[i].checked = true;
			}
		}
	}
	else
	{
		with(document.fileslist) 
		{
			for (var i=0; i < elements.length; i++) 
			{
				if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
					elements[i].checked = false;
			}
		}
	}
}

function showFile(workid,cat)
{
	var teacherId='<%= teacherId %>';
	var schoolid='<%= schoolId %>';
	//window.open("<%=(String)session.getAttribute("schoolpath")%>"+schoolid+"/"+teacherId+"/coursemgmt/<%=courseId%>/"+cat+"/"+workfile,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
	window.open("/LBCOM/coursemgmt/teacher/ShowAssignment.jsp?workid="+workid,"Document","resizable=no,scrollbars=yes,width=800,height=500,toolbars=no");
}

function displayStudents(workid,docname,checked,cat,total)
{
	parent.main.location.href="AsgnFrames.jsp?checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&tag=db&type=AS&total="+total;
}

function showAsgnInfo(workid)
{
	window.open("ViewAsgnInfo.jsp?workid="+workid,"Document","resizable=no,scrollbars=no,width=800,height=500,toolbars=no");
}

function goCategory()
{
	var cat=document.fileslist.asgncategory.value;
	parent.main.location.href="AssignmentEvaluator.jsp?totrecords=&start=0&cat="+cat+"&status=";
	return false;
}

function showPendingStudents(wid)
{
	parent.main.location.href="StudentsNotTaken.jsp?totrecords=&start=0&workid="+wid;
	return false;
}

function showStudents(wid)
{
	window.open("ShowStudentsList.jsp?wid="+wid,"Document","resizable=no,scrollbars=yes,width=550,height=400,toolbars=no");
}

function selectStudents()
{
	if(confirm("Do you want to select the students first and then assign the assignments?"))
	{
		parent.main.location.href="ManyToMany.jsp?sflag=sfirst&workids=&totrecords=";
	}
	else
	{
		return false;
	}
	//var cat=document.fileslist.asgncategory.value;
	//parent.main.location.href="AssignmentEvaluator.jsp?totrecords=&start=0&cat="+cat+"&status=";
	//return false;
}

function assignMany()
{
	var obj=document.fileslist;	  
	var cat=obj.asgncategory.value;
	var checkedCount=0;
    for(i=0;i<obj.elements.length;i++)
	{
		if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="selids" && obj.elements[i].checked==true)
		{
			workids[i]=obj.elements[i].value;
			checkedCount=checkedCount+1;
		}
	}
	if(checkedCount == 0)
	{
		alert("You have to select at least one assignment to assign from here!");
		return false;
	}
	else
	{
		var sf = '<%=sFlag%>';
		
		if(sf == 'sfirst')
		{
			parent.main.location.href="SelectDates.jsp?workids="+workids+"&studentids=<%=studentIds%>";
			return true;
		}
		else
		{
			parent.main.location.href="ManyToMany.jsp?workids="+workids+"&totrecords=";
			return true;
		}
	}
}

function getSelectedIds()
{
	var obj=document.studentslist;	  
    for(i=0,j=0,k=0;i<obj.elements.length;i++)
	{
		if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="selids")
		{
			if(obj.elements[i].checked==true)
				checked[j++]=obj.elements[i].value;
			else 
				unchecked[k++]=obj.elements[i].value;
		}
	}
}

function goCluster_old() // Selecting Groups
{
	var clusterId=document.fileslist.cluster.value;
	parent.main.location.href="AssignmentsByGroup.jsp?clid="+clusterId+"&totrecords=&start=0";
}

function goCluster() // Selecting Groups
{
	var clusterId=document.fileslist.cluster.value;
	parent.main.location.href="AssignmentClusterEvaluator.jsp?totrecords=&start=0&cat=all&status=&clid="+clusterId;
	return false;
}

//-->
</SCRIPT>
</head>

<body> 

<form name="fileslist" method="POST" action="--WEBBOT-SELF--">
 
<table width="100%" border="0" cellpadding="0" cellspacing="2" bordercolor="#BBB6B6">
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
		<IMG SRC="images/asgn_evaluator2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>
<hr>

<table border="0" cellpadding="0" cellspacing="0" bordercolor="BBB6B6" width="100%" >
<tr>
	<td class="gridhdr">
		<select id="asgncategory" name="asgncategory" onChange="goCategory(); return false;">
			<option value="all">All Categories</option>
<%
			st2=con.createStatement();

			try
			{

			rs3=st2.executeQuery("select * from category_item_master where category_type='AS' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");
			while(rs3.next())
			{
%>
				<option value="<%=rs3.getString("item_id")%>"><%=rs3.getString("item_des")%></option>
<%				
			}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("Assignment Evaluator .jsp","operations on database","SQLException",se.getMessage());	 
				System.out.println("Error: SQL -****************st2" + se.getMessage());
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("Assignment Evaluator.jsp","operations on database","Exception",e.getMessage());	 
				System.out.println("Error:  -********************st2" + e.getMessage());
			}
			finally
			{
				try
				{
					if(st2!=null)
						st2.close();
			
				}
				catch(SQLException se)
				{
					ExceptionsFile.postException("Assignment Evaluator.jsp","closing statement object","SQLException",se.getMessage());	 
					System.out.println(se.getMessage());
				}
			}
%>
		</select>
	</td>
	<script>
		document.fileslist.asgncategory.value="<%=cat%>";	
	</script>
	<td class="gridhdr">
		<select id="cluster" name="cluster" onChange="goCluster()">	

<%
			st3=con.createStatement();
			rs2=st3.executeQuery("select cluster_id,cluster_name from assignment_clusters where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"'");
			try
			{
			if(!rs2.next())
			{
%>
				<option value="none" selected>No Clusters</option>
<%
			}
			else
			{
%>
				<option value="none" selected>Select Cluster</option>
<%				do
				{
%>				
					<option value="<%=rs2.getString("cluster_id")%>"><%=rs2.getString("cluster_name")%></option>
<%
				}while(rs2.next());
			}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("Assignment Evaluator .jsp","operations on database","SQLException",se.getMessage());	 
				System.out.println("Error: SQL -****************st3333" + se.getMessage());
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("Assignment Evaluator.jsp","operations on database","Exception",e.getMessage());	 
				System.out.println("Error:  -********************st3333" + e.getMessage());
			}
			finally
			{
				try
				{
					if(st3!=null)
						st3.close();
			
				}
				catch(SQLException se)
				{
					ExceptionsFile.postException("Assignment Evaluator3333.jsp","closing statement object","SQLException",se.getMessage());	 
					System.out.println(se.getMessage());
				}
			}
%>
		</select>
	</td>
</tr>
</table>
<%
	try
	{
		if (sortingType==null)
			sortingType="A";
		if(!status.equals(""))
			status="Your work has been assigned successfully.";
		if (request.getParameter("totrecords").equals("")) 
		{ 
			st4=con.createStatement();
			if(cat.equals("all"))
			{
				rs4=st4.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and status < 2");
			}
			else
			{
				rs4=st4.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and category_id='"+cat+"' and status < 2");
			}
			rs4.next();
			c=rs4.getInt(1);
			if(c!=0 )
			{
				totRecords=rs4.getInt(1);
			}
			else
			{
%>
				<table border='0' width='100%' cellspacing='1' bordercolordark='#bfbebd' height='21'>
				<tr>
					<td width='100%' bgcolor='#bfbebd' height='21'>
						<font face='verdana' color='#453F3F' size='2'>There are no assignments available.</font>
					</td>
				</tr>
				</table>				
<%
				return;
			}
		}
		else
			totRecords=Integer.parseInt(request.getParameter("totrecords"));
		
		start=Integer.parseInt(request.getParameter("start"));
		c=start+pageSize;
		end=start+pageSize;
		
		if (sortingBy==null || sortingBy.equals("null"))
		{
			sortStr="slno";
			sortingBy="slno";
			sortingType="D";
		}
		else
		{
			if(sortingBy.equals("slno"))
				sortStr="doc_name";
			else if (sortingBy.equals("md"))
				sortStr="modified_date";
			if(sortingType.equals("A"))
			{
				sortStr=sortStr+" asc";
			}
			else
			{
				sortStr=sortStr+" desc";
			}
		}
		if (c>=totRecords)
			end=totRecords;
		flag=true;
		
		bgColor="#DBD9D5"; 
		currentPage=(start/pageSize)+1;
		rs4.close();
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("AssignmentEvaluator.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
		try
		{
			if(st4!=null)
				st4.close();
			if(rs4!=null)
				rs4.close();
			
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AssignmentEvaluator.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}	
	catch(Exception e)
	{
		ExceptionsFile.postException("AssignmentEvaluator.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	}	
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="33%" align="left"><font size="2">
		Assignments <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</font>
	</td>
	<td align="center" width="34%"><font size="2">
		
<%
		if(start==0 ) 
		{ 
			if(totRecords>end)
			{
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+cat+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>&nbsp;&nbsp;");
			}
			else
				out.println("Previous | Next &nbsp;&nbsp;");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+cat+"','"+sortingBy+"','"+sortingType+"');return false;\">Previous</a> |";
			
			if(totRecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+cat+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>&nbsp;&nbsp;";
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
	
		out.println("<select name='page' onchange=\"gotopage('"+totRecords+"','"+cat+"','"+sortingBy+"','"+sortingType+"');return false;\"> ");
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
	  
<table border="0" cellpadding="0" cellspacing="0" bordercolor="#BBB6B6" width="100%">
		<tr>
			<!-- <td width="3%" bgcolor="#C0C0C0" height="21" align="center" valign="middle">
				<input type="checkbox" name="selectall" onclick="javascript:selectAll()" title="Select or deselect all files">
			</td> -->
			<!-- <td width="3%" bgcolor="#C0C0C0" align="center" valign="middle">
				<a href="#" onclick="assignMany();return false;">
					<img src="../images/iassign.gif"  border="0" TITLE="Distribute group of Assignments to a group of Students">
				</a>
			</td> -->
			<td class="gridhdr">&nbsp;</td>
<%	 
			String bgColorDoc="#bfbebd",bgColorDate="#bfbebd";	 
			if(sortingBy.equals("slno"))
			{
				bgColorDoc= "#9D9D9D";     
			}
			if(sortingBy.equals("md"))	 
			{
				bgColorDate= "#858585";   
			} 
%>	 
			<td class="gridhdr">
<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="AssignmentEvaluator.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=slno&sorttype=A&status=" target="_self">
    			<img border="0" src="images/sort_dn_1.gif"></a>
<%   
			}
			else
			{
%>
				<a href="AssignmentEvaluator.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=slno&sorttype=D&status=" target="_self">
    			<img border="0" src="images/sort_up_1.gif"></a>
<%   
			}
%>		
				Assignment Name
			</td>
			<td class="gridhdr">
<%  
			if((sortingType.equals("D"))&&(sortingBy.equals("md")))
			{
%>  
				<a href="AssignmentEvaluator.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=md&sorttype=A&status=" target="_self">
    			<img border="0" src="images/sort_dn_1.gif"></a>
<%   
			}
			else
			{
%>     
				<a href="AssignmentEvaluator.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=md&sorttype=D&status=" target="_self">
    			<img border="0" src="images/sort_up_1.gif"></a>
<%   
			}
%>	 
				Start Date
			</td>
			<td class="gridhdr">
				End Date
			</td>
			<td class="gridhdr">
				Students (<%=tot%>)
			</td>
			<td class="gridhdr">
				Submissions
			</td>
			<td class="gridhdr">
				Remaining
			</td>
		</tr>

<%
		int assign=0,eval=0,pending=0,submit=0,rest=0;
		
		st=con.createStatement();
		
		try
		{
			if(cat.equals("all"))
			{
				rs=st.executeQuery("select curdate(),work_id,doc_name,category_id,asgncontent,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and status < 2 order by "+sortStr+" LIMIT "+start+","+pageSize);
			}
			else
			{
				rs=st.executeQuery("select curdate(),work_id,doc_name,category_id,asgncontent,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and category_id='"+cat+"' and status < 2 order by "+sortStr+" LIMIT "+start+","+pageSize);
			}
   			while(rs.next())
			{		
				topic="-";
				subtopic="-";
				workId=rs.getString("work_id");
				workFlag=rs.getString("status");
				topicId=rs.getString("topic");
				subtopicId=rs.getString("subtopic");
				cat=rs.getString("category_id");
				flag=true;	
				st5=con.createStatement();
				st6=con.createStatement();
				st7=con.createStatement();
				st8=con.createStatement();
				st9=con.createStatement();
				st10=con.createStatement();
												
				int i=0;
				checked="";
				rs5=st5.executeQuery("select student_id from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"'");
					
				while(rs5.next())
				{
					if (i==0) 
					{
						checked=rs5.getString("student_id");
					}
					else 
					{
						checked+=","+rs5.getString("student_id");
					}
				   i++;
				}
				st5.close();
					  
				rs6=st6.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"'");
				if (rs6.next())
					assign=rs6.getInt(1);

				st6.close();
				// Evaluator code
				rs7=st7.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2 and status!=5");
				if (rs7.next())
					submit=rs7.getInt(1);
				
				st7.close();
				rs8=st8.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 4 and status!=5");
				if (rs8.next())
					eval=rs8.getInt(1);
				
				st8.close();
				rs9=st9.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2 and status < 4 and status!=5");
				if (rs9.next())
					pending=rs9.getInt(1);

				st9.close();
				rs10=st10.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2 and status!=5");
				if(rs10.next())
					tot=rs10.getInt(1);
				rest=assign-submit;
				st10.close();

				// Evaluator code  ends here

				rs5.close();
				rs6.close();
				rs7.close();
				rs8.close();
				rs9.close();
				rs10.close();
								
				if(rs.getDate("to_date")!=null)
				{
					if ((rs.getDate(1).compareTo(rs.getDate("to_date")) <=0)) 
					{  
						//	 current date is before than the deadline
						flag=true;
					}
					else 
					{
						flag=false;
						forecolor="#996666";
					}
				}
				else
				{
					flag=true;
				}			
				
%>
<tr>
						<!-- <td bgcolor="#EFEFEF" align="center" valign="middle">
							<font size="2" face="verdana" color="#003366">
							<input type="checkbox" name="selids" value="<%=workId %>"></font>
						</td> -->
						<!-- <td  bgcolor="#EFEFEF" align="center" valign="middle">
							<a href="#" onclick="displayStudents('<%= workId %>','<%= rs.getString("doc_name")%>','','<%=cat%>','<%=rs.getString("marks_total")%>');return false;">
							<img src="../images/iassign.gif"  border="0" TITLE="Assign to Students"></a>
						</td>  -->
	<td class="griditem">
		<a href="#" onClick="showAsgnInfo('<%=workId%>');return false;">
			<img src="images/view_info.png"  border="0" TITLE="View Assignment Info"></a>
	</td>
	<td class="griditem">
		<a href="#" onClick="showFile('<%= rs.getString("work_id") %>','<%=cat%>');return false;">
		<%=rs.getString("doc_name")%></a>
	</td>
	<td class="griditem">
		<%=rs.getDate("modified_date")%>
	</td>
	<td class="griditem">
		
<%
		if(rs.getDate("to_date")!=null)
			out.println(rs.getDate("to_date"));
		else
			out.println("-");
%>
		
	</td>
	<td class="griditem">
		<font size="2" face="verdana" color="#003366">
		<a href="#" onclick="showStudents('<%=workId%>');return false;"><%=assign%></font>
	</td>
	<td class="griditem">
		
<%	
	if(submit==0)
	{ 
	    out.println(submit);
	}
	else
	{
%>	
	<a          		href="StudentsSubmissions.jsp?submsntype=pending&cat=<%=cat%>&workid=<%=workId%>&totrecords=<%=pending%>&start=0&maxmarks=<%=rs.getString("marks_total")%>&alltotrecords=<%=submit%>" title="<%=pending%> submission(s) made by <%=submit%> student(s) pending for evaluation"><%=pending%> (<%=submit%>)</a>
<%	
	}
%>	
		
	</td>
	<td class="griditem">
				<a          		href="StudentsNotTaken.jsp?cat=<%=cat%>&workid=<%=workId%>&totrecords=<%=rest%>&start=0&maxmarks=<%=rs.getString("marks_total")%>"><%=rest%></a>
		
	</td>
</tr>
  <%          
		}
	}catch(Exception e){
		ExceptionsFile.postException("AssignmentEvaluator.jsp","operations on database","Exception",e.getMessage());
		System.out.println("Exeption in ASsignmetnEvaluator.jsop is..."+e);
   }finally{
		try{
			if(st!=null)
				st.close();
			if(st5!=null)
				st5.close();
			if(st6!=null)
				st6.close();
			if(st7!=null)
				st7.close();
			if(st8!=null)
				st8.close();
			if(st9!=null)
				st9.close();
			if(st10!=null)
				st10.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AssignmentEvaluator.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("SQLExeption in ASsignmetnEvaluator.jsp is..."+se);
		}

    }
	
  %>  

</table>
</form>
</body>
</html>
