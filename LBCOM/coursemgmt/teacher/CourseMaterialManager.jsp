<%@page import = "java.sql.*,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
    int totRecords=0,pageSize=5,start=0,end=0,c=0,status=0,flag=0,assStu=0,viewedStu=0;
	String categoryId="",linkStr="",schoolId="",teacherId="",courseName="",sectionId="",workId="",url="",newTeacherId="",checked="";
	String courseId="",foreColor="",bgColor="",topic="",subtopic="",topicId="",subtopicId="",type=""; 	
%>
<%
	try
	{
		session=request.getSession();
		String s=(String)session.getAttribute("sessid");
		if(s==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		con=con1.getConnection();
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		sectionId=(String)session.getAttribute("classid");
		categoryId=request.getParameter("cat");
		type=request.getParameter("type");
		courseId=(String)session.getAttribute("courseid");
		Hashtable hsSelIds=new Hashtable();
		session.putValue("seltIds",hsSelIds);
		
		// Modifed by ranga

		st=con.createStatement();
		session.putValue("catType",type);
		if(type.equals("CO") && request.getParameter("tag").equals("true"))
		{
			rs=st.executeQuery("Select idx_file_path from category_index_files where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' and item_id='"+categoryId+"'");

			if(rs.next())
			{
				String fPath=(String)session.getAttribute("schoolpath")+schoolId+"/"+rs.getString("idx_file_path");
				//String fPath="../../schools/"+schoolId+"/"+rs.getString("idx_file_path");
				out.println("<html><script> window.location.href='"+fPath+"'; \n </script></html>");				
				return;
			}
			rs.close();
		}

		newTeacherId=teacherId.replace('@','_').replace('.','_');
		if(request.getParameter("totrecords").equals("")) 
		{ 
			if(categoryId.equals("all"))
			{
				rs=st.executeQuery("Select count(*) from course_docs c inner join category_item_master d on c.category_id=d.item_id and c.school_id=d.school_id where teacher_id='"+teacherId+"' and c.course_id='"+courseId+"' and d.course_id='"+courseId+"' and section_id='"+sectionId+"' and d.category_type='"+type+"' and c.school_id='"+schoolId+"'");
			}
			else
			{
				rs=st.executeQuery("Select count(*) from course_docs where category_id='"+categoryId+"' and teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"' and section_id='"+sectionId+"'");
			}
			rs.next();
			c=rs.getInt(1);
			
			if(c!=0 )
			{
				totRecords=rs.getInt(1);
			}
			else
			{
				out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
				out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='verdana' color='#FF0000' size='2'>There are no files available.</font></b></td></tr></table>");				
				return;
			}
		}
		else
		{
			totRecords=Integer.parseInt(request.getParameter("totrecords"));
		}
		   
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		st1=con.createStatement();
		start=Integer.parseInt(request.getParameter("start"));
		
		c=start+pageSize;
		end=start+pageSize;
		if(c>=totRecords)
			end=totRecords;
		
		if(categoryId.equals("all"))
		{
			rs=st.executeQuery("Select * from course_docs c inner join category_item_master d on c.category_id=d.item_id and c.school_id=d.school_id where teacher_id='"+teacherId+"' and c.course_id='"+courseId+"' and d.course_id='"+courseId+"' and section_id='"+sectionId+"' and d.category_type='"+type+"' and c.school_id='"+schoolId+"' order by c.status limit "+start+","+pageSize);
		}
		else
		{
			rs=st.executeQuery("SELECT * FROM course_docs where category_id='"+categoryId+"' and school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and  section_id='"+sectionId+"' and course_id='"+courseId+"' order by status LIMIT "+start+","+pageSize);
		}
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("courseDoclist.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("CoursesDocList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in CourseMaterialManager.jsp is..."+se.getMessage());
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("courseDoclist.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	}	
%>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<base target="main">

<SCRIPT LANGUAGE="JavaScript">
<!--

function go(start,totrecords,cat)
{		
	parent.bottompanel.location.href="CoursesDocList.jsp?start="+ start+ "&totrecords="+totrecords+"&cat="+cat+"&type=<%=type%>";
	return false;
}

function deleteFile(workid,cat)
{
	if(confirm("Are you sure you want to delete the file?"))
	{
		//parent.bottompanel.location.href="/servlet/coursemgmt.CourseManagerFun?basefoldername=&mode=delete&newfoldername=&oldfoldername=&selids="+workid+"&cat=<%=categoryId %>";
		parent.toppanel.document.leftpanel.asgncategory.value=cat;
		parent.bottompanel.location.href="/LBCOM/coursemgmt.CourseManagerFun?basefoldername=&mode=delete&newfoldername=&oldfoldername=&selids="+workid+"&cat="+cat+"&type=<%=type%>";
	}
	return false;
}

function deleteAllFiles(cat)
{
	var selid=new Array();
    with(document.fileslist) 
	{
		for(var i=0,j=0; i < elements.length; i++) 
		{
			if(elements[i].type == 'checkbox' && elements[i].name == 'selids' &&elements[i].checked==true)
				selid[j++]=elements[i].value;
		}
	}
    if(j>0) 
	{
		if(confirm("Are you sure you want to delete the selected file(s)?"))
		{
			parent.toppanel.document.leftpanel.asgncategory.value=cat; parent.bottompanel.location.href="/LBCOM/coursemgmt.CourseManagerFun?basefoldername=&mode=deleteall&newfoldername=&oldfoldername=&selids="+selid+"&cat="+cat+"&docname=&type=<%=type%>";
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
			for(var i=0; i < elements.length; i++) 
			{
				if(elements[i].type == 'checkbox' && elements[i].name == 'selids')
					elements[i].checked = false;
			}
		}
	}
}

/*	function showFile(workfile,docname){

		var teacherid='<%= teacherId %>';
		var schoolid='<%= schoolId %>';
		window.open("../../schools/dropbox/"+schoolid+"/"+teacherid+"/<%= categoryId %>/"+workfile,docname,'width=600,height=600,toolbars=no');
		return false;


	}*/

function displayStudents(workid,docname,checked,cat)
{
	//alert(checked);
	parent.toppanel.document.leftpanel.asgncategory.value=cat;	//parent.bottompanel.location.href="AssStudentsList.jsp?start=0&totrecords=&checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&type=<%=type%>";
		
	parent.bottompanel.location.href="AsgnFrames.jsp?start=0&totrecords=&checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&type=<%=type%>";
	return false;
}

function editWork(workid,category)
{		
	parent.toppanel.document.leftpanel.asgncategory.value=category;	parent.bottompanel.location.href="EditCourseWork.jsp?workid="+workid+"&cat="+category+"&type=<%=type%>";		
	return false;
}
//-->
</SCRIPT>


</head>

<body topmargin=0 leftmargin=3>
<form name="fileslist">
<table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
<tr>
	<td width="100%" >
		<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
		<tr>
			<td width="60%" bgcolor="#C2CCE0" height="21" colspan="7" align="left">
				<font size="2" face="verdana">
				<span class="last">Files <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</span>
				<font color="#000080">
<%
	if(start==0 ) 
	{ 
		if(totRecords>end)
		{
			out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+categoryId+"');return false;\"> Next</a>&nbsp;&nbsp;");
		}
		else
			out.println("Previous | Next &nbsp;&nbsp;");
	}
	else
	{
		linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+categoryId+"'); return false;\">Previous</a> |";
		if(totRecords!=end)
		{
			linkStr=linkStr+"<a href=\"#\" onclick=\" go('"+(start+pageSize)+ "','"+totRecords +"','"+categoryId+"'); return false;\"> Next</a>&nbsp;&nbsp;";
		}
		else
			linkStr=linkStr+" Next&nbsp;&nbsp;";
		out.println(linkStr);
	}	
%>
				</font>
			</td>
<%
	if(categoryId.equals("all"))
	{
%>
		<td width="40%" bgcolor="#C2CCE0" height="21" colspan="3"></td>
<%
	}
	else
	{
%>
		<td width="40%" bgcolor="#C2CCE0" height="21" colspan="3" align="right">
			<font size="2" face="verdana">
			<span class="last"><a href="EditCategoryItem.jsp?mode=edit&itemid=<%=categoryId%>&cat=<%=type%>" target="bottompanel">Edit</a></span>
		</td>
<%
	}
%>
	</tr>
	<tr>
		<td width="16" bgcolor="#CECBCE" height="21" align="center" valign="middle">
			<input type="checkbox" name="selectall" onclick="selectAll()" value="ON" title="Select or deselect all files">
		</td>
		<td width="14" bgcolor="#CECBCE" height="18" align="center" valign="middle">
			<font size="2" face="verdana" color="#000080"><b>
			<a href="#" onclick="return deleteAllFiles('<%= categoryId%>')" >
			<img border="0" src="../images/iddelete.gif"  TITLE="Delete selected files" width="19" height="21"></b></font></a>
		</td>
		<td width="14" bgcolor="#CECBCE" height="18" align="center" valign="middle">&nbsp;</td>
		<td width="13" bgcolor="#CECBCE" align="center" valign="middle">&nbsp;</td>
		<td width="150" bgcolor="#CECBCE" height="21" align="center"><b>
			<font size="2" face="verdana" color="#000080">Document Name</font></b>
		</td>
		<td width="92" bgcolor="#CECBCE" height="21" align="center">
			<font size="2" face="verdana" color="#000080"><b>Topic</b></font>
		</td>
		<td width="101" bgcolor="#CECBCE" height="21" align="center">
			<font size="2" face="verdana" color="#000080"><b>Subtopic</b></font>
		</td>
		<td width="100" bgcolor="#CECBCE" height="21" align="center">
			<font size="2" face="verdana" color="#000080"><b>Created Date</b></font>
		</td>
		<td width="100" bgcolor="#CECBCE" height="21" align="center">
			<font size="2" face="verdana" color="#000080"><b>Assigned To</b></font>
		</td>
		<td width="100" bgcolor="#CECBCE" height="21" align="center">
			<font size="2" face="verdana" color="#000080"><b>Accessed By</b></font>
		</td>
	</tr>
<%
	try
	{
   		while(rs.next())
	    {		
			topic="-";
			subtopic="-";
			bgColor="#EFEFEF";
			workId=rs.getString("work_id");
			categoryId=rs.getString("category_id");
			flag=rs.getInt("status");  
			topicId=rs.getString("topic");
			subtopicId=rs.getString("sub_topic");
			
			rs1=st1.executeQuery("select topic_des from topic_master where topic_id='"+topicId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
			if (rs1.next()) 
			{
				topic=rs1.getString("topic_des");
				rs1.close();
				rs1=st1.executeQuery("select subtopic_des from subtopic_master where topic_id='"+topicId+"' and subtopic_id='"+subtopicId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				if(rs1.next())
					subtopic=rs1.getString("subtopic_des");
			}
			
			if(flag==0) 
				foreColor="#000000";
			else
				foreColor="#003366";
%>

	<tr>
		<td width="16" height="18" bgcolor="<%=bgColor%>" align="center" valign="middle">
			<font size="2" face="verdana"><input type="checkbox" name="selids" value="<%=workId %>"></font>
		</td>
		<td width="14" height="18" bgcolor="<%=bgColor%>" valign="middle" align="center">
			<font size="2" face="verdana"><a href="#" onclick="return deleteFile('<%= workId %>','<%=categoryId%>')" >
			<img border="0" src="../images/idelete.gif" TITLE="Delete" ></a></font>
		</td>
		<td width="14" height="18" bgcolor="<%=bgColor%>" align="center" valign="middle">
			<font size="2" face="verdana" color="<%=foreColor%>">
			<a href="#" onclick="editWork('<%= workId %>','<%=categoryId%>'); return false;">
			<img border="0" src="../images/iedit.gif" TITLE="Edit" ></a></font>
		</td>
<%
	viewedStu=0;
	assStu=0;
	if(flag==1)
	{ 
		int i=0;
		checked="";
		rs1=st1.executeQuery("select * from course_docs_dropbox where school_id='"+schoolId+"' and work_id= any(select work_id from course_docs where school_id='"+schoolId+"' and work_id='"+workId+"')");
		while (rs1.next()) 
		{
			if((rs1.getInt("status"))==1)
				viewedStu++;
			assStu++;
			if(i==0) 
			{
				checked=rs1.getString("student_id");
			}
			else
			{
				checked+=","+rs1.getString("student_id");
			}
			i++;
		}
%>
		<td width="14" bgcolor="<%=bgColor%>" height="18" align="center" valign="middle">
			<a href="#" onclick="displayStudents('<%= workId %>','<%= rs.getString("doc_name")%>','<%=checked%>','<%=categoryId%>'); return false;">
			<img src="../images/iassign.gif" border="0" TITLE="Assign to Students" ></a>
		</td>
<%
	}
	else
	{
%>
		<td width="14" bgcolor="<%=bgColor%>" height="18" align="center" valign="middle">
			<a href="#" onclick="displayStudents('<%= workId %>','<%= rs.getString("doc_name")%>','','<%=categoryId%>'); return false;">
			<img src="../images/iassign.gif" border="0" TITLE="Assign to Students"></a>
		</td>
<%
	}
%>
		<td width="150" height="18" align="left" valign="middle" bgcolor="<%=bgColor%>">
			<font size="2" face="verdana" color="<%=foreColor%>">
			<a href="CourseFileManager.jsp?foldername=<%=workId%>&docname=<%=rs.getString("doc_name")%>&cat=<%=categoryId%>&workid=<%=workId%>&tag=&status=&type=<%=type%>" onclick="		parent.toppanel.document.leftpanel.asgncategory.value='<%=categoryId%>'" target="bottompanel"><%=rs.getString("doc_name")%></a></font>
		</td>
		<td width="92" height="18" align="left" valign="middle" bgcolor="<%=bgColor%>">
			<font size="2" face="verdana" color="<%=foreColor%>"><%=topic %></font>
		</td>
		<td width="101" height="18" align="left" valign="middle" bgcolor="<%=bgColor%>">
			<font size="2" face="verdana" color="<%=foreColor%>"><%=subtopic %></font>
		</td>
		<td width="100" height="18" align="center" valign="middle" bgcolor="<%=bgColor%>">
			<font size="2" face="verdana" color="<%=foreColor%>"><%=rs.getDate("created_date") %></font>
		</td>
		<td width="100" height="18" align="center" valign="middle" bgcolor="<%=bgColor%>">
			<font size="2" face="verdana" color="<%=foreColor%>"><%=assStu%></font>
		</td>
		<td width="100" height="18"  align="center" valign="middle" bgcolor="<%=bgColor%>">
			<font size="2" face="verdana" color="<%=foreColor%>"><%=viewedStu%></font>
		</td>
	</tr>
<%          
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CoursesDocList.jsp","operations on database","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("CoursesDocList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>  
		</table>
	</td>
</tr>
</table>
</form>
</body>
</html>		
