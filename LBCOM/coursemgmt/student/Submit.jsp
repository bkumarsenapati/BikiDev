<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!--
	/**
	 *submits the file selected by the student to teacher and copies that file in a folder 
	 */
-->
<HTML>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
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
	String courseId="",workFile="",pdFile="",edFile="",classId="",schoolId="",comments="",courseName="";
	
	int i=0,submitCount=0;
	
%>

<%
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
		
		destUrl=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId;
		dir=new File(destUrl);

		if (!dir.exists())  //creates required directories if that  path does  not exists
		{ 			
			dir.mkdirs();
		}

		MultipartRequest mreq=new MultipartRequest(request,destUrl);

		comments=mreq.getParameter("stucomments");
		pdFile=mreq.getParameter("pdfile");
		edFile=mreq.getParameter("editorfile");
		
		
		if (comments==null)
			comments="";
		
		if (edFile==null) {	

		if (pdFile==null) {	
			
			//if the student selects the file from his local system			
			stuFileName=mreq.getFilesystemName("stuworkfile");
			stuFileName=stuFileName.replace('#','_');
			//String fileExt=stuFileName.subString(stuFileName.lastIndexOf('.')+1);
			//System.out.println("after...fileExt...is,,,"+fileExt);


			//rename the uploaded file to workId_submitCount_fileName		
			act = new File(schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+stuFileName);
			
			temp = new File(schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workId+"_"+(submitCount+1)+"_"+stuFileName);
					

		}else {
			/*if the student selects the file from his personal docs, then the path is follows*/	

			//srcUrl="Apache Tomcat 4.0/webapps/ROOT/schools/PersonalFolders/"+schoolId +"/"+studentId+"/"+pdFile;
			srcUrl=pfpath+"/"+schoolId +"/"+studentId+"/PersonalFolders/"+pdFile;
			src=new File(srcUrl);	
			stuFileName=src.getName();		//get filename from the path of src file
			destUrl=destUrl+"/"+stuFileName;//path where that file is to be copied	
			dest=new File(destUrl);

			/*copying the file the specified path*/
			fis=new FileInputStream(src);
			fos=new FileOutputStream(dest);
		
			byte b;
		
			for(i=0;i<src.length();i++)
				 fos.write((byte)fis.read());
			fis.close();
			fos.close();

			act = new File(schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+stuFileName);
			temp = new File(schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workId+"_"+(submitCount+1)+"_"+stuFileName);

		}

			act.renameTo(temp);
	
		}

		con=con1.getConnection();
		st=con.createStatement();

		/*update the status to 2 which indicates that the student has submitted the work*/
		int k;
		String fileName;

		submitCount++;
		
		if (edFile==null)
			fileName=workId+"_"+submitCount+"_"+stuFileName;
		else{
//			fileName=submitCount+"_"+workId+".html";
			fileName=edFile;
		}

		if(submitCount==1){	
			k=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set status=2, submitted_date=curdate(),comments='"+comments+"',submit_count="+submitCount+",work_file='"+fileName+"' where student_id='"+studentId+"' and work_id='"+workId+"'");
			k=st.executeUpdate("update "+schoolId+"_cescores set status=1 where user_id='"+studentId+"' and work_id='"+workId+"' and category_id='"+categoryId+"' and status<=0 and school_id='"+schoolId+"'");
		}else{

//			k=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set status=2 where student_id='"+studentId+"' and work_id='"+workId+"'");

			k=st.executeUpdate("insert into "+schoolId+"_"+classId+"_"+courseId+"_dropbox(work_id,student_id,status,submitted_date,submit_count,comments,work_file) values('"+workId+"','"+studentId+"',2,curdate(),"+submitCount+",'"+comments+"','"+fileName+"')");

		}
		
		if(k!=0)			       			  //if the updation is success
			System.out.println("The status is updated");
		else		        			  	  //if the updation fails
			System.out.println("The status is not updated");
		
		
   }										  //catch the exceptions if any
   catch(SQLException se){
	        ExceptionsFile.postException("Submit.jsp","Operations on database","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
   }

   catch(Exception e){
	   ExceptionsFile.postException("Submit.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
   }

   finally{
		try{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("Submit.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
   
%>
<BODY>
<script>

/*displays the student work documents list*/
parent.location.href="StudentInbox.jsp?start=0&totrecords=&cat=<%=categoryId%>&coursename=<%=courseName%>";

</script>

</BODY>
</HTML>
