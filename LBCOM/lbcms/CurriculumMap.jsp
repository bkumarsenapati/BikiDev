<%@page import = "java.sql.*,java.util.Date,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",subject="",school="",year="",dispMsg="",developerId="",grade="";
	String standard="",skills="",assessments="",resources="",vocabulary="",unitslessons="";
	Connection con=null;
	ResultSet rs=null,rs1=null;
	Statement st=null;

	try
	{
		session=request.getSession();
		if(session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
			return;
		}
		courseId=request.getParameter("courseid");
		developerId=request.getParameter("userid");
		standard=request.getParameter("standard");
		if(standard == null)
			standard="slct";
			
		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select * from curriculum_info where course_id='"+courseId+"' and status='1'");

		if(rs.next())
		{
			courseName=rs.getString("course_name");
			subject=rs.getString("subject");
			//school=rs.getString("school");
			year=rs.getString("academic_year");
			grade=rs.getString("grade");
		}
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Curriculum Map</title>
<SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'>	</script>
<script language="JavaScript" type="text/javascript" src="wysiwyg/cmapwysiwyg.js"></script> 
<script language="javascript">
function validate()
{
	var win=window.document.curriculummap;
	if(trim(win.month.value)=="none")
	{
		alert("Please select the month");
		window.document.curriculummap.month.focus();
		return false;
	}
	if(trim(win.week.value)=="none")
	{
		alert("Please select the week");
		window.document.curriculummap.week.focus();
		return false;
	}
	if(trim(win.standard.value)=="none")
	{
		alert("Please select the standard");
		window.document.curriculummap.standard.focus();
		return false;
	}
	/*if(trim(win.skills.value)=="")
	{
		alert("Please enter the skills");
		win.skills.focus();
		return false;
	}  */
	
	replacequotes();
}
</script>
</head>

<body>

<form method="POST" name="curriculummap" action="AddCurriculumMapInfo.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&newstandard=<%=standard%>"  onsubmit="return validate();">

<table border="0" cellpadding="2" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="40" bgcolor="#800000">
  <tr>
    <td width="33%" height="32">
		<font face="Cambria" size="4" color="#FFFFFF">
			<b>&nbsp;Curriculum Map - <%=courseName%></b>
		</font>
	</td>
    <td width="34%" height="32" align="right">
		<b><a href="CourseHome.jsp?userid=<%=developerId%>"><font face="Cambria" color="#FFFFFF">&lt;&lt; Back To Home</font></a>&nbsp;</b>
	</td>
  </tr>
  <tr>
    <td width="33%" height="33">
		<font face="Cambria" color="#FFFFFF">&nbsp;<b><%=grade%> - <%=subject%></b>(<%=year%>)</font>
	</td>
    <td width="34%" height="33" align="right">
		<a href="CurriculumMapPreview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>">
			<font face="Cambria" size="2" color="#FFFFFF">PREVIEW</font>
		</a>&nbsp;
	</td>
  </tr>
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%" bordercolorlight="#C0C0C0">
  <tr>
    <td width="66%" colspan="2"><hr color="#800000" size="1"></td>
  </tr>
  <tr>
    <td width="12%"><font face="Cambria">&nbsp;Year, Month &amp; Week</font></td>
    <td width="54%" align="left">
      <select size="1" name="year" style="width: 150">
      <option selected>2009 - 2010</option>
      <option>2010 - 2011</option>
      <option>2011 - 2012</option>
      </select>
	  
	  &nbsp;&nbsp;

      <select size="1" name="month" style="width: 150">
      <option value="none" selected>Select Month</option>
      <option>January</option>
      <option>February</option>
      <option>March</option>
      <option>April</option>
      <option>May</option>
      <option>June</option>
      <option>July</option>
      <option>August</option>
      <option>September</option>
      <option>October</option>
      <option>November</option>
      <option>December</option>
      </select>
	  <font color="red">*</font>
	  &nbsp;&nbsp;
      <select size="1" name="week" style="width: 150">
	      <option value="none" selected>Select Week</option>
		  <option>1st Week</option>
	      <option>2nd Week</option>
		  <option>3rd Week</option>
	      <option>4th Week</option>
		  <option>5th Week</option>
      </select><font color="red">*</font>
	  </td>
    </tr>
  <tr>
    <td width="66%" colspan="2"><hr color="#800000" size="1"></td>
    </tr>
 <!--    <tr>
    <td width="12%"><font face="Cambria">&nbsp;Unit &amp; Lesson</font></td>
    <td width="54%" align="left">
		<select multiple="multiple" name="unitslessons" size="4"> -->
<%
/*		rs=st.executeQuery("select * from lbcms_dev_units_master where course_id='"+courseId+"'");		  

		while(rs.next())
		{
			rs1=st1.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+rs.getString("unit_id")+"'");
			while(rs1.next())
			{*/
%>
<!--  			<option value="rs1.getString(lesson_id)">rs.getString("unit_name") - rs1.getString("lesson_name")</option> --> 
<%
//			}
//		}	
%>
	<!-- 	</select>
	</td>
    </tr> -->
  <tr>
    <td width="66%" colspan="2"><hr color="#800000" size="1"></td>
  </tr>
  <tr>
    <td width="12%"><font face="Cambria">&nbsp;Standard</font></td>
    <td width="54%">
      <select size="1" name="standard">
      <option value="none">Select Standard</option>
<%
		rs=st.executeQuery("select distinct(standard) from curriculum_mapping_info where course_id='"+courseId+"'");		  
		while(rs.next())
		{
%>
			<option><%=rs.getString(1)%></option>
<%
		}	
%>
    </select>
	<script>
		document.curriculummap.standard.selected="<%=standard%>";
	</script>
	<font color="red">*</font>
	<b>
    <font size="1" color="#0000FF" face="Verdana">
    <a href="CurriculumStandard.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=developerId%>">(ADD NEW STANDARD)</a></font></b></td>
  </tr>
  <tr>
    <td width="100%" colspan="2"><hr color="#800000" size="1"></td>
  </tr>
  <tr>
    <td width="66%" colspan="2"><font face="Cambria">&nbsp;Skills</font><font color="red">*</font></td>
  </tr>
  <tr>
    <td width="100%" colspan="2">
		<textarea name="skills" id="skills" rows="1" cols="82"><%=skills%></textarea>
		<script language="JavaScript">
			generate_wysiwyg('skills');
		</script>
	</td>
  </tr>
  <tr>
    <td width="66%" colspan="2">
		<font face="Cambria">&nbsp;Units & Lessons</font>
		<font face="Verdana" size="1" color="#FF0000">(This will be integrated with the Course Builder soon)</font>
	</td>
  </tr>
  <tr>
    <td width="100%" colspan="2">
		<textarea name="unitslessons" id="unitslessons" rows="1" cols="82"><%=unitslessons%></textarea>
			<script language="JavaScript">
				generate_wysiwyg('unitslessons');
			</script>
	</td>
  </tr>
  <tr>
    <td width="100%" colspan="2"><hr color="#800000" size="1"></td>
  </tr>
  <tr>
    <td width="66%" colspan="2">
		<font face="Cambria">&nbsp;Related Assessments</font>
		<font face="Verdana" size="1" color="#FF0000">(This will be integrated with the Assessment Builder soon)</font>
	</td>
  </tr>
  <tr>
    <td width="66%" colspan="2">
		<textarea name="assessments" id="assessments" rows="1" cols="82"><%=assessments%></textarea>
		<script language="JavaScript">
			generate_wysiwyg('assessments');
		</script>
    </td>
  </tr>
  <tr>
    <td width="66%" colspan="2"><hr color="#800000" size="1"></td>
  </tr>
  <tr>
    <td width="66%" colspan="2"><font face="Cambria">&nbsp;Resources</font></td>
  </tr>
  <tr>
    <td width="66%" colspan="2">
		<textarea name="resources" id="resources" rows="1" cols="82"><%=resources%></textarea>
		<script language="JavaScript">
			generate_wysiwyg('resources');
		</script>
	</td>
  </tr>
  <tr>
    <td width="66%" colspan="2"><hr color="#800000" size="1"></td>
  </tr>
  <tr>
    <td width="66%" colspan="2"><font face="Cambria">Vocabulary</font></td>
  </tr>
  <tr>
    <td width="66%" colspan="2">
		<textarea name="vocabulary" id="vocabulary" rows="1" cols="82"><%=vocabulary%></textarea>
		<script language="JavaScript">
			generate_wysiwyg('vocabulary');
		</script>
	</td>
  </tr>
  <tr>
    <td width="66%" colspan="2"><hr color="#800000" size="1"></td>
  </tr>
  <tr>
    <td width="66%" colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td width="66%" colspan="2">
    <p align="center">
    <input type="submit" value="Save &amp; Add Another" name="save">&nbsp;&nbsp;
    <input type="button" value="Save &amp; Submit" name="saveclose">&nbsp;&nbsp;
    <input type="reset" value="Reset" name="reset">&nbsp;&nbsp;&nbsp;
    <input type="button" value="Preview" name="preview"></td>
  </tr>
  <tr>
    <td width="66%" colspan="2">&nbsp;</td>
  </tr>
</table>
</form>
</body>

<%
	}
	catch(Exception e)
	{
		System.out.println("The exception123456 in CurriculumMap.jsp is....."+e);
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
			System.out.println("The exception2 in CurriculumMap.jsp is....."+se.getMessage());
		}
	}
%>

</html>