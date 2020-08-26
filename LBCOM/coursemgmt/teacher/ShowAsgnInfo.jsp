<%@page import = "java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String  cours_last_date="",cours_last_datedb="",workId="", categoryId="", docName="", teacherId="", createdDate="", modifiedDate="", sectionId="", fromDate=""; 
	String workFile="", distType="",  deadLine="",qepath="", comments="",cat="",courseId="",topicId="",subtopicId="",schoolId="",classId="",year="",mm="",dd="",sessid="";
	int marksTotal=0,submit=0,maxAttempts=0,markScheme=0,tdays=0,cdays=0,eval=0;
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
			
			qepath = application.getInitParameter("q_editor_path");
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
		
			rs=st.executeQuery("select doc_name,topic,subtopic,asgncontent,mark_scheme,marks_total,max_attempts,from_date,to_date,instructions,to_days(from_date) fdate,to_days(curdate()) cdate from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where work_id='"+workId+"'");
   			   
			if(rs.next()){
				docName=rs.getString("doc_name");
				topicId=rs.getString("topic");
				subtopicId=rs.getString("subtopic");
				workFile=rs.getString("asgncontent");
				markScheme=rs.getInt("mark_scheme");
				marksTotal=rs.getInt("marks_total");
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
			ExceptionsFile.postException("EditWork.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
			System.out.println("The Error: SQL - "+e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}catch(SQLException se){
				ExceptionsFile.postException("EditWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		}
		catch(Exception e){
			ExceptionsFile.postException("EditWork.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
			out.println(e);
		}
%>
<HTML>
<head>
<script language="javascript" src="../../validationscripts.js"></script>
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

function openwin() {
	if (trim(document.create.workdoc.value)!="" || trim(document.create.editorfile.value)!=""){
			alert("You cannot select more than one document at a time");
			return false;
	}
	 var win=window.open("personaldocs/dbpersonaldocs.jsp?tag=T&foldername=","Personaldocuments",'dependent=yes,width=500,height=220, scrollbars=yes,left=175,top=200');
 	 win.focus();
}

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

	if(trim(win.totalmarks.value)=="") {
		alert("Please enter maximum points");
		window.document.create.totalmarks.focus();
		return false;
	}else {
		if(win.totalmarks.value<1)
		{
			alert("Maximum points should be greater than zero");
			window.document.create.totalmarks.focus();
			return false;
		}
	}

	
	if(win.fdate.disabled==false){
		if(validateDate(win.fdate,win.fmonth,win.fyear)==false){
			return false;
		}else{
			var dt=new Date(win.fyear.value,win.fmonth.value,win.fdate.value);
			var  d=new Date();
			d.setHours(0);
			d.setMinutes(0);
			d.setSeconds(0);
			dt.setHours(23);
			if(d>dt){
				alert("Sorry! You cannot enter past dates.");
				return false;
			}
		}
	}
	if(win.date.value!="" || win.month.value!="" || win.year.value!=""){
		if(validateDate(win.date,win.month,win.year)==false)
			return false;
		else{
			var t_dt=new Date(win.year.value,win.month.value,win.date.value);
			var  d=new Date();
			d.setHours(0);
			d.setMinutes(0);
			d.setSeconds(0);
			t_dt.setHours(23);
			if(d>t_dt){
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
	if(t_dt<f_dt){
				alert("Submission Date must be greater than the Start Date");
				return false;
	}

	if((trim(win.workdoc.value)!="" && trim(win.perdoc.value)!="")||(trim(win.workdoc.value)!="" && trim(win.editorfile.value)!="")||(trim(win.editorfile.value)!="" && trim(win.perdoc.value)!="")){
		alert("You cannot select more than one document at a time");
		win.workdoc.focus();
		return false;
	}

	dateConvert();
	win.fdate.disabled=false;
	win.fmonth.disabled=false;
	win.fyear.disabled=false;
	win.modifydisabled=true;
	replacequotes();
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
function openEditor(session,classid,courseid,workid){

	
	var win=window.document.create;
	if (trim(document.create.workdoc.value)!="" || trim(document.create.perdoc.value)!=""){
			alert("You can select only one document at a time");
			return false;
	}	

	<%
		if (workFile.equals(workId+".html"))
			out.println("var qid='"+workId+"'");
		else 
			out.println("var qid='new';");
	%>
	win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid="+qid+"&classid="+classid+"&courseid="+courseid+"&topicid="+win.topicid+"&subtopicid="+win.subtopicid+"&qtype=51&pathname=<%=cat%>/"+workid,"qed_win","width=875,height=525,scrollbars=yes");
	document.create.editorfile.value=workid+".html";	
	win.focus();
}

</script>



</head>				
<BODY >
<!--<form name="create" enctype="multipart/form-data" action="/LBCOM/coursemgmt.AddWork?mode=mod&categoryid=<%=cat%>" method="POST" onsubmit="return validate();" >-->
<form name="create" enctype="multipart/form-data" action="/LBCOM/coursemgmt.AddWork?mode=mod&categoryid=<%=cat%>"  method="POST" onsubmit="return validate();">
<table border="0" width="100%" height="100%" cellspacing="1">
    <tr>
      <td width="100%">
        <div align="center">
  <table  border="0" width="65%" cellspacing="0" bordercolorlight="#FFFFFF" height="262" cellpadding="0">

    <tr>
      <td width="600" height="23" colspan="3"><img border="0" src="../images/createtab.gif" width="151" height="28"> </td>
    </tr>

    <tr>
      <td width="600" height="23" colspan="3"><img border="0" src="../images/header.gif" width="597" height="25"> </td>
    </tr>

    <tr>
      <td width="228" height="23" align="right"><font face="Arial" size="2">Document Name&nbsp;</font> </td>
      <td width="9" height="23" align="center"><b><font face="Arial" size="2">:</font></b></td>
      <td width="359" height="23"><font face="Arial" size="2"><input type='text' name='docname' value="<%=docName%>" maxlength='15' oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" disabled>
        </font>
      </td>
    </tr>
	<tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Topic&nbsp;</font> </td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial"><select id="topic_id" name="topicid" onchange="getsubids(this.value);">
	  <option value="" selected>...Select...</option>

	<%
	try{
		rs=st.executeQuery("select * from topic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");	
		while (rs.next()) {
				out.println("<option value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</option>");
		}
	}catch(Exception e){
			ExceptionsFile.postException("EditWork.jsp","Operations on database  ","Exception",e.getMessage());
			
//			out.println(e);
		}finally{
		try{
			st.close();
			con1.close(con);
			
		}catch(SQLException se){
			ExceptionsFile.postException("EditWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	%>	
	</select>
       </font>
      </td>
    </tr>
	<tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Subtopic&nbsp;</font> </td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial"><select id='subtopic_id' name='subtopicid'>
	  <option value="" selected>...Select...</option></select>	
        </font>
      </td>
    </tr>
    <tr>
      <td width="228" height="23" align="right"><font face="Arial" size="2">Maximum Points&nbsp;</font> </td>
      <td width="9" height="23" align="center"><b><font face="Arial" size="2">:</font></b></td>
	<%
	  	if(eval==0){%>
      <td width="359" height="23"><font face="Arial" size="2"><input type=text name=totalmarks value="<%=marksTotal%>"   oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)" disabled>
        </font>
      </td>
    <%}else if(eval>0){%>
		<td width="359" height="23"><font face="Arial" size="2"><input type=text name=totalmarks value="<%=marksTotal%>" onblur="show_key(this);return false;" disabled>
        </font>
      </td>
	<%}%>
    </tr>
	<tr>
      <td width="228" height="23" align="right"><font face="Arial" size="2">Maximum Attempts&nbsp;</font> </td>
      <td width="9" height="23" align="center"><b><font face="Arial" size="2">:</font></b></td>
      <td width="359" height="23"><font face="Arial" size="2">
	  <select size='1' name='maxattempts'></select>
        </font>
      </td>
    </tr>
	<tr>
      <td width="228" height="23" align="right"><font face="Arial" size="2">Marking Scheme&nbsp;</font> </td>
      <td width="9" height="23" align="center"><b><font face="Arial" size="2">:</font></b></td>
      <td width="359" height="23"><font face="Arial" size="2">
<%	
			
	  if(markScheme==0){
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"0\" checked>Best");  
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"1\">Last");  
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"2\">Average");
	  }
	  else if(markScheme==1){
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"0\">Best");  
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"1\" checked>Last");  
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"2\">Average");
	  }
	  else if(markScheme==2){
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"0\">Best");  
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"1\">Last");  
	  out.println("<input type=\"radio\" name=\"markscheme\" value=\"2\" checked>Average");
	  }
%>
        </font>
      </td>
    </tr>
	<tr>
      <td width="228" height="23" align="right"><font face="Arial" size="2">Make Available From</font></td>
      <td width="9" height="23" align="center"><b><font face="Arial" size="2">:</font></b></td>
      <td width="359" height="23"><font face="Arial" size="2">
	  
	  <select size='1' name='fmonth'></select>
	  <select size='1' name='fdate'></select>
	  <select size='1' name='fyear'></select>
	  </font><font face="Arial" size=3 color="red">*</font></td>
    </tr>
    <tr>
      <td width="228" height="23" align="right"><font face="Arial" size="2">Last Date to Submit</font></td>
      <td width="9" height="23" align="center"><b><font face="Arial" size="2">:</font></b></td>
      <td width="359" height="23">
	  <select size='1' name='month'></select>
	  <select size='1' name='date'></select>
	  <select size='1' name='year'></select>
	  </td>
    </tr>

    <tr>
      <td width="35%" rowspan="4" valign="top" align="right"><font face="Arial" size="2">Work Document</font></td>
	  <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="65%"><b><font face="Arial" size="2" color="#CC0099">
	  <%
		
	  if(workFile.startsWith("w")){
		out.println(workFile.substring(workFile.indexOf('_')+1,workFile.length()));
	  }
	  else
	  out.println(workFile);
	  %></td>
    </tr>

<% 
	if(submit==0) {//modified on 10-11-2004 for blocking editing after students began submiting and to restrict the user to enter the file in the text box%>
	<tr>
	<td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" bgcolor="#FFFFFF"><input type="file" name="workdoc" disabled></td>
	</tr>
   <tr>
	<td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
     <td width="68%" bgcolor="#FFFFFF"><input type="text" name="perdoc" value="" readonly size="20">
       <input type="button" value="Personal Docs..."   name="getfile" onclick="return openwin();" disabled></td>
    </tr>
	<tr>
	<td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
     <td width="68%" bgcolor="#FFFFFF"><input type="text" name="editorfile" value="" readonly size="20">
       <input type="button" value="HTML Editor..."   name="editfile" onclick="return openEditor('<%=sessid%>','<%=classId%>','<%=courseId%>','<%=workId %>');"disabled></td>
    </tr>
<%}else {%>
	<tr>
	<td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" bgcolor="#FFFFFF"><input type="file" name="workdoc" disabled></td>
	</tr>
<tr>
	<td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
     <td width="68%" bgcolor="#FFFFFF"><input type="text" name="perdoc" value="" readonly size="20">
       <input type="button" value="Personal Docs..."   name="getfile" onclick="return openwin();" disabled></td>
    </tr>
	<tr>
	<td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
     <td width="68%" bgcolor="#FFFFFF"><input type="text" name="editorfile" value="" readonly size="20">
       <input type="button" value="HTML Editor..."   name="editfile" onclick="return openEditor('<%=sessid%>','<%=classId%>','<%=courseId%>','<%=workId %>');" disabled></td>
    </tr>
<%}%>
    <tr>
      <td width="35%" align="right"><font face="Arial" size="2">Instructions</font></td>
	  <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="65%"><font size="2" face="Arial"><textarea name="comments" rows='3' cols="35" maxlength=250><%=comments%></textarea></font></td>
    </tr>
	
    <tr>
      <td width="600" colspan="3" ><img border="0" src="../images/footer.gif" width="600" height="25"> </td>
    </tr>
    <tr>
      <td width="600" align="center" colspan="3" height="44">
       	<a href="javascript:self.close();" style="text-decoration:none;color=blue">
		<b><font face="Verdana" size="2">Close</font></b>
		</a>
	</td>

    </tr>
	<% 
		if(submit!=0 || (tdays-cdays)<0) 
		out.println("<SCRIPT Language=\"JavaScript\">document.create.fmonth.disabled=true;document.create.fdate.disabled=true;document.create.fyear.disabled=true;</SCRIPT>");
		

	%>
  </table>
</div>
</td></tr></table>

<input type='hidden' name=lastdate>
<input type='hidden' name=fromdate>
<input type="hidden" name="workfile" value="<%= workFile %>">
<input type="hidden" name="workid" value="<%= workId %>">
<input type="hidden" name="subcount" value="<%= submit %>">
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
			ExceptionsFile.postException("EditWork.jsp","Operations on database  ","Exception",e.getMessage());
		}%>
	}
	init();

//-->

</SCRIPT>
</HTML>
