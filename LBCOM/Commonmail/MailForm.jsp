<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript" src="../validationscripts.js">
</SCRIPT>
<script>
function checkfields()
{
	if(window.document.mailform.to.value==""){
		alert("Enter Email Address");
		window.document.mailform.to.focus();
		return false;
	}
	else if(isValidEmail(window.document.mailform.to.value)==false){
		window.document.mailform.to.focus();
		return false;
	}		
	if(window.document.mailform.subject.value==""){
		alert("Enter subject to the mail");
		window.document.mailform.subject.focus();
		return false;
	}
	if(window.document.mailform.body.value==""){
		alert("Enter message");
		window.document.mailform.body.focus();
		return false;
	}
}
</script>

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%@ page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String userid="",schoolid="",senderid="",category="",tablecolor="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%
try{
	session = request.getSession(true);
	category=request.getParameter("r1");
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	con = con1.getConnection();
	st=con.createStatement();

	if(category.equals("student")){
		userid = (String)session.getAttribute("emailid");
		schoolid = (String)session.getAttribute("schoolid");
		rs = st.executeQuery("select con_emailid from studentprofile where username='"+userid+"' and schoolid='"+schoolid+"'");
		if(rs.next())
			senderid=rs.getString(1);
	}
	else if(category.equals("teacher")){
		userid=request.getParameter("userid");
		schoolid=request.getParameter("schoolid");
		rs = st.executeQuery("select con_emailid from teachprofile where username='"+userid+"' and schoolid='"+schoolid+"'");
		if(rs.next())
			senderid=rs.getString(1);
	}
	else if(category.equalsIgnoreCase("admin")){
		userid=request.getParameter("userid");
		schoolid=request.getParameter("schoolid");
		rs = st.executeQuery("select emailid from school_profile where schoolid='"+schoolid+"'");
		if(rs.next())
			senderid=rs.getString(1);
	}

	if(category.equals("student"))
		tablecolor="#CFBEA0";
	else if(category.equals("teacher"))
		tablecolor="#40A0E0";
	else
		tablecolor="#F0B850";
}
catch(Exception e){
	out.println(e);

}
finally{
	try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("MailForm.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
}
%>
</head>
<body>

<form method="post" enctype="multipart/form-data" onSubmit="return checkfields();" name="mailform" action="/LBCOM/Commonmail.SendMail" ><BR>
  <div align="center">
    <center>
<table border="0" width="60%" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="<%= tablecolor %>" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="90%">
    <tr bgcolor="#FFFFFF"> 
      <td width="386" colspan="2" style="border-top-width:1; border-left-width:1; border-top-color:black; border-left-color:black; border-top-style:solid; border-left-style:solid;"><img src="images/Mail_<%= category %>.gif" border="0"></td>
                    <td style="border-top-width:1; border-right-width:1; border-top-color:black; border-right-color:black; border-top-style:solid; border-right-style:solid;">&nbsp;</td>
    </tr>
   <tr>
    <td width="25%" style="border-left-width:1; border-left-color:black; border-left-style:solid;"><b><font size="2" face="verdana">From</font></b></td>
    <td width="75%"><input type="text" name="from" size="20" ></td>
                    <td style="border-right-width:1; border-right-color:black; border-right-style:solid;">&nbsp;</td>
  </tr>
   <tr>
    <td width="25%" style="border-left-width:1; border-left-color:black; border-left-style:solid;"><b><font size="2" face="verdana">To</font></b></td>
    <td width="75%"><input type="text" name="to" size="20" ></td>
                    <td style="border-right-width:1; border-right-color:black; border-right-style:solid;">&nbsp;</td>
  </tr>
<tr>
<td width="25%" style="border-left-width:1; border-left-color:black; border-left-style:solid;"><b><font size="2" face="verdana">Subject</font></b></td>
<td width="75%"><input type="text" name="subject" size="20">
</td>
                    <td style="border-right-width:1; border-right-color:black; border-right-style:solid;">&nbsp;</td>
</tr>
<tr>
<td width="25%" style="border-left-width:1; border-left-color:black; border-left-style:solid;">
<font face="Verdana" size="2"><b>Attachment&nbsp;&nbsp;&nbsp;</b></font></td>
<td width="75%">
<!--<font size="2" face="Verdana" color="#CFBEA0"><b><img style=cursor:hand; TITLE="Add attachment" src="images/Attach_<%= category %>.gif" border="0" onClick="return getAttachment();"></b></font>-->
<input type='file' name='attach' size="35">
</td>
                    <td style="border-right-width:1; border-right-color:black; border-right-style:solid;">&nbsp;</td>
</tr>
<tr>
<td width="386" colspan="2" style="border-left-width:1; border-left-color:black; border-left-style:solid;">
<font size="2" face="verdana"><b>Message</b></font></td>
                    <td style="border-right-width:1; border-right-color:black; border-right-style:solid;">&nbsp;</td>
</tr>
<tr>
<td width="386" colspan="2" style="border-left-width:1; border-left-color:black; border-left-style:solid;"><p align="center"><textarea rows="11" cols="65" name="body" style="font-family:Verdana;"></textarea>
</td>
                    <td style="border-right-width:1; border-right-color:black; border-right-style:solid;">&nbsp;</td>
</tr>
<tr>
<td colspan="3" align='center' style="border-right-width:1; border-bottom-width:1; border-left-width:1; border-right-color:black; border-bottom-color:black; border-left-color:black; border-right-style:solid; border-bottom-style:solid; border-left-style:solid;">
<input type="image"  src="images/Send_<%= category %>.gif" border="0">
</td>
</tr>
</table>
    </center>
  </div>
<input type="hidden" name="from" value="<%= senderid %>">
<input type="hidden" name="category" value="<%= category %>">
<input type="hidden" name="user" value="<%= userid %>">
</form>
&nbsp;
</body>
</html>