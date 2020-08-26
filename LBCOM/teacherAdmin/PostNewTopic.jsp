<html>
<head><title></title>
<script language="javascript" src="../validationscripts.js"></script>
<script language = javascript>
function Validate(){
if((document.PostNewTopic.topic.value=="") || (document.PostNewTopic.message.value=="") || (document.PostNewTopic.dir.value=="noval")){
alert("Please dont Leave any field Blank!");return false;} replacequotes();
return true;}</script>
</head>
<body bgColor="#FFFFFF" topmargin="0" leftmargin="0">
<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	 String user="";
     Connection con=null;
     ResultSet rs=null,rs1=null;
     Statement st=null;
     String dir="",type=" ",topic="",schoolid="",emailid="",forumid="";

%>
<%
String sessid=(String)session.getAttribute("sessid");
if(sessid==null){
	out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	return;
}
	try{
		forumid=request.getParameter("fid");
		schoolid=(String)session.getAttribute("schoolid");
		emailid = (String)session.getAttribute("emailid");
		user = emailid;
		dir = request.getParameter("fname");
	}
    catch(Exception ex){
		ExceptionsFile.postException("PostNewTopic.jsp","reading parameters","Exception",ex.getMessage());
		out.println(ex+" its first");
	}
%>
<!--<form action="../teacherAdmin/AcceptTopic.jsp?emailid=<%=emailid%>&schoolid=<%=schoolid%>&dir=<%= dir %>" method="post" name="PostNewTopic" onsubmit="return Validate();">-->
<form action="/LBCOM/forums.SaveForum?sid=<%=schoolid%>&fid=<%=forumid%>&fname=<%=dir%>&type=1" method="post" name="PostNewTopic" onsubmit="return Validate();">
<table align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
    <tr>
      <td bgColor="#A8B8D0" align=left width="100%"><font color="#000000" face="Arial" size="2"><a href="ShowDirTopics.jsp?emailid=<%= user %>&schoolid=<%= schoolid %>" style="COLOR: #000000; TEXT-DECORATION: none"><b>Forums&nbsp;</b></a></font></td>
 <!--    <td bgColor="#A8B8D0" align=right width="25%"><font color="#000000" face="Arial" size="2"><a href="../teacherAdmin/ShowTopics.jsp?emailid=<%=user%>&schoolid=<%=schoolid%>&dir=<%= dir %>" style="COLOR: #000000; TEXT-DECORATION: none"><b>Back</b></a></font></td>-->
    </tr>
  </table>
  <table align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
    <tr> 
      <td bgColor="#40A0E0" vAlign="top" width="20%"><font color="#000000" face="Arial" size="2"><b>Note</b></font></td>
      <td bgColor="#40A0E0" vAlign="top" width="80%"><font color="#000000" face="Arial" size="2"> 
        <li>Would you like to reply or add your comments?</li>
        <br>
        <li>Authorized users can post a reply to this topic.</li>
        <br>
        <li>All comments are monitored for appropriateness.</li>
        </font></td>
    </tr>
<!--    <tr> 
      <td bgColor="#A8B8D0">&nbsp;</td>
      <td bgColor="#A8B8D0">&nbsp;</td>
    </tr>-->
    <tr> 
      <td bgColor="#A8B8D0"><b><font color="#000000" face="Arial" size="2">User 
        Name:</font></b></td>
      <td bgColor="#A8B8D0"><font color="#000000" face="Arial" size="2"><b><%= user %></b></font></td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0" noWrap><b><font color="#000000" face="Arial" size="2">Forum:</font></b></td>
      <td bgColor="#A8B8D0"> 
	       <b><font color="#000000" face="Arial" size="2"><%=dir%></font></b>
      </td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0" noWrap><b><font color="#000000" face="Arial" size="2">Topic:</font></b></td>
      <td bgColor="#A8B8D0"> 
        <input maxLength="85" name="topic" size="53"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">
      </td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0" noWrap vAlign="top"><b><font color="#000000" face="Arial" size="2">Message:</font></b> 
      <td bgColor="#A8B8D0"> 
        <textarea cols="45" name="message" rows="10" wrap="VIRTUAL"></textarea>
      </td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0">&nbsp;</td>
      <td bgColor="#A8B8D0">&nbsp;</td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0">
        <div align="right">
          &nbsp;
        </div>
      </td>
      <td bgColor="#A8B8D0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" value="Submit"><input type="reset" value="Clear"></td>
    </tr>
   	<tr> 
      <td bgColor="#40A0E0" colspan=2 vAlign="top">&nbsp;</td>
    </tr>
  </table>
  </form>
</body>
</html>
