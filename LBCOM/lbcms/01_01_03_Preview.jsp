<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";
	String lLength="";

	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	developerId=request.getParameter("userid");
%>
<%
	Connection con=null;
		ResultSet rs=null,rs1=null,rs2=null,rs10=null,rs11=null,rs4=null;
	Statement st=null,st1=null,st2=null,st10=null,st11=null,st4=null;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
%>

<html>
<head>
<title><%=courseName%> Content Developer</title>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<link href='images/sheet1' rel='stylesheet' type='text/css'>
<link href='images/sheet2' rel='stylesheet' type='text/css'>
<SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'>	</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{
	var win=document.thirdpage;
	replacequotes();
	win.submit();
}
function previewLesson()
{
	window.open("01_01_01_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>","Document","resizable=yes,scrollbars=yes,width=350,height=350,toolbars=no");
}
-->
</SCRIPT>
</head>
<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>

<form method="POST" name="firstpage" action="">

<table width='770' border='1' align='center' cellpadding='0' cellspacing='0'><tr><td align='left' valign='top' width='766'>
  <table id='Table_01' width='800' height='592' border='0' cellpadding='0' cellspacing='0' align='center'><tr>
  <td rowspan='10' width='1' height="591"></td>
    <td colspan='5' rowspan='2' width='254' height='1' background="images/content_03.jpg">
    <b><font face="Verdana" size="4">&nbsp;<font color="#FFFFFF"><%=courseName%></font></font></b></td><td colspan='2' rowspan='2' width='328' height='1'>
  <img src='images/content_03.jpg' width='328' height='65' alt=''></td><td colspan='3' rowspan='2' width='129' height='1'>
  <img src='images/content_04.jpg' width='129' height='64' alt=''></td><td colspan='2' width='65' height='1'><img src='images/content_05.jpg' width='87' height='20' alt='' border='0'></td>
  <td width='23' height="15"><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr>
            <td colspan='2' rowspan='2' width='65' height='36' valign='top'>
      <a href="#" onclick="previewLesson(); return false;"><img src='images/content_06.jpg' width='87' height='78' alt='' border='0'></a></td>

      <td width='23' height="45"><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr>
            <td colspan='10' background='images/line_06.jpg' class='main' width='711' height='36'><font face="Verdana" size="2"><%=unitName%>:&nbsp;<%=lessonName%></font></td>
      <td width='23' height="48"><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr>
  <td colspan='12' width='776' align='left' valign='top' rowspan='4' height="383">
<%
		if(rs.next())
		{
			String aTitle="",aAssessTitle="",aAssgnTitle="";
			aTitle=rs.getString("lesson_activity");
			aAssessTitle=rs.getString("lesson_assessment");
			aAssgnTitle=rs.getString("lesson_assignment");
		    lLength= rs.getString("lesson_length");

			String acts=rs.getString("activitystatus");
			String assgns=rs.getString("assignmentstatus");
			String assmts=rs.getString("assessmentstatus");
			System.out.println("assmts..."+assmts);
%>
  <table width='795' border='0' cellspacing='0' cellpadding='0' height='1'>
  <%
			
			 if(acts.equals("view"))
			{
				 // Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='acttitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
%>
  <tr>
    <td width='23' height='7' align='left' valign='top'><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></td>
    <td width='1383' height='7' align='left' valign='top'>
    <p align="left">&nbsp;<b><font face="Verdana" size="2" color="#FF0000"><%=rs.getString("lesson_activity")%></font></b></td></tr><tr><td width='23' height='64' align='left' valign='top'>&nbsp;</td><td width='1383' height='64' align='left' valign='top'>
      <p align="left"><%=rs.getString("activity")%></td>
	  </tr>
	  <%
			}
			 if(assmts.equals("view"))
			{
				 // Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		System.out.println("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assmttitleicon'");
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assmttitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
%>
	  <tr><td width='23' height='14' align='left' valign='top'><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></td>
	  <td width='1383' height='14' align='left' valign='top'>
      <hr color='#008080' width='90%' size='1' align='left' noshade></td></tr><tr>
    <td width='23' height='1' align='left' valign='top'></td>
    <td width='1383' height='1' align='left' valign='top'>
    <p align="left"><font face="Verdana" size="2" color="#FF0000"><b>&nbsp;<%=rs.getString("lesson_assessment")%></b></font></td></tr><tr><td width='23' height='61' align='left' valign='top'>&nbsp;</td><td width='1383' height='61' align='left' valign='top'>
      <p align="left"><%=rs.getString("assessment")%></td>
	  </tr>
	  <%
			}
			 if(assgns.equals("view"))
			{
				 // Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='assgntitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
%>
	  <tr><td width='23' height='19' align='left' valign='top'><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></td>
	  <td width='1383' height='19' align='left' valign='top'>
      <hr color='#008080' align='left' width='90%' size='1' noshade></td></tr><tr>
    <td width='23' height='1' align='left' valign='top'></td>
    <td width='1383' height='1' align='left' valign='top'>
    <p align="left"><font face="Verdana" size="2" color="#FF0000"><b>&nbsp;<%=rs.getString("lesson_assignment")%></b></font></td>
	</tr>
<%
			
%>
	<tr>
      <td width='23' height='42' align='left' valign='top'>&nbsp;</td>
      <td width='1383' height='42' align='left' valign='top'>
      <p align="left"><%=rs.getString("assignment")%></td></tr><tr><td width='23' height='18' align='left' valign='top'></td><td width='1383' height='18' align='left' valign='top'>
      <hr color='#008080' align='left' width='90%' size='1' noshade></td></tr>
	  <%
			}
		}
