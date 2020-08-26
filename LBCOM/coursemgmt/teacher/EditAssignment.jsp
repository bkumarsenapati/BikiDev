<%@page import = "java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String  cours_last_date="",cours_last_datedb="",workId="", categoryId="", docName="", teacherId="", createdDate="", modifiedDate="", sectionId="", fromDate=""; 
	String assgnContent="",distType="",deadLine="",attachFile="",comments="",cat="",courseId="",topicId="",subtopicId="",schoolId="",classId="",year="",mm="",dd="",sessid="";
	int submit=0,maxAttempts=0,markScheme=0,tdays=0,cdays=0,eval=0;
	float marksTotal=0.0f;
	char c;
	java.util.Date date=null,toDate=null;
%>
<%

	   try
	    {
			
			sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			
			teacherId = (String)session.getAttribute("emailid");
			courseId=(String)session.getAttribute("courseid");
			schoolId = (String)session.getAttribute("schoolid");
			classId=(String)session.getAttribute("classid");
			
			cat=request.getParameter("cat");
			workId=request.getParameter("docs");
			submit=Integer.parseInt(request.getParameter("submit")); //modified on 10-11-2004
			eval=Integer.parseInt(request.getParameter("eval"));
 			con=con1.getConnection();
			st=con.createStatement();
			String dbString11="select DATE_FORMAT(last_date,'%m/%d/%Y') as last_date,DATE_FORMAT(last_date,'%Y-%m-%d') as last_datedb from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'";
			rs=st.executeQuery(dbString11);
			boolean b=rs.next();
			cours_last_date=rs.getString(1);
			cours_last_datedb=rs.getString(2);
			rs.close();
		
			rs=st.executeQuery("select doc_name,topic,subtopic,asgncontent,attachments,mark_scheme,marks_total,max_attempts,from_date,to_date,instructions,to_days(from_date) fdate,to_days(curdate()) cdate from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
   			   
			if(rs.next())
			{
				docName=rs.getString("doc_name");
				System.out.println("docName..."+docName);
				docName=docName.replaceAll("\"","&#34;");
				topicId=rs.getString("topic");
				subtopicId=rs.getString("subtopic");
				assgnContent=rs.getString("asgncontent");
				assgnContent=assgnContent.replaceAll("&Acirc;","");
				assgnContent=assgnContent.replaceAll("Â","");
				assgnContent=assgnContent.replaceAll("http://oh.learnbeyond.net/LBCOM/","http://oh.learnbeyond.net:8080/LBCOM/");
				attachFile=rs.getString("attachments");
				markScheme=rs.getInt("mark_scheme");
				marksTotal=rs.getFloat("marks_total");
				maxAttempts=rs.getInt("max_attempts");
				date=rs.getDate("from_date");
				
			    toDate=rs.getDate("to_date");
				comments=rs.getString("instructions");
				tdays=rs.getInt("fdate");
				cdays=rs.getInt("cdate");
			}

			if(toDate!=null){
				deadLine=toDate.toString();
				mm=deadLine.substring(5,7);
				dd=deadLine.substring(8,10);
				year=deadLine.substring(0,4);
				int tt=Integer.parseInt(mm);
				tt--;
				mm=""+tt;
				tt=Integer.parseInt(dd);
				dd=""+tt;
			}
			else{
				deadLine=cours_last_datedb;
				mm=deadLine.substring(5,7);
				dd=deadLine.substring(8,10);
				year=deadLine.substring(0,4);
				int tt=Integer.parseInt(mm);
				tt--;
				mm=""+tt;
				tt=Integer.parseInt(dd);
				dd=""+tt;

			}
		}catch(SQLException e)
		{
			ExceptionsFile.postException("EditAssignment.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
			System.out.println("The Error: SQL - "+e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}catch(SQLException se){
				ExceptionsFile.postException("EditAssignment.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		}
		catch(Exception e){
			ExceptionsFile.postException("EditAssignment.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
			out.println(e);
		}
%>
<HTML>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT LANGUAGE="JavaScript">
function showattachments(subfile,cat)
{
	window.open("<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/"+cat+"/"+subfile,"Document","width=750,height=600,scrollbars");

}
</script>
<script language="JavaScript" type="text/javascript" src="wysiwyg/assgnwysiwyg.js"></script> 
<script language="javascript" src="../../validationscripts.js"></script>
<meta content="text/html; charset=utf-8" http-equiv="content-type" />
	<!-- TinyMCE -->
<script type="text/javascript" src="../../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		convert_urls : false,
		relative_urls : false,
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
   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
var topic=new Array();
<%
	rs=st.executeQuery("select * from subtopic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");
	int i=0;
	while (rs.next()) {
		out.println("topic["+i+"]=new Array('"+rs.getString("topic_id")+"','"+rs.getString("subtopic_id")+"','"+rs.getString("subtopic_des")+"');\n"); 
		i++;
	}
%>	
	function ltrim ( s )
	{
		return s.replace( /^\s*/, "" );
	}

	function rtrim ( s )
	{	
		return s.replace( /\s*$/, "" );
	}

	function trim ( s )
	{
		return rtrim(ltrim(s));
	}


</script>

<script>

function dateConvert()
{
	var win=window.document.create;
	var mon=parseInt(win.fmonth.value)+1;
	win.fromdate.value=win.fyear.value+'/'+mon+'/'+win.fdate.value;
	if(win.year.value!=""){
		mon=parseInt(win.month.value)+1;
		win.lastdate.value=win.year.value+'/'+mon+'/'+win.date.value;
	}
	else
		win.lastdate.value="";
}

function checkNum(keyCode)
{

   if(keyCode==8 || keyCode==13)
		return true;

	if(keyCode<48 || keyCode>57)
	{

		alert("Enter numbers only");
		return false;
	}
	return true;

}

function show_key(the_field)
{
	var the_key="0123456789";
	the_value=the_field.value;
	var the_char;
	var len=the_value.length;
	for(var i=0;i<len;i++){
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1) {
			alert("Enter numbers only");
			the_field.focus();
			return false;
		}
	}
}

function isValidDate(dd,mm,yy){
   d=dd.value;
   m=parseInt(mm.value)+1;
   y=yy.value;

   var dinm = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
   tday=new Date();
   if(y <=1900 ||isNaN(y)){
     alert("Enter a valid year");
     return false;
   }
   else
     if(y %4==0 &&(y%100!=0 ||y%400==0))
       dinm[2]=29;
   if((m > 12 || m < 1)|| isNaN(m)){
      alert("Enter a valid month");
      return false;
   }
   if((d<1 || d >dinm[m])||isNaN(d)){
     alert("Enter a valid date");
     return false;
   }
   return true;
}

function validateDate(dd,mm,yy){
	if(isValidDate(dd,mm,yy)==true){
		var dob=new Date(yy.value,mm.value,dd.value);
		var to=new Date();
		var toDay=new Date(to.getYear(),to.getMonth(),to.getDate());
	}else
		return false;
}

function validate()
{
	
	var win=window.document.create;
	win.docname.value=trim(win.docname.value);	
	if(win.docname.value=="")
	{
		alert("Please enter the document name");
		window.document.create.docname.focus();
		return false;
	}
	var cat=window.document.create.asgncategory.value
	if(cat=="all")
	{
		alert("Please select category");
		window.document.create.asgncategory.focus();
		return false;
		
	}

	if(trim(win.totalmarks.value)=="")
	{
		alert("Please enter maximum points");
		window.document.create.totalmarks.focus();
		return false;
	}
	else
	{
		if(win.totalmarks.value<1)
		{
			alert("Maximum points should be greater than zero");
			window.document.create.totalmarks.focus();
			return false;
		}
	}
	if(win.fdate.disabled==false)
	{
		if(validateDate(win.fdate,win.fmonth,win.fyear)==false)
		{
			return false;
		}
		else
		{
			var dt=new Date(win.fyear.value,win.fmonth.value,win.fdate.value);
			var  d=new Date();
			d.setHours(0);
			d.setMinutes(0);
			d.setSeconds(0);
			dt.setHours(23);
			if(d>dt)
			{
				alert("Sorry! You cannot enter past dates.");
				return false;
			}
		}
	}
	if(win.date.value!="" || win.month.value!="" || win.year.value!="")
	{
		if(validateDate(win.date,win.month,win.year)==false)
			return false;
		else
		{
			var t_dt=new Date(win.year.value,win.month.value,win.date.value);
			var  d=new Date();
			d.setHours(0);
			d.setMinutes(0);
			d.setSeconds(0);
			t_dt.setHours(23);
			if(d>t_dt)
			{
				alert("Sorry! You cannot enter past dates.");
				return false;
			}
			t_dt.setHours(0);
			var course_l_date=new Date("<%=cours_last_date%>");
			if(course_l_date<t_dt){
				alert("Submission Date should be less than or equal to the Course Completion Date(<%=cours_last_date%>)");
				return false;
			}
		}
	}
	var f_dt=new Date(win.fyear.value,win.fmonth.value,win.fdate.value);
	var t_dt=new Date(win.year.value,win.month.value,win.date.value);
	if(t_dt<f_dt)
	{
				alert("Submission Date must be greater than the Start Date");
				return false;
	}

	dateConvert();
	win.fdate.disabled=false;
	win.fmonth.disabled=false;
	win.fyear.disabled=false;
	win.modifydisabled=true;
	//replacequotes();
	win.totmarks.value=win.totalmarks.value;
	

		
}
function cleardata(){
		document.create.reset();
		getsubids('<%=topicId%>');
		addOptions();
		init();
		return false;
}

function getsubids(id) {
	clear();
	var j=1;
	var i;
	for (i=0;i<topic.length;i++){
		if(topic[i][0]==id){
			document.create.subtopicid[j]=new Option(topic[i][2],topic[i][1]);
			j=j+1;
		}
	} 
	if (j==1)
			document.create.subtopicid[j]=new Option("No Subtopics","");
}

function clear() {
	var i;
	var temp=document.create.subtopicid;
	for (i=temp.length;i>0;i--){
		if(temp.options[i]!=null){
			temp.options[i]=null;
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

	frm.fmonth.length=13;
	frm.fdate.length=32;
	frm.fyear.length=10;
	frm.fmonth[0]=new Option("MM","");
	for(i=0;i<12;i++)
		frm.fmonth[i+1]=new Option(month[i],i);
	frm.fdate[0]=new Option("DD","");
	for(i=1;i<=31;i++)
		frm.fdate[i]=new Option(i,i);
	frm.fyear[0]=new Option("YYYY","");
	for(i=date.getFullYear(),j=1;i<date.getFullYear()+10;i++,j++)
		frm.fyear[j]=new Option(i,i);

	frm.month.length=13;
	frm.date.length=32;
	frm.year.length=10;
	frm.month[0]=new Option("MM","");
	for(i=0;i<12;i++)
		frm.month[i+1]=new Option(month[i],i);
	frm.date[0]=new Option("DD","");
	for(i=1;i<=31;i++)
		frm.date[i]=new Option(i,i);
	frm.year[0]=new Option("YYYY","");
	for(i=date.getFullYear(),j=1;i<date.getFullYear()+10;i++,j++)
		frm.year[j]=new Option(i,i);

	frm.month.value="";
	frm.year.value="";
	frm.date.value="";
	return false;
}

</script>



</head>				
<BODY bgcolor="#EBF3FB">

<form name="create" enctype="multipart/form-data" action="/LBCOM/coursemgmt.AddEditAssignment?mode=edit&cat=<%=cat%>" method="POST" onsubmit="return validate();">


<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<a href="AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_editor2.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>
<hr>
<table border="1" align="center" width="60%" bgcolor="#EBF3FB" cellspacing="1" cellpadding="1">
<tr>
	<td width="100%" height="23" align="left" bgcolor="#C0C0C0" colspan="3">
		<font face="Verdana" size="2" color="#003399"><b>&nbsp;Edit Assignment :</b></font>
	</td>
</tr>
<tr>
	<td width="36%" height="23" align="right"><font size="2" face="Verdana"><b>Document Name&nbsp;</b></font> </td>
    <td width="3%" height="23" align="center"><b><font size="2" face="Verdana">:</font></b></td>
    <td width="68%" height="23">
		<font size="2" face="Verdana">
			<input type='text' name='docname' value="<%=docName%>" maxlength='50' size="40">
		</font>
      </td>
</tr>
<tr>
    <td width="36%" height="23" align="right"><font size="2" face="Verdana">Topic&nbsp;</font></td>
    <td width="3%" height="23" align="center"><b><font size="2" face="Verdana">:</font></b></td>
	<td width="68%" height="23">
		<select id="topic_id" name="topicid" onchange="getsubids(this.value);">
			<option value="" selected>Select</option>
<%
	try
	{
		rs=st.executeQuery("select * from topic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");	
		while (rs.next()) 
		{
			out.println("<option value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</option>");
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("EditAssignment.jsp","Operations on database  ","Exception",e.getMessage());
		System.out.println("Exception in EditASsignment.jsp is...."+e);
	}
%>	
		</select>
	</td>
</tr>
<tr>
	<td width="36%" height="23" align="right">
		<font size="2" face="Verdana">Subtopic&nbsp;</font>
	</td>
	<td width="3%" height="23" align="center">
		<b><font size="2" face="Verdana">:</font></b>
	</td>
    <td width="68%" height="23">
		<select id='subtopic_id' name='subtopicid'>
			<option value="" selected>Select</option>
		</select>	
	</td>
</tr>
<tr>
	<td width="36%" height="23" align="right">
		<font size="2" face="Verdana">Assignment Category&nbsp;</font>
	</td>
    <td width="3%" height="23" align="center">
		<b><font size="2" face="Verdana">:</font></b>
	</td>
	<td width="68%" height="23">
		<select id="asgncategory" name="asgncategory" disabled>
			<option value="all">Select</option>
<%
	try
	{
		rs=st.executeQuery("select * from category_item_master where category_type='AS' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
		
		while (rs.next())
		{
			if(cat.equals(rs.getString("item_id")))
			{
				out.println("<option value="+cat+" selected>"+rs.getString("item_des")+"</option>");
			}
			else
			{
				out.println("<option value='"+rs.getString("item_id")+"'>"+rs.getString("item_des")+"</option>");
			}
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("EditAssignment.jsp","operations on resultset","Exception",e.getMessage());
		System.out.println("Exception in EditAssignemt.jsp 2 is..."+e);
	}
	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("EditAssignment.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println("Exception in EditAssignment.jsppp iss..."+se.getMessage());
		}

    }
%>	
		</select>
	</td>
</tr>
<tr>
	<td width="228" height="23" align="right">
		<font face="Verdana" size="2">Maximum Points&nbsp;</font>
	</td>
	<td width="9" height="23" align="center">
		<b><font face="Verdana" size="2">:</font></b>
	</td>
<%
	if(eval==0)
	{
%>
		<td width="359" height="23">
			<font face="Verdana" size="2">
			<input type=text name="totalmarks" value="<%=marksTotal%>" oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)">
			</font>
		</td>
<%
	}
	else if(eval>0)
	{
%>
		<td width="359" height="23">
			<font face="Verdana" size="2">
			<input type=text name="totalmarks" value="<%=marksTotal%>" onblur="show_key(this);return false;">
			</font>
		</td>
<%
	}
%>
</tr>
<tr>
	<td width="228" height="23" align="right"><font face="Verdana" size="2">Maximum Attempts&nbsp;</font></td>
	<td width="9" height="23" align="center"><b><font face="Verdana" size="2">:</font></b></td>
	<td width="359" height="23">
		<select size='1' name='maxattempts'></select>
	</td>
</tr>
<tr>
	<td width="228" height="23" align="right"><font face="Verdana" size="2">Marking Scheme&nbsp;</font> </td>
    <td width="9" height="23" align="center"><b><font face="Verdana" size="2">:</font></b></td>
    <td width="359" height="23">
		<font size="2" face="Verdana">  
<%	
	if(markScheme==0)
	{
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"0\" checked>Best");  
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"1\">Last");  
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"2\">Average");
	}
	else if(markScheme==1)
	{
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"0\">Best");  
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"1\" checked>Last");  
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"2\">Average");
	}
	else if(markScheme==2)
	{
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"0\">Best");  
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"1\">Last");  
		out.println("<input type=\"radio\" name=\"markscheme\" value=\"2\" checked>Average");
	}
