<!--
	/**
	 *Lists the AS/HW/PW documents according to the work category and provides links to view the *documents and to submit the work done by the student to the teacher
	 */
-->

<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.io.*,coursemgmt.ExceptionsFile" 
autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<HTML>
  
<%!
	int pageSize=250;				//no.of documents have to be display per page
	private int getPages(int tRecords)
	{
		int noOfPages;
		if((tRecords%pageSize)>0)
		{
			noOfPages=(tRecords/pageSize)+1;
		}
		else
		{
			noOfPages=(tRecords/pageSize);
		}
		return noOfPages;
	}
%>
<%
     Connection con=null;
	 Statement st=null;
	 ResultSet rs=null;

     int totrecords=0;				//total no of work documents

	 int start=0;						//from which record we hve to start
	 int end=0;						//up to which record we have to display
	 int status=0;					//status of the work Documents
	 int submitCount=0;				//gives no of submissions given by student	 
	 int maxAttempts=0;				//gives max attempts allowed on the work
	 int c=0,pages=0,pageNo=0,currentPage=0;

	 String studentId="",categoryId="",teacherId="",schoolId="",courseName="";
	 String distType="",workId="",courseId="",classId="",url="",docName="";
	 String col="",linkStr="",foreColor="",workStatus="",deadLine="",tag="",sessid="";
	 String asgnsType="",qrStr="",flgMsg="",qrStr1="";
     
	 boolean flag=true,atmtsAllOver=false;				//false if there are no work documents
	 boolean deadLineFlag=false,startLineFlag=false;		//false if the curr date is after the dead line & cur date before start date 
	 File dir=null;					//for temporary use
	 File dest=null;					//destination file to where we have to copy
	 File src=null;					//sourse file from which we have to copy
