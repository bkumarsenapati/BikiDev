<%@page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@page import = "java.sql.*,java.util.Date,java.util.Calendar" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String mode="",oldNbName="",nbDesc="",schoolId="",courseName="",classId="",courseId="",grade="",className="",sessionId="";
	String teacherId="",crsId="",creator="";
	ResultSet  rs=null,rs1=null;
	Connection con=null;
	Statement st=null,st1=null;
%>
<%
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	grade=(String)session.getAttribute("grade");
	creator=request.getParameter("creator");
	con=con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select course_id,course_name from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+grade+"'");
%>
<HTML>
<HEAD>
<title></title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<SCRIPT LANGUAGE="JavaScript" SRC="../validationscripts.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
function isUserName(validateData){
	if(validateData==null || validateData.length==0){
			return false;
	}
	var charAta;
	for(var i=0;i<validateData.length;i++){
	charAta=validateData.charAt(i);
		if(!( (charAta>=0 && charAta<=9) || (charAta>='A' && charAta<='Z') || (charAta>='a' && charAta<='z') || (charAta=='_') || (charAta==' '))){
			alert("Enter valid Name");
			return false;
		}
	}
}

function validate(frm)
{
	frm.nbname.value=trim(frm.nbname.value);
	var title=frm.nbname.value;
	if(isUserName(title)==false){
		alert("Enter proper title.");
		frm.nbname.focus();
		return false;
	}
	frm.nbdesc.value=trim(frm.nbdesc.value);
	if(frm.nbdesc.value=="")
	{
		alert("Enter description");
		frm.nbdesc.focus();
		return false;
	}
	var temp=frm.nbdesc.value;
	if(temp.indexOf('#')!=-1){
		alert("Remove # from description");
		frm.nbdesc.focus();
		return false;
	}
	//frm.nbname.disabled=false;
	replacequotes();
}
function goback()
{
	document.location.href="NoticeBoards.jsp?creator=<%=creator%>";
	return false;
}
//-->
</SCRIPT>
</HEAD>
<%
	try
	{
		sessionId=(String)session.getAttribute("schoolid");
		mode=request.getParameter("mode");
		oldNbName=request.getParameter("oldname");
		nbDesc=request.getParameter("desc");
		String tag;
		if(mode.equals("edit"))
			tag="Edit";
		else
			tag="Create";
%>
<BODY bgcolor="white" text="black" link="blue" vlink="purple" alink="red"> 
<form name="nboard" action="/LBCOM/nboards.AddNewNoticeBoard" method="post" onsubmit="return validate(this);">
<input type='hidden' name='mode' value='<%=mode%>'>
<input type='hidden' name='creator' value='<%=creator%>'>
<input type='hidden' name='oldnbname' value='<%=oldNbName%>'>
<center>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table border="0" cellpadding="0" cellspacing="0" width="60%">
	<tr bgcolor="#A8B8D1">
		<td width="100%" colspan="3" align='center'>
			<font face="Verdana" size="2"><b><%=tag%> Notice Board</b></font>
		</td>
    </tr>
    <tr>
      <td width="100%" colspan="3">&nbsp;</td>
    </tr>
    <tr>
      <td width="40%" align="right"><font face="Arial" size="2"><b>Enter Title</b></td>
      <td width="5%" align="center"><b><font face="Arial" size="3">:</font></b></td>
      <td width="55%">
<%
		if(mode.equals("edit"))
		{	
			out.println("<input type='text' name='nbname' value=\""+oldNbName.replaceAll("\"","&quot;")+"\" oncontextmenu=\"return false\" onkeydown=\"restrictctrl(this,event)\" onkeypress=\"return AlphaNumbersOnly(this, event)\">");
		}
		else
		{
%>
			<input type='text' name='nbname' oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">
<%
		}
%>
	  </td>
    </tr>
    <tr>
		<td width="40%" align="right" valign="top">
			<font face="Arial" size="2"><b>Enter Description</b></td>
		<td width="5%" align="center" valign="top">
			<b><font face="Arial" size="3">:</font></b></td>

<%
		if(mode.equals("edit"))
		{
		    out.println("<td width='55%'><input type='text' name='nbdesc' value=\""+nbDesc.replaceAll("\"","&quot;")+"\" oncontextmenu=\"return false\" onkeydown=\"restrictctrl(this,event)\" onkeypress=\"return AlphaNumbersOnly(this, event)\"></td>");
		}
		else
		{
		    out.println("<td width='55%'><input type='text' name='nbdesc' value=\"\" oncontextmenu=\"return false\" onkeydown=\"restrictctrl(this,event)\" onkeypress=\"return AlphaNumbersOnly(this, event)\"></td>");
		}
%>
	 
    </tr>
	<!-- <tr>
		<td width="40%" align="right" valign="top">
			<font face="Arial" size="2">Select Course</td>
		<td width="5%" align="center" valign="top">
			<b><font face="Arial" size="3">:</font></b></td>
		<td width="55%" align="left" valign="top">
			<select name="classid" onchange="return showCourses();">
			<option value="none">All Courses</option>
 -->
<%
			while(rs.next())
			{
				crsId=rs.getString("course_id");
				//out.println("<option value='"+crsId+"'>"+rs.getString("course_name")+"</option>");
			}
			rs.close();
%>
		<!-- 	</select>
		</td>
	</tr>	 -->
	<tr>
		<td>&nbsp;</td>
	</tr>
    <tr>
		<td width='100%' colspan='3' align='center'>
			<input type='image' src='images/teacher_submit.jpg'>&nbsp;
			<input type='image' src='images/teacher_cancel.gif' onclick="return goback();"></td>
		</tr>
  </table>
  </center><P>
</form>
<p>&nbsp;</p>
<%
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("CreateNoticeBoard.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error in CNB.jsp:  -" + e);
	}

	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("CreateNoticeBoard.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Exception in CreateNoticeBoard.jsp is..."+se.getMessage());
		}
	}
%>
</BODY>
</HTML>
