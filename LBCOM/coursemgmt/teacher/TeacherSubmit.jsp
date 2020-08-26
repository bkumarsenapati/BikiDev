<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
    Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
     
    int i=0,status=0,marksScheme=0,count=0,totRecords=0,alltotRecords=0;
	String studentId="",workId="",categoryId="",docName="",schoolId="",courseId="",classId="",workFile="",remarks="";
	String submitDate="",submsnType="",destUrl="",attachFileName="",fileName="",stuAttachFile="";

	File dir=null,act=null,temp=null;
	FileInputStream fis=null;
	FileOutputStream fos=null;

		float marks=0.0f,maxMarks=0.0f;
%>
<%
	try
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		String schoolPath=application.getInitParameter("schools_path");
		schoolId=(String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();

		studentId=request.getParameter("stuid");
		workId=request.getParameter("workid");
		categoryId=request.getParameter("cat");
		stuAttachFile=request.getParameter("stufile");
		
		destUrl=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/"+categoryId;
		dir=new File(destUrl);

		if (!dir.exists())  //creates required directories if that  path does  not exists
		{ 			
			dir.mkdirs();
		}

		
		
		MultipartRequest mreq=new MultipartRequest(request,destUrl,10*1024*1024);
					
		marks=Float.parseFloat(mreq.getParameter("markssecured"));
		maxMarks=Float.parseFloat(mreq.getParameter("maxmarks"));
		//docName=mreq.getParameter("docname");
		rs1=st1.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
		if(rs1.next())
		{
			docName=rs1.getString("doc_name");
		
		}
		status=Integer.parseInt(mreq.getParameter("status"));
		workFile=mreq.getParameter("stuassgncontent");
		workFile=workFile.replaceAll("\'","&#39;");
		remarks = mreq.getParameter("remarks");
		submitDate=mreq.getParameter("submitdate");
		totRecords=Integer.parseInt(mreq.getParameter("totrecords"));
		count=Integer.parseInt(mreq.getParameter("count"));
		submsnType=mreq.getParameter("submsntype");
		alltotRecords=Integer.parseInt(mreq.getParameter("alltotrecords"));
		
		attachFileName=mreq.getFilesystemName("stuworkfile");
		if(attachFileName==null)		//If the Teacher not selected the attach file for feedback
		{
			fileName=stuAttachFile;		// Here we can handle the student submitted attachments, otherwise it will be empty
			
		}
		else
		{
				attachFileName=attachFileName.replace('#','_');
                attachFileName=attachFileName.replaceAll("'","&#39;"); 
				act = new File(destUrl+"/"+attachFileName);
																	//rename the uploaded file to workId_submitCount_fileName
				temp = new File(destUrl+"/"+workId+"_"+count+"_"+attachFileName);
				fileName=workId+"_"+count+"_"+attachFileName;
				act.renameTo(temp);
		}
		
		
			  
		if (status<4)
		{
			i=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set status=4, eval_date=curdate(),marks_secured="+marks+",remarks='"+remarks+"',answerscript='"+workFile+"',stuattachments='"+fileName+"' where student_id='"+studentId+"' and work_id='"+workId+"' and submit_count="+count);
		}
		else 
		{
			
			i=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_dropbox set marks_secured="+marks+",remarks='"+remarks+"',answerscript='"+workFile+"',stuattachments='"+fileName+"' where student_id='"+studentId+"' and work_id='"+workId+"' and submit_count="+count);			
		}

		rs=st.executeQuery("select mark_scheme from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");

		if(rs.next())
		{
			marksScheme=rs.getInt(1);
		}
		rs.close();
		
		if(marksScheme==0)		// Best
		{
			rs=st.executeQuery("select max(marks_secured) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status>=4");
			if (rs.next())
			{
				marks=Float.parseFloat(rs.getString(1));	
			}
		}
		else if(marksScheme==1)		// Last
		{
			rs=st.executeQuery("select marks_secured from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status >=4 order by submit_count desc");
			if(rs.next())
				marks=Float.parseFloat(rs.getString("marks_secured"));
		}
		else if(marksScheme==2)		// Average
		{
			rs=st.executeQuery("select avg(marks_secured) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status >=4");
			if(rs.next())
				marks=Float.parseFloat(rs.getString(1));
		}

		i=st.executeUpdate("update "+schoolId+"_cescores set marks_secured="+marks+",total_marks="+maxMarks+",submit_date='"+submitDate+"',status=2 where work_id='"+workId+"'and user_id='"+studentId+"' and school_id='"+schoolId+"'");
		
		if(i!=0)
		{
			if(submsnType.equals("pending"))
				totRecords=totRecords-1;
			out.println("<script>");
			docName=docName.replaceAll("\'","&#39;");
			out.println("location.href='StudentsSubmissions.jsp?submsntype="+submsnType+"&workid="+workId+"&cat="+categoryId+"&totrecords="+totRecords+"&alltotrecords="+alltotRecords+"&start=0&docname="+docName+"&maxmarks="+maxMarks+"';");

			out.println("</script>");
		}
		else
			out.println("The points are not Assigned");

   }
   catch(Exception e)
   {
	   ExceptionsFile.postException("TeacherSubmit.jsp","Operations on database and reading parameters","SQLException",e.getMessage());
	   System.out.println("The error in TeacherSubmit.jsp is: "+e);
   }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("TeacherSubmit.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("The error in TeacherSubmit.jsp is..."+se.getMessage());
		}

    }	  
%>


<BODY>

</BODY>
</HTML>
