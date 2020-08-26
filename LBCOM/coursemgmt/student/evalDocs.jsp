<!--
	/**
	 *Displays the list of evaluted work documents and also provides to links to the submitted file and
	 * to the file assigned by the teacher
	 */
-->
<html>
<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
    int pageSize=100;		//no.of eval documents to be displayed per page	
%>
<%
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	
	String studentId="",courseName="",categoryId="",schoolId="",teacherId="",submittedFile="",distType="",tmp="";
	String linkStr="",courseId="",classId="",sCount="";
	String submtCount="",workId="";
	
	int totrecords=0;         //total no. of evaluted documents 

	int start=0;				//from which document we have to be display
	int end=0;				//up to which document we have to display
	int c=0;
	boolean flag=false;			//flag is false when there is no evaluted docs
%>

<%
 		
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		studentId=(String)session.getAttribute("emailid");
		courseId=(String)session.getAttribute("courseid");
		schoolId=(String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");

		courseName=request.getParameter("coursename");
		categoryId=request.getParameter("cat");

   try
	{   
		con=con1.getConnection();
		if (request.getParameter("totrecords").equals("")) { 

			/*if the parameter totrecords is empty
			 *find the total work documents according to the category
			 *if there are workdocuments assign the total no of docs to the variable totrecords
			 *or else the flag to false.
			 */
			st=con.createStatement();
			flag=true;
			
			
			if(categoryId.equals("all"))
			{
				rs=st.executeQuery("select count(distinct d.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id where d.student_id='"+studentId+"' and d.status >= 4 and d.eval_date is not NULL");
			}
			else
			{
				rs=st.executeQuery("select count(distinct d.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on    w.work_id=d.work_id where d.student_id='"+studentId+"' and d.status >= 4 and w.category_id='"+categoryId+"'  and d.eval_date is not NULL");
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
			}
			rs.close();
		}else									  //if the parameter totrecords is not empty	
			totrecords=Integer.parseInt(request.getParameter("totrecords"));    
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

		start=Integer.parseInt(request.getParameter("start"));

		c=start+pageSize;
		end=start+pageSize;

		if (c>=totrecords)
		   end=totrecords;       

	    /*update the status in dropbox to 5 which indicates that the student has viewed the results*/
        int i=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set status=4 where status=5 and student_id='"+studentId+"' and eval_date is not NULL");
        
		/* select the required fields for displaying them to the student*/
			
		sCount="";
		if(categoryId.equals("all")){
			rs=st.executeQuery("select w.work_id,w.doc_name,w.category_id,w.max_attempts,w.asgncontent,w.teacher_id,w.category_id,w.marks_total,d.answerscript submitted_file,d.submitted_date,d.eval_date,d.marks_secured, d.stuattachments,d.submit_count from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id where d.status >= 4 and d.student_id='"+studentId+"'  and d.eval_date is not NULL order by w.work_id,d.submit_count desc LIMIT "+start+","+pageSize);
		}else{
			rs=st.executeQuery("select w.work_id,w.doc_name,w.category_id,w.max_attempts,w.asgncontent,w.teacher_id,w.category_id,w.marks_total,d.answerscript submitted_file,d.submitted_date,d.eval_date,d.marks_secured, d.stuattachments,d.submit_count from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on w.work_id=d.work_id where d.status >= 4 and d.student_id='"+studentId+"' and w.category_id='"+categoryId+"'  and d.eval_date is not NULL order by w.work_id,d.submit_count desc LIMIT "+start+","+pageSize);
		}
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("evalDocs.jsp","Operations on database","SQLException",e.getMessage());
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
				ExceptionsFile.postException("evalDocs.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
		}
	}	
    catch(Exception e){
		ExceptionsFile.postException("evalDocs.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
	}
%>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title><base target="contents">

<script language="javascript">
	function go(wid,subcount)
	{

		//parent.contents.location.href="/LBCOM/coursemgmt/student/AssignmentResult.jsp?category_id="+cat;
		parent.contents.location.href="/LBCOM/coursemgmt/student/AssignmentHistory.jsp?workid="+wid+"&submit_count="+subcount;	
		return false;
	}


	function go1(subfile,cat)
	{
		window.open("<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=studentId%>/coursemgmt/<%=courseId%>/"+cat+"/"+subfile);
		return false;
	}

	function goprevnext(start,totrecords,cat){		

    /*to provide links for previous/next page*/
parent.main.location.href="evalDocs.jsp?start="+start+"&totrecords="+totrecords+"&coursename=<%=courseName%>&cat="+cat;
		return false;
	}

		function selectAll(){
			
			if(document.filelist.selectall.checked==true){
				with(document.filelist) {
					 for (var i=0; i < elements.length; i++) {
						if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
							elements[i].checked = true;
					  }
				}
			}else{

				with(document.filelist) {
					 for (var i=0; i < elements.length; i++) {
						if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
							elements[i].checked = false;
					  }
				}
			}

	}








</script>

</head>
<body>
<form name="filelist">

<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
<tr>

<% 
	if(flag==false)						  //if there are no evaluated work documents	
	{
		out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='verdana' color='#FF0000' size='2'>Items are not found</font></b></td></tr></table></td></tr></table>");				
		return;
	}
%>
	<td width="50%" bgcolor="#7D8C98" height="21" align="left">
		<font size="2" face="verdana">Assignments <%= (start+1) %> - <%= end %> of <%= totrecords %>&nbsp;&nbsp;
	</td>
	<td width="50%" bgcolor="#7D8C98" height="21" align="right">
		<font color="#000080">
<%
		/**
		 *the following coding is to provide the prev||next links
		 *if there are no previous records then disable the prev link
		 *if there are no other records then disable the next link
		 * if there are no prev records and no further records then disable the both prev& next links
		 */
	   	if(start==0 ) 
		{ 
			if(totrecords>end)
			{
				out.println("Previous | <a href=\"#\" onclick=goprevnext('"+(start+pageSize)+ "','"+totrecords +"','"+categoryId+"')> Next</a>&nbsp;&nbsp;");
			}
			else
				out.println("Previous | Next &nbsp;&nbsp;");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=goprevnext('"+(start-pageSize)+ "','"+totrecords+"','"+categoryId+"')>Previous</a> |";
			if(totrecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick= goprevnext('"+(start+pageSize)+ "','"+totrecords +"','"+categoryId+"')> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);
		}	
%>
		</font>
	</td>
</tr>
</table>

  <!--Displaying the evaluated documents in a tabluar format-->
 <!--   <td width="19" bgcolor="#DBD9D5" height="21" align="center" valign="middle"><input type="checkbox" name="selectall" onclick="javascript:selectAll()" ></td>
              <td width="17" bgcolor="#DBD9D5" height="18" align="center" valign="middle"><font size="2" face="verdana" color="#000080"><b><a href="javascript:" onclick="javascript:return deleteAllFiles('<%= categoryId%>')" ><img border="0" src="../images/idelete.gif"  TITLE="Delete  selected files"></b></font></a></td>-->
<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
<tr>
	<td width="10%" bgcolor="#CECBCE" height="21" align="center">
		<font size="2" face="verdana" color="#000080"><b>Submission No.</b></font>
	</td>
	<td width="20%" bgcolor="#CECBCE" height="21">
		<b><font size="2" face="verdana" color="#000080">Document Name</font></b>
	</td>
	<!-- <td width="20%" bgcolor="#CECBCE" height="21">
		<b><font size="2" face="verdana" color="#000080">Assignment File</font></b>
	</td> -->
    <td width="20%" bgcolor="#CECBCE" height="21">
		<font size="2" face="verdana" color="#000080"><b>Answer File</b></font>
	</td>
    <td width="15%" bgcolor="#CECBCE" height="21" align="center">
		<font size="2" face="verdana" color="#000080"><b>Submitted On</b></font>
	</td>
    <td width="15%" bgcolor="#CECBCE" height="21" align="center">
		<font size="2" face="verdana" color="#000080"><b>Evaluated On</b></font>
	</td>
    <td width="10%" bgcolor="#CECBCE" height="21" align="center">
		<font size="2" face="verdana" color="#000080"><b>Points</b></font>
	</td>
</tr>


		<%
		try{
     			while(rs.next())
				{
					
					workId=rs.getString("work_id");
					teacherId=rs.getString("teacher_id");
					distType=rs.getString("max_attempts");
					submittedFile=rs.getString("submitted_file");
					categoryId=rs.getString("category_id");
					tmp=submittedFile.substring(submittedFile.indexOf('_')+1,submittedFile.length());
					tmp=tmp.substring(tmp.indexOf('_')+1,tmp.length());
					submtCount=rs.getString("submit_count");
					
	   %>	
    	  <tr>
  <!--  <td width="19" height="18" bgcolor="#E7E7E7" align="center" valign="middle"><font size="2" face="verdana"><input type="checkbox" name="selids" ></font></td>

	<td width="17" height="18" bgcolor="#E7E7E7" valign="middle" align="center"><font size="2" face="verdana"><a href="javascript:" onclick="javascript:return deleteFile()" ><img border="0" src="../images/idelete.gif" TITLE="Delete File" ></a></font></td>-->

	<td width="10%" height="18" bgcolor="#E7E7E7" align="center">
		<font size="2" face="verdana"><%=rs.getInt("submit_count")%></font>
	</td> 
	<td width="20%" height="18" bgcolor="#E7E7E7">
		<font size="2" face="verdana"><%= rs.getString("doc_name")%></a></font>
	</td>
	<td width="20%" height="18" bgcolor="#E7E7E7">
		<font size="2" face="verdana">
		<a href="#" onclick="go('<%=workId%>','<%=submtCount%>')">Work File</a></font>
	</td>
	<!-- <td width="20%" height="18" bgcolor="#E7E7E7">
		<font size="2" face="verdana"><a href="#" onclick="go1('','<%=categoryId%>')">Answer File</a></font>
	</td>  -->
	<td width="15%" height="18" bgcolor="#E7E7E7" align="center">
		<font size="2" face="verdana"><%=rs.getDate("submitted_date")%></font>
	</td> 
	<td width="15%" height="18" bgcolor="#E7E7E7" align="center">
		<font size="2" face="verdana"><%=rs.getDate("eval_date")%></font>
	</td> 
 	<td width="10%" height="18" bgcolor="#E7E7E7" align="center">
		<font size="2" face="verdana"><%=rs.getFloat("marks_secured")%><b>/</b><%=rs.getFloat("marks_total")%></font>
	</td> 	 
<%     			
		}
	}catch(Exception e){
		ExceptionsFile.postException("evalDocs.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
		System.out.println("Exception raised "+e);
	}finally{
	try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
	}catch(SQLException se){
			ExceptionsFile.postException("evalDocs.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
	}

}

  %>  
	
        
</table>

</form>
</BODY>