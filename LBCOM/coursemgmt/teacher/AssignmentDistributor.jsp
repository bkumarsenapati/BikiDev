<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	int pageSize=150;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	 
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
		
	teacherId=(String)session.getAttribute("emailid");
	schoolId=(String)session.getAttribute("schoolid");
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

	rs1=st1.executeQuery("select count(*) from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"' ");

	if(rs1.next())
		tot=rs1.getInt(1);
	rs1.close();
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
	parent.main.location.href="AssignmentDistributor.jsp?start="+ start+ "&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;
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
		parent.main.location.href="AssignmentDistributor.jsp?start="+ start+ "&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;	
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
	window.open("ViewAsgnInfo.jsp?workid="+workid,"Document","resizable=no,scrollbars=no,width=800,height=500,toolbars=no");
}

function displayStudents(workid)
{
	//parent.toppanel.document.leftpanel.asgncategory.value=cat;			
	parent.main.location.href="OneToManyStudents.jsp?workid="+workid+"&totrecords=&start=0";
}

function displayUnStudents(workid)
{
	//parent.toppanel.document.leftpanel.asgncategory.value=cat;			
	parent.main.location.href="OneToManyUnAssign.jsp?workid="+workid+"&totrecords=&start=0";
}

function goCategory()
{
	var cat=document.fileslist.asgncategory.value;
	parent.main.location.href="AssignmentDistributor.jsp?totrecords=&start=0&cat="+cat+"&status=";
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
		parent.main.location.href="ManyToMany.jsp?workids=&totrecords=&start=0&sflag=sfirst";
	}
	else
	{
		return false;
	}
	//var cat=document.fileslist.asgncategory.value;
	//parent.main.location.href="AssignmentDistributor.jsp?totrecords=&start=0&cat="+cat+"&status=";
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
		alert("You have to select atleast one assignment to assign from here!");
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
			parent.main.location.href="ManyToMany.jsp?workids="+workids+"&totrecords=&start=0";
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

function extendValidityBulk()
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
		alert("You have to select at least one assignment to extend the validity to any student!");
		return false;
	}
	else
	{
		parent.main.location.href="ExtendingBulkStudentsList.jsp?workids="+workids+"&totrecords=&start=0";
		return true;
	}
}

function extendValidity(wid,docname)
{
	if(confirm("Do you want to extend the validity of this assignment to some students?"))
	{
		parent.main.location.href="ExtendingStudentsList.jsp?workid="+wid+"&totrecords=&start=0&docname="+docname;
		return true;
	}
}

function goCluster() // Selecting Groups
{
	var clusterId=document.fileslist.cluster.value;
	parent.main.location.href="AssignmentClusterDistributor.jsp?totrecords=&start=0&cat=all&clid="+clusterId+"&status=";
}

function unAssignMany()
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
		alert("You have to select atleast one assignment to unassign work");
		return false;
	}
	else
	{
		parent.main.location.href="UnassignStudentsList.jsp?workids="+workids+"&totrecords=&start=0";
		return true;
	}
}

//-->
</SCRIPT>
</head>
<body> 
<form name="fileslist" method="POST" action="--WEBBOT-SELF--">

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
		<IMG SRC="images/asgn_distributor2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
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

<table border="0" cellpadding="0" cellspacing="0" bordercolor="white" width="100%" >
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
		<td class="gridhdr"><a href="../../manuals/distribute_assignment_manual/distribute_assignment.html" target="_blank">Manuals</a></td>
        <td class="gridhdr">
			<select id="cluster" name="cluster" onChange="goCluster()">	

