
<html><head>
<title><%=application.getInitParameter("title")%></title>
</head>
<%
    
String userid ="Admin";
String schoolid = (String)session.getAttribute("schoolid");
String sessId=(String)session.getAttribute("sessid");
if(sessId==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
}
%>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" oncontextmenu='return false;'> 
<div align="center">
<center>
 <table border="0" width="681" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0"> 
<tr><td width="629" colspan="4" height="28">
  <p align="center"><b>
  <font face="Verdana" size="2" color="#FF0000">Welcome, School Administrator !</font></b></td> 
</tr> 
<tr><td width="629" colspan="4" height="28"><p align="left"><b>
  <font face="Verdana" size="2">School Administration Controls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</font></b></td> 
</tr>
<tr>
  <td width="48" align="center" height="45"> 
<p><a href="javascript://" onclick="return handler('classids');">
<img src="images/classes.gif" width="35" height="35" border="0"></a></p></td> 
<td width="152" align="left" height="45"><p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('classids');">
<FONT 
face="Verdana" size="2"><b>Manage Class IDs.</b></FONT></a></td> 
<td width="30" height="30" align="center"><p align="center"><font size="2" face="Verdana"><b>-</b></font></p>
</td><td width="425" height="30" align="left"><FONT face=verdana color=#000000 size="2">Add, Modify or Delete Class IDs </FONT></td>
</tr>

<tr>
  <td width="48" align="center" height="45"> 
<p><a href="javascript://" onclick="return handler('subsections');"><img src="images/groups.gif" width="45" height="45" border="0"></a></p></td> 
<td width="152" align="left" height="45"><p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('subsections');">
<FONT 
face="Verdana" size="2"><b>Group/Section IDs</b></FONT></a></td> 
<td width="30" height="45" align="center"><p align="center"><font size="2" face="Verdana"><b>-</b></font></p>
</td><td width="425" height="45" align="left"><FONT face=verdana color=#000000 size="2">Add, Modify or Delete Group/Section IDs </FONT></td>
</tr>

<tr>
  <td width="48" height="45"><p><font size="2"><a href="javascript://" onclick="return handler('users');"><img src="images/addusers.gif" width="45" height="45" border="0"></a></font></p> 
</td><td width="152" align="left" height="45"><p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('users');"><font face="Verdana" size="2"><b>Add/Edit User</b></font></a></td>
  <td width="30" height="45" align="center"><p align="center"><b><font size="2" face="Verdana">-</font></b></p> 
</td><td width="425" height="45" align="left"><FONT face=verdana color=#000000 size="2">Add, Modify or Delete 
  User Information</FONT></td> 
</tr>
<!-- Added from here for District -->

<tr>
  <td width="48" align="center" height="45"> 
<p><a href="javascript://" onclick="return handler('dist');">
<img src="images/classes.gif" width="35" height="35" border="0"></a></p></td> 
<td width="152" align="left" height="45"><p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('dist');">
<FONT 
face="Verdana" size="2"><b>Manage District.</b></FONT></a></td> 
<td width="30" height="30" align="center"><p align="center"><font size="2" face="Verdana"><b>-</b></font></p>
</td><td width="425" height="30" align="left"><FONT face=verdana color=#000000 size="2">Add, Modify or Delete District</FONT></td>
</tr>
<!-- Upto here ----- >
<tr>
  <td width="48" height="45"><p><a href="javascript://" onclick="return handler('notice')"><img src="images/departments.gif" width="45" height="45" border="0"></a></p> 
</td><td width="152" align="left" height="45"><p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('notice')">
  <FONT 
face="Verdana" size="2"><b>Notice Boards</b></FONT></a></td> 
<td width="30" height="45" align="center"><p align="center"><font size="3" face="Verdana"><b>-</b></font></p>
</td><td width="425" height="45" align="left"> 
  <FONT  
face=verdana color=#000000 size="2">Add, Modify or Delete Notice Boards</FONT></td> 
</tr>
<tr>
  <td width="48" height="45"><p><a href="javascript://" onclick="return handler('guides');"><img src="images/userguid.gif" width="45" height="45" border="0"></a></p> 
</td><td width="152" align="left" height="45"> 
<p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('guides');">
<FONT  
face="Verdana" size="2"><b><u>User Manuals</u></b></FONT></a></td>
<td width="30" height="45" align="center"><p align="center"><font size="3" ace="Verdana"><b>-</b></font></p>
</td><td width="425" height="45" align="left"> <FONT face=verdana color=#000000 size=2> </FONT><font face="verdana" size="2">Learn how to make Hotschools work for you</font></td>
</tr>
<!------------------Import--------------------->
<tr>
  <td width ="48" height="45"><p><a href="javascript://" onclick="return handler('import');"><img src="images/import.gif" width="45" height="45" border="0"></a></p> 
