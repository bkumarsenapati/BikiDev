<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.io.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<HTML>
<%!
	int pageSize=25;
%>
<%
    Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;

    int totrecords=0,start=0,end=0,c=0,pages=0,pageNo=0,status=0;
		
	String studentId="",categoryId="",workFile="",teacherId="",schoolId="",courseName="",distType="",workId="",bgColor="";
	String docName="",stuTableName="",teachTableName="",linkStr="",courseId="",topicId="",subtopicId="",topic="",subtopic="";
    String queryString="",type="",lstTag;
	boolean flag=false; 
	File dir=null,dest=null,src=null;
	int i=0;

%>
<%
		try
		{
			
			session=request.getSession();
			String sessid=(String)session.getAttribute("sessid");
		
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
	     
		schoolId  = (String)session.getAttribute("schoolid");
		studentId = (String)session.getAttribute("emailid");
		if((courseId=request.getParameter("courseid"))==null){
			
			courseId  = (String)session.getAttribute("courseid");	
		}else{
			session.setAttribute("courseid",courseId);
		}
		
		categoryId= request.getParameter("cat");
		System.out.println("categoryId...."+categoryId);
		courseName= request.getParameter("coursename");
		type=request.getParameter("type");
		
		lstTag=request.getParameter("lsttag");

		i=0;
		con=con1.getConnection();
		st=con.createStatement();
		

		//* for setting default pages  *//

		if(type.equals("CO") && lstTag.equals("false")){
				rs=st.executeQuery("Select idx_file_path from category_index_files where school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+categoryId+"'");

				if(rs.next()){
					String fPath=(String)session.getAttribute("schoolpath")+schoolId+"/"+rs.getString("idx_file_path");
					out.println("<html><script> window.location.href='"+fPath+"'; \n </script></html>");				
					return;
				}
				rs.close();
			}

		//* ---  *//
		if (categoryId.equals("all")){
					
			rs=st.executeQuery("select item_id from category_item_master where category_type='"+type+"'");
			while(rs.next()){
				if(i==0){
			    	queryString="c.category_id='"+rs.getString("item_id")+"'";
					i++;
				}else
					queryString+=" or c.category_id='"+rs.getString("item_id")+"'";
			}
		}
					
		if (request.getParameter("totrecords").equals("")) 
		   	{   
				flag=true;
				if (categoryId.equals("all")){
					rs=st.executeQuery("select count(*) from course_docs_dropbox d inner join course_docs c on    d.work_id=c.work_id and d.school_id=c.school_id  where d.student_id='"+studentId+"' and ("+queryString+") and c.course_id='"+courseId+"' and c.school_id='"+schoolId+"'");
				}else{
					rs=st.executeQuery("select count(*) from course_docs_dropbox d inner join course_docs c on    d.work_id=c.work_id  and d.school_id=c.school_id   where d.student_id='"+studentId+"' and c.category_id='"+categoryId+"' and c.course_id='"+courseId+"' and c.school_id='"+schoolId+"'");
				}

				rs.next();
				c=rs.getInt(1);
				if (c!=0 )
				{
				
					totrecords=c;
			
				}
				else
				{
					// Santhosh added on Mar 13th,2013; coursebuilder

					if(categoryId.equals("SD"))
					{
					String cName="";
					boolean flg=false;
					st2=con.createStatement();
					System.out.println("Select * from coursewareinfo where school_id='"+schoolId+"' and course_id='"+courseId+"'");
					rs2=st2.executeQuery("Select * from coursewareinfo where school_id='"+schoolId+"' and course_id='"+courseId+"'");
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
						String fPath1=application.getInitParameter("ip_address")+"/LBCOM/lbcms/course_bundles/"+cName+"/Lessons.html";
						System.out.println("fPath1..."+fPath1);

						out.println("<html><script> window.location.href='"+fPath1+"'; \n </script></html>");		

						%>
						<!-- <script>
							window.open("<%=fPath1%>","Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbar=yes");
						</script> -->
						<%
					
					
					
					//String fPath="../../schools/"+schoolId+"/"+rs.getString("idx_file_path");
					//out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");

						//out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'><a href='"+fPath1+"' target=_blank'>"+cName+"</a></font></b></td></tr></table>");	
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
			{
				flag=true;
				totrecords=Integer.parseInt(request.getParameter("totrecords"));   
			} 
				
		  
    	   st=con.createStatement();
		   st1=con.createStatement();	

		   
		   start=Integer.parseInt(request.getParameter("start"));
     	   

		   c=start+pageSize;
		   end=start+pageSize;

		   if (c>=totrecords)
			   end=totrecords;
		   if(categoryId.equals("all")){
				rs=st.executeQuery("select c.category_id,c.doc_name,c.teacher_id,c.created_date,c.topic,c.sub_topic,c.comments, d.work_id,d.status from course_docs c inner join course_docs_dropbox d on c.work_id=d.work_id  and d.school_id=c.school_id  where d.student_id='"+studentId+"' and ("+queryString+") and c.course_id='"+courseId+"' and c.school_id='"+schoolId+"' order by d.status LIMIT "+start+","+pageSize);
		   }else{
				rs=st.executeQuery("select c.category_id,c.doc_name,c.teacher_id,c.created_date,c.topic,c.sub_topic,c.comments, d.work_id,d.status from course_docs c inner join course_docs_dropbox d on c.work_id=d.work_id  and d.school_id=c.school_id  where d.student_id='"+studentId+"' and c.category_id='"+categoryId+"' and c.course_id='"+courseId+"' and c.school_id='"+schoolId+"' order by d.status LIMIT "+start+","+pageSize);
		   }
        }
		catch(SQLException e)
		{
			ExceptionsFile.postException("CourseInbox.jsp","Operations on database","SQLException",e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
					con.close();
				
		}catch(SQLException se){
				ExceptionsFile.postException("CourseInbox.jsp","closing statement and connection objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
		}
		}	
	    catch(Exception e){
			ExceptionsFile.postException("CourseInbox.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e);
		}

    

%>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<base target="main">

<SCRIPT LANGUAGE="JavaScript">
<!--
	function go(start,totrecords,cat){	
window.location.href="CourseInbox.jsp?type=<%=type%>&start="+start+"&totrecords="+totrecords+"&cat="+cat+"&coursename=<%=courseName%>";
		return false;
	}

//-->

</SCRIPT>

</head>
<body topmargin=2 leftmargin=2>
<form name="filelist">

<div align="center">
<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
  <tr>
		

	<% if (flag==false){
		out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Nothing is made available yet.</font></b></td></tr></table></td></tr></table>");				
		return;
	}
	%>	

    <td width="100%" bgcolor="#BD966B" height="21" colspan="7">
      <p align="right"><font size="2" face="Arial"><span class="last">Files <%= (start+1) %> - <%= end %> of <%= totrecords %>&nbsp;&nbsp;</span><font color="#000080">


<%


	   	if(start==0 ) { 
			
			if(totrecords>end){
				
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"','"+categoryId+"');return false;\" target='contents'> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{
			

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totrecords+"','"+categoryId+"');return false;\" target='contents'>Previous</a> |";


			if(totrecords!=end){
				
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"','"+categoryId+"'); return false;\" target='contents'> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

	  
	  %>

	  
	  </font></td>
  </tr>
  <tr>
    <td width="168" bgcolor="#DBD9D5" height="21"><b><font size="2" face="Arial" color="#000080">Document
      Name</font></b></td>
	<td width="136" bgcolor="#DBD9D5" height="21"><b><font size="2" face="Arial" color="#000080">Topic</font></b></td>
    <td width="134" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>Subtopic</b></font></td>
    <td width="119" bgcolor="#DBD9D5" height="21" align="center"><font size="2" face="Arial" color="#000080"><b>Created on</b></font> </td>
    <td width="117" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>Comments</b></font></td>
   
  </tr>
  <%
	try{
   	    while(rs.next())
	    {	
			topic="-";
			subtopic="-";
			bgColor="#E7E7E7";
		    workId=rs.getString("work_id");
			categoryId=rs.getString("category_id");
			docName=rs.getString("doc_name");
			teacherId=rs.getString("teacher_id");
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
			
	%>	
    	  <tr>
	<%
     if (rs.getInt("status")==0) { %>
		<td width="168" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial"><a href="ChangeCourseStatus.jsp?workid=<%=workId%>&cat=<%=categoryId%>&coursename=<%=courseName%>&teacherid=<%=teacherId%>&docname=<%=docName%>" onclick="parent.category.document.leftpanel.asgncategory.value='<%=categoryId%>';" target="contents"><%=docName%></a></font></td>
		<%
	} else  {  %>
		<td width="168" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial"><a    href="ViewMaterial.jsp?workid=<%=workId%>&teacherid=<%=teacherId%>&docname=<%=docName%>&coursename=<%=courseName%>&cat=<%=categoryId%>" onclick="parent.category.document.leftpanel.asgncategory.value='<%=categoryId%>'" target="contents"><%=docName%></a></font></td>  <%
		if(totrecords==1){
			response.sendRedirect("/LBCOM/coursemgmt/student/ViewMaterial.jsp?workid="+workId+"&teacherid="+teacherId+"&docname="+docName+"&coursename="+courseName+"&cat="+categoryId+"");
		}

	}
	%>
	<td width="136" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial"><%=topic%></a></font></td>

    <td width="134" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial"><%=subtopic%></font></td>
    <td width="119" height="18" bgcolor="<%= bgColor %>" align="center"><font size="2" face="Arial"><%=rs.getDate("created_date")%></font></td>
    <td width="117" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial"><%=rs.getString("comments") %></font></td>
    
  </tr>
		
  <%        
		
		}
		
  }catch(Exception e){
	ExceptionsFile.postException("CourseInbox.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
	System.out.println("Exception raised "+e);
}finally{
	try{
		    if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
	}catch(SQLException se){
			ExceptionsFile.postException("courseInBox.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
	}

}

  %>  
	
        
</table>

</form>
</BODY>
</html>
