<%@page import = "java.sql.*,java.util.Date,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",subject="",school="",year="",dispMsg="",developerId="",grade="";
	String skills="",assessments="",resources="",vocabulary="";
	Connection con=null;
	ResultSet rs=null;
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
		dispMsg=request.getParameter("dispmsg");
		if(dispMsg==null)
			dispMsg="";

		if(dispMsg.equals("alreadyexists"))
		{
			dispMsg="<FONT COLOR='white' face='verdana' size='1'>A course with this name already exists! Please choose another one.</FONT>";
			courseName=request.getParameter("coursename");
		}
	
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

		rs=st.executeQuery("select * from curriculum_mapping_info where course_id='"+courseId+"' and status='1'");
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
<script>
function winprint()
{
	var w = 650;
	var h = 450;
	var l = (window.screen.availWidth - w)/2;
	var t = (window.screen.availHeight - h)/2;
	var sOption='toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,width=' + w + ',height=' + h + ',left=' + l + ',top=' + t;
	var sDivText =window.document.getElementById('divcontent').innerHTML;
	var objWindow = window.open('', 'Print', sOption);
	sDivText=sDivText.replace(/&lt;/g,'<');
	sDivText=sDivText.replace(/&gt;/g,'>');
	objWindow.document.write(sDivText);
	objWindow.document.close();
	objWindow.print();
	objWindow.close();
}
function edit(coursename)
{
	
alert("This feature will be added soon");	
return false;
}
</script>
</head>

<body>

<table border="0" cellpadding="2" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="40" bgcolor="#800000">
  <tr>
    <td width="33%" height="32">
		<font face="Cambria" size="4" color="#FFFFFF">
			<b>&nbsp;Curriculum Map - <%=courseName%></b>
		</font>
	</td>
    <td width="34%" height="32" align="right">
		<b><a href="CurriculumMap.jsp?courseid=<%=courseId%>&userid=<%=developerId%>">
		<font face="Cambria" color="#FFFFFF">&lt;&lt; Back To Curriculum Map</font></a>&nbsp;</b>
	</td>
  </tr>
  <tr>
    <td width="33%" height="33">
		<font face="Cambria" color="#FFFFFF">&nbsp;<b><%=grade%> - <%=subject%></b>(<%=year%>)</font>
	</td>
    <td width="34%" height="33" align="right">
		<a href='javascript:winprint();'><b><font size="1" face="Verdana" color="#FFFFFF">PRINT</font></b></a>
    </td>
  </tr>
</table>
<br>
<div id="divcontent">
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%" bordercolorlight="#C0C0C0">
  <tr>
    <td width="39" align="center" bgcolor="#FFFFFF">
    <font face="Verdana" size="1" color="#FB7D00"><b>Edit</b></font></td>
    <td width="95" bgcolor="#FFFFFF" align="center">
    <font face="Verdana" size="2" color="#FB7D00"><b>Month/Week</b></font></td>
    <td width="195" align="center" bgcolor="#FFFFFF">
    <font face="Verdana" size="2" color="#FB7D00"><b>Standard</b></font></td>
    <td width="166" align="center" bgcolor="#FFFFFF">
    <font face="Verdana" size="2" color="#FB7D00"><b>Skills</b></font></td>
    <td width="125" align="center" bgcolor="#FFFFFF">
    <font face="Verdana" size="2" color="#FB7D00"><b>Units / Lessons</b></font></td>
    <td width="152" align="center" bgcolor="#FFFFFF">
    <font face="Verdana" size="2" color="#FB7D00"><b>Assessments</b></font></td>
    <td width="146" align="center" bgcolor="#FFFFFF">
    <font face="Verdana" size="2" color="#FB7D00"><b>Resources</b></font></td>
    <td width="144" align="center" bgcolor="#FFFFFF">
    <font face="Verdana" size="2" color="#FB7D00"><b>Vocabulary</b></font></td>
  </tr>

<%
		int i=0;
		while(rs.next())
		{
%>
  <tr>
    <td width="39" align="center" valign="top">
		<a href="#" onclick="edit('<%=courseName%>');return false;">
					<font face="Verdana" size="1">Edit</font>
		</a>
	</td>
    <td width="95" valign="top" align="center">
		<font face="Verdana" size="2"><%=rs.getString("month")%><br><%=rs.getString("week")%></font>
	</td>
    <td width="195" valign="top">
		<font face="Verdana" size="2"><%=rs.getString("standard")%></font> &nbsp;
	</td>
    <td width="400" valign="top"><p align="justify"><%=rs.getString("skills")%></p></td>
    <td width="125" valign="top">
		<%=rs.getString("units_lessons_mapped")%> &nbsp;</td>
    <td width="152" valign="top">
		<%=rs.getString("assessments")%> &nbsp;</td>
    <td width="146" valign="top">
		<%=rs.getString("resources")%> &nbsp;</td>
    <td width="144" valign="top">
		<%=rs.getString("vocabulary")%> &nbsp;</td>
  </tr>
<%
		i++;
		}	  
%>
</table>
</div>
</body>

<%
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in CurriculumMappingPreview.jsp is....."+e);
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
			System.out.println("The exception2 in CurriculumMappingPreview.jsp is....."+se.getMessage());
		}
	}
%>

</html>