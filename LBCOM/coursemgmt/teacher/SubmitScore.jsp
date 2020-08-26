<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--
	/**
	 *submits the file selected by the student to teacher and copies that file in a folder 
	 */
-->
<HTML>
<%@ page import="java.sql.*,java.io.*,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
    Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	File src=null,dest=null,dir=null,act=null,temp=null;
	FileInputStream fis=null;
	FileOutputStream fos=null;
	String studentId="",workId="",srcUrl="",destUrl="",status="",stuFileName="",categoryId="";
	String courseId="",classId="",schoolId="",stdComment="",points="",tchComment="";
	int i=0,j=0,k=0,submitCount=0;
%>
<%
    try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid"); //validating the existence of the session
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		 	return;
	    }	

		String pfpath = application.getInitParameter("schools_path");
		String schoolPath=application.getInitParameter("schools_path");
		
		schoolId=(String)session.getAttribute("schoolid");
		courseId=(String)session.getAttribute("courseid");
		classId=(String)session.getAttribute("classid");
		studentId=request.getParameter("studentid");
		workId=request.getParameter("workid");      
		categoryId=request.getParameter("cat");
				
		destUrl=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId;
		
		dir=new File(destUrl);

		if (!dir.exists())  //creates required directories if that  path does  not exists
		{ 			
			dir.mkdirs();
		}

		MultipartRequest mreq=new MultipartRequest(request,destUrl);

		points=mreq.getParameter("points");
		tchComment=mreq.getParameter("teachercomments");
		stdComment="Teacher submitted on behalf of the student";

		//if the teacher selects the file from his local system			
		stuFileName=mreq.getFilesystemName("stuworkfile");
		
		if(stuFileName==null)
		{
			BufferedWriter res=new BufferedWriter(new FileWriter(destUrl+"/TeacherSubmit.html")); 
			
			res.write("<HTML><HEAD><TITLE>Teacher Submission</TITLE></HEAD><BODY><font color=#003399 face=verdana size=2>Teacher Submitted file.</font></BODY></HTML>");
		
			res.close();
			stuFileName="TeacherSubmit.html";
		}
				
		//rename the uploaded file to workId_submitCount_fileName		
		
		

		act = new File(schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+stuFileName);
		
			temp = new File(schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workId+"_"+(submitCount+1)+"_"+stuFileName);
				
		act.renameTo(temp);
	
		con=con1.getConnection();
		st=con.createStatement();

		/*update the status to 2 which indicates that the student has submitted the work*/

		String fileName;

		submitCount++;

		fileName=workId+"_"+submitCount+"_"+stuFileName;

		// Taking the assignment on behalf of the student
		
		i=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set status=4, submitted_date=curdate(),eval_date=curdate(),stuattachments='"+stdComment+"',remarks='"+tchComment+"',marks_secured='"+points+"',submit_count=1, answerscript='"+fileName+"' where student_id='"+studentId+"' and work_id='"+workId+"'");

		j=st.executeUpdate("update "+schoolId+"_cescores set  marks_secured="+points+",submit_date=curdate(),status=2 where user_id='"+studentId+"' and work_id='"+workId+"' and category_id='"+categoryId+"' and school_id='"+schoolId+"'");

		if(i>0 && j>0)			       			  //if the updation is success
			System.out.println("The status in SubmitScore.jsp is updated");
		else		        			  	  //if the updation fails
			System.out.println("The status in SubmitScore.jsp is not updated");

		// Taking the exam on behalf of the student is over
	}							//catch the exceptions if any
	catch(SQLException se)
	{
		ExceptionsFile.postException("SubmitScore.jsp","Operations on database","SQLException",se.getMessage());
		System.out.println("Error: in SubmitScore.jsp is SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("SubmitScore.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:in SubmitScore.jsp is..."+e.getMessage());
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
			ExceptionsFile.postException("SubmitScore.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println("Error:in SubmitScore.jsp is..."+se.getMessage());
		}
	}
%>
<BODY>
<script>
/*displays the student work documents list*/
//parent.location.href="StudentInbox.jsp?start=0&totrecords=&cat=<%=categoryId%>";
//location.href="AssignmentEvaluator.jsp?start=0&totrecords=&status=&cat=all&sortby=&sorttype=";
location.href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=";

</script>

</BODY>
</HTML>
