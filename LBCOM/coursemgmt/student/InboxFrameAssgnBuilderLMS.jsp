<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	session=request.getSession();
	String start="",totrecords="",courseName="",docName="",workFile="",workId="",categoryId="",deadLineFlag="",workStatus="";
	int status=0,maxAttempts=0,submitCount=0;
	String courseId="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",assgContent="",developerId="";
	int assgnNo=0;
	String assgName="",studentId="",schoolId="",classId="",attachFile="",teacherId="",stuFile="",userId="";
	String devCourseId="",prev2Link="",prev3Link="",next3Link="";
	boolean no=false;
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null,st1=null,st2=null;

%>	
	
<%
	
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
			st2=con.createStatement();
			schoolId=(String)session.getAttribute("schoolid");
			courseId=(String)session.getAttribute("courseid");
			classId=(String)session.getAttribute("classid");
			studentId=(String)session.getAttribute("emailid");
			categoryId=request.getParameter("cat");
			courseName=request.getParameter("coursename");
			workFile=request.getParameter("workfile");
			deadLineFlag=request.getParameter("flag");
			workId=request.getParameter("workid");
			devCourseId=request.getParameter("devcourseid");
			unitId=request.getParameter("unitid");
			lessonId=request.getParameter("lessonid");
			prev2Link=request.getParameter("prev2link");
			prev3Link=request.getParameter("prev3link");
			next3Link=request.getParameter("nextpage");
			
			
			status=Integer.parseInt(request.getParameter("status"));
			
			workStatus=request.getParameter("workstatus");
			maxAttempts=Integer.parseInt(request.getParameter("maxattempts"));
			submitCount=Integer.parseInt(request.getParameter("submitcount"));
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ASSIGNMENT</title>
<!-- <script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script>  -->
<!-- TinyMCE -->
<script type="text/javascript" src="../../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		nowrap : false,
		//convert_newlines_to_brs : true,
		//remove_linebreaks : false,
		preformatted : true,
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
<script language="javascript">
	function validate()
	{
		var win=document.sub;

		if(trim(win.stuattachfile.value)=="")
		{
			if(confirm("Are you sure that you want to submit without attaching document?")==true)
			{
				//window.location.href="AddEditCourse.jsp?mode=del&courseid="+courseid+"&userid="+developerid;
			}
			else
				return;
			win.stuattachfile.focus();
			return false;
		}

		replacequotes();
    }

	function showattachments(subfile,cat,tid)
	{
	window.open("<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/"+tid+"/coursemgmt/<%=courseId%>/"+cat+"/"+subfile,"Document","width=750,height=600,scrollbars");

	}

	function winprint()
	{
	
            var w = 650;
            var h = 450;
            var l = (window.screen.availWidth - w)/2;
            var t = (window.screen.availHeight - h)/2;
        
            var sOption="toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,width=" + w + ",height=" + h + ",left=" + l + ",top=" + t; 
            // Get the HTML content of the div
            var sDivText = window.document.getElementById('stuassgncontent').innerHTML;
            // Open a new window
            var objWindow = window.open("", "Print", sOption);
            // Write the div element to the window
			sDivText=sDivText.replace(/&lt;/g,"<");
            sDivText=sDivText.replace(/&gt;/g,">");
			sDivText=sDivText.replace(/&amp;nbsp;/g," ");
			sDivText=sDivText.replace(/&nbsp;/g," ");
            objWindow.document.write(sDivText);
            objWindow.document.close(); 
            // Print the window            
            objWindow.print();
            // Close the window
           objWindow.close();   
            //window.close();         
    
	}
	
	function cancel()
	{
	
		//parent.contents.location.href="StudentInbox.jsp?totrecords=&start=0&cat=<%=categoryId%>&coursename=<%=courseName%>";
		parent.contents.location.href="/LBCOM/lbcms/navMenu.jsp?start=0&totrecords=&cat=CM&dev_courseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&prev2link=<%=prev2Link%>&prev3link=<%=prev3Link%>&nextpage=<%=next3Link%>";
	}
	function save()
	{
		//var sac=document.sub.stuassgncontent.value;
		//alert(sac);
		document.sub.action="SaveAssignmentLMS.jsp?workid=<%=workId%>&workfile=<%=workFile%>&cat=<%=categoryId%>&coursename=<%=courseName%>&submitcount=<%=submitCount%>&devcourseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&prev2link=<%=prev2Link%>&prev3link=<%=prev3Link%>&nextpage=<%=next3Link%>";
		
		document.forms[0].submit();
	}
</script>

</head>
<body>
<form name="sub"  method="post" enctype="multipart/form-data" action="SubmitAssignmentLMS.jsp?workid=<%=workId%>&workfile=<%=workFile%>&cat=<%=categoryId%>&coursename=<%=courseName%>&submitcount=<%=submitCount%>&devcourseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&prev2link=<%=prev2Link%>&prev3link=<%=prev3Link%>&nextpage=<%=next3Link%>" onsubmit="return validate();">

<div align="center">
  <center>
  <table border="0" cellspacing="0" width="80%" bordercolor="#111111" cellpadding="0">
       
