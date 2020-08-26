<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	int pageSize=250;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	 
    int totRecords=0,start=0,end=0,c=0,stuStatus=0,tot=0;
	String cat="",linkStr="",schoolId="",teacherId="",courseName="",classId="",workId="",status="",workFlag="";
	String checked="",courseId="",topicId="",subtopicId="",topic="",subtopic="",sessid="";
	String sortStr="",sortingBy="",sortingType="";
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
	System.out.println("classId..."+classId);
	courseId=(String)session.getAttribute("courseid");		
	cat=request.getParameter("cat");
	status=request.getParameter("status");
	sortingBy=request.getParameter("sortby");
	sortingType=request.getParameter("sorttype");
	
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
<!--

var workids=new Array();

function go(start,totrecords,cat,sortby,sorttype)
{	
	parent.main.location.href="AssignmentEditor.jsp?start="+start+"&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;
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
		parent.main.location.href="AssignmentEditor.jsp?start="+start+"&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;	
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

function showAsgnInfo(workid)
{
	window.open("ViewAsgnInfo.jsp?courseid=<%=courseId%>&schoolid=<%=schoolId%>&teacherid=<%=teacherId%>&workid="+workid,"Document","resizable=no,scrollbars=no,width=800,height=500,toolbars=no");
}

function displayStudents(workid,docname,checked,cat,total)
{
	parent.location.href="AsgnFrames.jsp?checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&tag=db&type=AS&total="+total;
}

function goCategory()
{
	var cat=document.fileslist.asgncategory.value;
	parent.main.location.href="AssignmentEditor.jsp?totrecords=&start=0&cat="+cat+"&status=";

}

function editWork(workid,category,submit,eval)
{		
		parent.main.location.href="EditAssignment.jsp?docs="+workid+"&cat="+category+"&submit="+submit+"&eval="+eval;	
}

function deleteFile(workid,cat)
{
	if(confirm("Are you sure you want to delete the file?")==true)
	{
		parent.main.location.href="/LBCOM/coursemgmt.AddEditAssignment?mode=delete&workid="+workid+"&cat="+cat;
		return false;
	}
	else
		return false;
}

function deleteAllFiles(cat)
{
        var selid=new Array();
        with(document.fileslist)
		{
				for(var i=0,j=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'selids' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
				}
         }
		if (j>0)
		{
			if(confirm("Are you sure you want to delete the selected file(s)?")==true)
			{
				 window.document.fileslist.asgncategory.value=cat;
				 parent.main.location.href="/LBCOM/coursemgmt.AddEditAssignment?mode=deleteall&cat="+cat+"&selids="+selid;
					 return false;
             }
             else
                return false;
         }
		 else
		 {
             alert("Please select the file(s) to be deleted");
              return false;
        }
}
function setMarking(cat)
{
        var selid=new Array();
        with(document.fileslist)
		{
				for(var i=0,j=0; i < elements.length; i++)
				{
                   if (elements[i].type == 'checkbox' && elements[i].name == 'selids' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
				}
         }
		if (j>0)
		{
			if(confirm("Are you sure you want to set the Marking Periods?")==true)
			{
				window.document.fileslist.asgncategory.value=cat;
				 parent.main.location.href="/LBCOM/coursemgmt/teacher/SetMarking.jsp?cat="+cat+"&workids="+selid;
					 return false;
             }
             else
                return false;
         }
		 else
		 {
             alert("Please select the file(s) to set  Marking Period");
              return false;
        }
}


function goCreate()
{
	parent.main.location.href="CreateWork.jsp?mode=add&type=AS";
}

function createCluster(cat)
{
	var selid=new Array();
	var wids=0;
    with(document.fileslist)
	{
		for (var i=0,j=0; i < elements.length; i++)
		{
			if(elements[i].type == 'checkbox' && elements[i].name == 'selids')
			{
				if(elements[i].checked==true)
				{
					selid[j++]=elements[i].value;
					wids=wids+1;
				}
				else
					wids=wids+1;
			}
		}
	}
    if(j>1)
	{
		if(confirm("Are you sure that you want to create a cluster with the selected assignments?")==true)
		{
			window.document.fileslist.asgncategory.value=cat;
			parent.main.location.href="AddCluster.jsp?totrecords=&start=0&cat="+cat+"&selids="+selid;
			return false;
		}
        else
			return false;
	}
	else
	{
		if(wids==0)
		{
			alert("There should be at least two assignments in order to create a cluster!");
			return false;
		}
		else
		{
			alert("You have to select at least two assignments to create a cluster!");
			return false;
		}
	}
}

function changeOrder()
{
	parent.main.location.href="OrderAssignments.jsp?start=0";
}

function goCluster(cat) // Selecting Clusters
{
	var clusterId=document.fileslist.cluster.value;
	parent.main.location.href="AssignmentsByGroup.jsp?clid="+clusterId+"&totrecords=&start=0&status=&cat=all";
}

function manageCluster(cat) // Cluster Manager
{
	parent.main.location.href="ManageCluster.jsp?mode=manage&cat="+cat;
}
function importAssignments() // Cluster Manager
{
	//window.open=("/LBCOM/coursedeveloper/CourseHome.jsp");
	//alert(<%=classId%>);
	//window.open("/LBCOM/coursedeveloper/ImportAssignments.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>","Document","resizable=yes,scrollbars=yes,wdth=800,height=500,toolbars=no");

	window.open("/LBCOM/lbcms/ImportAssignments.jsp?schoolid=<%=schoolId%>&classid=<%=classId%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>","Document","resizable=yes,scrollbars=yes,wdth=800,height=500,toolbars=no");
}

//-->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF"> 
<form name="fileslist" method="POST" action="--WEBBOT-SELF--">
<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<IMG SRC="images/asgn_editor2.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
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
<table border="0" cellpadding="0" cellspacing="0" bordercolor="#EBF3FB" width="100%" bgcolor="#bfbebd">
      <tr>
        <td class="gridhdr">
			<select id="asgncategory" name="asgncategory" onChange="goCategory(); return false;">
				<option value="all">All Categories</option>
<%
				st2=con.createStatement();

				rs3=st2.executeQuery("select * from category_item_master where category_type='AS' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");
				while(rs3.next())
				{
%>
					<option value="<%=rs3.getString("item_id")%>"><%=rs3.getString("item_des")%></option>
<%					
				}
%>
			</select>
		</td>
		<script>
		document.fileslist.asgncategory.value="<%=cat%>";	
		</script>
        <td class="gridhdr">
			<a href="#" onClick="return goCreate();">
				Create Assignment
			</a>
		</td>
		<td class="gridhdr">
			<a href="#" onClick="return changeOrder();">
				Order List
			</a>
		</td>
		<td class="gridhdr">
			<a href="#" onClick="return createCluster('<%= cat%>');">
				Create Cluster</font>
			</a>
		</td>
		<td class="gridhdr">
			<a href="#" onClick="return manageCluster('<%= cat%>');">
				Cluster Manager</font>
			</a>
		</td>
		<td class="gridhdr">
			<a href="#" onClick="return importAssignments();">
				Import from Builder</font>
			</a>
		</td>
        <td class="gridhdr">
			<select id="cluster" name="cluster" onChange="goCluster('<%= cat%>')">	

<%
			rs2=st2.executeQuery("select cluster_id,cluster_name from assignment_clusters where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' order by cluster_id");
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
			st=con.createStatement();
			if(cat.equals("all"))
			{
				rs=st.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and status < 2 order by slno");
			}
			else
			{
				rs=st.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and category_id='"+cat+"' and status < 2");
			}
			rs.next();
			c=rs.getInt(1);
			if(c!=0 )
			{
				totRecords=rs.getInt(1);
			}
			else
			{
%>
				<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>
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
		
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

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

		if(cat.equals("all"))
		{
			rs=st.executeQuery("select   curdate(),work_id,doc_name,category_id,asgncontent,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and status < 2 order by "+sortStr+" LIMIT "+start+","+pageSize);
		}
		else
		{
			rs=st.executeQuery("select   curdate(),work_id,doc_name,category_id,asgncontent,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and category_id='"+cat+"'  and status < 2 order by "+sortStr+" LIMIT "+start+","+pageSize);
		}
		currentPage=(start/pageSize)+1;
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("AssignmentEditor.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
		System.out.println("Exception in AssignmentEditor.jsp is...."+e);
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Exception in AssignmentEditor.jsp is...."+e);
			ExceptionsFile.postException("AssignmentEditor.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}	
	catch(Exception e)
	{
		System.out.println("Exception in AssignmentEditor.jsp is...."+e);
		ExceptionsFile.postException("AssignmentEditor.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	}	
%>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
		<tr>
			<td><font size="2">
				Assignments <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</font>
			</td>
			<td >
				<font size="2">
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
			<td ><font size="2">
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
	  
		<table border="0" width="100%" bordercolorlight="#FFFFFF" cellspacing="0" bordercolordark="#FFFFFF" cellpadding="0" bgcolor="#FFFFFF">
		<tr>
			<td class="gridhdr">
				<input type="checkbox" name="selectall" onClick="javascript:selectAll()" title="Select or deselect all files" value="ON">
			</td>
			<td class="gridhdr"><b>
			<a href="#" onClick="return setMarking('<%= cat%>')">
            <img border="0" src="../images/marking.gif" TITLE="Set Marking Period" width="19" height="21"></b>
			</a>
		</font></td>
			<td class="gridhdr">
			
			<a href="#" onClick="return deleteAllFiles('<%= cat%>')">
            <img border="0" src="../images/iddelete.gif" TITLE="Delete selected files" width="19" height="21">
			</a>
	
			</td>
			<td class="gridhdr">&nbsp;</td>

<%	 
			String bgColorDoc="#FFFFFF",bgColorDate="#FFFFFF";	 
			if(sortingBy.equals("slno"))
			{
				bgColorDoc= "#FFFFFF";     
			}
			if(sortingBy.equals("md"))	 
			{
				bgColorDate= "#FFFFFF";   
			} 
%>	 
			<td class="gridhdr">
<%  
			if((sortingType.equals("D"))||(sortingBy.equals("en")))
			{
%>
				<a href="AssignmentEditor.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=slno&sorttype=A&status=" target="_self">
					<img border="0" src="images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>
				<a href="AssignmentEditor.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=slno&sorttype=D&status=" target="_self">
					<img border="0" src="images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>		
				<b><font face="Verdana" size="2" color="#453F3F">Assignment Name</font></b>
			</td>
			<td width="15%" bgcolor='#bfbebd' align="center">
<%  
			if((sortingType.equals("D"))&&(sortingBy.equals("md")))
			{
%>  
				<a href="AssignmentEditor.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=md&sorttype=A&status=" target="_self">
<img border="0" src="images/sort_dn_1.gif" width="12" height="11"></a>
<%   
			}
			else
			{
%>     
				<a href="AssignmentEditor.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=md&sorttype=D&status=" target="_self">
<img border="0" src="images/sort_up_1.gif" width="12" height="11"></a>
<%   
			}
%>	 
				<b><font face="Verdana" size="2" color="#453F3F">Start Date</font></b>
			</td>
			<td width="15%" bgcolor="#bfbebd" align="center" height="21">
				<b><font face="Verdana" size="2" color="#453F3F">End Date</font></b>
			</td>
	<!-- 		<td align="center" width="17%" bgcolor="#C0C0C0">
				<b><font face="Verdana" size="2" color="#003399">Students (5)</font></b>
			</td> -->
		</tr>

<%
		int assign=0,eval=0,pending=0,submit=0;
		
		try
		{
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
				st1=con.createStatement();
	
				if((workFlag.equals("1"))||workFlag.equals("2")) 
				{
					int i=0;
					checked="";
					rs1=st1.executeQuery("select student_id from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"'");
					
					while(rs1.next())
					{
						if (i==0) 
						{
							checked=rs1.getString("student_id");
						}
						else 
						{
							checked+=","+rs1.getString("student_id");
						}
					   i++;
					}
					  
					rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"'");
					if (rs1.next())
						assign=rs1.getInt(1);

					rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2");
					if (rs1.next())
						submit=rs1.getInt(1);
					
					rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 4");
					if (rs1.next())
						eval=rs1.getInt(1);
					
					rs1=st1.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2 and status < 4");
					if (rs1.next())
						pending=rs1.getInt(1);
					
					rs1=st1.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status >= 2");
					if(rs1.next())
						tot=rs1.getInt(1);

					rs1.close();
				}
				else 
				{
					assign=submit=eval=pending=0;
				}
				
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
					}
				}
				else
				{
					flag=true;
				}			
				if(workFlag.equals("2")) 
				{
%>
					<tr>
				    <td class="griditem">
						
						<input type="checkbox" name="selids" value="<%=workId%>">
					</td>
					<td  class="griditem">
   						<img src="../images/iedit.gif"  border="0" TITLE="Edit" width="16" height="19">
					</td> 
					<td  class="griditem">
						<img src="../images/idelete.gif"  border="0" TITLE="Delete" width="19" height="21">
					</td>
					<td class="griditem">
						<img src="images/view_info.png"  border="0" TITLE="View Assignment Info" width="16" height="19">
					</td>
<%
				}
				else
				{
%>
					<tr>
						<td class="griditem">
														<input type="checkbox" name="selids" value="<%=workId %>">
						</td>
				
<% 
					if(flag==false)
					{
%>
						<td  class="griditem">
						<a href="#" onclick="editWork('<%=workId%>','<%=cat%>','<%=submit%>','<%=eval%>');return false;">
							<img src="../images/iedit.gif"  border="0" TITLE="Edit" width="16" height="19">
						</td> 
<% 
					}
					else
					{
						if(workFlag.equals("1"))
						{
%>
							<td  class="griditem">
								<a href="#" onClick="editWork('<%=workId%>','<%=cat%>','<%=submit%>','<%=eval%>');return false;">
								<img src="../images/iedit.gif"  border="0" TITLE="Edit" width="16" height="19"></a>
							</td> 
<%
						}
						else
						{
%>
							<td  class="griditem">
								<a href="#" onClick="editWork('<%= workId %>','<%=cat%>','<%=submit%>','<%=eval%>');return false;"><!-- modified 0n 10-11-2004-->
								<img border="0" src="../images/iedit.gif" TITLE="Edit" width="16" height="19"></a>
							</td> 
<%
						}
					}
%>
					<td class="griditem">
						<a href="#" onClick="javascript:return deleteFile('<%= workId %>','<%= cat%>')">
						<img border="0" src="../images/idelete.gif" TITLE="Delete" width="19" height="21"></a>
					</td>
					<td class="griditem">
						<a href="#" onClick="showAsgnInfo('<%=workId%>');return false;">
						<img src="images/view_info.png"  border="0" TITLE="View Assignment Info" width="16" height="19"></a>
					</td>
<%  
				}
%>
    			<td class="griditem">
					<a href="#" onClick="showFile('<%=rs.getString("work_id")%>','<%=cat%>');return false;">
					<%=rs.getString("doc_name")%></a> &nbsp;</td>
				<td class="griditem">
					
					<%= rs.getDate("modified_date") %>
				</td>
				<td class="griditem">
					
<%
	if(rs.getDate("to_date")!=null)
		out.println(rs.getDate("to_date"));
	else
		out.println("-");
%>
	</td>
				<!-- <td width="17%" bgcolor="#EEEEEE" align="center">
					<font size="2" face="verdana" color=""><%=assign%></font>
				</td> -->
	</tr>
  <%          
		}
	}catch(Exception e){
		System.out.println("AssignmentEditor.jsp operations on database Exception"+e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AssignmentEditor.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }
	
  %>  	
</table>
</form>
</body>
</html>