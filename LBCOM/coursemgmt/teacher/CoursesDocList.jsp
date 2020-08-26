<%@page import = "java.sql.*,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
     Connection con=null;
	 Statement st=null,st1=null,st2=null,st3=null;
	 ResultSet rs=null,rs1=null,rs2=null,rs3=null;
     int totRecords=0,pageSize=20,start=0,end=0,c=0,status=0,flag=0,assStu=0,viewedStu=0;
	 String categoryId="",linkStr="",schoolId="",teacherId="",courseName="",sectionId="",workId="",url="",newTeacherId="",checked="";
	 String courseId="",foreColor="",bgColor="",topic="",subtopic="",topicId="",subtopicId="",type=""; 	
%>
<%
		try
		{

			session=request.getSession();

			String s=(String)session.getAttribute("sessid");
			if(s==null){
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
			if(type.equals("CO") && request.getParameter("tag").equals("true")){
				rs=st.executeQuery("Select idx_file_path from category_index_files where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' and item_id='"+categoryId+"'");

				if(rs.next()){
					String fPath=(String)session.getAttribute("schoolpath")+schoolId+"/"+rs.getString("idx_file_path");
					//String fPath="../../schools/"+schoolId+"/"+rs.getString("idx_file_path");
					out.println("<html><script> window.location.href='"+fPath+"'; \n </script></html>");				
					return;
				}
				rs.close();
			}

			System.out.println("sectionId...."+sectionId+"...categoryId..."+categoryId);

		
			newTeacherId=teacherId.replace('@','_').replace('.','_');
			if (request.getParameter("totrecords").equals("")) 
			{ 

				if(categoryId.equals("all")){
					
					rs=st.executeQuery("Select count(*) from course_docs c inner join category_item_master d on c.category_id=d.item_id and c.school_id=d.school_id where teacher_id='"+teacherId+"' and c.course_id='"+courseId+"' and d.course_id='"+courseId+"' and section_id='"+sectionId+"' and d.category_type='"+type+"' and c.school_id='"+schoolId+"' ");
				}else{
					
					rs=st.executeQuery("Select count(*) from course_docs where category_id='"+categoryId+"' and teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"' and section_id='"+sectionId+"'");
				}
				rs.next();
				c=rs.getInt(1);
				
				if (c!=0 ){
					totRecords=rs.getInt(1);

				}
				else{

					// Santhosh added on Feb 19th,2013; coursebuilder

					if(categoryId.equals("SD"))
					{
					String cName="";
					boolean flg=false;
					st2=con.createStatement();
					System.out.println("Select * from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"'");
					rs2=st2.executeQuery("Select * from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and course_id='"+courseId+"'");
					if(rs2.next())
					{
						
						
						String cbuilderId=rs2.getString("cbuilder_id");
						System.out.println("cbuilderId...is is is...."+cbuilderId);

						st3=con.createStatement();
						rs3=st3.executeQuery("select distinct(course_name) from lbcms_dev_course_master where course_id='"+cbuilderId+"'");
						if(rs3.next())
						{
							flg=true;
							cName=rs3.getString("course_name");
						}


					}

					if(flg==false)
					{

						out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");

						out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>There are no files available.</font></b></td></tr></table>");
						return;
					}
					else
					{
						//String fPath1=application.getInitParameter("ip_address")+"/LBCOM/lbcms/course_bundles/"+cName+"/Lessons.html";
						String fPath1="/LBCOM/lbcms/course_bundles/"+cName+"/Lessons.html";
						System.out.println("fPath1..."+fPath1);

						
						out.println("<html><script> window.location.href='"+fPath1+"'; \n </script></html>");		
					//String fPath="../../schools/"+schoolId+"/"+rs.getString("idx_file_path");
					//out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");

						//out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'><a href='"+fPath1+"' target=_blank'>"+cName+"</a></font></b></td></tr></table>");
						
						%>
						 <html>
								  <head>
								  <TITLE> New Document </TITLE>
								  <link type="text/css" href="styles/lbstyles/jquery.window.css" rel="stylesheet" />
								<script type="text/javascript" src="js/js/jquery.min.js"></script>

														<!-- Script for Window -->
													<script type="text/javascript" src="js/js/jquery/jquery-ui-1.8.20.custom.min.js"></script>
													<script type="text/javascript" src="js/js/jquery/window/jquery.window.min.js"></script>
													<script type="text/javascript" src="js/js/custom.js"></script>
								</head>

								<body  topmargin=0 leftmargin=3>
						
								   <!-- <table>
						  <tr>
							<td>
								<a href="javascript:createWindowWithBoundary();">Material</b></a>
								</td>
								</tr>
								</table> -->
						
						<div id="window_block2" style="display:none;">


						  
						  
						  <!-- <iframe src="/LBCOM/lbcms/course_bundles/Testcourse/Lessons.html" width="100%" height="700px" frameborder="0" scrolling="auto"></iframe> -->
						  
						  <iframe id="modal" src="<%=fPath1%>" width="100%" height="8000px" frameborder="0" scrolling="auto"></iframe>
						  
						  
						  
						  
						</div>
						<div id="wrapper" align="center">
						  
							<div id="content">
						 <div id="plank">
										  <div id="imgt">&nbsp;</div>
										  <div id="imgp"><a href="#" rel="toggle[assignmentDiv]" ></a></div>
										</div>
						<div id="assignmentDiv"></div>
						</div>
						</div>
						</body>
						</html>

						
							<%


						return;			
						

					}
					}
					else
					{
						out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");

						out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>There are no files available.</font></b></td></tr></table>");	
						return;

					}


				}
			}
			else
				totRecords=Integer.parseInt(request.getParameter("totrecords"));
		   
		   st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		   st1=con.createStatement();
		   start=Integer.parseInt(request.getParameter("start"));
		
		   c=start+pageSize;
		   end=start+pageSize;

		   if (c>=totRecords)
			   end=totRecords;
		   	
		   if(categoryId.equals("all")){
			  
			   rs=st.executeQuery("Select * from course_docs c inner join category_item_master d on c.category_id=d.item_id and c.school_id=d.school_id where teacher_id='"+teacherId+"' and c.course_id='"+courseId+"' and d.course_id='"+courseId+"' and section_id='"+sectionId+"' and d.category_type='"+type+"' and c.school_id='"+schoolId+"' order by work_id limit "+start+","+pageSize);
		   }else{
			   rs=st.executeQuery("SELECT * FROM course_docs where category_id='"+categoryId+"' and school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and  section_id='"+sectionId+"' and course_id='"+courseId+"' order by work_id LIMIT "+start+","+pageSize);
		   }
        }
		catch(SQLException e)
		{
			ExceptionsFile.postException("courseDoclist.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}catch(SQLException se){
				ExceptionsFile.postException("CoursesDocList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		}catch(Exception e)
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
<link href="admcss.css" rel="stylesheet" type="text/css" />
<SCRIPT LANGUAGE="JavaScript">
<!--


	function go(start,totrecords,cat){		
		
		parent.bottompanel.location.href="CoursesDocList.jsp?start="+ start+ "&totrecords="+totrecords+"&cat="+cat+"&type=<%=type%>";
		return false;
	}

	function deleteFile(workid,cat){
		
		if(confirm("Are you sure you want to delete the file?")){
			 	//parent.bottompanel.location.href="/servlet/coursemgmt.CourseManagerFun?basefoldername=&mode=delete&newfoldername=&oldfoldername=&selids="+workid+"&cat=<%=categoryId %>";
		  		parent.toppanel.document.leftpanel.asgncategory.value=cat;
			   parent.bottompanel.location.href="/LBCOM/coursemgmt.CourseManagerFun?basefoldername=&mode=delete&newfoldername=&oldfoldername=&selids="+workid+"&cat="+cat+"&type=<%=type%>";
		}
		return false;
	}

    function deleteAllFiles(cat){

        var selid=new Array();
        with(document.fileslist) {
             for (var i=0,j=0; i < elements.length; i++) {
                    if (elements[i].type == 'checkbox' && elements[i].name == 'selids' &&elements[i].checked==true)
                                    selid[j++]=elements[i].value;
              }
         }
        if (j>0) {
            if(confirm("Are you sure you want to delete the selected file(s)?")){
               		parent.toppanel.document.leftpanel.asgncategory.value=cat; parent.bottompanel.location.href="/LBCOM/coursemgmt.CourseManagerFun?basefoldername=&mode=deleteall&newfoldername=&oldfoldername=&selids="+selid+"&cat="+cat+"&docname=&type=<%=type%>";
                     return false;
            }else
                return false;
        }
        else{
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

/*	function shoswFile(workfile,docname){

		var teacherid='<%= teacherId %>';
		var schoolid='<%= schoolId %>';
		window.open("../../schools/dropbox/"+schoolid+"/"+teacherid+"/<%= categoryId %>/"+workfile,docname,'width=600,height=600,toolbars=no');
		return false;


	}*/

	function displayStudents(workid,docname,checked,cat)
	{
		parent.toppanel.document.leftpanel.asgncategory.value=cat;	//parent.bottompanel.location.href="AssStudentsList.jsp?start=0&totrecords=&checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&type=<%=type%>";
		
		parent.bottompanel.location.href="/LBCOM/coursemgmt/teacher/AsgnFrames.jsp?start=0&totrecords=&checked="+checked+"&unchecked=&workid="+workid+"&docname="+docname+"&cat="+cat+"&type=<%=type%>";
		return false;
	}

	function editWork(workid,category){		
		parent.toppanel.document.leftpanel.asgncategory.value=category;	parent.bottompanel.location.href="EditCourseWork.jsp?workid="+workid+"&cat="+category+"&type=<%=type%>";		
		return false;
	}



//-->
</SCRIPT>

<link type="text/css" href="styles/lbstyles/jquery.window.css" rel="stylesheet" />
<script type="text/javascript" src="js/js/jquery.min.js"></script>

						<!-- Script for Window -->
					<script type="text/javascript" src="js/js/jquery/jquery-ui-1.8.20.custom.min.js"></script>
					<script type="text/javascript" src="js/js/jquery/window/jquery.window.min.js"></script>
					<script type="text/javascript" src="js/js/custom.js"></script>
</head>

<body  topmargin=0 leftmargin=3>
<form name="fileslist">
<table border="0" width="100%" bordercolor="#BBB6B6" cellspacing="0"  cellpadding="0" >
    <tr>
      <td width="100%" >
	  <table border="0" width="100%" >
     <tr>
     <td  height="21" colspan="7">
      <p align="left"><font size="2">Files <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;

	  <%

	  	if(start==0 ) { 
			
			if(totRecords>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totRecords +"','"+categoryId+"');return false;\"> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totRecords+"','"+categoryId+"'); return false;\">Previous</a> |";


			if(totRecords!=end){
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
		<td  height="21" colspan="3"></td>
		  
<%
	}
	else
	{
%>
		<td width="5%" height="21" colspan="3">
			<p align="right">
			
			<a href="EditCategoryItem.jsp?mode=edit&itemid=<%=categoryId%>&cat=<%=type%>" target="bottompanel">Edit</a>
			
		</td>
<%
	}
%>

  </tr>
  <tr>
    <td width="5%" class="gridhdr">
		<input type="checkbox" name="selectall" onClick="selectAll()" value="ON" title="Select or deselect all files"></td>
    <td width="8%" class="gridhdr">
			<a href="#" onClick="return deleteAllFiles('<%= categoryId%>')" >
		<img border="0" src="../images/iddelete.gif"  TITLE="Delete selected files" width="19" height="21"></a>	</td>
    <td width="8%" class="gridhdr" >&nbsp;</td>
    <td width="5%" class="gridhdr">&nbsp;</td>
    <td width="14%" class="gridhdr">
		Document Name	</td>
    <td width="7%" class="gridhdr">
		Topic</td>
    <td width="9%" class="gridhdr">
		Subtopic</td>
    <td width="16%" class="gridhdr">
     Created Date    </td>
	<td width="11%" class="gridhdr">
		Assigned To    </td>
	<td width="12%" class="gridhdr">
		Accessed By    </td>
  </tr>

   <%
	 try{
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
			if (rs1.next()) {
				topic=rs1.getString("topic_des");
				rs1.close();
				rs1=st1.executeQuery("select subtopic_des from subtopic_master where topic_id='"+topicId+"' and subtopic_id='"+subtopicId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				if (rs1.next())
				  subtopic=rs1.getString("subtopic_des");
				  

			}
			
			    
			if (flag==0) 
				foreColor="#000000";
			else
				foreColor="#003366";
						
  %>

  <tr>
    <td class="griditem">
		<input type="checkbox" name="selids" value="<%=workId %>">
	</td>
    <td class="griditem">
		<a href="#" onClick="return deleteFile('<%= workId %>','<%=categoryId%>')" >
		<img border="0" src="../images/idelete.gif" TITLE="Delete" ></a>
	</td>
    <td class="griditem">
				<a href="#" onClick="editWork('<%= workId %>','<%=categoryId%>'); return false;">
		<img border="0" src="../images/iedit.gif" TITLE="Edit" ></a>
	</td>
	<%
		
			viewedStu=0;
	        assStu=0;
	        if (flag==1){ 
				int i=0;
				checked="C000_vstudent";
			
				rs1=st1.executeQuery("select * from course_docs_dropbox where school_id='"+schoolId+"' and work_id= any(select work_id from course_docs where school_id='"+schoolId+"' and work_id='"+workId+"')");
				while (rs1.next()) {
					if ((rs1.getInt("status"))==1)
			           viewedStu++;
					   assStu++;
					   
					   /*

				// Santhosh is commented on 1/28/2013 due to issue

					   if (i==0) {
						 checked=rs1.getString("student_id");
					   }
					   else {
						 checked+=","+rs1.getString("student_id");
					   }

					   */
					   i++;
					}
		
				
%>
			<td class="griditem">
				<a href="#" onClick="displayStudents('<%= workId %>','<%= rs.getString("doc_name")%>','<%=checked%>','<%=categoryId%>'); return false;">
				<img src="../images/iassign.gif" border="0" TITLE="Assign to Students" ></a>
			</td>
<%
		}
		else
		{
%>
			<td class="griditem">
				<a href="#" onClick="displayStudents('<%= workId %>','<%= rs.getString("doc_name")%>','','<%=categoryId%>'); return false;">
				<img src="../images/iassign.gif" border="0" TITLE="Assign to Students"></a>
			</td>
<%
		}
%>
    		<td class="griditem">
								<a href="CourseFileManager.jsp?foldername=<%=workId%>&docname=<%=rs.getString("doc_name")%>&cat=<%=categoryId%>&workid=<%=workId%>&tag=&status=&type=<%=type%>" onClick="		parent.toppanel.document.leftpanel.asgncategory.value='<%=categoryId%>'" target="bottompanel"><%=rs.getString("doc_name")%></a>
			</td>
			<td class="griditem">
				<%=topic %>
			</td>
			<td class="griditem">
				<%=subtopic %>
			</td>
			<td class="griditem">
				<%=rs.getDate("created_date") %>
			</td>
			<td class="griditem">
				<%=assStu%>
			</td>
			<td class="griditem">
				<%=viewedStu%>
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
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
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
