<%@ page language="java" contentType="text/html" import = "java.io.*" import  = 'com.oreilly.servlet.*' %>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@page import="coursemgmt.FileHandler"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.*,utility.FileUtility,utility.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	PreparedStatement ps=null;
	Statement st=null,st1=null,st2=null;
    
	String courseName="",courseColor="",subject="",noOfUnits="",courseId="",schoolId="",schoolPath="",unitId="";
	int unitCount=0;
	String courseDevPath="",mode="",developerId="",grade="",courseDesc="";
	String url="",attachFileName="",sessid="",fileName="",disPath="";
	boolean flag=false;
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}

	try
	{	 
		String devPath= application.getInitParameter("lbcms_dev_path");
		
		
		url=devPath+"/course_bundles/ext_files/tmp";
		File tmpDir =new File(url);
					if(!tmpDir.exists())
						tmpDir.mkdirs();
		MultipartRequest mreq = new MultipartRequest(request, url,1000*1024*1024);
		mode=request.getParameter("mode");
		developerId=request.getParameter("userid");
		
		courseName=mreq.getParameter("cname");
		//courseColor=request.getParameter("ccolor");
		courseColor="other";
		subject=mreq.getParameter("subject");
		//noOfUnits=request.getParameter("units");
		noOfUnits="1";

		grade=mreq.getParameter("grade");
		courseDesc=mreq.getParameter("cdesc");
		con=con1.getConnection();
		st=con.createStatement();

		System.out.println("grade..."+grade+"...courseDesc..."+courseDesc);

		if(mode.equals("add"))
		{
			
			System.out.println("select course_name from lbcms_dev_course_master where course_name='"+courseName+"' and developer='"+developerId+"'");
			rs=st.executeQuery("select course_name from lbcms_dev_course_master where course_name='"+courseName+"' and developer='"+developerId+"'");
			if(rs.next())
			{
				response.sendRedirect("CourseHome.jsp?userid="+developerId);
				return;
			}

			st2=con.createStatement();
			rs2=st2.executeQuery("select course_name from lbcms_upload_courses where course_name='"+courseName+"' and developer='"+developerId+"'");

			if(rs2.next())
			{
				response.sendRedirect("UploadCourse.jsp?coursename="+courseName+"&dispmsg=alreadyexists");
				return;
			}

			schoolPath = application.getInitParameter("schools_path");
			//courseDevPath = application.getInitParameter("lbcms_dev_path");

			//schoolId = (String)session.getAttribute("schoolid");
			//if(schoolId == null || schoolId=="")
				schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.
			

			// Physical file

				
				Utility utility=new Utility(schoolId,schoolPath);	
				courseId=utility.getId("DevCrsId");
				if (courseId.equals(""))
				{
					utility.setNewId("DevCrsId","DC000");	//Dev Course.... DevelopmentCourse
					courseId=utility.getId("DevCrsId");
				}
				
				//url=devPath+"/course_bundles/ext_files/"+courseId;


					System.out.println("url...."+url);
					FileUtility fu=new FileUtility();
	
					 
					 attachFileName=mreq.getFilesystemName("cfile");

					String newURL=devPath+"/course_bundles/ext_files/"+courseId;
					//fu.createDir(newURL);
					File dir =new File(newURL);
					if(!dir.exists())
						dir.mkdirs();
					//fu.renameFile(url+"/"+attachFileName,newURL+"/"+attachFileName);
					//fileName=workId+"_"+fileName;
					System.out.println("before Multipart................"+url+"......attachFileName..."+newURL+"/"+attachFileName);
					fu.copyFile(url+"/"+attachFileName,newURL+"/"+attachFileName);
					fu.deleteDir(url);

				 // Files extract

				 FileHandler fh=null;

				 fh=new FileHandler();

				//url=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+folderName;
				

				
				flag=fh.extractZipFile(attachFileName,newURL);



				%>
				<script language="javascript">

				<%
				
				if (flag==false)	
					out.println("alert(\"File extraction failed.\");");

				out.println("window.location.href='CourseHome.jsp?userid="+developerId+"';");

			%>
			</script>
			
			<%

				 // Files extract upto here


				 System.out.println("attachFileName...."+attachFileName);
			   if(attachFileName==null)
				{
					attachFileName="";							//Not selected the attach file
				}
				else
				{
					attachFileName=attachFileName.replace('#','_');
					fileName=attachFileName;
					 System.out.println("before attachFileName...."+attachFileName);
										
					 
					 System.out.println("**************fileName..."+fileName);
					 String isZip=attachFileName.substring(attachFileName.lastIndexOf('.')+1);
					 //disPath=newURL+"/"+fileName+"/index.htm";
					 if(isZip.equals("zip"))
					{
						System.out.println("**************isZip..."+isZip);
						fu.deleteDir(newURL+"/"+attachFileName);
						fileName=attachFileName.substring(0,attachFileName.lastIndexOf('.'));
					}
					else
					{
						  System.out.println("**************not zip file............");
					}
				}

			// Physical file upto here
			
			
			/*
			ps=con.prepareStatement("insert into lbcms_dev_course_master(course_id,course_name,subject,developer,no_of_units,color_choice,status,grade,course_desc,mat_name) values(?,?,?,?,?,?,?,?,?,?)");

			ps.setString(1,courseId);
			ps.setString(2,courseName);
			ps.setString(3,subject);
			ps.setString(4,developerId);
			ps.setString(5,noOfUnits);
			ps.setString(6,courseColor);
			ps.setString(7,"1");
			ps.setString(8,grade);
			ps.setString(6,courseDesc);
			ps.setString(6,disPath);
			ps.executeUpdate();
			*/

			
			
			response.sendRedirect("WelcomeCourseFile.jsp?userid="+developerId+"&courseid="+courseId+"&foldername="+fileName);
		}
		else if(mode.equals("edit"))
		{
			
			courseId=request.getParameter("courseid");
			rs=st.executeQuery("select course_name from lbcms_dev_course_master where course_name='"+courseName+"' and course_id!='"+courseId+"'");

			if(rs.next())
			{
				System.out.println("There is another course with this name already!");
				response.sendRedirect("EditCourse.jsp?courseid="+courseId+"&userid="+developerId+"&dispmsg=alreadyexists");
				return;
			}

			int i=0;
			i=st.executeUpdate("update lbcms_dev_course_master set course_name='"+courseName+"',subject='"+subject+"',no_of_units='"+noOfUnits+"',color_choice='"+courseColor+"' where course_id='"+courseId+"'");

			
			response.sendRedirect("CourseHome.jsp?userid="+developerId);
		}
		else if(mode.equals("del"))
		{
			
			courseId=request.getParameter("courseid");
			int i=0;
			i=st.executeUpdate("delete from lbcms_dev_course_master where course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_units_master where course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lessons_master where course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lesson_content_master where course_id='"+courseId+"'");
			i=st.executeUpdate("delete from lbcms_dev_lesson_words where course_id='"+courseId+"'");

			
			response.sendRedirect("CourseHome.jsp?userid="+developerId);
		}
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in AddEditCourse.jsp is....."+e);
	}
	finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(ps!=null)
					ps.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in AddEditCourse.jsp.jsp is....."+se.getMessage());
			}
		}
%>
