<%@ page import="java.sql.*,utility.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
String cours_last_date="",cours_last_datedb="",courseName="",classId="",cat="",courseId="",workId="",s="",schoolId="",qePath="",deadLine="",mm="",dd="",year="";

%>
<%
   try{

	session=request.getSession();
	s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
    String schoolPath = application.getInitParameter("schools_path");
	qePath = application.getInitParameter("q_editor_path");
	schoolId=(String)session.getAttribute("schoolid");
    Utility utility= new Utility(schoolId,schoolPath);
	con=con1.getConnection();
	st=con.createStatement();
	classId=(String)session.getAttribute("classid");
		courseName=(String)session.getAttribute("coursename");
	courseId=(String)session.getAttribute("courseid");
	cat=request.getParameter("cat");
	
	String dbString11="select DATE_FORMAT(last_date,'%m/%d/%Y') as last_date,DATE_FORMAT(last_date,'%Y-%m-%d') as last_datedb from coursewareinfo where course_id='"+courseId+"' and school_id='"+schoolId+"'";
	rs=st.executeQuery(dbString11);
	boolean b=rs.next();
	cours_last_date=rs.getString(1);
	cours_last_datedb=rs.getString(2);
	rs.close();

	workId=utility.getId("WorkId");
	if (workId.equals("")){
		utility.setNewId("WorkId","w0000");
		workId=utility.getId("WorkId");
	}
	deadLine=cours_last_datedb;
	mm=deadLine.substring(5,7);
	dd=deadLine.substring(8,10);
	year=deadLine.substring(0,4);
	int tt=Integer.parseInt(mm);
	tt--;
	mm=""+tt;
	tt=Integer.parseInt(dd);
	dd=""+tt;
%>

<HTML>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   <script language="javascript" src="../../validationscripts.js"></script>

</head>
<%
    
	out.println("<script>\n");  
	
	out.println("var topic=new Array();\n");

	rs=st.executeQuery("select * from subtopic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");
	int i=0;
	while (rs.next()) {
		out.println("topic["+i+"]=new Array('"+rs.getString("topic_id")+"','"+rs.getString("subtopic_id")+"','"+rs.getString("subtopic_des")+"');\n"); 
		i++;
	}
	out.println("</script>\n");
}catch(SQLException e){
	ExceptionsFile.postException("CreateWork.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
	System.out.println("The Error: SQL - "+e.getMessage());
	try{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
		
	}catch(SQLException se){
		ExceptionsFile.postException("CreateWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println(se.getMessage());
	}
}catch(Exception e){
		ExceptionsFile.postException("CreateWork.jsp","operations on database","Exception",e.getMessage());
}
%>

<script language="javascript">
	
var flag;
	function ltrim ( s ){
		return s.replace( /^\s*/, "" );
	}
	function rtrim ( s ){	
		return s.replace( /\s*$/, "" );
	}
	function trim ( s ){
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

function dateConvert(){
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

function checkNum(keyCode){
   if(keyCode==8 || keyCode==13)
		return true;
	if(keyCode<48 || keyCode>57){
		alert("Please enter numbers only");
		return false;
	}
	return true;
}

function show_key(the_form){
	var the_key="0123456789";
	var the_value=the_form.value;
	var the_char;
	var len=the_value.length;
	for(var i=0;i<len;i++){
		the_char=the_value.charAt(i);
		if(the_key.indexOf(the_char)==-1) {
			alert("Please enter numbers only");
			the_form.focus();
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
	var toDay;
	if(isValidDate(dd,mm,yy)==true){
		var dob=new Date(yy.value,mm.value,dd.value);
		var to=new Date();
		if(navigator.appName=="Netscape")
			toDay=new Date(to.getYear()+1900,to.getMonth(),to.getDate());
		else
			toDay=new Date(to.getYear(),to.getMonth(),to.getDate());
	}
	else
		return false;
}

function validate(){
	
var win=window.document.create;
	if(trim(win.docname.value)=="")	{
		alert("Please enter the document name");
		window.document.create.docname.focus();
		return false;
	}
	
	if(trim(win.totmarks.value)==""){
		alert("Please enter maximum points");
		window.document.create.totmarks.focus();
		return false;
	}else {
		if(win.totmarks.value<1){
			alert("Maximum points should be greater than zero");
			window.document.create.totmarks.focus();
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


	/*if(validateDate(win.fdate,win.fmonth,win.fyear)==false)
		return false;

	if(win.date.value!="" || win.month.value!="" || win.year.value!="")
		if(validateDate(win.date,win.month,win.year)==false)
			return false;
	*/
	if(trim(win.workdoc.value)=="" && trim(win.perdoc.value)=="" && trim(win.editorfile.value)==""){
		alert("Please select any document");
		win.workdoc.focus();
		return false;
	}

	if((trim(win.workdoc.value)!="" && trim(win.perdoc.value)!="")||(trim(win.workdoc.value)!="" && trim(win.editorfile.value)!="")||(trim(win.editorfile.value)!="" && trim(win.perdoc.value)!="")){
		alert("You cannot select more than one document at a time");
		win.workdoc.focus();
		return false;
	}

	dateConvert();
	replacequotes();
}

function cleardata(){
	document.create.reset();
	addOptions();
	return false;
}

function getsubids(id){
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

		frm.maxattempts.value=1;
		//frm.month.value=


		frm.fmonth.value=date.getMonth();
		frm.fyear.value=date.getYear();
		if(navigator.appName=="Netscape")
			frm.fyear.value=date.getYear()+1900;
		frm.fdate.value=date.getDate();
		frm.month.value="<%=mm%>";
		frm.year.value="<%=year%>";
		frm.date.value="<%=dd%>";
		return false;
	}
function openEditor(session,classid,courseid,workid)
{
	
    var win=window.document.create;
	if (trim(document.create.workdoc.value)!="" || trim(document.create.perdoc.value)!=""){
			alert("You can select only one document at a time");
			return false;
	}
	if(flag==true){
		
		var win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid="+workid+"&classid="+classid+"&courseid="+courseid+"&topicid="+win.topicid+"&subtopicid="+win.subtopicid+"&qtype=51&pathname=<%=cat%>/"+workid,"qed_win","width=875,height=525,scrollbars=yes");
		
	}else {
		
		var win=window.open("/LBCOM/qeditor/fetchQuestion.jsp?qid=new&classid="+classid+"&courseid="+courseid+"&topicid="+win.topicid+"&subtopicid="+win.subtopicid+"&qtype=51&pathname=<%=cat%>/"+workid,"qed_win","width=875,height=525,scrollbars=yes");
		document.create.editorfile.value=workid+".html";		
	}	
	win.focus();
}

   </script>

<BODY onload=" return addOptions();">

<!--<form name='create' enctype="multipart/form-data" action="/LBCOM/coursemgmt.AddWork?mode=add&categoryid=<%=cat%>" method="POST" onsubmit="return validate();"  >-->
<form name='create' enctype="multipart/form-data" action="/LBCOM/coursemgmt.AddWork?mode=add&categoryid=<%=cat%>" method="POST" onsubmit="return validate();" >
<input type='hidden' name=lastdate>
<input type='hidden' name=fromdate>

<input type='hidden' name='workid' value='<%= workId %>'>

<table border="0" width="100%" height="100%" cellspacing="0">
    <tr>
      <td width="100%">
        <div align="center">
  <table border="0" width="65%" bgcolor="#C5CDE2" cellspacing="0" bordercolorlight="#FFFFFF" height="262" cellpadding="0">
    
    
	<tr>
      <td width="107%" height="23" align="right" bgcolor="#FFFFFF" colspan="3">
        <p align="left"><img border="0" src="../images/createtab.gif" width="151" height="28"> </td>
    </tr>
    
    
	<tr>
      <td width="107%" height="23" align="right" bgcolor="#FFFFFF" colspan="3">
        <p align="left"><img border="0" src="../images/studentslistheader.gif" width="597" height="25"> </td>
    </tr>
    
    
	<tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Document Name&nbsp;</font> </td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial">
      <input type='text' name='docname' maxlength='15'  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)" size="20">
        </font>
      </td>
    </tr>
	<tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Topic&nbsp;</font> </td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial"><select id="topic_id" name="topicid" onchange="getsubids(this.value);">
	  <option value="" selected>Select</option>
	<%
	try{
		
		rs=st.executeQuery("select * from topic_master where course_id='"+courseId+"' and school_id='"+schoolId+"'");	
		while (rs.next()) {
		out.println("<option value='"+rs.getString("topic_id")+"'>"+rs.getString("topic_des")+"</option>");
		
	  }
	}catch(Exception e){
		ExceptionsFile.postException("CreateWork.jsp","operations on resultset","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CreateWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
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
	  <option value="" selected>Select</option></select>	
        </font>
      </td>
    </tr>
    <tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Maximum Points&nbsp;</font> </td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial">
      <input type="text" name="totmarks" value=""     oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return NumbersOnly(this, event)" size="20" >
        </font>
      </td>
    </tr>
    <tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Maximum Attempts&nbsp;</font> </td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial">
	  <select size='1' name='maxattempts'>
	  </select>
        </font>
      </td>
    </tr>
    <tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Marking Scheme&nbsp;</font> </td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial"><input type="radio" name="markscheme" value="0" checked>Best  <input type="radio" name="markscheme" value="1">Last
	  <input type="radio" name="markscheme" value="2">Average
        </font>
      </td>
    </tr>
	<tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Make Available From</font></td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial">
	  
	  <select size='1' name='fmonth'></select>
	  <select size='1' name='fdate'></select>
	  <select size='1' name='fyear'></select>
	  </font> <font face="Arial" size=3 color="red">*</font></td>
    </tr>
    <tr>
      <td width="36%" height="23" align="right" bgcolor="#FFFFFF"><font size="2" face="Arial">Last Date to Submit</font></td>
      <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" height="23" bgcolor="#FFFFFF"><font size="2" face="Arial">
	
	  <select size='1' name='month'></select>
	  <select size='1' name='date'></select>
	  <select size='1' name='year'></select>
	  </font></td>
    </tr>

	<tr>
      <td width="36%" rowspan="3" valign="middle" align="right" bgcolor="#FFFFFF"><font face="Arial" size="2">Work Document</font></td>
	  <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
      <td width="68%" bgcolor="#FFFFFF">
      <input type="file" name="workdoc" size="20"></td>
    </tr>
    <tr>
	<td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
     <td width="68%" bgcolor="#FFFFFF"><input type="text" name="perdoc" value="" readonly size="20">
       <input type="button" value="Personal Docs"   name="getfile" onclick="return openwin();"></td>
    </tr>
	<tr>
	<td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial">:</font></b></td>
     <td width="68%" bgcolor="#FFFFFF"><input type="text" name="editorfile" value="" size="20" readonly>
       <input type="button" value="HTML Editor"   name="editfile" onclick="return openEditor('<%=s%>','<%=classId%>','<%=courseId%>','<%=workId %>');"></td>
    </tr>
    <tr>
      <td width="36%" align="right" bgcolor="#FFFFFF"><font face="Arial" size="2">Instructions</font></td>
	  <td width="3%" height="23" align="center" bgcolor="#FFFFFF"><b><font size="2" face="Arial" bgcolor="#FFFFFF">:</font></b></td>
      <td width="68%" bgcolor="#FFFFFF"><font size="2" face="Arial"><textarea name="comments" rows='3' cols="35" maxlength=250></textarea></td>
    </tr>

    <tr>
      <td width="100%" colspan="3" height="15" bgcolor="#FFFFFF"><img border="0" src="../images/studentslistfooter.gif" width="600" height="25"></td>
    </tr>
    <tr>
      <td width="100%" colspan="3" height="44" bgcolor="#FFFFFF">
        <p align="center"><center><font size="2" face="Arial"><input type=image src="../images/submit.gif" width="88" height="33">
		<input type="image" onClick="return cleardata()" src="../images/reset.gif"></font></center></p>
      </td>
    </tr>
  </table>
</div>
</td></tr></table>
</form>

</BODY>

</HTML>