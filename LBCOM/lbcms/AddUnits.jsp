<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;   
	Statement st=null,st1=null,st2=null,st3=null,st6=null; 
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs6=null;
	String developerId="",courseId="",courseName="",courseDevPath="";
	boolean courseFlag=false;
	int totUnits=0;
	String unitId="",unitName="",lessonId="",lessonName="",newCourseId="";
try{
	courseDevPath=application.getInitParameter("lbcms_dev_path");
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	developerId=request.getParameter("developer");
	
	courseId=request.getParameter("courseid");
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	rs2=st2.executeQuery("select * from lbcms_dev_course_master where developer='"+developerId+"' and course_id='"+courseId+"'");
	if(rs2.next())
	{
		
		courseName=rs2.getString("course_name");
		totUnits=rs2.getInt("no_of_units");
	}
	rs2.close();
	st2.close();
	
	
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
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<form method="POST" name="addcourse" action="CreateNewUnits.jsp?mode=add&userid=<%=developerId%>&courseid=<%=courseId%>&totunits=<%=totUnits%>" onsubmit="return validate();">
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
  </table>
  
    <tr>
        <td width="100%" height="495" colspan="3" bgcolor="#FFFFFF" align="center" valign="top">
           
<div align="center"> 


			  <table width="85%" border="0" cellspacing="0" cellpadding="0">
<tr class="gridhdrNew">
                <td width="13" height="30" valign="middle">
                <p align="left">&nbsp;</td>
                <td width="394" height="30" valign="middle">
                <p align="left">Course Name:&nbsp;<b> <%=courseName%></b></td>
                <td width="394" height="30" valign="middle">
                <p align="right"><b><a href="CourseHome.jsp?userid=<%=developerId%>">
            &lt;&lt; Back To Course Home</a></b> &nbsp;</p>
</td>
        </tr>
            </table>

              <table width="85%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                <tr>
                  <th height="86" align="center" valign="top" scope="col">
                 
					  <hr>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0">
 <tr>
	<td width="2%" class="gridhdrNew1">&nbsp;</td>
    <td width="98%" class="gridhdrNew1" colspan="2"><b><font face="Verdana" size="2" color="#934900">Available Courses</font></b></td>
  </tr>
					
<%						int j=0;
						rs=st.executeQuery("select * from lbcms_dev_course_master where developer='"+developerId+"' and status=1 order by course_id");
						while(rs.next())
						{
							
							courseName=rs.getString("course_name");
							newCourseId=rs.getString("course_id");
							
							%>
									<tr>
									<td width="20%" style="margin-left:70px;"><b><%=courseName%></b></td>
									</tr>
									<%
							
								st6=con.createStatement();
								rs6=st6.executeQuery("select * from lbcms_dev_units_master where course_id='"+newCourseId+"' order by unit_id");
								while(rs6.next())
								{
								unitId=rs6.getString("unit_id");
								unitName=rs6.getString("unit_name");
								j=0;
									%>
									<tr>
										<td width="2%" class="gridhdrNew1">&nbsp;</td>
										 <td width="2%" class="gridhdrNew1"><input type="checkbox" name="uids" value="<%=unitId%>"></td>
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
                        <td align="middle" class="gridhdrNew1" width="794" colspan="3" height="35">
                            <table align="center"  border="0" cellpadding="0" cellspacing="0" width="100%" height="28">
                                <tr>
                                    <td width="794" class="gridhdrNew1" align="center" valign="middle">
                                        <INPUT type="submit" class="button-small" tabIndex="19" value="Add"> 
										<INPUT type="reset" class="button-small" tabIndex="21" value="Clear">
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
			if(st2!=null)
				st2.close();
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