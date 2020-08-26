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
	String sortStr="",sortingBy="",sortingType="",ids="";
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
	cat=request.getParameter("cat");
	status=request.getParameter("status");
	sortingBy=request.getParameter("sortby");
	sortingType=request.getParameter("sorttype");
	forecolor="#003366";
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
function go(start,totrecords,cat,clid,sortby,sorttype)
{	
	parent.main.location.href="AssignmentsByGroup.jsp?clid="+clid+"&start="+start+"&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;
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
		parent.main.location.href="AssignmentsByGroup.jsp?clid="+clid+"&start="+start+"&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;	
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

function deleteAllFiles(cat,clid){

        var selid=new Array();
		
        with(document.grfileslist) {
             for (var i=0,j=0; i < elements.length; i++) {
                    if (elements[i].type == 'checkbox' && elements[i].name == 'selids' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
              }
         }
         if (j>0) 
			 {
                if(confirm("Are you sure you want to delete the selected file(s)?")==true)
				{
					
				   window.document.grfileslist.asgncategory.value=cat;
				   
				   
                  //parent.location.href="/LBCOM/coursemgmt.AddGroup?mode=deleteall&cat="+cat+"&selids="+selid;
				  parent.main.location.href="/LBCOM/coursemgmt.AddEditAssignment?mode=cdeleteall&workid="+selid+"&cat="+cat+"&clid="+clid;
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

function editWork(workid,category,submit,eval)
{		
		//parent.toppanel.document.leftpanel.asgncategory.value=category;
		parent.main.location.href="EditAssignment.jsp?docs="+workid+"&cat="+category+"&submit="+submit+"&eval="+eval;	
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

function displayStudents(workid,docname,checked,cat,total)
{
	parent.location.href="AsgnFrames.jsp?checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&tag=db&type=AS&total="+total;
}
function deleteFile(workid,cat,clid)
	{
		if(confirm("Are you sure you want to delete the file?")==true)
		{
			//parent.main.location.href="/LBCOM/coursemgmt.AddGroup?mode=del&workid="+workid+"&cat="+cat;
			parent.main.location.href="/LBCOM/coursemgmt.AddEditAssignment?mode=cdelete&workid="+workid+"&cat="+cat+"&clid="+clid;
			return false;
		}
		else
			return false;
	}

function goCategory()	// Selecting by Category
{
	var cat=document.grfileslist.asgncategory.value;
	
	parent.main.location.href="AssignmentEditor.jsp?totrecords=&start=0&cat="+cat+"&status=";

}

function goCreate()	//For Assignment Create
{
	parent.main.location.href="CreateWork.jsp?mode=add&type=AS";
}
function goGroups(cluster) // Selecting Groups
{
	var clid=document.grfileslist.cluster.value;
	parent.main.location.href="AssignmentsByGroup.jsp?clid="+clid+"&totrecords=&start=0&status=&cat=all";
}

function createCluster()
{
	alert("Sorry! You cannot create a Cluster from here. Go to All Categories.");
	return false;
}


function manageCluster(cat) // Cluster Manager
{
	parent.main.location.href="ManageCluster.jsp?mode=manage&cat="+cat;
}

function changeOrder()
{
	parent.main.location.href="OrderAssignments.jsp?start=0";
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
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#EBF3FB" width="100%"  bgcolor="#C0C0C0">
      <tr>
	  <td width="15%">
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
		
       <td width="23%" align="center" valign="center">
			<a href="#" onclick="return goCreate();">
				<font color="black" size="1" face="verdana"><B>Create Assignment</B></font>
			</a>
		</td>
		<td width="17%" align="center" valign="center">
			<a href="#" onclick="return changeOrder();">
				<font color="black" size="1" face="verdana"><B>Order List</B></font>
			</a>
		</td>
		<td width="15%" align="center" valign="center">
			<a href="#" onclick="return createCluster('<%= cat%>');">
				<font color="black" size="1" face="verdana"><B>Create Cluster</B></font>
			</a>
		</td>
		
		<td width="15%" align="center" valign="center">
			<a href="#" onclick="return manageCluster('<%= cat%>');">
				<font color="black" size="1" face="verdana"><B>Cluster Manager</B></font>
			</a>
		</td>
		
        
		<td width="23%" align="right">
			<select id="cluster" name="cluster" onchange="goGroups('<%= cat%>'); return false;">	
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
			document.grfileslist.cluster.value="<%=clid%>";	
		</script>
								
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
				rs=st.executeQuery("Select work_ids from assignment_clusters where  school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' and cluster_id='"+clid+"' and work_ids!='null'");

			}
			
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
		//rs=st.executeQuery("select   curdate(),work_id,doc_name,category_id,work_file,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and status < 2 order by "+sortStr+" LIMIT "+start+","+pageSize);
		rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+id+"' and teacher_id='"+teacherId+"' order by "+sortStr+" LIMIT "+start+","+pageSize);
		
	
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("AssignmentEditor.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
		System.out.println("Exception in AssignmentsByGroup.jsp is...."+e);
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Exception in AssignmentsByGroup.jsp is...."+e);
			ExceptionsFile.postException("AssignmentEditor.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}	
	catch(Exception e)
	{
		System.out.println("Exception in AssignmentsByGroup.jsp is...."+e);
		ExceptionsFile.postException("AssignmentEditor.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	}
%>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#EBF3FB">
		<tr>
			<td width="200" align="left">
				<font color="#000080" size="2" face="verdana" >Assignments <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</font>
			</td>
			<td align="center">
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
			<td align='right'>
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
<table border="1" cellpadding="0" cellspacing="1" bordercolor="#C0C0C0" width="100%">
<tr>
	<td width="3%" bgcolor="#C0C0C0" height="21" align="center" valign="middle">
		<input type="checkbox" name="selectall" onclick="javascript:selectAll()" title="Select or deselect all files">
	</td>
	<td width="3%" bgcolor="#C0C0C0" align="center" valign="middle">&nbsp;</td>
	<td width="3%" bgcolor="#C0C0C0" align="center" valign="middle">
		<font size="1" face="Verdana" color="#000080"><b>
			<a href="#" onclick="return deleteAllFiles('<%= cat%>','<%= clid%>')"><img border="0" src="../images/iddelete.gif" TITLE="Delete selected files"></b>
			</a>
		</font>
	</td>
	<td width="3%" bgcolor="#C0C0C0" align="center" valign="middle">&nbsp;</td>
	<td width="50%" bgcolor="#C0C0C0" align="left">
		<b><font face="Verdana" size="2" color="#003399">Assignment Name</font></b>
	</td>
	<td width="15%" bgcolor="#C0C0C0" align="center">
 		<b><font face="Verdana" size="2" color="#003399">Start Date</font></b>
	</td>
	<td width="15%" bgcolor="#C0C0C0" align="center" height="21">
		<b><font face="Verdana" size="2" color="#003399">End Date</font></b>
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
					rs=st.executeQuery("select   curdate(),work_id,doc_name,category_id,asgncontent,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and work_id='"+work_id+"' and status < 2 order by "+sortStr+" LIMIT "+start+","+pageSize);
					while(rs.next())
					{
						cat=rs.getString("category_id");
						workFlag=rs.getString("status");
						flag=true;		
						int assign=0,eval=0,pending=0,submit=0;
						if((workFlag.equals("1"))||workFlag.equals("2")) 
						{
								
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
								//rs1=st1.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and status < 2");
														
								if (rs1.next())
										assign=rs1.getInt(1);
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
							<td bgcolor="#EEEEEE" align="center" valign="middle">
								<font size="2" face="verdana" color="">
								<input type="checkbox" name="selids" value="<%=work_id%>"></font>
							</td>
							<td  bgcolor="#EEEEEE" align="center" valign="middle">
								<img src="../images/iedit.gif"  border="0" TITLE="Edit">
							</td> 
							<td  bgcolor="#EEEEEE" align="center" valign="middle">
								<img src="../images/idelete.gif"  border="0" TITLE="Delete">
							</td>
							<td  bgcolor="#EEEEEE" align="center" valign="middle">
								<img src="images/view_info.png"  border="0" TITLE="View Assignment Info">
							</td>
<%
						}
						else
						{
							
%>
							<tr>
								<td bgcolor="#EEEEEE" align="center" valign="middle">
									<font size="2" face="verdana" color="green">
									<input type="checkbox" name="selids" value="<%=work_id %>"></font>
								</td>
					
<% 
							if(flag==false)
							{
%>
								<td  bgcolor="#EEEEEE" align="center" valign="middle">
									<img src="../images/iedit.gif"  border="0" TITLE="Edit">
								</td> 
<% 
							}
							else
							{
								if(workFlag.equals("1"))
								{
%>
									<td  bgcolor="#EEEEEE" height="18" align="center" valign="middle">
										<a href="#" onclick="editWork('<%=work_id%>','<%=cat%>','<%=submit%>','<%=eval%>');return false;">
										<img src="../images/iedit.gif"  border="0" TITLE="Edit"></a>
									</td> 
<%
								}
								else
								{
%>
									<td  bgcolor="#EEEEEE" align="center" valign="middle">
										<a href="#" onclick="editWork('<%= work_id %>','<%=cat%>','<%=submit%>','<%=eval%>');return false;"><!-- modified 0n 10-11-2004-->
										<img border="0" src="../images/iedit.gif" TITLE="Edit"></a>
									</td> 
<%
								}
							}
%>
							<td bgcolor="#EEEEEE" align="center" valign="middle">
								<a href="#" onclick="javascript:return deleteFile('<%= work_id %>','<%= cat%>','<%= clid%>')">
								<img border="0" src="../images/idelete.gif" TITLE="Delete"></a>
							</td>
							<td bgcolor="#EEEEEE" align="center" valign="middle">
								<a href="#" onclick="showAsgnInfo('<%=work_id%>');return false;">
								<img src="images/view_info.png"  border="0" TITLE="View Assignment Info"></a>
							</td>
<%  
						}
%>
						<td width="50%" bgcolor="#EFEFEF">
							<a href="#" onclick="showFile('<%=rs.getString("work_id")%>','<%=cat%>');return false;">
							<font size="2" face="verdana" color="#003366"><%=rs.getString("doc_name")%></font></a>
						</td>
						<td width="15%" height="18" bgcolor="#EEEEEE" align="center" valign="middle">
							<font size="2" face="verdana" color="">
							<%= rs.getDate("modified_date") %></font>
						</td>
						<td width="15%" height="18" bgcolor="#EEEEEE" align="center">
							<font size="2" face="verdana" color="">
<%
					if(rs.getDate("to_date")!=null)
						out.println(rs.getDate("to_date"));
					else
						out.println("-");
%>
					</font></td>
								<!-- <td width="17%" bgcolor="#EEEEEE" align="center">
									<font size="2" face="verdana" color=""><%=assign%></font>
								</td> -->
					</tr>
  <%          
					}
				}
		}
	}
catch(Exception e)
{
	System.out.println("AssignmentsByGroup.jsp operations on database Exception"+e.getMessage());
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
			ExceptionsFile.postException("AssignmentsByGroup.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }
	
  %>  	
</table>
</form>
</body>
</html>
