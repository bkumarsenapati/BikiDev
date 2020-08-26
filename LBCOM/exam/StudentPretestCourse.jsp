<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.PretestMaterialGenerator,cmgenerator.CopyDirectory,java.io.*"%>
<%@page import = "utility.*,common.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String schoolPath="",courseDevPath="",homePagePath="",imagesPath="",imageName="";
	String color="",subject="";
	String cSource="",dDest="",cImgSource="",dImgDest="",cCSSSource="",dCSSDest="";
	String colorSource="",colorDest="",totalMarks="",marksScored="";
	boolean courseFlag=false;	 
	
	String studentId="",classId="",courseId="",schoolId="",courseName="",devCourseId="";
	String widStr="",lidStr="",unitStr="",asgnStr="",slidePath="";
	PretestMaterialGenerator matGen=null;
	 CopyDirectory cd = new CopyDirectory();
%>
<%
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/coursedeveloper/logout.html'; \n </script></html>");
		return;
	}

	schoolPath = application.getInitParameter("schools_path");   //School path
	//courseDevPath=application.getInitParameter("course_dev_path"); 
	courseDevPath=application.getInitParameter("lbcms_dev_path");
	
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	schoolId=(String)session.getAttribute("schoolid");
	studentId=request.getParameter("studentid");
	devCourseId=request.getParameter("cbcourseid");

	totalMarks=request.getParameter("totalmarks");
	marksScored=request.getParameter("marks");
	

	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();

		rs=st1.executeQuery("select * from lbcms_dev_course_master where course_id='"+devCourseId+"' and status=1");
		if(rs.next())
		{
			courseName=rs.getString("course_name");
			subject=rs.getString("subject");
			color=rs.getString("color_choice");
		}

		homePagePath=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName;
		File LessonFile=new File(homePagePath);
		LessonFile.mkdirs();

		slidePath=courseDevPath+"/course_bundles/"+courseName+"/slides";
		File slideF=new File(slidePath);
		slideF.mkdirs();

		imagesPath=courseDevPath+"/course_bundles/"+courseName+"/images";
		File imagesFile1=new File(imagesPath);
		imagesFile1.mkdirs();

		
		
		/*			Before new template			*/


		imagesPath=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/images";
		File imagesFile=new File(imagesPath);
		imagesFile.mkdirs();

		
		FileUtility fu=new FileUtility();
		if(subject.equals("others"))
		{
			rs=st.executeQuery("select image_name from lbcms_dev_copy_images where image_path='general'");
		
			while(rs.next())
			{
				imageName=rs.getString(1);
				fu.copyFile(courseDevPath+"/copyimages/general/"+imageName,schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/images/"+imageName);
			}
		}
		else

		{
			rs1=st1.executeQuery("select image_name from lbcms_dev_copy_images where image_path='course'");
			while(rs1.next())
			{
				imageName=rs1.getString(1);
				fu.copyFile(courseDevPath+"/copyimages/"+subject+"/"+color+"/"+imageName,schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/images/"+imageName);			
			}
		}
						
								
		
		colorSource=courseDevPath+"/copyimages/"+subject+"/"+color+"/images";
		colorDest=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/images";

				//----------- Upto here

		cSource=courseDevPath+"/CB_images";
		dDest=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/slides/images";


		cImgSource=courseDevPath+"/coursebuilder/"+courseName+"/slides/images";
		dImgDest=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/slides/images";
		
		// For New Template
		
		
		
		if(subject.equals("others"))
		{
			cCSSSource=courseDevPath+"/copyimagesnewtemp/general/"+color+"/css";
			dCSSDest=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/css";
			
			cImgSource=courseDevPath+"/copyimagesnewtemp/general/"+color+"/images";
			dImgDest=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/images";

		}
		else
		{

			
			cCSSSource=courseDevPath+"/copyimages/new_template/"+color+"/css";
			dCSSDest=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/css";
						
			cImgSource=courseDevPath+"/copyimages/"+subject+"/"+color;
			dImgDest=schoolPath+"/"+schoolId+"/"+studentId+"/coursemgmt/"+courseId+"/CD/"+courseName+"/images";

		}

		// ---------------------  Upto here



		matGen=new PretestMaterialGenerator();
		matGen.createHomePage(schoolId,studentId,courseId,devCourseId,schoolPath);
		matGen.createLessonFile(schoolId,studentId,devCourseId,courseName,courseId,schoolPath);
		matGen.copyDirectory(new File(cImgSource),new File(dImgDest));

		matGen.copyDirectory(new File(cCSSSource),new File(dCSSDest));
		matGen.copyDirectory(new File(cImgSource),new File(dImgDest));
		matGen.copyDirectory(new File(cSource),new File(dDest));
		
		


%>

<HTML>
<HEAD>
<TITLE>STUDENT SAVE COURSE</TITLE>
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<body bgcolor="#EBF3FB"> 
<br>
<table border='0'  width='100%' bordercolorlight='#FFFFFF' cellspacing='1'>
<tr bgcolor='#E3975E'><td><font size="2" face="Arial" color="#FFFFFF"> You Scored <%=marksScored%> Out Of <%=totalMarks%></td>
<td><font size="2" face="Arial" color="#FFFFFF">Successfully submitted the assessment!</td></tr><tr><td><BR><img src="images/pleasewait.gif" border="0" title="Please wait.."/></td>
</tr>
</table>
<%
		out.println("<script language=\"JavaScript\">function Redirect(){window.close();}");
		out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',10000);}</script></head>");
		out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">&nbsp;</font></i></b></center></body></html>");
%>
</BODY>
</HTML>
<%
	
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in SaveStudentCourse.jsp is....."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in SaveStudentCourse.jsp is....."+se.getMessage());
			}
		}
%>