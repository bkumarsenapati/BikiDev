<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseName="",dispMsg="",developerId="";

	developerId=request.getParameter("developer");

	dispMsg=request.getParameter("dispmsg");
	if(dispMsg==null)
		dispMsg="";

	if(dispMsg.equals("alreadyexists"))
	{
		dispMsg="<FONT COLOR='white' face='verdana' size='1'>A course with this name already exists! Please choose another one.</FONT>";
		courseName=request.getParameter("coursename");
	}
%>

<html>
<head>
<title>No title</title>
<meta name="generator" content="Microsoft FrontPage 5.0">

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
	/*
	if(trim(win.ccolor.value)=="none")
	{
		alert("Please select a color");
		window.document.addcourse.ccolor.focus();
		return false;
	}
	*/
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
<body >
<form method="POST" name="addcourse" action="AddEditCourse.jsp?mode=add&userid=<%=developerId%>" onsubmit="return validate();">
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
        <td width="95%" height="495" colspan="3"  align="center" valign="top">
           
<div align="center" style="width:95%; margin-left:50px;" > 


			  <table width="100%" border="0" cellspacing="0" cellpadding="0"  >
<tr class="gridhdrNew">
                <td width="19" height="30" valign="middle" class="gridhdrNew">
            <p align="left">&nbsp;</td>
          <td width="313" height="30" valign="middle">
            <p align="left"><b>Create Course</b></td>
          <td width="351" height="30" valign="middle">
              <p align="right"><b><a href="CourseHome.jsp?userid=<%=developerId%>">
                <font >&lt;&lt; Back To Course Home</font></a></b> &nbsp;</p>
</td>
        </tr>
            </table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="boarder"  bgcolor="#FFFFFF" >
                <tr style="margin-left:200px;">
                  <th height="86"  valign="top" scope="col">
                  <table width="92%" cellspacing="1" cellpadding="3"  border="0">
                    <tbody>
                      <tr>
                        <td  class="Grid_tHeader" height="28" colspan="3" valign="middle">
                        <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="87%" id="AutoNumber1">
                          <tr>
                            <td width="51%"><%=dispMsg%></td>
                            <td width="49%" align="right"><font ><font color="red">* </font>fields are mandatory</font></td>
                          </tr>
                        </table>                        </td>
                      </tr>
                      <tr >
                        <td align="middle"  width="257" height="22" class="gridhdrNew1">
                        <p align="left"><font >Course Name </font><font color="red">*</font></td>
                      <td align="middle"  width="13" height="22" class="gridhdrNew1">
                        <p>:</p></td>
                  <td align="middle" class="gridhdrNew1" width="444" valign="middle" height="22">
      <p align="left">
						<INPUT type="text"  name="cname" value="<%=courseName%>" size="20" width="400" style="width:400px; height:20px;"></td>
                      </tr>
                      <tr>
                        <td align="middle"  width="257" height="22" class="gridhdrNew1">
                        <p align="left"><font >Course Color</font> </td>
                      <td align="middle" width="13" height="22" class="gridhdrNew1">
                        <p>:</p></td>
                        <td class="gridhdrNew1"align="left"  width="444" height="22" valign="middle"><select size="1" name="ccolor" style="width:400px;">
                          <option value="none" selected>Select Color</option>
                          <option value="red">Red</option>
                          <option value="brown">Brown</option>
                          <option value="yellow">Yellow</option>
                          <option value="teal">Teal</option>
                          <option value="gray">Gray</option>
                        </select></td>
                      </tr>
                      <tr>
                        <td align="middle"  width="257" height="22" class="gridhdrNew1">
                        <p align="left"> <font >Subject</font> <font color="red">*</font></td>
                      <td align="middle"  width="13" height="22" class="gridhdrNew1">
                        <p>:</p>						</td>
                  <td align="left" width="444" valign="middle" height="22" class="gridhdrNew1">
<select size="1" name="subject" style="width:400px;">
								<option value="none" selected>Select A Subject</option>
								<option value="larts">Language Arts</option>
								<option value="math">Mathematics</option>
								<option value="science">Science</option>
								<option value="social">Social Studies</option>
								<option value="others">Others</option>
					</select>						</td>
                      </tr>
                    <tr>
                        <td align="middle"  width="257" height="22" class="gridhdrNew1">
                      <p align="left"><font >Number of Units</font> </p></td>
                  <td align="middle" width="13" height="22" class="gridhdrNew1">
                    <p>:</p></td>
            <td align="left" width="444" valign="middle" height="22" class="gridhdrNew1">
<select size="1" name="units" style="width:400px;">
								<option value="0" selected>Add Later</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
					</select>						</td>
                    </tr>
                    <tr>
                        <td align="middle" colspan="3" height="35" class="gridhdrNew1">
                      <table align="center" class="gridhdrNew1" cellpadding="0" cellspacing="0" width="100%" height="28">
                                <tr>
                                    <td width="794" align="center" valign="middle">
                                        <INPUT type="submit" class="button" tabIndex="19" value="Save"> 
										<INPUT type="reset" class="button" tabIndex="21" value="Clear">                                    </td>
                                </tr>
                          </table></td>
                    </tr>
                    </tbody>
                  </table>
                  </th>
                </tr>
              </table>
              <br />
            </div>
        </td>
    </tr>
</table>
</body>

</html>