st.close();
// Sections added from here

int i=5;
st4=con.createStatement();
rs4=st4.executeQuery("select * from lbcms_dev_lesson_firstpage_content where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_no>5 order by section_no");
		while(rs4.next())
		{
			i++;
			// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='"+i+"'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
%>

<tr>
        <td height='1' width='8'><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></td>
      <td height='1' width='1370'><b>
      <font face="Verdana" size="2" color="#FF0000"><%=rs4.getString("section_title")%></font></b></td></tr><tr>
        <td height='19' width='8'>&nbsp;</td>
        <td height='19' width='1370'><%=rs4.getString("section_content")%></td></tr><tr>
      <td height='18' width='64'>
      </td>
      <td height='18' width='697'>
      <hr color="#008080" width="700" size="1" align="left" noshade></td>
      </tr>


<%}
st4.close();


// Upto here
%>
	  
	  <tr>
    <td width='23' height='1' align='center' valign='top'></td>
    <td width='1383' height='1' align='center' valign='top'>
    <p align="left"><b><font face="Verdana" size="2" color="#FF0000">&nbsp;LENGTH</font></b></td></tr><tr>
      <td width='23' height='1' align='center' valign='top'></td>
      <td width='1383' height='1' align='left' valign='top'><%=lLength%></td></tr>
<%
		

		
%>
		<tr><td width='23' height='18' align='center' valign='top'></td><td width='1383' height='18' align='center' valign='top'>
      <hr color='#008080' align='left' width='90%' size='1' noshade></td></tr><tr><td width='23' height='18' align='center' valign='top'></td><td width='1383' height='18' align='center' valign='top'></td></tr></table>
	  </td><td width='23' height="37"><img src='images/spacer.gif' width='1' height='25' alt=''></td></tr><tr>
      <td width='23' height="83"><img src='images/spacer.gif' width='1' height='58' alt=''></td></tr><tr>
      <td width='23' height="208"><img src='images/spacer.gif' width='1' height='146' alt=''></td></tr><tr>
      <td width='23' height="55"><img src='images/spacer.gif' width='1' height='39' alt=''></td></tr><tr>
      <td colspan='8' width='628' height="55"><img src='images/content_26.jpg' width='628' height='47' alt=''></td>
      <td colspan='4' width='148' height="55"><img src='images/content_27.jpg' width='170' height='47' alt=''></td>
      <td width='23' height="55"><img src='images/spacer.gif' width='1' height='47' alt=''></td></tr><tr>
      <td colspan='6' width='448' height="22"><img src='images/content_28.jpg' width='448' height='19' alt=''></td>
      <td colspan='2' rowspan='2' width='180' height="45"><img src='images/content_29.jpg' width='180' height='39' alt=''></td>
      <td rowspan='2' width='73' height="45"><img src='images/content_30.jpg' width='73' height='39' alt=''></td>
      <td colspan='2' rowspan='2' width='48' height="45"><a href='01_01_02_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=1'><img src='images/content_31.jpg' width='48' height='39' alt='' border='0'></a></td>
      <td rowspan='2' width='27' height="45">
  <input type="image" src='images/content_32.jpg' width='49' height='39' alt='Exit Lesson page' onclick="javascript:window.close();" border='0'></a></td>
      <td width='23' height="22">	<img src='images/spacer.gif' width='1' height='19' alt=''></td></tr><tr>
      <td colspan='6' width='448' height="23"><img src='images/content_33.jpg' width='448' height='20' alt=''></td>
      <td width='23' height="23">	<img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr>
      <td width='1' height="1"><img src='images/spacer.gif' width='1' height='1' alt=''></td>
      <td width='30' height="1">	<img src='images/spacer.gif' width='30' height='1' alt=''></td>
      <td width='2' height="1"><img src='images/spacer.gif' width='2' height='1' alt=''></td>
      <td width='2' height="1"><img src='images/spacer.gif' width='2' height='1' alt=''></td>
      <td width='44' height="1"><img src='images/spacer.gif' width='44' height='1' alt=''></td>
      <td width='176' height="1"><img src='images/spacer.gif' width='176' height='1' alt=''></td>
      <td width='194' height="1"><img src='images/spacer.gif' width='194' height='1' alt=''></td>
      <td width='134' height="1"><img src='images/spacer.gif' width='134' height='1' alt=''></td>
      <td width='46' height="1">	<img src='images/spacer.gif' width='46' height='1' alt=''></td>
      <td width='73' height="1">	<img src='images/spacer.gif' width='73' height='1' alt=''></td>
      <td width='10' height="1">	<img src='images/spacer.gif' width='10' height='1' alt=''></td>
      <td width='38' height="1">	<img src='images/spacer.gif' width='38' height='1' alt=''></td>
      <td width='27' height="1">	<img src='images/spacer.gif' width='49' height='1' alt=''></td>
      <td width='23' height="1"></td></tr></table></td></tr></table></ul></ul></ul>

</form>
<%
		}
		catch(Exception e)
		{
			System.out.println("The exception1 in 01_01_03_Preview.jsp is....."+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(st4!=null)
					st4.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in 01_01_03_Preview.jsp is....."+se.getMessage());
			}
		}
%>

</body>
</html>