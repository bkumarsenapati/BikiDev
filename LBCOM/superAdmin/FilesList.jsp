<!-- Lists the Work Assignments files by categorywise(HW/PW/AS)     -->


<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=15;
%>
<%
         Connection con=null;
	 Statement st=null,st1=null;
	 ResultSet rs=null,rs1=null;
	 
         int totRecords=0,start=0,end=0,c=0,stuStatus=0,tot=0;
	 String cat="",linkStr="",schoolId="",teacherId="",courseName="",classId="",workId="",status="",workFlag="",bgColor="";
	 String checked="",courseId="",forecolor="",topicId="",subtopicId="",topic="",subtopic="",sessid="";
	 String sortStr="",sortingBy="",sortingType="";
	 Hashtable hsSelIds=null;
	 boolean flag=false;
	 int currentPage=0;

%>
<%
		try
		{

			session=request.getSession();
			sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
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
                        if (sortingType==null)
				sortingType="A";

			
			if(!status.equals(""))
				status="Your work has been assigned successfully.";
			if (request.getParameter("totrecords").equals("")) 
			{ 
				st=con.createStatement();
				if(cat.equals("all")){
					rs=st.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"'");
				}else{
					rs=st.executeQuery("Select count(*) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where  teacher_id='"+teacherId+"' and category_id='"+cat+"'");
				}
				rs.next();
				c=rs.getInt(1);
				if (c!=0 ){
					totRecords=rs.getInt(1);
				}
				else{

					out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
					out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Requested item is not available yet.</font></b></td></tr></table>");				
					return;


				}
			}
			else
				totRecords=Integer.parseInt(request.getParameter("totrecords"));
		   
		   st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		   start=Integer.parseInt(request.getParameter("start"));

		
		   c=start+pageSize;
		   end=start+pageSize;
		   
		    if (sortingBy==null || sortingBy.equals("null")){
				sortStr="modified_date desc";
				sortingBy="md";
				sortingType="D";
		      }else{

			       if (sortingBy.equals("en"))
				        sortStr="doc_name";
			        else if (sortingBy.equals("md"))
				         sortStr="modified_date";

			        if (sortingType.equals("A")){
					sortStr=sortStr+" asc";
				  }
				   else{
					sortStr=sortStr+" desc";
				   }
		            }
		   

		   if (c>=totRecords)
			   end=totRecords;
		   flag=true;
		   if(cat.equals("all")){
				rs=st.executeQuery("select   curdate(),work_id,doc_name,category_id,work_file,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' order by "+sortStr+" LIMIT "+start+","+pageSize);
		   }else{
			   rs=st.executeQuery("select   curdate(),work_id,doc_name,category_id,work_file,modified_date,marks_total,to_date,status,topic,subtopic from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and category_id='"+cat+"' order by "+sortStr+" LIMIT "+start+","+pageSize);
		   }
		   bgColor="#DBD9D5"; 
		   currentPage=(start/pageSize)+1;
		   
		}
		catch(SQLException e)
		{
			ExceptionsFile.postException("FilesList.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}catch(SQLException se){
				ExceptionsFile.postException("FilesList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				
			}
		}	

		catch(Exception e)
		{
			ExceptionsFile.postException("FilesList.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	
		}	

%>


<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=application.getInitParameter("title")%></title>
<base target="main">

<SCRIPT LANGUAGE="JavaScript">
<!--

	function go(start,totrecords,cat,sortby,sorttype){	
			parent.bottompanel.location.href="FilesList.jsp?start="+ start+ "&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;
		return false;
	}
	function gotopage(totrecords,cat,sortby,sorttype){
		var page=document.fileslist.page.value;
		if(page==0){
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			parent.bottompanel.location.href="FilesList.jsp?start="+ start+ "&totrecords="+totrecords+"&status=&cat="+cat+"&sortby="+sortby+"&sorttype="+sorttype;	
			return false;
		}
	}

	function deleteFile(workid,cat){
		if(confirm("Are you sure you want to delete the file?")==true){			//parent.bottompanel.location.href="/servlet/coursemgmt.AddWork?mode=del&workid="+workid+"&cat="+cat;
   		parent.toppanel.document.leftpanel.asgncategory.value=cat;
    	parent.bottompanel.location.href="/LBCOM/coursemgmt.AddWork?mode=del&workid="+workid+"&cat="+cat;
		return false;
		}
		else
			return false;
	}

    function deleteAllFiles(cat){

        var selid=new Array();
        with(document.fileslist) {
             for (var i=0,j=0; i < elements.length; i++) {
                    if (elements[i].type == 'checkbox' && elements[i].name == 'selids' && elements[i].checked==true)
                            selid[j++]=elements[i].value;
              }
         }
         if (j>0) {
                if(confirm("Are you sure you want to delete the selected file(s)?")==true){
      		   	   parent.toppanel.document.leftpanel.asgncategory.value=cat;

                   parent.bottompanel.location.href="/LBCOM/coursemgmt.AddWork?mode=deleteall&cat="+cat+"&selids="+selid;
                   return false;
                }
                else
                    return false;
         }else {
               alert("Please select the file(s) to be deleted");
               return false;
        }
    }

	function selectAll(){
	
		if(document.fileslist.selectall.checked==true){
			with(document.fileslist) {
				 for (var i=0; i < elements.length; i++) {
			        if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
						elements[i].checked = true;
	              }
			}
		}else{

			with(document.fileslist) {
				 for (var i=0; i < elements.length; i++) {
			        if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
						elements[i].checked = false;
                  }
			}
		}
	}

	function showFile(workfile,dname,cat){

		var teacherId='<%= teacherId %>';
		var docname=dname;
		var schoolid='<%= schoolId %>';
		window.open("<%=(String)session.getAttribute("schoolpath")%>"+schoolid+"/"+teacherId+"/coursemgmt/<%=courseId%>/"+cat+"/"+workfile,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
	}

	function displayStudents(workid,docname,checked,cat,total){
     		parent.toppanel.document.leftpanel.asgncategory.value=cat;			parent.bottompanel.location.href="AsgnFrames.jsp?checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&tag=db&type=AS&total="+total;
			
			//parent.bottompanel.location.href="AssStudentsList.jsp?start=0&totrecords=&checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&tag=db&type=AS&total="+total;

	}

	function editWork(workid,category,submit,eval){	//modified on 10-11-2004	
		parent.toppanel.document.leftpanel.asgncategory.value=category;
		window.location.href="EditWork.jsp?docs="+workid+"&cat="+category+"&submit="+submit+"&eval="+eval;	
	}



//-->
</SCRIPT>


</head>

<body topmargin=0 leftmargin=2>
<form name="fileslist">
<center>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td width="100%" >
        <div align="center">


<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0"  >

  <tr>
	<td colspan="15">

	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>

	<td width="200" bgcolor="#C2CCE0" height="21">

      <sp align="right"><font size="2" face="Arial" ><span class="last">Files <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</span></font>

		</td><td bgcolor="#C2CCE0" height="21" align="center"><font color="#000080" face="arial" size="2">
	  <%

	  	if(start==0 ) { 
			
			if(totRecords>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+cat+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+cat+"','"+sortingBy+"','"+sortingType+"');return false;\">Previous</a> |";


			if(totRecords!=end){
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+cat+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

	  
	  %>
	  
	  </font></td>
	  
	  <td  bgcolor='#C2CCE0' height='21' align='right' ><font face="arial" size="2">Page&nbsp;
	  <%int index=1;
	    int str=0;
	    int noOfPages=0;
		if((totRecords%pageSize)>0)
		    noOfPages=(totRecords/pageSize)+1;
		else
			noOfPages=totRecords/pageSize;
		out.println("<select name='page' onchange=\"gotopage('"+totRecords+"','"+cat+"','"+sortingBy+"','"+sortingType+"');return false;\"> ");
		while(index<=noOfPages){
				
				if(index==currentPage){
				    out.println("<option value='"+index+"' selected>"+index+"</option>");
				}else{
					out.println("<option value='"+index+"'>"+index+"</option>");
				}
				index++;
				str+=pageSize;

		
	   }%>
	  </select>
	  </font></td>
	  </tr>
	  </table>
  </td>
  </tr>
  
  <tr>
    <td width="12" bgcolor="#CECBCE" height="21" align="center" valign="middle">
		<input type="checkbox" name="selectall" onclick="javascript:selectAll()" title="Select or deselect all files">
	</td>
	<td width="12" bgcolor="#CECBCE" height="18" align="center" valign="middle">
		<font size="2" face="Arial" color="#000080"><b>
		<a href="#" onclick="return deleteAllFiles('<%= cat%>')">
		<img border="0" src="../images/iddelete.gif" TITLE="Delete selected files"></b></font></a>
	</td>
    <td width="12" bgcolor="#CECBCE" height="18" align="center" valign="middle">&nbsp;</td>
    <td width="12" bgcolor="#CECBCE" align="center" valign="middle">&nbsp;</td>
	 <td width="12" bgcolor="#CECBCE" align="center" valign="middle">&nbsp;</td>
	 
<%	 
      String bgColorDoc="#CECBCE",bgColorDate="#CECBCE";	 
      if(sortingBy.equals("en"))
      {     bgColorDoc= "#CBCBEE";     }
      if(sortingBy.equals("md"))	 
	{      bgColorDate= "#CBCBEE";   } 
%>	 
    <td width="125" bgcolor='<%=bgColorDoc%>' align="center" height="21">
    <%  if((sortingType.equals("D"))&&(sortingBy.equals("en"))){
    %>
    	<a href="./FilesList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=en&sorttype=A&status=" target="_self">
    	<img border="0" src="images/sort_dn_1.gif"></a>
   <%   }else{  %>
   	<a href="./FilesList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=en&sorttype=D&status=" target="_self">
    	<img border="0" src="images/sort_up_1.gif"></a>
   <%   }  %>		
        <font size="2" face="Arial" color="#000080"><b>Document</b></font></td>
    </td>
     <td width="69" bgcolor='<%=bgColorDate%>' align="center" height="21">
   <%  if((sortingType.equals("D"))&&(sortingBy.equals("md"))){
    %>  
     	 <a href="./FilesList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=md&sorttype=A&status=" target="_self">
    	 <img border="0" src="images/sort_dn_1.gif"></a>
     <%   }else{  %>     
	 <a href="./FilesList.jsp?totrecords=<%=totRecords%>&start=<%=start%>&cat=<%=cat%>&sortby=md&sorttype=D&status=" target="_self">
    	 <img border="0" src="images/sort_up_1.gif"></a>
     <%   }  %>	 
	 <font size="2" face="Arial" color="#000080"><b>Date</b></font>
    </td>
   <td width="75" bgcolor="#CECBCE" align="center" height="21">
		<font size="2" face="Arial" color="#000080"><b>Topic</b></font></td>
    <td width="100" bgcolor="#CECBCE" align="center" height="21">
		<font size="2" face="Arial" color="#000080"><b>Subtopic</b></font> </td>
    <td width="76" bgcolor="#CECBCE" align="center" height="21">
		<font size="2" face="Arial" color="#000080"><b>Max Points</b></font></td>
    <td width="79" bgcolor="#CECBCE" align="center" height="21">
		<font size="2" face="Arial" color="#000080"><b>Due Date</b></font></td>
	 <td align="center"  width="12" bgcolor="#CECBCE" height="21">
		<img border="0" src="../images/idassign.gif"  TITLE="Number of assigned students"></td>
	 <td align="center"  width="12" bgcolor="#CECBCE" height="21">
		<img border="0" src="../images/idsubmit.gif"  TITLE="Submissions"></td>
 	 <td width="12" align="center"  bgcolor="#CECBCE" height="21">
		<img border="0" src="../images/ideval.gif"  TITLE="Number of evaluated submissions"></td>
 	 <td width="12" align="center"  bgcolor="#CECBCE" height="21">
		<img border="0" src="../images/idpending.gif"  TITLE="Number of submissions pending for evaluation"></td>
</tr>

<%
	int assign=0,eval=0,pending=0,submit=0;
	bgColor="#EFEFEF";

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
			rs1=st1.executeQuery("select topic_des from topic_master where topic_id='"+topicId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
			
			if (rs1.next()) {
				topic=rs1.getString("topic_des");
					
				rs1.close();
				rs1=st1.executeQuery("select subtopic_des from subtopic_master where topic_id='"+topicId+"' and subtopic_id='"+subtopicId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				if (rs1.next())
				  subtopic=rs1.getString("subtopic_des");
				  

			}
			
			rs1.close();

			if((workFlag.equals("1"))||workFlag.equals("2")) {
				
				int i=0;
				checked="";
				rs1=st1.executeQuery("select student_id from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"'");
				
				while(rs1.next()){
					if (i==0) {
							checked=rs1.getString("student_id");
					}	else {
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

				forecolor="#003366";
				rs1.close();
				
				
			    
				if (assign==submit) {
					if (submit==eval) 
						forecolor="#999966";
				}

			}else {
				
				assign=submit=eval=pending=0;
				forecolor="#000000";
			}
			
			if(rs.getDate("to_date")!=null){
				
				if ((rs.getDate(1).compareTo(rs.getDate("to_date")) <=0)) {  
								//	 current date is before than the deadline
					flag=true;
				}
				else {
					flag=false;
					forecolor="#996666";
				
				}
			}else{
                             flag=true;
}
			
			if (workFlag.equals("2")) {forecolor="#666699";%>

				<tr>
			    <td  height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial" color="<%=forecolor%>"><input type="checkbox" name="selids" value="<%=workId %>"></font></td>

				<td  height="18" bgcolor="<%= bgColor %>" valign="middle" align="center"><font size="2" face="Arial" color="<%=forecolor%>"><img border="0" src="../images/idelete.gif" TITLE="Delete" ></font></td>
			    <td height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial" color="<%=forecolor%>"><img border="0" src="../images/iedit.gif" TITLE="Edit" ></font></td>	
			    <td  bgcolor="<%= bgColor %>" height="18" align="center" valign="middle">
   				<img src="../images/iassign.gif"  border="0" TITLE="Assign to Students" ></td> 
				<td  bgcolor="<%= bgColor %>" height="18" align="center" valign="middle"><img src="../images/ieval.gif"  border="0" TITLE="Evaluate Submissions" ></td>

			<%} else	{%>

			<tr>
			<td  height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial" color="<%=forecolor%>"><input type="checkbox" name="selids" value="<%=workId %>"></font></td>

	          <td  height="18" bgcolor="<%= bgColor %>" valign="middle" align="center"><font size="2" face="Arial" color="<%=forecolor%>"><a href="#" onclick="javascript:return deleteFile('<%= workId %>','<%= cat%>')" ><img border="0" src="../images/idelete.gif" TITLE="Delete"></a></font></td>
			  <% if (flag==false) { 	%>

			  <td  height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial" color="<%=forecolor%>">
			  <img border="0" src="../images/iedit.gif" TITLE="Edit"></font></td>	

			  <td  bgcolor="<%= bgColor %>" height="18" align="center" valign="middle">
			  <img src="../images/iassign.gif"  border="0" TITLE="Assign to Students"></td> 
              <% } else {%>
              <td height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial" color="<%=forecolor%>"><a href="#" onclick="editWork('<%= workId %>','<%=cat%>','<%=submit%>','<%=eval%>');return false;"><!-- modified 0n 10-11-2004-->
			  <img border="0" src="../images/iedit.gif" TITLE="Edit"></a></font></td>
			  
			  <% if (workFlag.equals("1")){ %>
			  <td  bgcolor="<%= bgColor %>" height="18" align="center" valign="middle"><a href="#" onclick="displayStudents('<%= workId %>','<%= rs.getString("doc_name")%>','<%=checked%>','<%=cat%>','<%=rs.getString("marks_total")%>');return false;">
					<img src="../images/iassign.gif"  border="0" TITLE="Assign to Students"></a></td> 
			  <%} else { %>
				<td  bgcolor="<%= bgColor %>" height="18" align="center" valign="middle">
				  <a href="#" onclick="displayStudents('<%= workId %>','<%= rs.getString("doc_name")%>','','<%=cat%>','<%=rs.getString("marks_total")%>');return false;"><img src="../images/iassign.gif"  border="0" TITLE="Assign to Students"></a></td> 
			  <%}}%>
			  
<!--	<td width="14" bgcolor="<%= bgColor %>" height="18" align="center" valign="middle"><a href="teacherdropbox/submittedFilesList.jsp?totrecords=&start=0&cat=<%=cat%>" target="bottompanel"><img src="../images/iassign.gif"  border="0" TITLE="Evaluate" ></a></td> 	  -->

	<td bgcolor="<%= bgColor %>" height="18" align="center" valign="middle"><a          		href="ShowStudentFile.jsp?cat=<%=cat%>&workid=<%=workId%>&totrecords=<%=tot%>&start=0&docname=<%=rs.getString("doc_name")%>&maxmarks=<%=rs.getString("marks_total")%>" onclick="		parent.toppanel.document.leftpanel.asgncategory.value='<%=cat%>';" target="bottompanel"><img src="../images/ieval.gif"  border="0" TITLE="Evaluate Submissions" ></a></td>
	<%  }  %>
    	
	<td width="125" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial" color="<%=forecolor%>"><a href="#" onclick="showFile('<%= rs.getString("work_file") %>','<%= rs.getString("doc_name") %>','<%=cat%>');return false;"><%= rs.getString("doc_name") %></a></font></td>

    <td width="69" height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial" color="<%=forecolor%>"><%= rs.getDate("modified_date") %></font></td>
    <!--<td width="101" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial" color="<%=forecolor%>"><%=rs.getString("work_file") %></font></td>-->
	<td width="75"height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial" color="<%=forecolor%>"><%=topic %></font></td>
	<td width="100"height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial" color="<%=forecolor%>"><%=subtopic%></font></td>
    <td width="76" height="18" bgcolor="<%= bgColor %>" align="center" ><font size="2" face="Arial" color="<%=forecolor%>"><%=rs.getInt("marks_total") %></font></td>
    <td width="79" height="18" bgcolor="<%= bgColor %>" align="center" ><font size="2" face="Arial" color="<%=forecolor%>">
<%
	if(rs.getDate("to_date")!=null)
		out.println(rs.getDate("to_date"));
	else
		out.println("-");
%>
	</font></td>
    <td  height="18" bgcolor="<%= bgColor %>" align="center" ><font size="2" face="Arial" color="<%=forecolor%>"><%= assign %></font></td>
    <td  height="18" bgcolor="<%= bgColor %>" align="center" ><font size="2" face="Arial" color="<%=forecolor%>">
<%	
	if(submit==0)
	{ 
	    out.println(submit);
	}
	else{
%>	
	<a          		href="ShowStudentFile.jsp?cat=<%=cat%>&workid=<%=workId%>&totrecords=<%=tot%>&start=0&docname=<%=rs.getString("doc_name")%>&maxmarks=<%=rs.getString("marks_total")%>" onclick="		parent.toppanel.document.leftpanel.asgncategory.value='<%=cat%>';" target="bottompanel" TITLE="Evaluate Submissions"><%= submit %></a>
<%	
          }
%>	
	</font></td>
    <td  height="18" bgcolor="<%= bgColor %>" align="center" ><font size="2" face="Arial" color="<%=forecolor%>"><%= eval %></font></td>
    <td  height="18" bgcolor="<%= bgColor %>" align="center" ><font size="2" face="Arial" color="<%=forecolor%>"><%= pending %></font></td>
  </tr>
  <%          
		}
	}catch(Exception e){
		ExceptionsFile.postException("FilesList.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("FilesList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }
	
  %>  


  <tr>
    <td width="100%" height="1" bgcolor="#C2CCE0" align="center" valign="middle" colspan="14">
      <p align="center"><font size="2" face="Arial" color="#FF0000"><%= status%></font></td>

  </tr>


</table>

       </div>
      </td>
    </tr>
  </table>
  </center> 
  
</form>
</body>
</html>		








