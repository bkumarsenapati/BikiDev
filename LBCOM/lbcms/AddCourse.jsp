<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;   
	Statement st=null,st1=null,st3=null,st6=null; 
	ResultSet rs=null,rs1=null,rs3=null,rs6=null;
	String developerId="",courseId="",courseName="",courseDevPath="";
	boolean courseFlag=false;
	int totUnits=0;
	String unitId="",unitName="",lessonId="",lessonName="";
try{
	courseDevPath=application.getInitParameter("lbcms_dev_path");
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	developerId=request.getParameter("developer");
	System.out.println("developerId..."+developerId);
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();

	
%>

<html>
<head>
<title>Hotschools Course Builder</title>
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
<form method="POST" name="addcourse" action="CreateNewCourse.jsp?mode=add&userid=<%=developerId%>" onsubmit="return validate();">
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
        <td width="100%" height="495" colspan="3" bgcolor="#FFFFFF" align="center" valign="top">
          
<div align="center"> 


			  <table width="95%" border="0" cellspacing="0" cellpadding="0">
        <tr class="gridhdrNew">
                <td width="13" height="30" valign="middle">
                <p align="left">&nbsp;</td>
                <td width="394" height="30" valign="middle">
                <p align="left"><b>Create Course</b></td>
                <td width="394" height="30" valign="middle">
                <p align="right"><b><a href="CourseHome.jsp?userid=<%=developerId%>">
                &lt;&lt; Back To Course Home</a></b> &nbsp;</p>
</td>
        </tr>
            </table>

              <table width="95%" border="0" cellpadding="0" cellspacing="0"  bgcolor="#FFFFFF">
                <tr>
                  <th height="86" align="center" valign="top" scope="col">
                  <table width="100%" cellspacing="1" cellpadding="3"  border="0">
                    <tbody>
                      <tr>
                        <td width="794" align="middle" class="gridhdrNew1" height="28" colspan="3" valign="middle">
                        <table  cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
                          <tr>
                            <td width="70%" class="gridhdrNew1">&nbsp;</td>
                            <td width="30%" align="right" class="gridhdrNew1"><font color="red">*</font> <font color="#000000">fields are mandatory</font></td>
                          </tr>
                        </table>
                        </td>
                      </tr>
                      <tr>
                        <td align="middle" class="gridhdrNew1" width="256" height="22" >
                            <p align="left"><font >Course Name</font> <font color="red">*</font></td>
                        <td align="middle" class="gridhdrNew1" width="16" height="22" style="margin-left:20px;">
                            <p>:</p>
</td>
                        <td align="middle"  class="gridhdrNew1" width="508" valign="middle" height="22">
                            <p align="left">
							<INPUT type="text" class="TextField" name="cname" value="<%=courseName%>" size="20" style="width:600px;"></td>
                      </tr>
                      <tr>
                        <td align="middle" width="256" height="22" class="gridhdrNew1" style=" margin-left:20px;" >
                            <p align="left"><font >Course Color</font> </td>
                        <td align="middle" class="gridhdrNew1" width="16" height="22" >
                            <p>:</p>
</td>
                        <td align="left" width="508" height="22" valign="middle" class="gridhdrNew1">
							<select size="1" name="ccolor" style="width:600px;">
								<option value="none" selected>Select Color</option>
								<option value="red">Red</option>
								<option value="brown">Brown</option>
								<option value="yellow">Yellow</option>
								<option value="teal">Teal</option>
								<option value="gray">Gray</option>
							</select>
						</td>
                      </tr>
                      <tr>
                        <td align="middle" width="256" height="22" class="gridhdrNew1" style=" margin-left:20px;">
                            <p align="left"><font >Subject</font><font color="red">*</font></td>
                        <td align="middle" class="gridhdrNew1" width="16" height="22">
                            <p>:</p>
						</td>
                        <td align="left" class="gridhdrNew1" width="508" valign="middle" height="22">
							<select size="1" name="subject" style="width:600px;">
								<option value="none" selected>Select A Subject</option>
								<option value="larts">Language Arts</option>
								<option value="math">Mathematics</option>
								<option value="science">Science</option>
								<option value="social">Social Studies</option>
								<option value="others">Others</option>
							</select>
						</td>
                      </tr>
					  </table>
					  <hr>
	<table  cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
 <tr>
	<td width="2%" class="gridhdrNew1">&nbsp;</td>
    <td width="98%" colspan="2" class="gridhdrNew1"><b><font face="Verdana" size="2" >Available Courses</font></b></td>
  </tr>
					
<%						int j=0;
						rs=st.executeQuery("select * from lbcms_dev_course_master where developer='"+developerId+"' and status=1 order by course_id");
						while(rs.next())
						{
							
							courseName=rs.getString("course_name");
							courseId=rs.getString("course_id");
							%>
									<tr>
									<td width="20%"><%=courseName%></td>
									</tr>
									<%
							
								st6=con.createStatement();
								rs6=st6.executeQuery("select * from lbcms_dev_units_master where course_id='"+courseId+"' order by unit_id");
								while(rs6.next())
								{
								unitId=rs6.getString("unit_id");
								unitName=rs6.getString("unit_name");
								j=0;
									%>
									<tr>
										<td width="2%" class="gridhdrNew1">&nbsp;</td>
										 <td width="2%" class="gridhdrNew1"><input type="checkbox" name="uids" value="<%=unitId%>"></td>
										<!-- <td width="96%"><font face="Verdana" size="2"><%=lessonName%></font></td> -->
										<td width="96%" class="gridhdrNew1"><font face="Verdana" size="2"><%=unitName%></font></td>
									</tr>
									<%
								
								}
								rs6.close();
								st6.close();
						}

			

%>
					</tr>
					
					<tr>
                        <td align="middle" class="Grid_tHeader" width="794" colspan="3" height="35">
                            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" height="28">
                                <tr>
                                    <td width="794" align="center" valign="middle">
                                        <INPUT type="submit" class="button" tabIndex="19" value="Save"> 
										<INPUT type="reset" class="button" tabIndex="21" value="Clear">
                                    </td>
                                </tr>
                            </table>
</td>
                    </tr>
                    </tbody>
                  </table>
                  </th>
                
              </table>
              <br />
            </div>
        </td>
    </tr>
</table>
<%
}
catch(SQLException se)
	{
		System.out.println("The exception1 in AddCourse.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in AddCourse.jsp is....."+e);
	}
	finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st3!=null)
				st3.close();
			if(st6!=null)
				st6.close();
			if(rs!=null)
				rs.close();
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("AddCourse.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
</body>

</html>