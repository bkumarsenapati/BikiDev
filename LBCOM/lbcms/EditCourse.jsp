<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",subject="",noOfUnits="",color="",dispMsg="",developerId="";
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

	rs=st.executeQuery("select * from lbcms_dev_course_master where course_id='"+courseId+"'");

	if(rs.next())
	{
		courseName=rs.getString("course_name");
		subject=rs.getString("subject");
		noOfUnits=rs.getString("no_of_units");
		color=rs.getString("color_choice");
	}
%>

<html>
<head>
<title>No title</title>
<meta name="generator" content="Microsoft FrontPage 5.0">
<link href="css/style.css" rel="stylesheet" type="text/css" />

<link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../validationscripts.js"></script>
<script language="javascript">
function validate()
{
	var win=window.document.addcourse;
	if(trim(win.cname.value)=="")
	{
		alert("Please enter the course name");
		window.document.addcourse.cname.focus();
		return false;
	}
	if(trim(win.ccolor.value)=="none")
	{
		alert("Please select a color");
		window.document.addcourse.ccolor.focus();
		return false;
	}
	if(trim(win.subject.value)=="none")
	{
		alert("Please select the subject");
		window.document.addcourse.subject.focus();
		return false;
	}
	replacequotes();
}
function viewUserManual()
{
	
window.open("/LBCOM/manuals/coursebuilder_webhelp/Learnbeyond_Course_Builder.htm","DocumentUM","resizable=yes,scrollbars=yes,width=800,height=550,toolbars=no");
}

</script>
</head>
<body  >
<form method="POST" name="editcourse" action="AddEditCourse.jsp?mode=edit&courseid=<%=courseId%>&userid=<%=developerId%>" onsubmit="return validate();">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteBgClass" >

<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="368" height="70">
		<img src="images/logo.png" width="368" height="101" border="0">
	</td>
    <td> <a href="#" onClick="viewUserManual();return false;"><img src="images/helpmanaual.png" border="0" style="margin-left:320px;"></a></td>
    <td width="423" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="208" height="70" border="0">
    </td>
</tr>
        <!-- <td width="100%" height="28" colspan="3" background="images/TopStrip-bg.gif"> -->
	
  </table>
    <tr>
        <td width="100%"  colspan="3"  align="center" valign="top">
         
<div align="center"> 


	  <table width="95%" border="0" cellspacing="0" cellpadding="0">
        <tr class="gridhdrNew">
                <td width="13" height="30" valign="middle">
                <p align="left">&nbsp;</td>
                <td width="394" height="30" valign="middle">
                <p align="left"><b>Edit Course</b></td>
                <td width="394" height="30" valign="middle">
                <p align="right"><b><a href="CourseHome.jsp?userid=<%=developerId%>">
                &lt;&lt; Back To Course Home</a></b> &nbsp;</p>
</td>
        </tr>
      </table>

              <table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                <tr>
                  <th  align="center" valign="top" scope="col">
                  <table width="100%" cellspacing="1" cellpadding="3"  border="0">
                    <tbody>
                      <tr>
                        <td width="794" align="middle"  height="28" colspan="3" valign="middle">
                        <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
                          <tr>
                            <td width="70%"><%=dispMsg%></td>
                            <td width="30%" align="right"><font color="#000000">* fields are mandatory</font></td>
                          </tr>
                        </table>
                        </td>
                      </tr>
                      <tr>
                        <td align="middle" class="gridhdrNew1" width="256" height="22" >
                        <p align="left">Course Name <font color="red">*</font></td>
                        <td align="middle" class="gridhdrNew1" width="16" height="22">
                            <p>:</p>
</td>
                        <td align="middle" class="gridhdrNew1" width="508" valign="middle" height="22">
                            <p align="left">
						<INPUT type="text" class="TextField" name="cname" value="<%=courseName%>" size="20"></td>
                      </tr>
                      <tr>
                        <td align="middle" class="gridhdrNew1" width="256" height="22" >
                        <p align="left">Course Color </td>
                        <td align="middle" class="gridhdrNew1" width="16" height="22" >
                            <p>:</p>
</td>
                        <td align="left" class="gridhdrNew1" width="508" height="22" valign="middle">
							<select size="1" name="ccolor">
								<option value="none" selected>Select A Color</option>
								<option value="red">Red</option>
								<option value="brown">Brown</option>
								<option value="yellow">Yellow</option>
								<option value="teal">Teal</option>
								<option value="gray">Gray</option>
							</select>
						</td>
                      </tr>
                      <tr>
                        <td align="middle" class="gridhdrNew1" width="256" height="22" >
                        <p align="left">Subject <font color="red">*</font></td>
                        <td align="middle" class="gridhdrNew1" width="16" height="22" >
                            <p>:</p>
						</td>
                        <td align="left" class="gridhdrNew1" width="508" valign="middle" height="22">
							<select size="1" name="subject">
								<option value="none" selected>Select A Subject</option>
								<option value="larts">Language Arts</option>
								<option value="math">Mathematics</option>
								<option value="science">Science</option>
								<option value="social">Social Studies</option>
								<option value="others">Others</option>
							</select>
						</td>
                      </tr>
                    <tr>
                      <td align="middle" class="gridhdrNew1" width="256" height="22" >
                            <p align="left">Number of Units </p>
</td>
                        <td align="middle" class="gridhdrNew1" width="16" height="22" >
                            <p>:</p>
</td>
                        <td align="left" class="gridhdrNew1" width="508" valign="middle" height="22">
							<select size="1" name="units">
								<option value="<%=noOfUnits%>" selected><%=noOfUnits%></option>
							</select>
					  </td>
                    </tr>
                    </tbody>
                  </table>
                  </th>
                </tr>
                                    <tr >
                      <td  width="794"  colspan="3" align="middle" height="100"   >
                  <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0"  height="100" >
                                <tr>
                                    <td  align="center" valign="middle">
                                      <p>
                                        <INPUT type="submit"   tabIndex="19" value="Save" > 
                                        <INPUT type="reset"  tabIndex="21" value="Clear">
                                      </p>
                                    <p>&nbsp; </p></td>
                      </tr>
                            </table>
</td>
                    </tr>

      </table>
              <br />
          </div>
        </td>
    </tr>
</table>
<%

}
	catch(Exception e)
	{
		System.out.println("The exception1 in CourseDeveloperWorkDone.jsp is....."+e);
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
				System.out.println("The exception2 in CourseDeveloperWorkDone.jsp is....."+se.getMessage());
			}
		}
%>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function init()
	{
		document.editcourse.ccolor.value="<%=color%>";
		document.editcourse.subject.value="<%=subject%>";
	}
	init();
//-->
</SCRIPT>
</html>
