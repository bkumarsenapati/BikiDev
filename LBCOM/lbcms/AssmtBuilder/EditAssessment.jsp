<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",assgnContent="",developerId="";
	String tableName="",assmtId="",catType="",categoryName="",assmtName="",instructions="";
	int assmt=0;
	boolean no=false;

		try
		{
		courseId=request.getParameter("courseid");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		unitName=unitName.replaceAll("'","\'");
		lessonId=request.getParameter("lessonid");
		assmtId=request.getParameter("assmtid");
		catType=request.getParameter("cattype");

		
		if(catType.equals("EX"))
			categoryName="Exam";
		if(catType.equals("AS"))
			categoryName="Assessment";
		if(catType.equals("QZ"))
			categoryName="Quiz";
		if(catType.equals("SV"))
			categoryName="Survey";

		con=con1.getConnection();
		st=con.createStatement();

		tableName="lbcms_dev_assessment_master";
		
		rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and assmt_id='"+assmtId+"'");
		if(rs.next())
		{
			assmtName=rs.getString("assmt_name");
			assmt=Integer.parseInt(rs.getString("slno"));
			lessonName=rs.getString("lesson_name");
			courseName=rs.getString("course_name");
			instructions=rs.getString("assmt_instructions");
	
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Edit Assessments</title>
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

<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" id="AutoNumber2" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
          
	<tr>
      <td width="50%"><font face="Verdana" size="2" color="#000080"><b>Course :
      </b></font><font face="Verdana" size="2" color="#800000"><%=courseName%></font></td>
      <td width="50%">
      <p align="right"><font face="Verdana" size="2" color="#000080"><b>&nbsp;Lesson 
      : </b></font><font face="Verdana" size="2" color="#800000"><%=lessonName%></font></td>
    </tr>
  </table>
  

  <table border="0" cellspacing="1" width="80%" id="AutoNumber1" height="75%">
    <tr>
      <td width="73%" bgcolor="#FFFFFF" height="25" colspan="2">
      <hr color="#C0C0C0" size="1"></td>
    </tr>
    <tr>
      <td width="28%" bgcolor="#7C7C7C" height="1"><b>
      <font face="Verdana" size="2" color="#FFFFFF">&nbsp;Edit ASSESSMENT</font><font face="Verdana" size="2" color="#000080">
      </font></b></td>
      <td width="45%" bgcolor="#7C7C7C" height="1">
      <p align="right"><b><font face="Verdana" size="1" color="#FFFFFF">
      <a href="javascript:self.close();"><font color="#FFFFFF">CLOSE</font></a>&nbsp; </font></b></td>
    </tr>
    <tr>
      <td width="12%" height="1" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Assessment Name</font></td>
      <td width="61%" height="1" bgcolor="#EBEBEB">
    
        <input type="text" name="assgnname" id="assgnname" value="<%=assmtName%>" size="54"></td>
    </tr>
    <tr>
      <td width="12%" height="1" bgcolor="#C0C0C0">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="61%" height="1" bgcolor="#EBEBEB"><select id="asgncategory" name="asgncategory">
			<option value="<%=catType%>" selected><%=categoryName%></option>
			
      </select></td>
    </tr>
   <tr>
      <td width="33%" colspan="2" height="1%" bgcolor="#C0C0C0" align="left">
     <font face="Verdana" size="2">&nbsp;Enter the assessment 
      instructions in the below area: </font><p align="center"><font face="Verdana" size="2">
      <textarea rows="7" name="instructions" id="instructions" cols="40"><%=instructions%></textarea></font></td>
    </tr>
    
  </table>
	<input type="hidden" name="coursename" value="<%=courseName%>">
	<input type="hidden" name="unitid" value="<%=unitId%>">
	<input type="hidden" name="lessonid" value="<%=lessonId%>">
	<input type="hidden" name="lessonname" value="<%=lessonName%>">
	
  </center>
</div>
  

	 <center> <input type="button" value="Submit" name="B1" onclick="return validate();">&nbsp;&nbsp; <input type="reset" value="Reset" name="B2" onClick="return cleardata()"> </center>
	  <%
			}
		}
	catch(Exception e)
	{
		System.out.println("The exception1 in EditAssessment.jsp is....."+e);
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
				System.out.println("The exception2 in EditAssessment.jsp is....."+se.getMessage());
			}
	}
%>
      <p>&nbsp;
	 
</form>
</body>
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
		
		var assmtname=document.getElementById("assgnname").value;
		assmtname=assmtname.replace(/&/g,"@");
		var cattype=document.getElementById("asgncategory").value;
		var instruct=document.getElementById("instructions").value;
		instruct=instruct.replace("'","\'");
	
		document.location.href="AssessmentUpdate.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&assmt=<%=assmt%>&cattype="+cattype+"&instruct="+instruct+"&assgnname="+assmtname;
	}
	//replacequotes();
}
	  </script>

</html>