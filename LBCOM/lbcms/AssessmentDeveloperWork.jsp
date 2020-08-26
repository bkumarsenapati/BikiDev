<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",assgnContent="",developerId="";
	String tableName="";
	int assmt=0;
	boolean no=false;

		try
		{
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		con=con1.getConnection();
		st=con.createStatement();

		if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
		{
			tableName="lbcms_dev_assgn_social_larts_content_master";
		
		}
		else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
		{
			tableName="lbcms_dev_assgn_science_content_master";
		
		}
		else
		{
			tableName="lbcms_dev_assgn_math_content_master";
		
		}

		rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		while(rs.next())
		{
			assmt=Integer.parseInt(rs.getString("assgn_no"));
			assmt=assmt+1;
			
			no=true;
		}
		if(no==false)
		{
			 assmt=1;
		
		}


	
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>CREATE ASSIGNMENT</title>
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" /> 
<script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script> 
<script language="javascript">

function show_key(the_form)
{
	var the_key="0123456789";
	var the_value=the_form.value;
	var the_char;
	var len=the_value.length;
	for(var i=0;i<len;i++)
	{
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1) 
		{
			alert("Please enter numbers only");
			the_form.focus();
			return false;
		}
	}
}



function cleardata()
{
	document.create.reset();
	addOptions();
	return false;
}
</script>

</head>
<body>
<form name="create" method="post" enctype="multipart/form-data" action="">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" id="AutoNumber2" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
    <tr>
      <td width="100%"  colspan="2">
      <img border="0" src="images/logo.png" width="368" height="101"></td>
    </tr>
    <tr>
      <td width="100%" colspan="2"><hr  size="1"></td>
    </tr>
    
	<tr>
      <td width="50%"><font face="Verdana" size="2" class="gridhdrNew"><b>Course :
      </b></font><font face="Verdana" size="2" ><%=courseName%></font></td>
      <td width="50%" class="gridhdrNew">
      <p align="right"><font face="Verdana" size="2" ><b>&nbsp;Lesson 
      : </b></font><font face="Verdana" size="2"><%=lessonName%></font></td>
    </tr>
  </table>
  </center>
</div>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="80%" id="AutoNumber1" height="175">
    <tr>
      <td width="73%" class="gridhdrNew1" height="25" colspan="2">
      <hr color="#C0C0C0" size="1"></td>
    </tr>
    <tr>
      <td width="28%" class="gridhdrNew1" height="1"><b>
      <font face="Verdana" size="2" >&nbsp;CREATE ASSESSMENT</font><font face="Verdana" size="2" >
      </font></b></td>
      <td width="45%" class="gridhdrNew1" height="1">
      <p align="right"><b><font face="Verdana" size="1" >
      <a href="javascript:self.close();"><font >CLOSE</font></a>&nbsp; </font></b></td>
    </tr>
    <tr>
      <td width="12%" height="1" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Assessment Name</font></td>
      <td width="61%" height="1" class="gridhdrNew1">
    
        <input type="text" name="assgnname" id="assgnname" size="54"></td>
    </tr>
    <tr>
      <td width="12%" height="1" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="61%" height="1" class="gridhdrNew1"><select id="asgncategory" name="asgncategory">
			<option value="all" selected>Select Category</option>
			<option value="AS">Assessment</option>
			<option value="EX">Exam</option>
			<option value="QZ">Quiz</option>
			<option value="SV">Survey</option>
      </select></td>
    </tr>
   <tr>
      <td width="73%" colspan="2" height="1" class="gridhdrNew1" align="center">
      <p align="left"><font face="Verdana" size="2">&nbsp;Enter the assessment 
      instructions in the below area: </font><p align="center"><font face="Verdana" size="2">
      <textarea rows="7" name="instructions" id="instructions" cols="50"></textarea></font><p align="left">&nbsp;</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="27" class="gridhdrNew1">
      <p align="center">
		</td>
    </tr>
  </table>
  </center>
</div>
&nbsp;</p>
      </form>
	 <center> <input type="button" value="Submit" name="B1" onClick="return validate();">&nbsp;&nbsp; <input type="reset" value="Reset" name="B2" onClick="return cleardata()"> </center>
	  <%
			}
	catch(Exception e)
	{
		System.out.println("The exception1 in AddNewCourse.jsp is....."+e);
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
				System.out.println("The exception2 in AddNewCourse.jsp is....."+se.getMessage());
			}
	}
%>
      <p>&nbsp;
	  <script>
function validate()
{
	var win=window.document.create;
	
	if(win.assgnname.value == "")
	{
		alert("Please enter the document name");
		window.document.create.assgnname.focus();
		return false;
	}
	var cat=window.document.create.asgncategory.value

	if(cat=="all")
	{
		alert("Please select category");
		window.document.create.asgncategory.focus();
		return false;
	}
	else
	{
		var asname=document.getElementById("assgnname").value;
		var cattype=document.getElementById("asgncategory").value;
		var instruct=document.getElementById("instructions").value;
		document.location.href="/LBCOM/lbcms/CDAssmtWorkDone.jsp?mode=add&coursename=<%=courseName%>&userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&assmt=<%=assmt%>&asname="+asname+"&cattype="+cattype+"&instruct="+instruct;
	}
	//replacequotes();
}
	  </script>
</body>

</html>