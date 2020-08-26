<%@page import="java.io.*,java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%!
	String      month[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
%>
<%

	String		courseId="",sessid="",examType="",mode="",examId="",fromDate="",toDate="",mm="",dd="",yyyy="",hh="",min="";
	String		examName="",examInstructions="",qidList="",fromTime="",toTime="",schoolId="",createdDate="",tblName="",enableMode="";
	

	StringTokenizer stk=null;
	Connection con=null;
	Statement st=null;
	ResultSet   rs=null;
	int enable=0,pasword=0,maxAttempts=0,grading=0,noOfGrps=0,status=0;
	byte flag=0,durMins=0,durHrs=0,shortType=0;

%>

<%
	try{
		
		//checking For session is valid or not
		session=request.getSession();
		examId=null;
		sessid=(String)session.getAttribute("sessid");
		if(sessid==null) {
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	    }
		schoolId=(String)session.getAttribute("schoolid");
		examType=request.getParameter("examtype");	
		mode=request.getParameter("mode");
		courseId=(String)session.getAttribute("courseid");
		
		enableMode=request.getParameter("enableMode");


		
		session.removeValue("qidlist");
		session.removeValue("groupDetails");
		session.removeValue("totQts");
		
		con=db.getConnection();
		st=con.createStatement();

	    if (enableMode.equals("0"))
			tblName="exam_tbl";
		else
			tblName="exam_tbl_tmp";
		
		if (mode.equals("create")){
			durMins=0;
			durHrs=0;
			examName="";
			examInstructions="";
			createdDate="0000-00-00";		
		}
        		
		if (mode.equals("edit") || mode.equals("exist")){
			examId=request.getParameter("examid");
			String dbString="";
			if(mode.equals("exist")){
				dbString="select exam_name,no_of_groups,instructions,dur_hrs,dur_min,status from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'";
			}else{
				dbString="select status,exam_name,no_of_groups,instructions,dur_hrs,dur_min from "+tblName+" where exam_id='"+examId+"' and school_id='"+schoolId+"'";
			}
			
			
			rs=st.executeQuery(dbString);


			if(rs.next()){
				examName=rs.getString("exam_name");
				examInstructions=rs.getString("instructions");
				durMins=Byte.parseByte(rs.getString("dur_min"));
//**				createdDate=rs.getString("create_date");
				durHrs=Byte.parseByte(rs.getString("dur_hrs"));
				noOfGrps=rs.getInt("no_of_groups");
				status=rs.getInt("status");
		    }
			rs.close();

		}

		rs=st.executeQuery("select * from category_item_master where category_type='EX' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");

//**		rs=st.executeQuery("select * from category_item_master where category_type='"+examType+"' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");

	}catch(SQLException e){
			ExceptionsFile.postException("CreateExamt.jsp","operations on database","SQLException",e.getMessage());
			
	
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}catch(SQLException se){
				ExceptionsFile.postException("CreateExam.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				
			}

    
	}catch(NullPointerException ne){
		ExceptionsFile.postException("CreateExam.jsp","operations on database","NullPointerException",ne.getMessage());	
		
	}
	catch(Exception e){
		 ExceptionsFile.postException("CreateExam.jsp","operations on database","Exception",e.getMessage());	
		 
	}
%>

<html>
<head>
<title></title>
<!--<META HTTP-EQUIV="Pragma" CONTENT="no-cache, must-revalidate>" 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate">
<META HTTP-EQUIV="Expires" CONTENT="0">-->
<script language="javascript" src="../validationscripts.js"></script> 

</head>
<script language="javascript">

function validData(the_key_val){//begin function validData
	var the_key;

	if(the_key_val=="")
	return false;
	if(the_key_val!="")
	for(var i=0;i<the_key_val.length;i++)	{
	the_key=the_key_val.charAt(i);
	if(!((the_key>='0' && the_key<='9') || (the_key>='A' && the_key<='Z') || (the_key==' ') ||(the_key=='_')|| (the_key>='a' && the_key<='z') || (the_key=='.') ||( the_key=="-"))){
	return false;

	}

	}
}//end function validData

function checkAllFields(){
	var win=window.document.examdetails;
	//checking for Exam name valid or not
	win.testname.value=trim(win.testname.value);

   	if(validData(trim(win.testname.value))==false){
		alert("Please enter a valid assessment name");
		window.document.examdetails.testname.focus();
		return false;
	}		
	
	window.document.examdetails.testhours.value=win.testhour.value;
	replacequotes();

	return true;
	
}



function openExam(){
	var win=window.open("ExistingExams.jsp?examType=<%=examType%>","ExistingExams",'dependent=yes,width=500,height=220, scrollbars=yes,left=175,top=200');
 	win.focus();
}

</script>

<body >


<!--<form name="examdetails" method="post" onsubmit="return checkAllFields();" action="/servlet/exam.CreateSaveExam?mode=<%=mode%>&flag=<%=flag%>&shortType=<%=shortType%>">
-->
<form name="examdetails" method="post" onsubmit="return checkAllFields();" action="/LBCOM/exam.CreateSaveExam?mode=<%=mode%>&shortType=<%=shortType%>&noofgrps=<%=noOfGrps%>">

<script>

function validData(the_key_val){//begin function validData
	var the_key;

	if(the_key_val=="")
		return false;
	if(the_key_val!="")
		for(var i=0;i<the_key_val.length;i++)	{
			the_key=the_key_val.charAt(i);
/*
			if(!((the_key>='0' && the_key<='9') || (the_key>='A' && the_key<='Z') || (the_key==' ') ||(the_key=='_')|| (the_key>='a' && the_key<='z') || (the_key=='.') ||( the_key=="-"))){
*/
			if(the_key=='"' || the_key=="'" || the_key=='`' || the_key=='#' || the_key=='&'){
				return false;
			}
		}
}//end function validData

</script>

<div align="center">
<center>
<table border="0" width="650"  cellspacing="0" bordercolor="#DFE2F4" style="border-collapse: collapse" cellpadding="0">
  <tr>
    <td  height="30" bgcolor="#FFFFFF" colspan="5" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" width="592"><img border="0" src="../coursemgmt/images/createtab.gif" width="151" height="28"></td>
  </tr>
  <tr>
    <td height="21" bgcolor="#4AA2E7" colspan="5" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" width="592">&nbsp;</td>
  </tr>
  <tr>
    <td height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" align="right">
    <font face="Arial" size="2">Assessment Type</font></td>
    <td width="4" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b>
    <font face="Arial" size="2">&nbsp;:&nbsp;</font></b></td>
    <td width="429" height="30" colspan="3" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
    <font face="Arial" size="2">
    
    <select name="examtype" onchange="parent.parent.toppanel.document.examform.examcategory.value=document.examdetails.examtype.value">
	   <%
		try{ 
			while(rs.next()) {
			    out.println("<option value='"+rs.getString("item_id")+"'>"+rs.getString("item_des")+"</option>");
			}
			rs.close();
	
       %>
		</select>
    
    
    </font></td>
  </tr>
  <tr>
    <td  height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" align="right"><font face="Arial" size="2">Assessment Name</font></td>
    <td width="4" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b><font face="Arial" size="2">&nbsp;:&nbsp;</font></b></td>
    <td width="429" height="30" colspan="3" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><font face="Arial" size="2">
	
	<input type="text" name="testname" size="20" value="<%=examName%>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">

	<input type="button" value="Browse Archived Assessment" onclick="openExam()">
    </font></td>
  </tr>
  <tr>
    <td   bgcolor="#FFFFFF" bordercolor="#DFE2F4" height="30" align="right"><font face="Arial" size="2">Assessment Instructions</font></td>
    <td width="4"  bgcolor="#FFFFFF" bordercolor="#DFE2F4" height="30"><b><font face="Arial" size="2">&nbsp;:&nbsp;</font></b></td>
    <td width="429"  colspan="3" bgcolor="#FFFFFF" bordercolor="#DFE2F4" height="30"><font face="Arial" size="2">
    <textarea rows="4" name="testinstructins" cols="48"><%=examInstructions%></textarea></font></td>
  </tr>
  <tr>
    <td  height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4" align="right"><font face="Arial" size="2">Test Duration&nbsp;</font></td>
    <td width="4" height="30" bgcolor="#FFFFFF" bordercolor="#DFE2F4"><b><font face="Arial" size="2">:&nbsp;</font></b></td>
    <td width="429" height="30" colspan="3" bgcolor="#FFFFFF" bordercolor="#DFE2F4">
    <font face="Arial" size="2">
	<select size="1" name="testhour">
	<option value="0">00</option>
    <%
			for(byte i=1;i<=10;i++){
					out.println("<option value='"+i+"'>"+i+"</option>");
			}
	%>
  </select>Hours
	<select size="1" name="testtime">
	<option value="0">00</option>
    <%
		for(byte i=5;i<=55;i+=5)
				out.println("<option value='"+i+"'>"+i+"</option>");
	%>
  </select>Mins.</font></td>
  </tr>
  <%  if (!enableMode.equals("0")){ %>
   <tr>
    <td width="648" height="34" colspan="6">
      <p align="center">&nbsp;&nbsp;&nbsp;<font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input  type="image" src="images/submit.jpg" > <input type="image" src="images/reset.jpg" value="Reset" name="Reset" onclick="document.examdetails.reset();init();return false;"></font></p>
    </td>
  </tr>
  <% } %>
</table>
</center>
</div>
<input type="hidden" name="frmDate">
<input type="hidden" name="tDate">
<input type="hidden" name="mode" value="<%=mode%>">
<input type="hidden" name="testhours">
<input type="hidden" name="pasword">
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="qidlist" value="<%=qidList%>">
<%if(examId!=null){%>
<input type="hidden" name='selExId' value='<%=examId%>'>
<%}%>
</form>
</body>
<script language='javascript'>	
	function init(){
		document.examdetails.examtype.value="<%=examType%>";
		document.examdetails.testhour.value="<%=durHrs%>";
		document.examdetails.testtime.value="<%=durMins%>";
	  }
	  init();


	<%  if (enableMode.equals("0")){ %>
		var frm=document.examdetails;
		for (var i=0; i<frm.elements.length;i++)
				frm.elements[i].disabled=true;

		<% } %>

</script>

</html>
<%
	}catch(Exception e){
		ExceptionsFile.postException("CreateExam.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
			    con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CreateExam.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}

    }

%>