<%		
		boolean flag=false;
		
		rs2=st2.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status=5");
		if(rs2.next())
		{
			assgContent=rs2.getString("answerscript");
			stuFile=rs2.getString("stuattachments");
			flag=true;
		}
		// if(submitCount==0)     If the first time
		if(flag==false)
		{
			if(submitCount==0)
			{
				rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"' and category_id='"+categoryId+"'");
				if(rs.next())
				{
					assgContent=rs.getString("asgncontent");
					docName=rs.getString("doc_name");
				
				}
			}
			else
			{
				rs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and submit_count='"+submitCount+"'");
				
				if(rs.next())
				{
					assgContent=rs.getString("answerscript");
				}
			}
		}
		
		//assgContent=assgContent.replaceAll("&nbsp;"," ");
		assgContent=assgContent.replaceAll("&amp;nbsp;","&nbsp;");
		assgContent=assgContent.replaceAll("&Acirc;","");
		assgContent=assgContent.replaceAll("http://oh.learnbeyond.net/LBCOM/","http://oh.learnbeyond.net:8080/LBCOM/");
		userId=studentId;
		rs1=st1.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"' and category_id='"+categoryId+"'");
		if(rs1.next())
		{
			docName=rs1.getString("doc_name");
			if(stuFile.equals("") || stuFile==null || stuFile.equals("null"))
			{
				attachFile=rs1.getString("attachments");
				userId=rs1.getString("teacher_id");
			}
			else
				attachFile=stuFile;
				
		}
		
		
%>
	
  </table>
  </center>
</div>
<div align="center">
  <center>
  <table border="0" cellspacing="1" width="80%" height="524">
  <br>
    <tr>
      <td width="100%" bgcolor="#ffffff" height="10" colspan="2">
<%
	if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
	{
		
%>		<font face="Verdana" size="2" color="#546878">There is no attachment for this assignment.</font>
<%		
	}
	else
	{				
%>
		<a href="javascript:showattachments('<%=attachFile%>','<%=categoryId%>','<%=userId%>');"><font face="Verdana" size="2" color="#546878"><b>&nbsp;Assignment Attachments</b></font>
<%		
	}
%>
     </td>
    </tr>
	<tr>
      <td width="73%" bgcolor="#546878" height="25"><b>
      <font face="Verdana" size="2" color="#FFFFFF" align="left">&nbsp;&nbsp;<%=docName%></font></b>
	  </td>
	  <td width="27%" bgcolor="#546878" height="25" align="right">
		  <b>
		<a href="javascript:winprint();">
		<font face="verdana" color="#FFFFFF" size="2"><b>Print</b></font></b>
	 </td>
    </tr>
    <tr>
      <td width="73%" colspan="2" height="388" bgcolor="#EBEBEB" align="center">
      <textarea name="stuassgncontent" id="stuassgncontent" rows="24" cols="87"><%=assgContent%></textarea>
		<script language="JavaScript">
			generate_wysiwyg('stuassgncontent');
		</script>
	</td>
    </tr>
    
<% 
	if(status>=0 && (submitCount<maxAttempts || maxAttempts==-1) && deadLineFlag.equals("true")&&workStatus.equals("1"))
	{
%>	<tr>
	<td align="right" width="100%" colspan="2" align="right" bgcolor="#C0C0C0">
		<font face="verdana" size="2">Attachment:</font><input type="file" name="stuattachfile" size="20"><font face="Verdana" size="2" color="#546878">&nbsp;(Max upload: 10 MB)</font>
	</td>
      <!-- <td width="73%" colspan="2" height="27" bgcolor="#C0C0C0" align="right"><input type="file" name="attach"></td> -->
    </tr>
    <tr>
		<td width="73%" colspan="3" height="27" align="center" bgcolor="#546878">
		
				<font face="Verdana" size="2" color="#FFFFFF"><input type="submit" value="Save" name="B1" onclick="save();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
				<font face="Verdana" size="2" color="#FFFFFF"><input type="submit" value="Submit" name="B2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
				<font face="Verdana" size="2" color="#FFFFFF"><input type="Button" onclick="cancel();" value="Cancel" name="B3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
			</td>
    </tr>
<%  }
	else
	{
%>
		<tr>
      <td width="73%" colspan="2" height="27" bgcolor="#546878">
      <p align="center"><b><font face="Verdana" size="2" color="#FFFFFF">&nbsp;You cannot submit the assignment.</b></font></td>
    </tr>
<%
	}
	if(!(submitCount<maxAttempts || maxAttempts==-1))
	{
%>
    <tr>
      <td width="73%" colspan="2" height="27" bgcolor="#546878">
      <p align="center"><font face="Verdana" size="2" color="#FFFFFF">&nbsp;You have utilized all the choices.</font></td>
    </tr>
<%  }
	if(deadLineFlag.equals("false"))
	{
%>
    <tr>
      <td width="73%" colspan="2" height="27" bgcolor="#546878">
      <p align="center"><font face="Verdana" size="2" color="#FFFFFF">&nbsp;Assignment has been expired.</font></td>
    </tr>
<%  }
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in InboxFrameAssgnBuilder.jsp is....."+e);
	}
	finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
			con1.close(con);
						
		}catch(SQLException se){
			ExceptionsFile.postException("InboxFrameAssgnBuilder.jsp","Closing statement object","SQLException",se.getMessage());
			System.out.println("The exception1 in InboxFrameAssgnBuilder.jsp is....."+se.getMessage());
		}
	}
%>

  </table>
  </center>
  <table>
 
	</table>
</div>
</p>
		
      </form>
      
</body>

</html>