%>
		</font>
	</td>
</tr>
<tr>
	<td width="228" height="23" align="right"><font face="Verdana" size="2">Assignment Start Date</font></td>
    <td width="9" height="23" align="center"><b><font face="Verdana" size="2">:</font></b></td>
    <td width="359" height="23">
		<select size='1' name='fmonth'></select>
		<select size='1' name='fdate'></select>
		<select size='1' name='fyear'></select>
	</td>
</tr>
<tr>
	<td width="228" height="23" align="right"><font face="Verdana" size="2">Assignment Due Date</font></td>
    <td width="9" height="23" align="center"><b><font face="Verdana" size="2">:</font></b></td>
    <td width="359" height="23">
		<select size='1' name='month'></select>
		<select size='1' name='date'></select>
		<select size='1' name='year'></select>
	</td>
</tr>
<tr>
<td bgcolor="#546878" colspan="3">
<%
if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
	{
		
%>		<font face="Verdana" size="2" color="#FFFFFF">There is no attachment for this assignment.</font>
<%		
	}
	else
	{				
%>
		<a href="javascript:showattachments('<%=attachFile%>','<%=cat%>');"><font face="Verdana" size="2" color="#FFFFFF"><b>Attachment Preview</b></font>
<%		
	}
%>
</td>

</tr>
<tr>
	<td width="100%" colspan="3" height="15" bgcolor="#546878">
	<table>
	<tr>
      <td width="35%" colspan="2" height="88" bgcolor="#EBEBEB" align="center">


      <!-- <textarea name="assgncontent" id="assgncontent" rows="24" cols="87"><%=assgnContent%></textarea>
		<script language="JavaScript">
			generate_wysiwyg('assgncontent');
		</script> -->

		 <textarea cols="80" id="assgncontent" name="assgncontent" rows="10"><%=assgnContent%></textarea>
		
		<script type="text/javascript">
			//<![CDATA[

				CKEDITOR.replace( 'assgncontent',
					{
						/*
						skin : 'office2003',
						filebrowserBrowseUrl : 'http://192.168.1.3:8080/LBCOM/cmgenerator.CBSaveFile',
						filebrowserImageBrowseUrl : 'http://192.168.1.3:8080/LBCOM/cmgenerator.CBSaveFile',
						filebrowserUploadUrl : 'http://192.168.1.3:8080/LBCOM/cmgenerator.CBSaveFile',
						filebrowserImageUploadUrl : 'http://192.168.1.3:8080/LBCOM/cmgenerator.CBSaveFile'

						*/
						fullPage : true,
						skin : 'office2003',
						 filebrowserBrowseUrl : 'http://oh.learnbeyond.net/~oh/LBCOM/ckfinder/ckfinder.html',
					filebrowserImageBrowseUrl : 'http://oh.learnbeyond.net/~oh/LBCOM/ckfinder/ckfinder.html?Type=Images',
        filebrowserFlashBrowseUrl : 'http://oh.learnbeyond.net/~oh/LBCOM/ckfinder/ckfinder.html?Type=Flash',
        filebrowserUploadUrl : 'http://oh.learnbeyond.net/~oh/LBCOM/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files',
        filebrowserImageUploadUrl : 'http://oh.learnbeyond.net/~oh/LBCOM/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Images',
        filebrowserFlashUploadUrl : 'http://oh.learnbeyond.net/~oh/LBCOM/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Flash'

					});

			//]]>
			</script>
	  </td>
    </tr>
	<tr>
		<td width="35%" align="right" bgcolor="#546878">
			<font face="Verdana" size="2" color="#FFFFFF"><b>Attachment:</b><input type="file" name="attachfile" size="20"></font>
		</td>
		
    </tr>

