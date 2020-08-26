<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";
	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	developerId=request.getParameter("userid");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
%>
<%
	Connection con=null;
	ResultSet rs=null,rs1=null;
	Statement st=null;
	try
	{
		con=con1.getConnection();
		st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		rs=st.executeQuery("select what_i_learn_today from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
%>

<html>
<head>
<title><%=courseName%> Content Developer</title>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<link href='images/sheet1' rel='stylesheet' type='text/css'>
<link href='images/sheet2' rel='stylesheet' type='text/css'>
<SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'>	</script>
<!-- <script language="JavaScript" type="text/javascript" src="wysiwyg/clwysiwyg.js"></script>  -->
	<!-- TinyMCE -->
<script type="text/javascript" src="../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		convert_urls : false,
		relative_urls : false,
		plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

		// Theme options
		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		],

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{
	
	replacequotes();
	//win.submit();
}
-->
</SCRIPT>
</head>
<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>

<form method="POST" name="firstpage" action="SaveCheckList.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>">

<%
		if(rs.next())
		{

			String lToday;
			lToday=rs.getString(1);
			if(lToday==null)
			{
				lToday=" ";
			}
%>
<table width='770' border='1' align='center' cellpadding='0' cellspacing='0'><tr><td align='left' valign='top' width='766'>
  <div align="center">
    <center>
    <table id='Table_01' width='800' border='0' cellpadding='0' cellspacing='0' bordercolor="#111111">
	<tr>
		<td rowspan='14' width='1'><img src='images/content_01.jpg' width='1' alt=''></td>
		<td colspan='5' rowspan='2' width='254' height='1' background="images/content_03.jpg">
			<font size="4" face="Verdana">&nbsp;<b><font color="#FFFFFF"><%=courseName%></font></b></font>
		</td>
		<td colspan='2' rowspan='2' width='328' height='1'><img src='images/content_03.jpg' width='328' alt=''></td>
		<td colspan='3' rowspan='2' width='129' height='1'><img src='images/content_04.jpg' width='129' height='58' alt=''></td>
		<td colspan='2' width='65' height='1'><img src='images/content_05.jpg' width='87' height='20' alt='' border='0'></td>
		<td width='23' height='1'><img src='images/spacer.gif' width='1' height='20' alt=''></td>
	</tr>
	<tr><td colspan='2' rowspan='2' width='65' height='1' valign='top'>
        <!-- <a href="CourseUnits.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>"><img src='images/content_06.jpg' width='87' alt='' border='0'></a></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td colspan='10' background='images/line_06.jpg' class='main' width='711' height='1'>  -->
		<a href="CourseUnitLessons.jsp?&userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>"><img src='images/content_06.jpg' width='87' alt='' border='0'></a></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td colspan='10' background='images/line_06.jpg' class='main' width='711' height='1'>
		
  <font face="Verdana" size="2">&nbsp;<b><%=unitName%>:</b>&nbsp;<%=lessonName%></font></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr>
  <tr><td colspan='12' width='776' align='left' valign='top' rowspan='8'>
    <table width='795' border='0' cellspacing='0' cellpadding='0' style="border-collapse: collapse" bordercolor="#111111"><tr>
        <td width='8' height='25'>&nbsp;</td>
        <td width='1370' class='main' height='25'><b>
        <font face="Verdana" size="2" color="#FF0000">ADD THE CHECKLIST CONTENT HERE!</font></b></td></tr><tr>
        <td height='19' width='8'>&nbsp;</td>
        <td height='10' width='680'>
         <textarea name="learn_today" id="learn_today" rows="25" cols="96"><%=lToday%></textarea>
		 <script language="JavaScript">
			generate_wysiwyg('learn_today');
		 </script>
		</td></tr>
<%
		}
%>
		</table></td>
		<td width='23'>
		<img src='images/spacer.gif' width='1' height='25' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td width='23' ><img src='images/spacer.gif' width='1' height='30' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='58' alt=''></td></tr><tr><td width='23' height='146'><img src='images/spacer.gif' width='1' height='146' alt=''></td></tr><tr><td width='23' height='1'><img src='images/spacer.gif' width='1' height='39' alt=''></td></tr><tr><td colspan='8' width='628' height='47'>&nbsp;</td><td colspan='4' width='148' height='47'><img src='images/content_27.jpg' width='170' height='47' alt=''></td><td width='23' height='47'><img src='images/spacer.gif' width='1' height='47' alt=''></td></tr><tr><td colspan='6' width='448' height='19'><img src='images/content_28.jpg' width='448' height='19' alt=''></td><td colspan='2' rowspan='2' width='180' height='39'><img src='images/content_29.jpg' width='180' height='39' alt=''></td><td rowspan='2' width='73' height='39'><img src='images/content_30.jpg' width='73' height='39' alt=''><td colspan='2' rowspan='2' width='48' height='39'>
      <a href="CourseUnitLessons.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>"><img src='images/content_31.jpg' width='48' height='39' alt='' border='0'></a></td><td rowspan='2' width='27' height='39'><input type="image" src='images/content_32.jpg' width='49' height='39' alt='Save and move to the lessons page' border='0' onclick="return validate();"></td><td width='23' height='19'>	<img src='images/spacer.gif' width='1' height='19' alt=''></td></tr><tr><td colspan='6' width='448' height='20'><img src='images/content_33.jpg' width='448' height='20' alt=''></td><td width='23' height='20'><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr><td width='1' height='1'><img src='images/spacer.gif' width='1' height='1' alt=''></td><td width='30' height='1'><img src='images/spacer.gif' width='30' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='44' height='1'><img src='images/spacer.gif' width='44' height='1' alt=''></td><td width='176' height='1'><img src='images/spacer.gif' width='176' height='1' alt=''></td><td width='194' height='1'><img src='images/spacer.gif' width='194' height='1' alt=''></td><td width='134' height='1'><img src='images/spacer.gif' width='134' height='1' alt=''></td><td width='46' height='1'><img src='images/spacer.gif' width='46' height='1' alt=''></td><td width='73' height='1'><img src='images/spacer.gif' width='73' height='1' alt=''></td><td width='10' height='1'><img src='images/spacer.gif' width='10' height='1' alt=''></td><td width='38' height='1'><img src='images/spacer.gif' width='38' height='1' alt=''></td><td width='27' height='1'><img src='images/spacer.gif' width='49' height='1' alt=''></td><td width='23' height='1'></td></tr></table>
    </center>
  </div>
  </td></tr></table>

</form>
<%
		}
		catch(Exception e)
		{
			System.out.println("The exception2 in Checklist.jsp is....."+e);
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
				System.out.println("The exception1 in Checklist.jsp is....."+se.getMessage());
			}
		}
%>

</body>
</html>