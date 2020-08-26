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
	String colorSource="",colorDest="";
	boolean courseFlag=false;	 
	int assmtLength=0,assmtAssignedCount2=0,assmtIgnoredCount2=0;
	int assignLength=0,assessLength=0,sidLen=0,ignoredCount1=0,ignoredCount2=0,assignedCount1=0,assignedCount2=0;
	String studentId="",startDate="",dueDate="";
	String classId="",courseId="",schoolId="",courseName="",devCourseId="";
	String widStr="",lidStr="",unitStr="",asgnStr="";
	PretestMaterialGenerator matGen=null;
	 CopyDirectory cd = new CopyDirectory();
%>
<%
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}

	schoolPath = application.getInitParameter("schools_path");   //School path
	courseDevPath=application.getInitParameter("lbcms_dev_path");
	
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	schoolId=(String)session.getAttribute("schoolid");
	

	studentId=request.getParameter("studentids");
	widStr=request.getParameter("workids");
	lidStr=request.getParameter("lessonids");
	unitStr=request.getParameter("unitids");
	asgnStr=request.getParameter("asgnids");
	assignLength=Integer.parseInt(request.getParameter("asgncount")); 
	assignedCount1=Integer.parseInt(request.getParameter("assignedcount"));
	ignoredCount1=Integer.parseInt(request.getParameter("ignoredcount"));
	
	assmtLength=Integer.parseInt(request.getParameter("assmtcount"));  
	assmtAssignedCount2=Integer.parseInt(request.getParameter("assmtassignedcount"));
	assmtIgnoredCount2=Integer.parseInt(request.getParameter("assmtignoredcount"));
	
	startDate=request.getParameter("startdate");
	dueDate=request.getParameter("duedate");

	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();

		rs1=st1.executeQuery("select * from pretest where course_id='"+courseId+"' and school_id='"+schoolId+"'");
		while(rs1.next())
		{
			devCourseId=rs1.getString("cb_courseid");			
		}
	
	//devCourseId="DC001";				///////// ---------->  Important
	
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

		
		
		/*						Before new template


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

		*/

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
<hr>
<br>
<table border="1" cellspacing="0" width="500" align="center">
	<tr bgcolor="#934900">
		<td width="100%" colspan="2">&nbsp;<font face="Verdana" size="2" color="white"><b>&nbsp;Assignments Distribution Summary</b></font></td>
	</tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Assignments :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assignLength%></font></td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Name of the Student :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=studentId%></font></td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No of Successful Assignings :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assignedCount1%></font>
<%
	if(assignedCount2 < 0) // once we write the ListAssignedOnes.jsp we will change the condition to > .
	{
%>
      	<font face="Verdana" size="1" color="#800000"><a href="#" onclick="listAssignedOnes(); return false;">&nbsp;(LIST)</a></font>
<%
	}	
%>
		</td>
    </tr>
	<tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No of Altered Assignings :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=ignoredCount1%></font>
<%
	if(ignoredCount1 < 0)	// once we write the ListAssignedOnes.jsp we will change the condition to > .
	{
%>
      	<font face="Verdana" size="1" color="#800000"><a href="igndlist">&nbsp;(LIST)</a></font>
<%
	}
%>
	  </td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Start Date :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=startDate%></font></td>
    </tr>
	<tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Due Date :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=dueDate%></font></td>
    </tr>
</table>
<br>
<table border="1" cellspacing="0" width="500" align="center">
   <tr bgcolor="#934900">
		<td width="100%" colspan="2">&nbsp;<font face="Verdana" size="2" color="white"><b>&nbsp;Assessments Distribution Summary</b></font></td>
	</tr>
    <!-- <tr>
      <td width="28%">&nbsp;</td>
      <td width="36%">&nbsp;</td>
    </tr> -->
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Assessments :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assmtLength%> </font>
		<!-- <font face="Verdana" size="1" color="#800000">
		<a href="#" onclick="listAssessments(); return false;">(LIST)</a></font> -->
	  </td>
    </tr>
    <!-- <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No. of Students :</font></td>
      <td width="36%">
      	<font face="Verdana" size="2" color="#800000">&nbsp;<%=sidLen%></font>
      	<!-- <font face="Verdana" size="1" color="#800000">
		<a href="#" onclick="listStudents(); return false;">(LIST)</a></font> 
      </td>
    </tr> -->
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No of Successful Assignings :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assmtAssignedCount2%></font>
<%
	if(assmtAssignedCount2 < 0) // once we write the ListAssignedOnes.jsp we will change the condition to > .
	{
%>
      	<font face="Verdana" size="1" color="#800000"><a href="#" onclick="listAssignedOnes(); return false;">&nbsp;(LIST)</a></font>
<%
	}	
%>
		</td>
    </tr>
	<tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">No of Altered Assignings :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=assmtIgnoredCount2%></font>
<%
	if(assmtIgnoredCount2 < 0)	// once we write the ListAssignedOnes.jsp we will change the condition to > .
	{
%>
      	<font face="Verdana" size="1" color="#800000"><a href="igndlist">&nbsp;(LIST)</a></font>
<%
	}
%>
	  </td>
    </tr>
    <tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Start Date :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=startDate%></font></td>
    </tr>
	<tr>
      <td width="28%" align="right"><font face="Verdana" size="2" color="black">Due Date :</font></td>
      <td width="36%"><font face="Verdana" size="2" color="#800000">&nbsp;<%=dueDate%></font></td>
    </tr>
    <tr>
      <td width="100%" colspan="2">&nbsp;</td>
    </tr>
    <tr>
      <td width="64%" colspan="2" align="center" rowspan="2" height="34">
      	<font face="Verdana" size="2">
		<a href="ListOfStudents.jsp">Back to Student List</a></font>
      </td>
    </tr>
</table>
</center>

</BODY>
</HTML>
<%
	//response.sendRedirect("DistributeAssessments.jsp?asgncount="+widLen+"&assignedcount="+assignedCount+"&ignoredcount="+ignoredCount+"&studentids="+studentId+"&workids="+assessStr+"&asgnids="+widStr+"&lessonids="+lessonStr+"&unitids="+unitStr+"&startdate="+startDate+"&duedate="+dueDate);
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