<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	String docName="",studentId="",comments="",remark="",assgContent="";
	String workId="",categoryId="",submitDate="",count="",filePath="",totRecords="",submsnType="",alltotRecords="";
	String courseId="",schoolId="",classId="";
	int status=0,eCredit=0;

	float marksSecured=0.0f,maxMarks=0.0f;

	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null,st1=null,st2=null;

	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	try
	{
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");
	classId=(String)session.getAttribute("classid");
	studentId=request.getParameter("studentid");
	categoryId=request.getParameter("cat");
	maxMarks=Float.parseFloat(request.getParameter("maxmarks"));
	comments=request.getParameter("comments");
	workId=request.getParameter("workid");	
	status=Integer.parseInt(request.getParameter("status"));
	marksSecured=Float.parseFloat(request.getParameter("marks"));
	remark=request.getParameter("remarks");
	submitDate=request.getParameter("submitdate");
	count=request.getParameter("count");
	//filePath=request.getParameter("filepath");
	totRecords=request.getParameter("totrecords");
	submsnType=request.getParameter("submsntype");
	alltotRecords=request.getParameter("alltotrecords");
	rs1=st1.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
	if(rs1.next())
	{
		docName=rs1.getString("doc_name");
		
	}
	rs1.close();

	st2=con.createStatement();
	rs2=st2.executeQuery("select * from category_item_master where course_id='"+courseId+"' and item_id='"+categoryId+"' and school_id='"+schoolId+"'");
	if(rs2.next())
	{
		eCredit=rs2.getInt("grading_system");					
	}
		
	rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and submit_count='"+count+"'");
	if(rs.next())
	{
		assgContent=rs.getString("answerscript");
		assgContent=assgContent.replaceAll("&Acirc;","");
				assgContent=assgContent.replaceAll("Â","");
%>

<html>
<head>
<title>.::Welcome to Learnbeyond.net::.</title>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- TinyMCE -->
<script type="text/javascript" src="../../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		nowrap : false,
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
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="hotschools">
<!-- <script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script>  -->
<script>
function check()
{
	var max=<%=maxMarks%>;
	var max1=<%=eCredit%>;
	if(max1==2)
	{
		max=1000;
	}
	else
		max=max;
	
	var win=window.document.sub;
	//if(show_key(win.value)==false)
	//{
		//alert("Enter only numbers");
		//win.focus();
		//return false;
	//}
	//else
	//{
		if(win.markssecured.value > max || win.markssecured.value == "")
		{
			alert("Maximum points should be less than or equal to "+max);
			win.focus();
			return false;
		}
		if(win.stuworkfile.value == "") 
		{
			if(confirm("Are you sure that you want to proceed with out submitting a document?")==true)
			{
				win.stuworkfile.focus();
				return true;
			}
			else
				win.stuworkfile.focus();
				return false;			
		}
	//}
}

function show_key(the_value)
{
	var the_key="0123456789";
	var the_char;
	var len=the_value.length;
	if(the_value=="")
		return false;
	for(var i=0;i<len;i++)
	{
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1)
			return false;
	}
}

function showcomments(subfile,cat)
{
	window.open("<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=studentId%>/coursemgmt/<%=courseId%>/"+cat+"/"+subfile,"Document","width=750,height=600,scrollbars");

}

function enterRemarks(remark)
{
	var newWin=window.open("SetRemark.jsp?remark="+remark,'TeacherRemarks',"resizable=no,toolbars=no,scrollbar=yes,width=250,height=250,top=200,left=300");
	/*newWin.document.writeln("<html><head><title>Teacher's Remarks</title></head><body><font face='Arial' size='2' color='blue'><u>");
	newWin.document.writeln("Please Enter the Remarks</u><br><textarea name='remarks' rows='8'></textarea><br><center><input type=submit value='Ok' onclick='return setremark();'></center></body></html>");*/
}

</script>
</head>

<body bgcolor="#EBF3FB">
<form name="sub" enctype="multipart/form-data" method="post" action="TeacherSubmit.jsp?workid=<%=workId%>&cat=<%=categoryId%>&stuid=<%=studentId%>&stufile=<%=comments%>" onsubmit="javascript:return check();">
<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor1.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator2.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>
<hr>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="white" width="100%" bgcolor="#C0C0C0">
<tr>
	<td width="100%" valign="middle" align="left">
		<font color="#003399" face="verdana" size="2"><b>&nbsp;<%=studentId%></b></font>
		<font size=2>&nbsp;<b>:</b>&nbsp;</font>
		<font color="black" face="verdana" size="2"><%=docName%></font>
	</td>
</tr>
</table>
<table border="1" width="100%" cellspacing="1" height="1">
<tr>
<% if((comments==null) || comments.equals(""))
	{
%>	
	<td width="25%" valign="middle" align="center" bgcolor="#E8ECF4" height="1">
		<font color="#003399" face="verdana" size="2">&nbsp;No Attachments</a>
		</font>
	</td>
<%	
	}
	else
	{
%>	
	<td width="25%" valign="middle" align="center" bgcolor="#E8ECF4" height="1">
		<font color="#003399" face="verdana" size="2">
			<a href="javascript:showcomments('<%=comments.replaceAll("'","&#92;&#39;")%>','<%=categoryId%>');">Attachments</a>
		</font>
	</td>
<%	
	}