</td>
<td width="152" align="left" height="45"> 
<p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('import');">
<FONT face="Verdana" size="2"><b><u>Import Utility</u></b></FONT></a></td>

<td width="30" height="45" align="center"><p align="center"><font size="3" ace="Verdana"><b>-</b></font></p>
</td><td width="425" height="45" align="left"> <FONT face=verdana color=#000000 size=2>
  Import Questions and create Assessments from Zipped Archives</FONT></td>
</tr>

<!-- Santhosh added from here to import the assessments to Coursebuilder -->

<tr>
  <td width ="48" height="45"><p><a href="javascript://" onclick="return handler('import');"><img src="images/import.gif" width="45" height="45" border="0"></a></p> 
</td>
<td width="152" align="left" height="45"> 
<p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('importcb');">
<FONT face="Verdana" size="2"><b><u>Assessments Export</u></b></FONT></a></td>

<td width="30" height="45" align="center"><p align="center"><font size="3" ace="Verdana"><b>-</b></font></p>
</td><td width="425" height="45" align="left"> <FONT face=verdana color=#000000 size=2>
  Export Questions and create Assessments in Course Builder</FONT></td>
</tr>
<tr>
		<!-- Upto here -->



<!--------------------------------------------->

<!--<tr>
  <td width="48"> 
<p><a href="BillingStart.jsp?schoolid=<%= schoolid%>&userid=<%= userid%>"><img src="images/billinginfo.gif" width="45" height="45" border="0"></a></p></td> 
<td width="137" align="left" valign="middle"><p align="left"><a style="COLOR: blue" href="BillingStart.jsp?schoolid=<%= schoolid%>&userid=<%= userid%>"><FONT 
face="Verdana" size="2" color="#0033FF"><b>Billing and Usage</b></FONT></a></td> 
<td width="17"><p align="center"><font size="2" face="Verdana"><b>-</b></font></p>
</td><td width="393"><FONT face=verdana size="2" color=#000000>View storage reports and 
modify your Price Plan</FONT></td>
</tr>
-->


<tr>
  <td width ="48" height="45"><p><a href="javascript://" onclick="return handler('cms');"><img src="images/cms.gif" width="45" height="45" border="0"></a></p> 
</td><td width="152" align="left" height="45"> 
<p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('cms');">
<FONT face="Verdana" size="2"><b><u>CMS</u></b></FONT></a></td>
<td width="30" height="45" align="center"><p align="center"><font size="3" ace="Verdana"><b>-</b></font></p>
</td><td width="425" height="45" align="left"> <FONT face=verdana color=#000000 size=2>
  Content Management System</FONT></td>
</tr>
<!-- Added by Rajesh -->
		<tr>
		  <td width ="48" height="45"><a href="javascript://" onclick="return handler('accesscontrol');"><img src="../accesscontrol/images/accescontrol.gif" width="45" height="45" border="0"></a></td>
          <td width="152" align="left" height="45"> 
		<p align="left"><a style="COLOR: blue" href="javascript://" onclick="return handler('accesscontrol');">
        <FONT face="Verdana" size="2"><b><u>Form Access Control</u></b></FONT></a></td>
		<td width="30" height="47" align="center"><font size="3" face="Verdana"><b>-</b></font></td>
          <td width="425" height="47" align="left"> <font face="verdana" size="2">Enable/Disable Learnbeyond features</font></td>
		</tr>
		<tr>
		  <td width ="48" height="39"><a href="javascript://" onclick="return handler('mpoints');"><img src="../markingpoints/images/mperiods.jpg" width="45" height="45" border="0"></a></td>
          <td width="152" align="left" height="39"> 
			<p align="left">
				<a style="COLOR: blue" href="javascript://" onclick="return handler('mpoints');">
			<FONT face="Verdana" size="2"><b><u>Marking Periods</u></b></FONT></a></td>
		<td width="30" height="39" align="center"><font size="3" face="Verdana"><b>-</b></font></td>
          <td width="425" height="39" align="left"> 
		  <font face="verdana" size="2">Create and Manage Marking Periods for the 
          Courses&nbsp;</font></td>
		</tr>
		
