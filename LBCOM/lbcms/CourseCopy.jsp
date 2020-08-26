<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.MaterialGenerator,cmgenerator.CopyDirectory,java.io.*"%>
<%@page import = "utility.*,common.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<HTML>
<HEAD>
<TITLE>SAVE COURSE</TITLE>
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String courseId="",devCourseName="",teacherId="",schoolId="",materialId="",courseDevPath="",homePagePath="",catId="";
	String cSource="",dDest="",schoolsPath="";
	String folderName="",docName="";
	boolean courseFlag=false;	 
	MaterialGenerator matGen=null;
	
%>
<%
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}

	try
	{
		courseId=request.getParameter("courseid");
		teacherId=request.getParameter("teacherid");
		schoolId=request.getParameter("schoolid");
		devCourseName=request.getParameter("coursename");
		folderName=request.getParameter("foldername");
	    docName=request.getParameter("docname");
		catId=request.getParameter("catid");
		materialId=request.getParameter("materialid");
		courseDevPath = application.getInitParameter("lbcms_dev_path");
		schoolsPath = application.getInitParameter("schools_path");
					
		con=con1.getConnection();
		st=con.createStatement();
		
		homePagePath=courseDevPath+"/course_bundles/"+devCourseName;		
				
		cSource=homePagePath;
		//dDest=schoolsPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+catId+"/"+materialId+"/"+devCourseName;
		dDest=schoolsPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+catId+"/"+folderName+"/"+devCourseName;
		matGen=new MaterialGenerator();
		int temp=matGen.copyCourse(new File(cSource),new File(dDest));

		
%>	

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
			<%if(temp==0)
			{
			%>
			<tr><td><b><font face="Verdana" color="#0000FF" size="2"><%=devCourseName%> course has not been saved in the builder. Please login to the Course Builder, save the course and try here again.</td></tr>
			<%
			}
			else
			{
			%>
				<td width="97" align="left"><a href="javascript:self.close()">Close</a></td>
			
				</tr>
				<tr>
					<td width="100%" height="5" colspan="2"></td>
				</tr>
				</table>
			</div>
			</td>
			</tr><tr>
			<td align="center"><b><font face="Verdana" color="#0000FF" size="2">The course has been imported successfully!
			<br>
			Please make sure that the course has been made available to the students.</font></b></td>
			<script>

window.opener.location.href="/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?workid=<%=materialId%>&foldername=<%=folderName%>&docname=<%=docName%>&cat=<%=catId%>";
window.close();
 

</script>
			<%
			}
			%>
</tr>
</table>

</BODY>
</HTML>
<%
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in CourseCopy.jsp is....."+e);
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
				System.out.println("The exception2 in CourseCopy.jsp is....."+se.getMessage());
			}
		}
%>