<%
			rs2=st2.executeQuery("select cluster_id,cluster_name from assignment_clusters where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"'");
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
<!-- 		 <td width="25%" align="center">&nbsp;
			<a href="#" onclick="extendValidity();"><font face="verdana" size="2">Extend Validity</font></a> 
		</td>-->
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
				rs=st.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and status < 2");
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
				<table border='0' width='100%' cellspacing='1' bordercolordark='#bfbebd' height='21'>
				<tr>
					<td width='100%' bgcolor='#bfbebd' height='21'>
						<font face='verdana' color='453F3F' size='2'>There are no assignments available.</font>
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
		currentPage=(start/pageSize)+1;

		flag=true;

		if(cat.equals("all"))
		{
			rs=st.executeQuery("select   curdate(),work_id,doc_name,category_id,asgncontent,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and status < 2 order by "+sortStr+" LIMIT "+start+","+pageSize);
		}
		else
		{
			rs=st.executeQuery("select   curdate(),work_id,doc_name,category_id,asgncontent,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and category_id='"+cat+"' and status < 2 order by "+sortStr+" LIMIT "+start+","+pageSize);
		}
		bgColor="#DBD9D5"; 
		currentPage=(start/pageSize)+1;
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("AssignmentDistributor.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AssignmentDistributor.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}	
	catch(Exception e)
	{
		ExceptionsFile.postException("AssignmentDistributor.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
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
            <td class="gridhdr"><input type="checkbox" name="selectall" onClick="javascript:selectAll()" title="Select or deselect all files" value="ON"></td>
			
            <td class="gridhdr"><a href="#" onClick="assignMany();return false;"> <img src="../images/iassign.gif"  border="0" title="Distribute group of Assignments to a group of Students" width="19" height="21" align="middle"> </a> </td>
            <td class="gridhdr"><a href="#" onclick="extendValidityBulk();return false;">
				<IMG SRC="images/extend_due_date.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Extend the Due Date">
            </td>
			<td class="gridhdr">
			<a href="#" onClick="unAssignMany();return false;"><img src="../images/unassign_student.png"  border="0" title="Unassign to Students" width="19" height="21"></a>
			</td>
            <td class="gridhdr"><a href="#" onClick="selectStudents();return false;"> <img src="images/student_icon.png" width="16" height="19" border="0" alt="Select the Students First" align="middle"> </a> </td>
            <%	 
			String bgColorDoc="#C0C0C0",bgColorDate="#C0C0C0";	 
			if(sortingBy.equals("slno"))
			{
				bgColorDoc= "#858585";     
			}
			if(sortingBy.equals("md"))	 
			{
				bgColorDate= "#858585";   
			} 
%>
            <td class="gridhdr"><%  
			if((sortingType.equals("D"))&&(sortingBy.equals("slno")))
			{
%>
                <a href="AssignmentDistributor.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=slno&sorttype=A&status=" target="_self"> <img border="0" src="images/sort_dn_1.gif" width="12" height="11"></a>
                <%   
			}
			else
			{
%>
                <a href="AssignmentDistributor.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=slno&sorttype=D&status=" target="_self"> <img border="0" src="images/sort_up_1.gif" width="12" height="11"></a>
                <%   
			}
%>
              Assignment Name </td>
            <td class="gridhdr"><%  
			if((sortingType.equals("D"))&&(sortingBy.equals("md")))
			{
%>
                <a href="AssignmentDistributor.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=md&sorttype=A&status=" target="_self"> <img border="0" src="images/sort_dn_1.gif" width="12" height="11"></a>
                <%   
			}
			else
			{
%>
                <a href="AssignmentDistributor.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=md&sorttype=D&status=" target="_self"> <img border="0" src="images/sort_up_1.gif" width="12" height="11"></a>
                <%   
			}
%>
              Start Date </td>
            <td class="gridhdr"> End Date </td>
            <td class="gridhdr"> Students (<%=tot%>) </td>
          </tr>
          <%
		int assign=0;
		
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

				rs1.close();
								
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
            <td class="griditem"><input type="checkbox" name="selids" value="<%=workId %>">
            </td>
            <td  class="griditem"><a href="#" onClick="displayStudents('<%= workId %>');return false;"> <img src="../images/iassign.gif"  border="0" title="Assign to Students" width="19" height="21"></a> </td>
            <td class="griditem"><a href="#" onClick="extendValidity('<%=workId%>');return false;"> <img src="images/extend_due_date.png" width="16" height="19" border="0" alt="Extend the Due Date"> </a> </td>
			<td class="griditem">
			<a href="#" onClick="displayUnStudents('<%= workId %>');return false;"><img src="../images/unassign_student.png"  border="0" title="Unassign to Students" width="19" height="21"></a>
			</td>
            <td class="griditem"><a href="#" onClick="showAsgnInfo('<%=workId%>');return false;"> <img src="images/view_info.png" width="16" height="19" border="0" alt="View Assignment Info"> </a> </td>
            <td class="griditem"><a href="#" onClick="showFile('<%= rs.getString("work_id") %>','<%=cat%>');return false;"> <%=rs.getString("doc_name")%></a> &nbsp;</td>
            <td class="griditem"><%=rs.getDate("modified_date")%> </td>
            <td class="griditem"><%
				if(rs.getDate("to_date")!=null)
					out.println(rs.getDate("to_date"));
				else
					out.println("-");
%>
            </td>
            <td class="griditem"><a href="#" onClick="showStudents('<%=workId%>');return false;"><%=assign%></a> &nbsp; </td>
            <input type="hidden" name="assgname" value='<%=rs.getString("doc_name")%>'>
          </tr>
          <%          
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AssignmentDistributor.jsp","operations on database","Exception",e.getMessage());
			System.out.println("Exeption in ASsignmetnDistributor.jsop is..."+e);
		}
		finally
		{
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
				ExceptionsFile.postException("AssignmentDistributor.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println("SQLExeption in ASsignmetnDistributor.jsp is..."+se);
			}
		}
%>
        </table>
</form>
</body>
</html>