%>
	
	<td width="20%" valign="middle" align="center" bgcolor="#E8ECF4" height="1">
		<font color="#003399" face="verdana" size="2">
			<a href="javascript:enterRemarks('<%=remark%>');">Add Remarks</a>
		</font>
	</td>
	<td width="25%" valign="middle" align="center" bgcolor="#E8ECF4" height="1">
		<font color="#003399" face="verdana" size="2">Total Points&nbsp;[Max = <%=maxMarks%>]</font>
	</td>
	<td width="30%" valign="middle" align="right" bgcolor="#E8ECF4" height="1">
		<input type="text" name="markssecured" value="<%=marksSecured%>" size="10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="image" align="center" src="images/submit.png">
		</font>
	</td>
</tr>
</table>
<table border="1" width="100%" height="300" cellspacing="1">
<tr>
	<td width="100%" valign="top" align="center" bgcolor="#E8ECF4">
		<textarea name="stuassgncontent" id="stuassgncontent" rows="24" cols="87"><%=assgContent%></textarea>
		<!-- <script language="JavaScript">
			generate_wysiwyg('stuassgncontent');
		</script> -->
	</td>
	<!-- <td width="5%" valign="top" height="300" align="left">
		<textarea rows="19" cols="4" title="You can use this area as rough"></textarea>
	</td> -->
</tr>
</table>
<table>
<tr>
    <td width="40%" height="10" align="left"><font face="Verdana" size="2">Upload Document :</font></td>
   <!--  <td width="60%" height="10" align="right"><input type="file" name="stuworkfile" size="20" onclick="return checkBrowse();"></td> -->
   <td width="60%" height="10" align="left"><input type="file" name="stuworkfile" size="20"></td>
  </tr>
  </table>
<%
	}
		docName=docName.replaceAll("\"","&#34;");
	}
	catch(SQLException se)
	{
		System.out.println("The exception1 in Evaluator.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in Evaluator.jsp is....."+e);
	}
	finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(rs!=null)
				rs.close();
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("Evaluator.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}

%>
<input type="hidden" name="cat" value="<%=categoryId%>">
<input type="hidden" name="studentid" value="<%=studentId%>">	
<input type="hidden" name="workid" value="<%=workId%>">
<input type="hidden" name="maxmarks" value="<%=maxMarks%>">
<!-- <input type="hidden" name="docname" value="<%=docName%>"> -->
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="remarks">
<input type="hidden" name="submitdate" value="<%=submitDate%>">
<input type="hidden" name="count" value="<%=count%>">
<input type="hidden" name="totrecords" value="<%=totRecords%>">
<input type="hidden" name="submsntype" value="<%=submsnType%>">
<input type="hidden" name="alltotrecords" value="<%=alltotRecords%>">

</form>
</body>
</html>