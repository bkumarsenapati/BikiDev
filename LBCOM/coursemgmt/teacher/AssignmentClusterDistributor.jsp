<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.StringTokenizer,java.util.Enumeration,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%!
	int pageSize=100;
%>
<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	 
    int totRecords=0,start=0,end=0,c=0,stuStatus=0,tot=0;
	String cat="",linkStr="",schoolId="",teacherId="",courseName="",classId="",workId="",status="",workFlag="",bgColor="",clid="";
	String checked="",courseId="",forecolor="",topicId="",subtopicId="",topic="",subtopic="",sessid="",docNmae="";
	String  createdDate="", modDate="", sectionId="", fromDate="";
	String sortStr="",sortingBy="",sortingType="",ids="",sFlag="",studentIds="";
	String work_idd="",widStr="",id="";
	Hashtable hswids=null;
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
	clid=request.getParameter("clid");
	status=request.getParameter("status");
	sortingBy=request.getParameter("sortby");
	sortingType=request.getParameter("sorttype");
	forecolor="#003366";

	sFlag=request.getParameter("sflag");
	if(sFlag == null)
		sFlag="slast";

	if(sFlag.equals("sfirst"))
	{
		studentIds=request.getParameter("studentids");
	}

	if (request.getParameter("totrecords").equals("")) 
	{ 
		st=con.createStatement();
			
		rs=st.executeQuery("Select work_ids from assignment_clusters where  school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' and cluster_id='"+clid+"'");

		rs.next();
		widStr=rs.getString("work_ids");

		StringTokenizer widTokens=new StringTokenizer(widStr,",");
		
		while(widTokens.hasMoreTokens())
		{
			id=widTokens.nextToken();
			c++;
		}

		if(c==0)
		{
			out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
			out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'><b><font face='verdana' color='#FF0000' size='2'>There are no assignments available.</font></b></td></tr></table>");				
			return;
		}
		else
			totRecords=c;
	}
	else
		totRecords=Integer.parseInt(request.getParameter("totrecords"));

	start=Integer.parseInt(request.getParameter("start"));
	c=start+pageSize;
	end=start+pageSize;

	if (c>=totRecords)
		end=totRecords;
	currentPage=(start/pageSize)+1;
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Assignments By Group</title>
<!-- <link href="../../style.css" rel="stylesheet" type="text/css" /> -->

<SCRIPT LANGUAGE="JavaScript">
<!--
var workids=new Array();

function go(start,totrecords,cat,clid,sortby,sorttype)
{	
	parent.main.location.href="AssignmentClusterDistributor.jsp?clid="+clid+"&start="+start+"&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;
	return false;
}

function gotopage(totrecords,cat,clid,sortby,sorttype)
{
	var page=document.grfileslist.page.value;
	if(page==0)
	{
		return false;
	}
	else
	{
		start=(page-1)*<%=pageSize%>;
		parent.main.location.href="AssignmentClusterDistributor.jsp?clid="+clid+"&start="+start+"&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;	
		return false;
	}
}


function selectAll()
{
	if(document.grfileslist.selectall.checked==true)
	{
		with(document.grfileslist) 
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
		with(document.grfileslist) 
		{
			for (var i=0; i < elements.length; i++) 
			{
				if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
					elements[i].checked = false;
			}
		}
	}
}