</table>
	
	</td>
</tr>
<tr>
	<td width="100%" colspan="3" height="33" align="center">
		<input type="image" name="modify" border="0" src="../images/modify.gif" width="88" height="33">
		<input type="image" onClick="return cleardata()" src="../images/reset.gif" width="91" height="33">
	</td>
</tr>
</table>
<% 
	if(submit!=0 || (tdays-cdays)<0) 
		out.println("<SCRIPT Language=\"JavaScript\">document.create.fmonth.disabled=true;document.create.fdate.disabled=true;document.create.fyear.disabled=true;</SCRIPT>");
%>


<input type='hidden' name=lastdate>
<input type='hidden' name="asgncategory" value="<%=cat%>">
<input type='hidden' name="fromdate" value="<%=date%>">
<input type="hidden" name="attachfile" value="<%=attachFile%>">
<input type="hidden" name="workid" value="<%=workId%>">
<input type="hidden" name="subcount" value="<%=submit%>">
<input type="hidden" name="totmarks" value="<%=marksTotal%>">
</form>
</BODY>
<SCRIPT LANGUAGE="JavaScript">
<!--

	function init(){
		document.create.topicid.value="<%=topicId%>";
		getsubids('<%=topicId%>');
		addOptions();
		document.create.subtopicid.value="<%=subtopicId%>";
		document.create.maxattempts.value="<%=maxAttempts%>";
		<%try{%>
		document.create.fmonth.value="<%=date.getMonth()%>";	
		document.create.fdate.value="<%=date.getDate()%>";
		document.create.fyear.value="<%=date.getYear()+1900%>";
			
		document.create.month.value="<%=mm%>";
		document.create.date.value="<%=dd%>";
		document.create.year.value="<%=year%>";
		<%}catch(Exception e){
			ExceptionsFile.postException("EditAssignment.jsp","Operations on database  ","Exception",e.getMessage());
		}%>
	}
	init();

//-->

</SCRIPT>
</HTML>
