<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",currentSlide="",slideNo="",slideContent="";
	String schoolId="",schoolPath="",developerId="";
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	currentSlide=request.getParameter("slideno");
	developerId=request.getParameter("userid");
%>
<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select * from lbcms_dev_lesson_content_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slide_no");
%>
<html>
<head>
<title><%=courseName%> Content Developer</title>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<link href='images/sheet1' rel='stylesheet' type='text/css'>
<link href='images/sheet2' rel='stylesheet' type='text/css'><link href='images/slide_css.css' rel='stylesheet' type='text/css'><script src='../images/script.js'>
</script><bgsound id=pptSound><link href='images/slide_css.css' rel='stylesheet' type='text/css'><SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'>	</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{
	var win=document.secondpage;
	replacequotes();
	win.submit();
}

function gotoThirdPage()
{
	window.location.href="01_01_03.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>";
}

function previewLesson()
{
	window.open("01_01_01_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>","Document","resizable=yes,scrollbars=yes,width=350,height=350,toolbars=no");
}

-->
</SCRIPT>
<script language="JavaScript" type="text/javascript" src="openwysiwyg/wysiwyg.js"></script> 
</head>
<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>

<form method="POST" name="secondpage" action="">

<table width='770' border='1' align='center' cellpadding='0' cellspacing='0' height="486"><tr>
		<td align='left' valign='top' width='766' height="484">
        <table id='Table_01' width='800' height='435' border='0' cellpadding='0' cellspacing='0' align='center'><tr>
          <td rowspan='14' width='1' height='434'><img src='images/content_01.jpg' width='1' height='600' alt=''></td>
    <td colspan='5' rowspan='2' width='254' height='1' background="images/content_03.jpg">
    <b><font face="Verdana" size="4">&nbsp;<font color="#FFFFFF"><%=courseName%></font></font></b></td><td colspan='2' rowspan='2' width='328' height='1'><img src='images/content_03.jpg' width='328' height='58' alt=''></td><td colspan='3' rowspan='2' width='129' height='1'><img src='images/content_04.jpg' width='129' height='58' alt=''></td><td colspan='2' width='65' height='1'><img src='images/content_05.jpg' width='87' height='20' alt='' border='0'></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr>
            <td colspan='2' rowspan='2' width='65' height='36' valign='top'>
      <a href="#" onclick="previewLesson(); return false;"><img src='images/content_06.jpg' width='87' height='78' alt='' border='0'></a></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr>
            <td colspan='10' background='images/line_06.jpg' class='main' width='711' height='36'><font face="Verdana" size="2"><%=unitName%>:&nbsp;<%=lessonName%></font></td>
	  <td width='23' height='36'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td colspan='12' width='776' align='left' valign='top' rowspan='8' height='376'>

	  <%
		  int total_count = 0;

	
       Statement stcount = con.createStatement();
	   String strQuerycount = "select count(*) from lbcms_dev_lesson_content_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slide_no";
	   
	   ResultSet rscount = stcount.executeQuery(strQuerycount);
		if(rscount.next())
		{
			 total_count=rscount.getInt(1);
		}

%>
<%
        int slidedisplay=1;	
		while(rs.next())
			{
				slideNo=rs.getString("slide_no");
				
				if(currentSlide.equals(slideNo))
				{
					slideContent=rs.getString("slide_content");
%>
					<!-- <span style="background-color: #FF0000">&nbsp;<%=slidedisplay%>&nbsp;</span> -->
<%
				}
				else
				{
%>
					<!-- <span style="background-color: #C0C0C0">&nbsp;<a href="01_01_02_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=<%=slideNo%>"><%=slidedisplay%></a>&nbsp;</span> -->
<%
				}
				slidedisplay++;
			}
%>
				<!-- </font></b>
			</td>
				<td width='72' class='main' height='26'></td>
		</tr> -->
           
			<head><meta name='GENERATOR' content='Microsoft FrontPage 5.0'><meta name='ProgId' content='FrontPage.Editor.Document'><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'><title>Test Course</title><link href='images/slide_css.css' rel='stylesheet' type='text/css'><script src='../images/script.js'></script><bgsound id=pptSound><link href='images/slide_css.css' rel='stylesheet' type='text/css'></head><body>
			<table>
			  <tr>
			    <td><font color="gray">Slide by slide</font></td>
				<td>|</td>
				<td><a href='01_01_02_Preview_All.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>'><font color="Red">All Slides</td>

			  </tr>
			 </table>
			<table border='2' cellpadding='0' cellspacing='0' bordercolor='#000080' width='670' height='440' align='center'><tr><td width='670' height='425'><div class='slide_heading' align='center'></div><P>&nbsp;</P>
        <P>
		
		&nbsp;<%=slideContent%>
		
		</P>