<!--  Added by Ghanendra -->		
		<tr>
		  <td width ="48" height="39"><a href="javascript://" onclick="return handler('mailp');"><img src="images/mail_priv.gif" width="45" height="45" border="0"></a></td>
          <td width="152" align="left" height="39"> 
			<p align="left">
				<a style="COLOR: blue" href="javascript://" onclick="return handler('mailp');">
			<FONT face="Verdana" size="2"><b><u>Mail send privilege</u></b></FONT></a></td>
		<td width="30" height="39" align="center"><font size="3" face="Verdana"><b>-</b></font></td>
        <td width="425" height="39" align="left"> 
		  <font face="verdana" size="2">Define mail send privilege&nbsp;</font></td>
		  </tr>

		  <tr>
		  <td width ="48" height="39"><a href="javascript://" onclick="return handler('mailp');"><img src="images/upload_logo.png" width="45" height="45" border="0"></a></td>
          <td width="152" align="left" height="39"> 
			<p align="left">
				<a style="COLOR: blue" href="javascript://" onclick="return handler('cobrand');">
			<FONT face="Verdana" size="2"><b><u>Upload Logo</u></b></FONT></a></td>
		<td width="30" height="39" align="center"><font size="3" face="Verdana"><b>-</b></font></td>
        <td width="425" height="39" align="left"> 
		  <font face="verdana" size="2">Define Logo&nbsp;</font></td>
		  </tr>
		
		
		
		
		<!-- <tr>
		  <td width ="48" height="39"><a href="javascript://" onclick="return handler('weightages');">
		  <img src="images/departments.gif" width="45" height="45" border="0"></a></td>
          <td width="152" align="left" height="39"> 
			<p align="left">
				<a style="COLOR: blue" href="javascript://" onclick="return handler('weightages');">
			<FONT face="Verdana" size="2"><b><u>Course Categories</u></b></FONT></a></td>
		<td width="30" height="39" align="center"><font size="3" face="Verdana"><b>-</b></font></td>
          <td width="425" height="39" align="left"> 
		  <font face="verdana" size="2">Add and Manage Categories for the Courses</font></td>
		</tr> -->
		
		<!-- <tr>
		  <td width ="48" height="45"><a href="javascript://" onclick="return handler('courseware');"><img src="../markingpoints/images/mperiods.jpg" width="45" height="45" border="0"></a></td>
          <td width="170" align="left" height="45"> 
			<p align="left">
				<a style="COLOR: blue" href="javascript://" onclick="return handler('courseware');">
			<FONT face="Verdana" size="2"><b><u>Courseware Manager</u></b></FONT></a></td>
		<td width="30" height="47" align="center"><font size="3" face="Verdana"><b>-</b></font></td>
          <td width="425" height="47" align="left"> 
		  <font face="verdana" size="2">Create and Manage Courses</font></td>
		</tr> -->
<!-- Added by Rajesh -->
</table></center>
</div>
</body>

<SCRIPT LANGUAGE="JavaScript">
<!--
function handler(anc){
	if(anc=="classids")
		document.location.href="/LBCOM/schoolAdmin/DisplayClasses.jsp?schoolid=<%= schoolid%>";
	else if(anc=='courseware')
		parent.main.location.href="/LBCOM/coursemgmt/admin/CoursewareFrame.jsp";
	else if(anc=="mpoints")
		document.location.href="/LBCOM/markingpoints/";
	else if(anc=="weightages")
		document.location.href="weightage";
	else if(anc=="subsections")
		document.location.href="/LBCOM/schoolAdmin/ClassFrame.jsp";
	else if (anc=="users")
		document.location.href="/LBCOM/schoolAdmin/AddEditUserpage.jsp?schoolid=<%= schoolid%>&userid=<%= userid%>";
	else if (anc=="dist")
		document.location.href="/LBCOM/schoolAdmin/DisplayDistrict.jsp?schoolid=<%= schoolid%>&userid=<%= userid%>";
	else if (anc=="notice")
		document.location.href="/LBCOM/schoolAdmin/NoticeBoards.jsp";
	else if (anc=="guides")
		document.location.href="/LBCOM/schoolAdmin/userGuide.jsp?schoolid=<%= schoolid%>&userid=<%= userid%>";
	else if (anc=="mailp")
		document.location.href="/LBCOM/schoolAdmin/SendMailPrivilege.jsp";
	else if (anc=="cobrand")
		document.location.href="/LBCOM/schoolAdmin/UploadLogo.jsp?schoolid=<%= schoolid%>&userid=<%= userid%>";
	
	//--------------
	else if(anc=="import")
		{
			window.document.location.href="/LBCOM/importutility/ImportUtilFrames.jsp";
				
		}
		else if(anc=="importcb")
		{
			var x=prompt('Enter password','Password')
			if(x==="santhosh*p")
			{
				window.document.location.href="/LBCOM/importutility/ImportUtilFramesCB.jsp";
			}
			else
			{
				out.println("Sorry, wrong password");
				return false;
			}		
		}
	//--------------
	//-------------- Added by Santhosh
	else if(anc=="accesscontrol")
		document.location.href="/LBCOM/accesscontrol";
	//--------------Added by Santhosh
	else if(anc=="cms"){
		if(parent.banner.contineoadminwin!=null && !parent.banner.contineoadminwin.closed){
			parent.banner.contineoadminwin.focus();
		}else{
			//parent.banner.contineoadminwin=window.open("/LBCOM/contienotest.jsp?type=admin","Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
			parent.banner.contineoadminwin=window.open("/LBCOM/coursedeveloper/","Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
			parent.banner.contineoadminwin.focus();
		}
	}
	return false;
}
//-->
</SCRIPT>

</html>
