<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",assgnContent="",developerId="";
	String tableName="",assgn_Attachments="";
	boolean no=false;
	int totMarks=0,assgNo=0,max_Attempts=0;

		try
		{
		con=con1.getConnection();
		st=con.createStatement();

		String cat="",assgName="",assgContent="";
		
		courseId=request.getParameter("course_id");
		
		unitId=request.getParameter("unit_id");
		lessonId=request.getParameter("lesson_id");
		assgNo=Integer.parseInt(request.getParameter("assgn_no"));
		
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>EDIT ASSIGNMENT</title>
<!-- TinyMCE -->
<script type="text/javascript" src="../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
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
<!-- <script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script>  -->
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

function addOptions(){
	var frm=document.create;
	var date=new Date();
	var month=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");

	frm.maxattempts.length=10;
	frm.maxattempts[0]=new Option('No Limit','-1');
	for(i=1;i<=10;i++)
		frm.maxattempts[i]=new Option("      "+i,i);
	return false;
}
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
	if(win.points.value == "")
	{
		alert("Please enter maximum points");
		window.document.create.points.focus();
		return false;
	}
	else 
	{
		if(win.points.value<1)
		{
			alert("Maximum points should be greater than zero");
			window.document.create.points.focus();
			return false;
		}
	}	
	
	//replacequotes();
}

function cleardata()
{
	document.create.reset();
	addOptions();
	return false;
}
</script>
<link href="styles/teachcss.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
<form name="create" method="post" enctype="multipart/form-data" action="/LBCOM/lbcms/CourseDeveloperWorkDone.jsp?mode=edit&assgnno=<%=assgNo%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&coursename=<%=courseName%>&lessonname=<%=lessonName%>" onSubmit="return validate();">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" id="AutoNumber2" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
    <tr>
      <td width="100%" colspan="2">
      <img border="0" src="images/logo.png" width="284" height="90"></td>
    </tr>
    <tr>
      <td width="100%" colspan="2"><hr  size="1"></td>
    </tr>
<%
		
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
		rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and assgn_no="+assgNo+"");
		if(rs.next())
		{
			courseName=rs.getString("course_name");
			lessonName=rs.getString("lesson_name");
			assgName=rs.getString("assgn_name");
			totMarks=Integer.parseInt(rs.getString("marks_total"));
			max_Attempts=Integer.parseInt(rs.getString("maxattempts"));
			assgn_Attachments=rs.getString("assgn_attachments");
			cat=rs.getString("category_id");
			if(cat==null || cat.equals(""))
				cat="all";
			assgContent=rs.getString("assgn_content");
			assgContent=assgContent.replaceAll("&Acirc;","");
			assgContent=assgContent.replaceAll("Â","");
			
		}
	
%>
	<input type="hidden" name="attachments" value="<%=assgn_Attachments%>">
	<tr class="gridhdrNew">
      <td width="50%" class="gridhdrNew"><font face="Verdana" size="2" color="#000080"><b>Course :
      </b></font><font face="Verdana" size="2" ><%=courseName%></font></td>
      <td width="50%" class="gridhdrNew">
      <p align="right"><font face="Verdana" size="2" ><b>&nbsp;Lesson 
      : </b></font><font face="Verdana" size="2" ><%=lessonName%></font></td>
    </tr>
  </table>
  </center>
</div>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="80%" id="AutoNumber1" height="524">
    <tr>
      <td width="73%" height="25" colspan="2">
      <hr  size="1"></td>
    </tr>
	<tr>
      <td width="28%" class="gridhdrNew1" height="25"><b>
      <font face="Verdana" size="2" >&nbsp;EDIT ASSIGNMENT</font><font face="Verdana" size="2" >
      </font></b></td>
      <td width="45%" class="gridhdrNew1" height="25">
      <p align="right"><b><font face="Verdana" size="1">
      <a href="javascript:self.close();"><font >CLOSE</font></a>&nbsp; </font></b></td>
    </tr>
    <tr>
      <td width="12%" height="22" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Assignment Name</font></td>
      <td width="61%" height="22" class="gridhdrNew1">
    
        <input type="text" name="assgnname" size="54" value="<%=assgName%>"></td>
    </tr>
    <tr>
      <td width="12%" height="22" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Category</font></td>
      <td width="61%" height="22" class="gridhdrNew1"><select id="asgncategory" name="asgncategory">
<%
			if(cat.equals("WR"))
			{
%>
				<option value="all">Select Category</option>
				<option value="WA" selected>Writing assignment</option>
				<option value="RA">Reading assignment</option>
				<option value="HW">Home work</option>
				<option value="PW">Project work</option>
<%
			}
			else if(cat.equals("RA"))
			{
%>			
				 <option value="all">Select Category</option>
				<option value="WR">Writing assignment</option>
				<option value="RA" selected>Reading assignment</option>
				<option value="HW">Home work</option>
				<option value="PW">Project work</option>
<%
			}
			else if(cat.equals("HW"))
			{
%>			
				 <option value="all">Select Category</option>
				<option value="WR">Writing assignment</option>
				<option value="RA">Reading assignment</option>
				<option value="HW" selected>Home work</option>
				<option value="PW">Project work</option>
<%
			}
			else
			{
%>			
				 <option value="all">Select Category</option>
				<option value="WR">Writing assignment</option>
				<option value="RA">Reading assignment</option>
				<option value="HW">Home work</option>
				<option value="PW" selected>Project work</option>
<%
			}
%>
			
      </select></td>
    </tr>
    <tr>
      <td width="12%" height="22" class="gridhdrNew1">
      <font face="Verdana" size="2">&nbsp;Maximum Points</font></td>
      <td width="61%" height="22" class="gridhdrNew1">
    
        <input type="text" name="points" size="8" value="<%=totMarks%>"></td>
    </tr>
    <tr>
	<td width="12%" height="22" class="gridhdrNew1"><font face="Verdana" size="2">Maximum Attempts&nbsp;</font></td>
	<td width="61%" height="22" class="gridhdrNew1">
		<select size='1' name='maxattempts'></select>
	</td>
</tr>
    <tr>
      <td width="73%" colspan="2" height="388" class="gridhdrNew1" align="center">
      <textarea name="assgncontentgen" id="assgncontentgen" rows="24" cols="87"><%=assgContent%></textarea>
		<script language="JavaScript">generate_wysiwyg('assgncontentgen');</script>
	</td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="27" class="gridhdrNew1" align="right">&nbsp;<font face="arial" size="2">Attachment:<input type="file" name="assgnattachfile" size="20"></font></td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="27" class="gridhdrNew1">
      <p align="center">
		<input type="submit" value="Submit" name="B1">&nbsp;&nbsp; <input type="reset" value="Reset" name="B2" onClick="return cleardata()"></td>
    </tr>
	
  </table>
  </center>
  <table>
  <tr>
      <td width="61%" height="22">&nbsp;
    
        
		
	</td>
    </tr>
	</table>
</div>
&nbsp;</p>
		
      </form>
      <p>&nbsp;
</body>
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
<SCRIPT LANGUAGE="JavaScript">
<!--

	function init(){
		
		addOptions();
		var a="<%=max_Attempts%>";
		document.create.maxattempts.value="<%=max_Attempts%>";
		<%try{%>
		
		<%}catch(Exception e){
			ExceptionsFile.postException("EditAssignment.jsp","Operations on database  ","Exception",e.getMessage());
		}%>
	}
	init();

//-->

</SCRIPT>
</html>
