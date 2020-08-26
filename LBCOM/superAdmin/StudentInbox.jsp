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
	int pageSize=15;				//no.of documents have to be display per page
	private int getPages(int tRecords){
		int noOfPages;
		if((tRecords%pageSize)>0){
			noOfPages=(tRecords/pageSize)+1;
		}else{
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

	 String studentId="",categoryId="",workFile="",teacherId="",schoolId="",courseName="",distType="",workId="",courseId="",classId="";
	 String url="",docName="",col="",linkStr="",foreColor="",workStatus="",deadLine="",tag="",sessid="";
     
	 boolean flag=false;				//false if there are no work documents
	 boolean deadLineFlag=false;		//false if the curr date is after the dead line
	 File dir=null;					//for temporary use
	 File dest=null;					//destination file to where we have to copy
	 File src=null;					//sourse file from which we have to copy
	

%>
<%
	 try {
				
			session=request.getSession();  //validating the existence of session
	        sessid=(String)session.getAttribute("sessid");
		   	if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			
			submitCount=0;		    
			schoolId  = (String)session.getAttribute("schoolid");

			studentId = (String)session.getAttribute("emailid");
			if((courseId=request.getParameter("courseid"))==null){
				
				courseId  = (String)session.getAttribute("courseid");
			}else{
				session.setAttribute("courseid",courseId);
			}
			classId  = (String)session.getAttribute("classid");

			categoryId= request.getParameter("cat");
			courseName=request.getParameter("coursename");

			

			con=con1.getConnection();
			if (request.getParameter("totrecords").equals("")) { 
							   
					st=con.createStatement();
					flag=true;
					if(categoryId.equals("all")){	
						

						rs=st.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on    w.work_id=d.work_id where d.student_id='"+studentId+"' and (w.from_date<=curdate()) ");
					}else{
						rs=st.executeQuery("select count(distinct w.work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox d on    w.work_id=d.work_id where d.student_id='"+studentId+"' and w.category_id='"+categoryId+"' and (w.from_date<=curdate())");
					}
					rs.next();
					c=rs.getInt(1);
					if (c!=0 ) {                 
						totrecords=c;
					} else	{					
						flag=false;					
					}
					rs.close();
			} else							         //if the parameter totrecords is not empty
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
			if(categoryId.equals("all")){
				rs=st.executeQuery("select curdate(),d.status,d.work_id,max(submit_count) submit_count ,w.doc_name,w.teacher_id,category_id,w.modified_date,w.work_file,w.to_date,w.comments, w.marks_total,w.max_attempts,w.status workstatus,w.from_date from " +schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join "+schoolId+"_"+classId+"_"+courseId+"_dropbox   d   on w.work_id=d.work_id where d.student_id='"+studentId+"' and (w.from_date<=curdate())  group by d.work_id LIMIT "+start+","+pageSize);
			}else{
				rs=st.executeQuery("select curdate(),d.status,d.work_id,max(submit_count) submit_count ,w.doc_name,w.teacher_id,category_id,w.modified_date,w.work_file,w.to_date,w.comments, w.marks_total,w.max_attempts,w.status workstatus,w.from_date from "+schoolId+"_"+classId+"_"+courseId+"_workdocs w inner join " +schoolId+"_"+classId+"_"+courseId+"_dropbox d   on w.work_id=d.work_id where d.student_id='"+studentId+"' and w.category_id='"+categoryId+"' and (w.from_date<=curdate())  group by d.work_id LIMIT "+start+","+pageSize); 

			}
        }
		//and w.course_id='"+courseId+"' 
		//catch the exceptions
		catch(SQLException e) {
			ExceptionsFile.postException("StudentInbox.jsp","Operations on database","SQLException",e.getMessage());
//			System.out.println("The Error: SQL - "+e.getMessage());
			try{
				if(st!=null)
					st.close();			//finally close the statement object
				if(con!=null && !con.isClosed())
					con.close();
			}catch(SQLException se){
				ExceptionsFile.postException("StudentInbox.jsp","closing connection object","SQLException",se.getMessage());
			}
		}	
	    catch(Exception e) {
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

<base target="main">

<SCRIPT LANGUAGE="JavaScript">

								
/*	  function selectAll(){					 
			
			if(document.filelist.selectall.checked==true){  
				with(document.filelist) {
					 for (var i=0; i < elements.length; i++) {  
						if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
							elements[i].checked = true;
					  }
				}
			}else{       //if the user unchecks the selectall checkbox

				with(document.filelist) {
					 for (var i=0; i < elements.length; i++) {      //uncheck all the checkboxes
						if (elements[i].type == 'checkbox' && elements[i].name == 'selids')
							elements[i].checked = false;
					  }
				}
			}

	}*/

	function go(start,totrecords,cat){			 //script for calling a page

		window.location.href="StudentInbox.jsp?start="+ start+ "&totrecords="+totrecords+"&coursename=<%=courseName%>&cat="+cat;
		return false;
	}
	function gotopage(totrecords,cat){
		var page=document.filelist.page.value;
		if (page==0){
			alert("Select page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			window.location.href="StudentInbox.jsp?start="+ start+ "&totrecords="+totrecords+"&coursename=<%=courseName%>&cat="+cat;
			return false;
		}
	}
	function showHistory(workid,maxattempt,category)
	{
		parent.parent.studenttopframe.stuExamHistoryWin = window.open("ShowHistory.jsp?workid="+workid+"&maxattempts="+maxattempt+"&category="+category,"HistoryWindow","resizable=no scrollbars=yes width=600,height=400,toolbars=no");
	}

							
/*	function deleteFile(workid){
		
		if(confirm("Are you sure you want to delete the file?")){ //asking the user for conformation
											//if the user wishes to delete
			
		}
		return false;
	}

	function deleteAllFiles(cat){			

		if(confirm("Are you sure you want to delete the selected files?")){ //asking the user for conformation
											//if the user wishes to delete
				var selid=new Array();
				with(document.filelist)  {
					 for (var i=0,j=0; i < elements.length; i++){//select all the documents in the form
						    if (elements[i].type == 'checkbox' && elements[i].name == 'selids') 
											selid[j++]=elements[i].value;
			          }
			     }
				 
			     return false;
		}else
			return;
	}*/

</script>

</head>
<body topmargin=0 leftmargin=3>
<form name="filelist">

<center>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
    <tr>
      <td width="100%" height="21">
        <div align="center">

<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
  <tr>
   <td colspan="6">
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>

	<% if (flag==false){		//if there are no work documents to the student
		out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Nothing is assigned yet.</font></b></td></tr></table></td></tr></table>");				
		return;
	}
	%>
    <td bgcolor="#BC946B" height="21" >
      <p align="left"><font size="2" face="Arial"><span class="last">Files <%= (start+1) %> - <%= end %> of <%= totrecords %>&nbsp;&nbsp;</span></td>
	  <td bgcolor="#BC946B" height="21" align="center"><font size="2" face="Arial" color="#000080">


<%

		/*to provide navigation like prev|next if the documents are more than the pagesize*/
	   	if(start==0 ) {    
			
			if(totrecords>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"','"+categoryId+"');return false;\" target='contents'> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+totrecords+"','"+categoryId+"'); return false;\" target='contents'>Previous</a> |";


			if(totrecords!=end){
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+totrecords +"','"+categoryId+"'); return false; \" target='contents'> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	
		
	  
	  %>
	  </font></td>
	  <td  bgcolor='#BD966B' height='21' align='right' ><font face="arial" size="2">Page&nbsp;
	  <%
		int index=1;
		int begin=0;
		int noOfPages=getPages(totrecords);
		out.println("<select name='page' onchange=\"gotopage('"+totrecords+"','"+categoryId+"');return false;\"> ");
		while(index<=noOfPages){
			if(index==currentPage){
			    out.println("<option value='"+index+"' selected>"+index+"</option>");
			}else{
				out.println("<option value='"+index+"'>"+index+"</option>");
			}
			index++;
			begin+=pageSize;


		}
	  %>
	  </font></td>
	  </tr>
	</table>
   </td>
  </tr>
<!-- For displaying the details the of the work documents in a tabular format -->

 <tr>
  <!--  <td width="19" bgcolor="#DBD9D5" height="21" align="center" valign="middle"><input type="checkbox" name="selectall" onclick="javascript:selectAll()" ></td>
              <td width="17" bgcolor="#DBD9D5" height="18" align="center" valign="middle"><font size="2" face="Arial" color="##DBD9D5"><b><a href="javascript:" onclick="javascript:return deleteAllFiles('<%= categoryId%>')" ><img border="0" src="../images/idelete.gif"  TITLE="Delete  selected files"></b></font></a></td>-->
  

    <td width="168" bgcolor="#DBD9D5" height="21"><b><font size="2" face="Arial" color="#000080">Document
      Name</font></b></td>
	  <td width="80" bgcolor="#DBD9D5" height="21" align="center"><b><font size="2" face="Arial" color="#000080">Attempts</font></b></td>
	<td width="100" bgcolor="#DBD9D5" height="21" align="center"><b><font size="2" face="Arial" color="#000080">Total Points</font></b></td>
    <td width="120" bgcolor="#DBD9D5" height="21" align="center"><font size="2" face="Arial" color="#000080"><b>Created on </b></font></td>
    <td width="119" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>Work-file&nbsp;</b></font> </td>
    <td width="75" bgcolor="#DBD9D5" height="21" align="center"><font size="2" face="Arial" color="#000080"><b>Deadline</b></font></td>
    
	
  </tr>

  <%
   try{
   	    while(rs.next())
	    {		
			
			
		    workId=rs.getString("work_id");
			categoryId=rs.getString("category_id");
			docName=rs.getString("doc_name");
			teacherId=rs.getString("teacher_id");
			workFile=rs.getString("work_file");
			maxAttempts=rs.getInt("max_attempts");
			workStatus=rs.getString("workstatus");
			status=rs.getInt("status");
			submitCount=rs.getInt("submit_count");
			
			if(maxAttempts!=-1)
				tag=""+maxAttempts;
			else
				tag="No Limit";
			url=(String)session.getAttribute("schoolpath")+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workFile;

			


				/*if (distType.equals("N"))
				{
								
						String destUrl="C:/Tomcat 5.0/webapps/ROOT/schools/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId;
						
						dir=new File(destUrl);
						
						if (!dir.exists())
							dir.mkdirs();
						
						destUrl=destUrl+"/"+workFile;
						
						dest=new File(destUrl);
						src=new File(url);
						

						FileOutputStream fos=new FileOutputStream(dest);
						FileInputStream fis=new FileInputStream(src);
						

						for(int i=0;i<src.length();i++)
					
					    	fos.write((byte)fis.read());
							url=destUrl;
							
				}*/	
				if (status==0) 					             //student not yet viewed the work document
			          foreColor="#FF0000";
				else if (status==1)							 //the student viewed the document
					 foreColor="#006666";		
					else if (status==2)						 //the student submitted the work given
					      foreColor="#6D79CD";
						else if (status==3)		             //the teacher viewed the submitted work
							foreColor="#005900";		
							else if ((status==4)||(status==5))//the teacher had evaluated||the student 											viewed the results
								foreColor="#FF7B4F";
							  else if (status==6)
								  foreColor="#993399";
				//
				if(rs.getString("to_date")!=null){
				   if(!rs.getString("to_date").equals("0000-00-00")){ 	  

						if ((rs.getDate(1).compareTo(rs.getDate("to_date")) <=0)){  
							/*current date is before than the deadline*/
							deadLineFlag=true;
						}
						else{
							deadLineFlag=false;		    //last date to submit is over
							foreColor="#CC9966";
						}
						deadLine=rs.getDate("to_date").toString();
				   }
				}
				else
					deadLine="-";
				
			
if(workStatus.equals("2"))
   foreColor="#B4B4B4";

	%>	
  	<tr>
 <!--   <td width="19" height="18"  align="center" valign="middle" bgcolor="#E7E7E7" ><font size="2" face="Arial" ><input type="checkbox" name="selids" value="<%=workId %>"></font></td>

	          <td width="17" height="18"  valign="middle" align="center" bgcolor="#E7E7E7" ><font size="2" face="Arial" color="<%= foreColor%>"><a style="text-decoration:none;" href="javascript:" onclick="javascript:return deleteFile('<%= workId %>')" ><img border="0" src="../images/idelete.gif" TITLE="Delete File" ></a></font></td>-->
      
    
 	<td width="168" height="18" bgcolor="#E7E7E7" ><font size="2" face="Arial" color="<%= foreColor%>"><a style="text-decoration:none;" href="InboxFrame.jsp?workfile=<%=url%>&workid=<%=workId%>&cat=<%=categoryId%>&coursename=<%=courseName%>&status=<%=status%>&docname=<%=docName %>&flag=<%=deadLineFlag%>&workstatus=<%=workStatus%>&maxattempts=<%=maxAttempts%>&submitcount=<%=submitCount%>" style="<%=col%>" onclick="parent.category.document.leftpanel.asgncategory.value='<%=categoryId%>'" target="contents"><%=docName%></a></font></td>

	<td width="80" bgcolor="#E7E7E7" height="21" align="center"><font size="2" face="Arial" color="<%= foreColor%>"><a style="text-decoration:none;" href="javascript://" onclick="return showHistory('<%=workId%>','<%=maxAttempts%>','<%=categoryId%>');"><%=submitCount%>&nbsp;/&nbsp;<%=tag%></a></font></td>

	<td width="100" height="18" bgcolor="#E7E7E7" align="center" ><font size="2" face="Arial" color="<%= foreColor%>"><%=rs.getInt("marks_total")%></a></font></td>

    <td width="120" height="18" bgcolor="#E7E7E7" align="center"  ><font size="2" face="Arial" color="<%= foreColor%>"><%= rs.getDate("modified_date") %></font></td>
    <td width="119" height="18" bgcolor="#E7E7E7" ><font size="2" face="Arial" color="<%= foreColor%>"><%=workFile.substring(workFile.indexOf('_')+1,workFile.length())%></font></td>
	<td width="75" height="18" bgcolor="#E7E7E7" align="center" ><font size="2" face="Arial" color="<%= foreColor%>"><%=deadLine%></font></td>
   
    
  </tr>
		
  <%        
			
		}
  }catch(Exception e){
	ExceptionsFile.postException("StudentInbox.jsp","displaying","Exception",e.getMessage());

  }finally{
	try{
		    if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("stuInBox.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
}
  %>  
	
        
</table>

</form>
</BODY>