<br><div class='slide_sub_heading'>&nbsp;&nbsp;</div><br></td></tr><tr><td height='15' width='670'><table border='0' cellpadding='0' cellspacing='0' width='100%' height='15'><tr><td width='33%' height='15' class='main'><font face='Verdana' size='1'>

<%
	int i=Integer.parseInt(currentSlide);
	if(i<=total_count){
if(i!=1){

	%>
<a href='01_01_02_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=<%=(i-1)%>'>&nbsp;&lt;&lt;PREVIOUS</a>
<%
}
	i++;
}
%>
</font></td><td width='34%' height='15' class='main' align='center'><a href='01_01_02_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=1'><font face='Verdana' size='1'>&lt;&lt;HOME&gt;&gt;</font></a></td><td width='33%' height='15' class='main' align='right'>
<%
	i=Integer.parseInt(currentSlide);
	if(i<=total_count){

if(i!=total_count){
	%>
<a href='01_01_02_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=<%=(i+1)%>'><font face='Verdana' size='1'>NEXT&gt;&gt;&nbsp;</font>
<%
  }
	i++;
}
%>
</a></td></tr></table></td></tr></table></body></html>	<hr size="1" width="77%" color="green">
			
</td><td width='23' height='25'><img src='images/spacer.gif' width='1' height='25' alt=''></td></tr><tr><td width='23' height='38'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td width='23' height='30'><img src='images/spacer.gif' width='1' height='30' alt=''></td></tr><tr><td width='23' height='40'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23' height='40'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23' height='58'><img src='images/spacer.gif' width='1' height='58' alt=''></td></tr><tr><td width='23' height='146'><img src='images/spacer.gif' width='1' height='146' alt=''></td></tr><tr><td width='23' height='1'><img src='images/spacer.gif' width='1' height='39' alt=''></td></tr><tr><td colspan='8' width='628' height='47'><img src='images/content_26.jpg' width='628' height='47' alt=''></td><td colspan='4' width='148' height='47'><img src='images/content_27.jpg' width='170' height='47' alt=''></td><td width='23' height='47'><img src='images/spacer.gif' width='1' height='47' alt=''></td></tr><tr><td colspan='6' width='448' height='19'><img src='images/content_28.jpg' width='448' height='19' alt=''></td><td colspan='2' rowspan='2' width='180' height='39'><img src='images/content_29.jpg' width='180' height='39' alt=''></td><td rowspan='2' width='73' height='39'><img src='images/content_30.jpg' width='73' height='39' alt=''></td>
		  <td colspan='2' rowspan='2' width='48' height='39'>	<a href="01_01_01_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>"><img src='images/content_31.jpg' width='48' height='39' alt='' border='0'></a></td><td rowspan='2' width='27' height='39'><a href="01_01_03_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>"><img src='images/content_32.jpg' width='49' height='39' alt='' border='0'></a></td><td width='23' height='19'>	<img src='images/spacer.gif' width='1' height='19' alt=''></td></tr><tr><td colspan='6' width='448' height='20'><img src='images/content_33.jpg' width='448' height='20' alt=''></td><td width='23' height='20'><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr><td width='1' height='1'><img src='images/spacer.gif' width='1' height='1' alt=''></td><td width='30' height='1'><img src='images/spacer.gif' width='30' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='44' height='1'><img src='images/spacer.gif' width='44' height='1' alt=''></td><td width='176' height='1'><img src='images/spacer.gif' width='176' height='1' alt=''></td><td width='194' height='1'><img src='images/spacer.gif' width='194' height='1' alt=''></td><td width='134' height='1'><img src='images/spacer.gif' width='134' height='1' alt=''></td><td width='46' height='1'><img src='images/spacer.gif' width='46' height='1' alt=''></td><td width='73' height='1'><img src='images/spacer.gif' width='73' height='1' alt=''></td><td width='10' height='1'><img src='images/spacer.gif' width='10' height='1' alt=''></td><td width='38' height='1'><img src='images/spacer.gif' width='38' height='1' alt=''></td><td width='27' height='1'><img src='images/spacer.gif' width='49' height='1' alt=''></td><td width='23' height='1'></td></tr></table></td></tr></table>
</form>

<%
		}
		catch(Exception e)
		{
			System.out.println("The exception1 in 01_01_02_Preview.jsp is....."+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in 01_01_02_Preview.jsp is....."+se.getMessage());
			}
		}
%>

</body>
</html>
</body></html>