%>
<%
	try 
	{
		session=request.getSession();  //validating the existence of session
		sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		submitCount=0;		    
		schoolId=(String)session.getAttribute("schoolid");

		studentId=(String)session.getAttribute("emailid");
		if((courseId=request.getParameter("courseid"))==null)
		{
			courseId=(String)session.getAttribute("courseid");
		}
		else
		{
			session.setAttribute("courseid",courseId);
		}
		classId=(String)session.getAttribute("classid");

		categoryId=request.getParameter("cat");
		courseName=request.getParameter("coursename");

		asgnsType=request.getParameter("asgnstype");

		if(asgnsType == null)
			asgnsType="all";
		if(asgnsType.equals("all"))
		{
			qrStr="";
			qrStr1="";
		}
		else if(asgnsType.equals("pending"))
		{
			qrStr=" and d.status <= 1";
			qrStr1=" and d.status <= 1";
		}
		else if(asgnsType.equals("submitted"))
		{
			qrStr=" and d.status >= 4";
			qrStr1=" and d.status > 1";
		}

		con=con1.getConnection();
		if(request.getParameter("totrecords").equals("")) 
		{ 
			st=con.createStatement();
			flag=true;
			if(categoryId.equals("all"))
			{	
				//rs=st.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id where d.student_id='"+studentId+"' and (d.start_date<=curdate()) "+qrStr);
				
				rs=st.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id and d.status!=5 where d.student_id='"+studentId+"' and w.status='1' and (d.start_date<=curdate()) "+qrStr);
			}
			else
			{
				//rs=st.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on    w.work_id=d.work_id where d.student_id='"+studentId+"' and w.category_id='"+categoryId+"' and (d.start_date<=curdate()) "+qrStr);

				rs=st.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on    w.work_id=d.work_id and d.status!=5 where d.student_id='"+studentId+"' and w.category_id='"+categoryId+"' and w.status='1'and (d.start_date<=curdate()) "+qrStr);
			}
			
			rs.next();
			c=rs.getInt(1);
			if (c!=0 )
			{                 
				totrecords=c;
			}
			else
			{
				flag=false;
				if(asgnsType.equals("all"))
					flgMsg="There are no assignments available at this point of time.";
				else if(asgnsType.equals("pending"))
					flgMsg="There are no assignments pending for submission.";
				else if(asgnsType.equals("submitted"))
					flgMsg="There are no assignments submitted so far.";
			}
			rs.close();
			st.close();
		}
		else							         //if the parameter totrecords is not empty
			totrecords=Integer.parseInt(request.getParameter("totrecords"));    
					
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		deadLineFlag=true;	
				
		start=Integer.parseInt(request.getParameter("start")); 
		c=start+pageSize;
		end=start+pageSize;

		if (c>=totrecords)
			end=totrecords;
		currentPage=(start/pageSize)+1;
															 //select the fields to be displayed		
		if(categoryId.equals("all"))
		{
			//rs=st.executeQuery("select curdate(),d.status,d.start_date,d.end_date,d.work_id,max(submit_count) submit_count ,w.doc_name,w.teacher_id,category_id,w.modified_date,w.asgncontent,w.to_date,w.marks_total,w.max_attempts,w.status workstatus,w.from_date from " +schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id where d.student_id='"+studentId+"' and (d.start_date<=curdate()) "+qrStr1+" group by d.work_id LIMIT "+start+","+pageSize);

			rs=st.executeQuery("select curdate(),d.status,d.start_date,d.end_date,d.work_id,max(submit_count) submit_count ,w.doc_name,w.teacher_id,category_id,w.modified_date,w.asgncontent,w.to_date,w.marks_total,w.max_attempts,w.status workstatus,w.from_date from " +schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id and d.status!=5 where d.student_id='"+studentId+"' and w.status='1'and (d.start_date<=curdate()) "+qrStr1+" group by slno LIMIT "+start+","+pageSize);
		}
		else
		{
			//rs=st.executeQuery("select curdate(),d.status,d.start_date,d.end_date,d.work_id,max(submit_count) submit_count ,w.doc_name,w.teacher_id,category_id,w.modified_date,w.asgncontent,w.to_date,w.marks_total,w.max_attempts,w.status workstatus,w.from_date from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join " +schoolId+"_"+classId+"_"+courseId+"_dropbox d   on w.work_id=d.work_id where d.student_id='"+studentId+"' and w.category_id='"+categoryId+"' "+qrStr1+" and (d.start_date<=curdate()) group by d.work_id LIMIT "+start+","+pageSize); 
			
			rs=st.executeQuery("select curdate(),d.status,d.start_date,d.end_date,d.work_id,max(submit_count) submit_count ,w.doc_name,w.teacher_id,category_id,w.modified_date,w.asgncontent,w.to_date,w.marks_total,w.max_attempts,w.status workstatus,w.from_date from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join " +schoolId+"_"+classId+"_"+courseId+"_dropbox d   on w.work_id=d.work_id and d.status!=5 where d.student_id='"+studentId+"' and w.status='1' and w.category_id='"+categoryId+"' "+qrStr1+" and (d.start_date<=curdate()) group by slno LIMIT "+start+","+pageSize); 
		}
	}
	catch(SQLException e) 
	{
		ExceptionsFile.postException("StudentInbox.jsp","Operations on database","SQLException",e.getMessage());
		System.out.println("The Error: SQL - "+e.getMessage());
		try
		{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("The Error in StudentInbox.jsp: SQL - "+se.getMessage());
			ExceptionsFile.postException("StudentInbox.jsp","closing connection object","SQLException",se.getMessage());
		}
	}	
	catch(Exception e) 
	{
		ExceptionsFile.postException("StudentInbox.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
	}
%>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<link href="admcss.css" rel="stylesheet" type="text/css" />
<base target="main">
<link href="admcss.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">

function go(start,totrecords,cat){			 //script for calling a page
	
	window.location.href="StudentInbox.jsp?start="+ start+ "&totrecords="+totrecords+"&coursename=<%=courseName%>&cat="+cat;
		return false;
}
function gotopage(totrecords,cat)
{
	var page=document.filelist.page.value;
	if (page==0)
	{
		alert("Select page");
		return false;
	}
	else
	{
		start=(page-1)*<%=pageSize%>;
		window.location.href="StudentInbox.jsp?start="+ start+ "&totrecords="+totrecords+"&coursename=<%=courseName%>&cat="+cat;
		return false;
	}
}
function showHistory(workid,maxattempt,category,dname)
{
	parent.contents.location.href="ShowHistory.jsp?workid="+workid+"&maxattempts="+maxattempt+"&category="+category+"&docname="+dname;
	return false;
}

function goAssignmentType()
{
	var astype=document.filelist.asgntype.value;
	parent.contents.location.href="StudentInbox.jsp?totrecords=&start=0&cat=<%=categoryId%>&coursename=<%=courseName%>&courseid=<%=courseId%>&asgnstype="+astype;
	return false;
}
function open_help(){
		window.open("st_assgn_list_help.html","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=400, height=200")
	}
</script>

</head>
<body topmargin=0 leftmargin=3>
<form name="filelist">

<table border="0" width="100%" cellspacing="1"  >
<tr>
    <td  height="21" width="33%" align="left">
		<font size="2" face="verdana" >
			Assignments <%= (start+1) %> - <%= end %> of <%= totrecords %>
		</font>
	</td>
	<td  height="21" align="center" width="34%">
		<font size="2" face="verdana" >
<%
		/*to provide navigation like prev|next if the documents are more than the pagesize*/
	   	if(start==0 ) 
		{    
			if(totrecords>end)
			{
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"','"+categoryId+"');return false;\" target='contents'> Next</a>&nbsp;&nbsp;");
			}
			else
				out.println("Previous | Next &nbsp;&nbsp;");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totrecords+"','"+categoryId+"'); return false;\" target='contents'>Previous</a> |";

			if(totrecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"','"+categoryId+"'); return false; \" target='contents'> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);
		}	
%>
		</font>
	</td>
	<td width="351" >
		<a href="javascript://" onclick=open_help() style="cursor: pointer;cursor: hand;"><font size="2" face="Arial" color="#FFFFFF">Help!</font></a>
 </td>
	<td  height='21' align='right' width="33%">
		<select size="1" name="asgntype" onChange="goAssignmentType(); return false;">
			<option value="all" selected>All Assignments</option>
			<option value="pending">Pending Assignments</option>
			<option value="submitted">Submitted Assignments</option>
		</select>
	</td>
</tr>
</table>
<script>
	document.filelist.asgntype.value="<%=asgnsType%>";
</script>
<% 
	if (flag==false)	//if there are no work documents to the student
	{		
%>	
		<table border="0" width="100%" cellspacing="1" >
		<tr>	
			<td width='100%'  height='21'>
				<font face='verdana' size='2'>
					<b><%=flgMsg%></b>
				</font>
			</td>
		</tr>
		</table>
<%
		return;
	}
%>
</table>

<!-- For displaying the details the of the work documents in a tabular format -->
<table width="100%">
<tr>   
	<td class="gridhdr">
		&nbsp;Assignment Name</td>
	<td class="gridhdr">
		Submission History</td>
	<td class="gridhdr">
		Points</td>
    <td class="gridhdr">
		Open Date</td>
	<td class="gridhdr">
		Close Date</td>
</tr>

<%
	try
	{
		while(rs.next())
	    {
			atmtsAllOver=true;
			
			workId=rs.getString("work_id");
			categoryId=rs.getString("category_id");
			docName=rs.getString("doc_name");

			docName=docName.replaceAll("&#39;","&#92;&#39;");

			docName=docName.replaceAll("&#34;","&#92;&#34;");

			//docName=docName.replaceAll("\"","&#92;&#34;");

			teacherId=rs.getString("teacher_id");
			maxAttempts=rs.getInt("max_attempts");
			workStatus=rs.getString("workstatus");
			status=rs.getInt("status");
			submitCount=rs.getInt("submit_count");
			
			
			if(maxAttempts!=-1)
				tag=""+maxAttempts;
			else
				tag="No Limit";
			
						
		/*
			if(status==0)				//student not yet viewed the work document
				foreColor="#FF0000";
			else if(status==1)			//the student viewed the document
				foreColor="#006666";		
			else if (status==2)			//the student submitted the work given
				foreColor="#6D79CD";
			else if (status==3)		    //the teacher viewed the submitted work
				foreColor="#005900";		
			else if ((status==4)||(status==5))//the teacher had evaluated||the student viewed the results
				foreColor="#FF7B4F";
			else if (status==6)
				foreColor="#993399";

				*/

			if(rs.getString("end_date")!=null)
			{
				if(!rs.getString("end_date").equals("0000-00-00"))
				{ 	  
					if((rs.getDate(1).compareTo(rs.getDate("end_date")) <=0))
					{  
						/*current date is before than the deadline*/
						deadLineFlag=true;
						foreColor="green";
					}
					else
					{
						deadLineFlag=false;		    //last date to submit is over
						foreColor="blue";
					}
					deadLine=rs.getDate("end_date").toString();
				}
			}
			else
				deadLine="-";

			if((rs.getDate(1).compareTo(rs.getDate("end_date")) <=0))
			{
				if((rs.getDate(1).compareTo(rs.getDate("start_date")) >=0))
					{  
						/*current date is before than the deadline*/
						startLineFlag=true;
						foreColor="green";
					}
					else
					{
						startLineFlag=false;		    //last date to submit is over
						foreColor="blue";
					}
				
			}
			if(!tag.equals("No Limit"))
			{
				if(submitCount==0 && rs.getDate(1).compareTo(rs.getDate("start_date")) <=0)
				{
					foreColor="red";
				}
				else if(submitCount==0 && rs.getDate(1).compareTo(rs.getDate("end_date")) <=0)
				{
					foreColor="red";
				}
				else if(submitCount==Integer.parseInt(tag))
				{
					foreColor="blue";
					atmtsAllOver=false;
				}
			}
			else
			{
				if(submitCount==0 && rs.getDate(1).compareTo(rs.getDate("start_date")) <=0)
				{
					foreColor="red";
				}
			}
			
			
			
%>	
	<tr >
		<td class="griditem">
			<%
	
			if(deadLineFlag)
			{
	%>
				<a href="InboxFrameAssgnBuilder.jsp?workid=<%=workId%>&cat=<%=categoryId%>&coursename=<%=courseName%>&status=<%=status%>&flag=<%=deadLineFlag%>&workstatus=<%=workStatus%>&maxattempts=<%=maxAttempts%>&submitcount=<%=submitCount%>" onClick="parent.category.document.leftpanel.asgncategory.value='<%=categoryId%>'" target="contents"><%=docName.replaceAll("&#92;&#39;","&#39;")%></a>
	<%
				}
				else if(!deadLineFlag)
				{
				%>			
					 <font size="2" face="verdana" color="<%=foreColor%>" title="Due date is passed"><%=docName.replaceAll("&#92;&#39;","&#39;")%>
				<%

				}
				else if (!startLineFlag)
				{
					
					
	%>			
					 <font size="2" face="verdana" color="<%=foreColor%>" title="Due date is passed"><%=docName.replaceAll("&#92;&#39;","&#39;")%>
	<%
				}
				else if(atmtsAllOver)
				{
				%>			
					 <font size="2" face="verdana" color="<%=foreColor%>" title="Due date is passed"><%=docName.replaceAll("&#92;&#39;","&#39;")%>
				<%
				}
				
				%>
		</td>
		<%
					
				docName=docName.replaceAll("\"","&#92;&#34;");
		%>
		<td class="griditem">
			
				<a href="javascript://" onClick="showHistory('<%=workId%>','<%=maxAttempts%>','<%=categoryId%>','<%=docName.replaceAll("'","&#92;&#39;")%>'); return false;">
					<%=submitCount%>&nbsp;/&nbsp;<%=tag%>
				</a>
			
		</td>
		<td class="griditem">
			<%=rs.getInt("marks_total")%>
		</td>
		<td class="griditem">
			<%= rs.getDate("start_date")%>
		</td>
		<td class="griditem">
			<%=deadLine%>
		</td>
	</tr>
		
<%        
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception in StudentInbox.jsp is..."+e.getMessage());
		ExceptionsFile.postException("StudentInbox.jsp","displaying","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("stuInBox.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>  
       
</table>
</form>
</BODY>
</html>