function deleteAllFiles(cat){

        var selid=new Array();
        with(document.grfileslist) {
             for (var i=0,j=0; i < elements.length; i++) {
                    if (elements[i].type == 'checkbox' && elements[i].name == 'selids' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
              }
         }
         if (j>0) {
                if(confirm("Are you sure you want to delete the selected file(s)?")==true){
					
				   window.document.grfileslist.asgncategory.value=cat;
				   
                   parent.location.href="/LBCOM/coursemgmt.AddGroup?mode=deleteall&cat="+cat+"&selids="+selid;
                   return false;
                }
                else
                    return false;
         }else {
               alert("Please select the file(s) to be deleted");
               return false;
        }
    }
	
function showFile(workid,cat)
{
	var teacherId='<%= teacherId %>';
	var schoolid='<%= schoolId %>';
	//window.open("<%=(String)session.getAttribute("schoolpath")%>"+schoolid+"/"+teacherId+"/coursemgmt/<%=courseId%>/"+cat+"/"+workfile,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");

	window.open("/LBCOM/coursemgmt/teacher/ShowAssignment.jsp?workid="+workid,"Document","resizable=no,scrollbars=yes,width=800,height=500,toolbars=no");
}
function showDet(workid)
{		
		window.open("/LBCOM/coursemgmt/teacher/AssignInfo.jsp?workid="+workid);
		return false;
		
}

function showAsgnInfo(workid)
{
	window.open("ViewAsgnInfo.jsp?workid="+workid,"Document","resizable=no,scrollbars=no,width=800,height=500,toolbars=no");
}

function displayStudents(workid,checked,cat,total)
{
	//parent.location.href="AsgnFrames.jsp?checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&tag=db&type=AS&total="+total;
	parent.main.location.href="OneToManyStudents.jsp?workid="+workid+"&totrecords=&start=0";
}
function deleteFile(workid,cat)
	{
		if(confirm("Are you sure you want to delete the file?")==true)
		{
			parent.main.location.href="/LBCOM/coursemgmt.AddGroup?mode=del&workid="+workid+"&cat="+cat;
			return false;
		}
		else
			return false;
	}

function goCategory()
{
	var cat=document.grfileslist.asgncategory.value;
	parent.main.location.href="AssignmentDistributor.jsp?totrecords=&start=0&cat="+cat+"&status=";
	return false;
}

function goCreate()	//For Assignment Create
{
	parent.main.location.href="CreateWork.jsp?mode=add&type=AS";
}
function goGroups() // Selecting Groups
{
	var clusterId=document.grfileslist.gr.value;
	parent.main.location.href="AssignmentClusterDistributor.jsp?totrecords=&start=0&cat=all&clid="+clusterId+"&status=";
}

function showStudents(wid,asgnname)
{
	window.open("ShowStudentsList.jsp?wid="+wid+"&asgnname="+asgnname,"Document","resizable=no,scrollbars=yes,width=550,height=400,toolbars=no");
}

function createCluster()
{
	var selid=new Array();
	var wids=0;
    with(document.grfileslist)
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
			window.document.grfileslist.asgncategory.value='all';
			parent.main.location.href="AddCluster.jsp?totrecords=&start=0&cat=all&selids="+selid;
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

function assignMany()
{
	var obj=document.grfileslist;	  
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

function extendValidity(wid)
{
	if(confirm("Do you want to extend the validity of this assignment to some students?"))
	{
		parent.main.location.href="ExtendingStudentsList.jsp?workid="+wid+"&totrecords=&start=0";
		return true;
	}
}
//-->
</SCRIPT>
</head>
<body bgcolor="#EBF3FB">
<form name="grfileslist" method="POST" action="--WEBBOT-SELF--">
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
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#EBF3FB" width="100%"  bgcolor="#C0C0C0">
<tr>
	<td width="50%" align="left">
		<select id="asgncategory" name="asgncategory" onchange="goCategory(); return false;">
				<option value="none">Select Category</option>
				<option value="all">All Categories</option>
<%
				st2=con.createStatement();

				rs3=st2.executeQuery("select * from category_item_master where category_type='AS' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");
				while(rs3.next())
				{
%>
					<option value="<%=rs3.getString("item_id")%>"><%=rs3.getString("item_des")%></option>
<%					
				}rs3.close();
%>
		</select>
	</td>
	<td width="50%" align="right">
		<select id="gr" name="gr" onchange="goGroups(); return false;">	
<%
			st2=con.createStatement();
			rs2=st2.executeQuery("select * from assignment_clusters where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' order by cluster_id");
			while(rs2.next())
			{
%>
			<option value="<%=rs2.getString("cluster_id")%>"><%=rs2.getString("cluster_name")%></option>
<%
			}
			rs2.close();
			
%>
		</select>
	</td>
	<script>
		document.grfileslist.gr.value="<%=clid%>";	
	</script>
</tr>
</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#EBF3FB">
		<tr>
			<td width="33%" align="left">
				<font color="#000080" size="2" face="verdana" >Assignments <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</font>
			</td>
			<td width="34%" align="center">
				<font color="#000080" face="verdana" size="2">
<%
		if(start==0 ) 
		{ 
			if(totRecords>end)
			{
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+cat+"','"+clid+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>&nbsp;&nbsp;");
			}
			else
				out.println("Previous | Next &nbsp;&nbsp;");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+cat+"','"+clid+"','"+sortingBy+"','"+sortingType+"');return false;\">Previous</a> |";
			
			if(totRecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords+"','"+cat+"','"+clid+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>&nbsp;&nbsp;";
			}	
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);
		}	
%>
	  
				</font>
			</td>
			<td width="33%" align='right'>
				<font face="verdana" color="#000080" size="2">Goto Page&nbsp;
<%
		int index=1;
	    int str=0;
	    int noOfPages=0;
		if((totRecords%pageSize)>0)
		    noOfPages=(totRecords/pageSize)+1;
		else
			noOfPages=totRecords/pageSize;
	
		out.println("<select name='page' onchange=\"gotopage('"+totRecords+"','"+cat+"','"+clid+"','"+sortingBy+"','"+sortingType+"');return false;\"> ");
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
			<td width="3%" bgcolor="#C0C0C0" height="21" align="center" valign="middle">
				<input type="checkbox" name="selectall" onclick="javascript:selectAll()" title="Select or deselect all files">
			</td>
			<td width="3%" bgcolor="#C0C0C0" align="center" valign="middle">
				<a href="#" onclick="assignMany();return false;">
					<img src="../images/iassign.gif"  border="0" TITLE="Distribute group of Assignments to a group of Students" width="19" height="21" align="middle">
				</a>
			</td>
			<td width="3%" bgcolor="#C0C0C0" align="center" valign="middle">&nbsp;</td>
			<td width="3%" bgcolor="#C0C0C0" align="center" valign="middle">
				<a href="#" onclick="selectStudents();return false;">
					<IMG SRC="images/student_icon.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Select the Students First" align="middle">
				</a>
			</td>
			<td width="12%" bgcolor="#C0C0C0" align="left">
				<b><font face="Verdana" size="2" color="#003399">Assignment Name</font></b>
			</td>
			<td width="12%" bgcolor="#C0C0C0" align="center">
 				<b><font face="Verdana" size="2" color="#003399">Start Date</font></b>
			</td>
			<td width="12%" bgcolor="#C0C0C0" align="center" height="21">
				<b><font face="Verdana" size="2" color="#003399">End Date</font></b>
			</td>
			<td align="center" width="17%" bgcolor="#C0C0C0">
				<b><font face="Verdana" size="2" color="#003399">Students</font></b>
			</td>
		</tr>

<%
	try
	{
		hswids=new Hashtable();	
		rs3=st2.executeQuery("select * from assignment_clusters where cluster_id='"+clid+"' and school_id='"+schoolId+"'");
		if(rs3.next())
		{
			ids=rs3.getString("work_ids");
			
			StringTokenizer idsTkn=new StringTokenizer(ids,",");
			while(idsTkn.hasMoreTokens())
			{
				workId=idsTkn.nextToken();
				hswids.put(workId,workId);
			}
				Enumeration workids=hswids.keys();
				while(workids.hasMoreElements())
				{					
					String work_id=(String)workids.nextElement();
					st=con.createStatement();
					rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+work_id+"' and status < 2");
					while(rs.next())
						{
					
							cat=rs.getString("category_id");
							workFlag=rs.getString("status");
							flag=true;		
							int assign=0;
							int i=0;
							checked="";
							st1=con.createStatement();
							rs1=st1.executeQuery("select student_id from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+work_id+"' and status < 2");
																	
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
									  
							rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+work_id+"'");
							if (rs1.next())
								assign=rs1.getInt(1);
							else
								assign=0;
							
%>
					<tr>
					<td bgcolor="#EEEEEE" align="center" valign="middle">
						<font size="2" face="verdana" color="<%=forecolor%>">
						<input type="checkbox" name="selids" value="<%=work_id %>"></font>
					</td>
					<td width="3%" bgcolor="#EEEEEE" align="center" valign="middle">
						<a href="#" onclick="displayStudents('<%= work_id %>','<%=cat%>','<%=rs.getString("marks_total")%>');return false;">
						<img src="../images/iassign.gif"  border="0" TITLE="Assign to Students" width="19" height="21">
						</a>
					</td>
					<td bgcolor="#EEEEEE" align="center" valign="middle">
						<a href="#" onclick="extendValidity('<%=work_id%>');return false;">
							<IMG SRC="images/extend_due_date.png" WIDTH="16" HEIGHT="19" BORDER="0" ALT="Extend the Due Date">
						</a>					
					</td>
					<td bgcolor="#EEEEEE" align="center" valign="middle">
						<a href="#" onclick="showAsgnInfo('<%=work_id%>');return false;">
						<img src="images/view_info.png"  border="0" TITLE="View Assignment Info"></a>
					</td>
					<td width="39%" bgcolor="#EEEEEE">
						<font size="2" face="verdana" color="<%=forecolor%>">
						<a href="#" onclick="showFile('<%=rs.getString("work_id")%>','<%=cat%>');return false;"><font size="2" face="verdana" color="#003366"><%= rs.getString("doc_name") %></a></font>
					</td>
					<td width="12%" height="18" bgcolor="#EEEEEE" align="center" valign="middle">
						<font size="2" face="verdana" color="<%=forecolor%>">
						<%= rs.getDate("created_date") %></font>
					</td>
					<td width="12%" height="18" bgcolor="#EEEEEE" align="center" valign="middle">
						<font size="2" face="verdana" color="<%=forecolor%>">
						<%= rs.getDate("to_date") %></font>
					</td>
					<td width="17%" bgcolor="#EEEEEE" align="center">
						<font size="2" face="verdana" color="<%=forecolor%>">
							<a href="#" onclick="showStudents('<%=work_id%>');return false;"><%=assign%></a>
						</font>
					</td>
				
				
	</tr>
  <%					}
							
						
					
				}
		}
		else
		{
			out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
				out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='verdana' color='#FF0000' size='2'>Requested item is not available yet.</font></b></td></tr></table>");				
				return;
		}
}
catch(Exception e)
{
	System.out.println("AssignmentClusterDistributor.jsp operations on database Exception"+e.getMessage());
}
finally
{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AssignmentClusterDistributor.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }
	
  %>  	
</table>
</form>
</body>
</html>
