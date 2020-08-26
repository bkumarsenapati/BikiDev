
<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,utility.*,common.*" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	

	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",instruct="",s="",schoolId="";
	String assmtName="",assmtContent="",cat="",mode="",destUrl="",tableName="",qt="",ExamId="",assmtId="",classId="",developerId="";
	String Question="",Qtype="";
	int assmt=0;
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
	session=request.getSession();
		s=(String)session.getAttribute("sessid");

		if(s==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		

		if(request.getParameter("mode")!=null)
			mode=request.getParameter("mode");
		else
			mode="q";
			courseId=request.getParameter("courseid");
			qt=request.getParameter("qt");
	   	//out.print("inn."+mode+qt);
			unitId=request.getParameter("unitid");
			lessonId=request.getParameter("lessonid");
			Qtype=request.getParameter("qtype");
			developerId=request.getParameter("userid");	
							
			assmt=Integer.parseInt(request.getParameter("assmt"));	
			cat=request.getParameter("cattype");
			con=con1.getConnection();
			st=con.createStatement();
			
			rs=st.executeQuery("select * from lbcms_dev_assessment_master where course_id='"+courseId+"'and slno="+assmt+"");
			if(rs.next())
			{
				courseName=rs.getString("course_name");
				assmtName=rs.getString("assmt_name");
				unitId=rs.getString("unit_id");
				lessonId=rs.getString("lesson_id");
				assmtId=rs.getString("assmt_id");
				lessonName=rs.getString("lesson_name");
				lessonName=lessonName.replaceAll("\'","&#39;");
				assmtName=rs.getString("assmt_name");
				instruct=rs.getString("assmt_instructions");
			}
			else
			{

			}
		


	 %>
<HTML>
<HEAD>
<TITLE> Assessment Builder </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<link href="../styles/teachcss.css" rel="stylesheet" type="text/css" />
</HEAD>
<frameset rows="65,0,35"name="mail" border="0" frameborder="0" framespacing="0">
<%
if(mode.equals("edit"))
{
	
	%>
		<frame src='CDAssmtWorkDone.jsp?courseid=<%=courseId%>&userid=<%=developerId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assmtName%>&cattype=<%=cat%>&qt=no&assmtId=<%=assmtId%>&mode=q#' name="leftmail" target="mainmail" scrolling="no" marginwidth="0" marginheight="0" noresize border="0">
		<%}
	else
	{	
		courseName=request.getParameter("coursename");
		lessonName=request.getParameter("lessonname");
		String aName="";
		aName=request.getParameter("asname");
		aName=aName.replaceAll("\'","&#39;");
		instruct=request.getParameter("instruct");
		instruct=instruct.replaceAll("\'","&#39;");
		

		
		%>
<frame src='CDAssmtWorkDone.jsp?mode=add&coursename=<%=courseName%>&userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&assmt=<%=assmt%>&asname=<%=aName%>&cattype=<%=cat%>&qt=<%=qt%>&qtype=<%=Qtype%>&lessonname=<%=lessonName%>&instruct=<%=instruct%>' name="leftmail" target="mainmail" scrolling="no" marginwidth="0" marginheight="0" noresize border="0">

		<%}
		%>

		<frame src="UntitledFrame-3" name="refreshframe" scrolling="yes" noresize target="mainmail" border="0">
<%
if(mode.equals("edit"))
{
	%>
		<frame src='QuestionsList.jsp?view=yes&courseid=<%=courseId%>&exId=<%=assmtId%>' name="mainmail" scrolling="yes" noresize border="0">
			<%}
	else
	{
		%>
				<frame src='QuestionsList.jsp?' name="mainmail" scrolling="yes" noresize border="0">

		<%}
		%>
	</frameset><noframes></noframes>
<BODY onUnload="opener.location.reload();">

</BODY>
</HTML>
