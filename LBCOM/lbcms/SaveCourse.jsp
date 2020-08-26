<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.LBCMSMaterial,cmgenerator.CopyDirectory,java.io.*"%>
<%@page import = "utility.*,common.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String courseId="",courseName="",courseDevPath="",homePagePath="",imagesPath="",imageName="";
	String color="",subject="";
	String cSource="",dDest="",cImgSource="",dImgDest="",cCSSSource="",dCSSDest="";
	String colorSource="",colorDest="",slidePath="";
	boolean courseFlag=false;	 
	LBCMSMaterial lbcmsMat=null;
	 CopyDirectory cd = new CopyDirectory();
%>
<%
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	courseDevPath = application.getInitParameter("lbcms_dev_path");
	
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		
		rs=st.executeQuery("select * from lbcms_dev_course_master where course_id='"+courseId+"' and status=1");
		if(rs.next())
		{
			courseName=rs.getString("course_name");
			subject=rs.getString("subject");
			color=rs.getString("color_choice");
		}

		homePagePath=courseDevPath+"/course_bundles/"+courseName;
		System.out.println("homePagePath..."+homePagePath);
		File LessonFile=new File(homePagePath);
		LessonFile.mkdirs();

		slidePath=courseDevPath+"/course_bundles/"+courseName+"/slides";
		File slideF=new File(slidePath);
		slideF.mkdirs();

		imagesPath=courseDevPath+"/course_bundles/"+courseName+"/images";
		File imagesFile=new File(imagesPath);
		imagesFile.mkdirs();


		FileUtility fu=new FileUtility();
		if(subject.equals("others"))
		{
			rs=st.executeQuery("select image_name from lbcms_dev_copy_images where image_path='general'");
		
			while(rs.next())
			{
				imageName=rs.getString(1);
				fu.copyFile(courseDevPath+"/copyimages/general/"+imageName,courseDevPath+"/course_bundles/"+courseName+"/images/"+imageName);
			}
		}
		else

		{
			rs1=st1.executeQuery("select image_name from lbcms_dev_copy_images where image_path='course'");
			while(rs1.next())
			{
				imageName=rs1.getString(1);
				fu.copyFile(courseDevPath+"/copyimages/"+subject+"/"+color+"/"+imageName,courseDevPath+"/course_bundles/"+courseName+"/images/"+imageName);			
			}
		}
		
		colorSource=courseDevPath+"/copyimages/"+subject+"/"+color;
		colorDest=courseDevPath+"/course_bundles/"+courseName+"/images";

		cSource=courseDevPath+"/CB_images";
		dDest=courseDevPath+"/course_bundles/"+courseName+"/slides/images";


		cImgSource=courseDevPath+"/coursebuilder/"+courseName+"/slides/images";
		dImgDest=courseDevPath+"/course_bundles/"+courseName+"/slides/images";
		
		
		// For New Template
		cCSSSource=courseDevPath+"/copyimages/new_template/"+color+"/css";
		dCSSDest=courseDevPath+"/course_bundles/"+courseName+"/css";
				
		// Upto here

		lbcmsMat=new LBCMSMaterial();
		lbcmsMat.createHomePage(courseId,courseDevPath);
		lbcmsMat.createLessonFile(courseName,courseId,courseDevPath);
		//lbcmsMat.createLessonSlide(courseName,courseId,courseDevPath);
		//lbcmsMat.copyDirectory(new File(cSource),new File(dDest));
		lbcmsMat.copyDirectory(new File(colorSource),new File(colorDest));
		lbcmsMat.copyDirectory(new File(cImgSource),new File(dImgDest));
		lbcmsMat.copyDirectory(new File(cCSSSource),new File(dCSSDest));
%>

<HTML>
<HEAD>
<TITLE> SAVE COURSE </TITLE>
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<table align="center">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<tr>
<td width="100%" height="28" colspan="3" bgcolor="#bbccbb">
    <div align="right">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tr>
			<td width="90%"><p>&nbsp;</p></td>
			<td width="97" align="left"><a href="javascript:history.back()">Back</a></td>
		</tr>
		<tr>
			<td width="100%" height="5" colspan="2"></td>
		</tr>
		</table>
    </div>
	</td>
	</tr><tr>
<td align="center"><b><font face="Verdana" color="#0000FF" size="2">The course 
has been saved successfully!</font></b></td>
</tr>
</table>

</BODY>
</HTML>
<%
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in SaveCourse.jsp is....."+e);
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
				System.out.println("The exception2 in SaveCourse.jsp is....."+se.getMessage());
			}
		}
%>