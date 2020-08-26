<HTML>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>SAVE ASSIGNMENT</title>
<script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script> 
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
    Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null;
	File src=null,dest=null,dir=null,act=null,temp=null;
	FileInputStream fis=null;
	FileOutputStream fos=null;
	String studentId="",workId="",status="",categoryId="";
	String courseId="",workFile="",classId="",schoolId="",comments="",courseName="",stuAssContent="";
	String pdFile="",edFile="",srcUrl="",destUrl="",stuFileName="";
	String startDate="",endDate="";

	String devCourseId="",unitId="",lessonId="",prev2Link="",prev3Link="",next3Link="";
	
	int i=0,submitCount=0,saveStatus=0;
	
    try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid"); //validating the existence of the session
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		 	return;
	    }	
				
		String pfpath = application.getInitParameter("schools_path");
		String schoolPath=application.getInitParameter("schools_path");

		
		studentId=(String)session.getAttribute("emailid");  
		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		classId=(String)session.getAttribute("classid");

		workId=request.getParameter("workid");         
		categoryId=request.getParameter("cat");
		courseName=request.getParameter("coursename");	
		submitCount=Integer.parseInt(request.getParameter("submitcount"));

		 devCourseId=request.getParameter("devcourseid");
		 unitId=request.getParameter("unitid");
		 lessonId=request.getParameter("lessonid");
		 prev2Link=request.getParameter("prev2link");
		 prev3Link=request.getParameter("prev3link");
		 next3Link=request.getParameter("nextpage");

				
		destUrl=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId;
		dir=new File(destUrl);

		if (!dir.exists())  //creates required directories if that  path does  not exists
		{ 			
			dir.mkdirs();
		}
		
		MultipartRequest mreq=new MultipartRequest(request,destUrl,10*1024*1024);
		
		stuAssContent=mreq.getParameter("stuassgncontent");
		stuAssContent=stuAssContent.replaceAll("\'","&#39;");
		

		comments=mreq.getParameter("stucomments");
			
		if (comments==null)
			comments="";
		String fileName;
		
			
			//if the student selects the file from his local system			
			stuFileName=mreq.getFilesystemName("stuattachfile");
			
			if(stuFileName==null)
			{
				fileName="";
			}
			else
			{
			
				stuFileName=stuFileName.replace('#','_');
                stuFileName=stuFileName.replaceAll("'","&#39;"); 
				//rename the uploaded file to workId_submitCount_fileName		
				act = new File(schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+stuFileName);
			
				temp = new File(schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+stuFileName);
				fileName=stuFileName;
				act.renameTo(temp);
			}

			
			//con=con1.getConnection();
			//st=con.createStatement();

		/*update the status to 2 which indicates that the student has submitted the work*/

			
		int k=0;
		boolean flag=false;
				
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		rs=st1.executeQuery("select start_date,end_date,status from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where student_id='"+studentId+"' and work_id='"+workId+"'");
		while(rs.next())
		{
			startDate= rs.getDate("start_date").toString();
			endDate= rs.getDate("end_date").toString();
			saveStatus=Integer.parseInt(rs.getString("status"));
			
			if(saveStatus==5)
			{
				
				/*update the status to 5 which indicates that the student has saved the work, not the first time*/

				k=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set status=5,submitted_date=curdate(),stuattachments='"+fileName+"',submit_count="+submitCount+",answerscript='"+stuAssContent+"' where student_id='"+studentId+"' and work_id='"+workId+"' and status=5");
				flag=true;
			}
			else
			{
				// System.out.println("Status is not 5");
			}			
		}
		if(flag==false)
		{
			/*
			if(submitCount==0)
			{
				k=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set status=5,submitted_date=curdate(),stuattachments='"+fileName+"',submit_count="+submitCount+",answerscript='"+stuAssContent+"' where student_id='"+studentId+"' and work_id='"+workId+"' and status=0");
			}
			else
			{
				k=st.executeUpdate("insert into "+schoolId+"_"+classId+"_"+courseId+"_dropbox(work_id,student_id,start_date,end_date,status,submitted_date,submit_count,stuattachments,answerscript) values('"+workId+"','"+studentId+"','"+startDate+"','"+endDate+"',5,curdate(),"+submitCount+",'"+fileName+"','"+stuAssContent+"')");
			}
			*/

			// For the first time saved the Assignment

			k=st.executeUpdate("insert into "+schoolId+"_"+classId+"_"+courseId+"_dropbox(work_id,student_id,start_date,end_date,status,submitted_date,submit_count,stuattachments,answerscript) values('"+workId+"','"+studentId+"','"+startDate+"','"+endDate+"',5,curdate(),"+submitCount+",'"+fileName+"','"+stuAssContent+"')");
		}
				
		
		if(k!=0)			       			  //if the updation is success
			System.out.println("The status is updated");
		else		        			  	  //if the updation fails
			System.out.println("The status is not updated");
		
		
	}										  //catch the exceptions if any
	catch(SQLException se)
	{
	        ExceptionsFile.postException("SubmitAssignment.jsp","Operations on database","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
	   ExceptionsFile.postException("SubmitAssignment.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
	}

	finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();                //finally close the statement object
			if(fis!=null)
				fis.close(); 
			if(fos!=null)
				fos.close();
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("SubmitAssignment.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
   
%>
<BODY>
<script>

/*displays the student assignments list*/
//parent.contents.location.href="StudentInbox.jsp?start=0&totrecords=&cat=<%=categoryId%>&coursename=<%=courseName%>";

parent.contents.location.href="/LBCOM/lbcms/navMenu.jsp?start=0&totrecords=&cat=CM&dev_courseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&prev2link=<%=prev2Link%>&prev3link=<%=prev3Link%>&nextpage=<%=next3Link%>";

</script>

</BODY>
</HTML>
