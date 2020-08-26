<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<title></title>
<script language="javascript" src="../validationscripts.js"></script>
<script language="JavaScript" type="text/javascript" src="wysiwyg/2wysiwyg.js"></script>
<script language = javascript>
/*function Validate()
{
if(document.PostReply.message.value=="")
{
alert("Please dont' leave any field blank");return false;}
replacequotes();
return true;
}*/
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth=0 marginheight=0>
<%
	String emailid=null,schoolid=null,sId=null,dir=null,topic=null,forumid=null,puser="";
	String ruser="",posteddate="",sno="";
	String crtby="",topiccount="",replydate="",desc="",rdate="",utype="",replycount="",auser="";
%>
<% 
String sessid=(String)session.getAttribute("sessid");
if(sessid==null){
	out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	return;
}
dir = request.getParameter("fname");
auser = request.getParameter("user");
puser = request.getParameter("puser");
posteddate = request.getParameter("postdate");
topic=request.getParameter("topic");
topic=topic.replaceAll("\"","&#34;");
topic=topic.replaceAll("\'","&#39;");

sId=request.getParameter("sid");
forumid=request.getParameter("fid");
emailid=(String)session.getAttribute("emailid");
schoolid=(String)session.getAttribute("schoolid");

crtby=request.getParameter("crtby");
	utype=request.getParameter("utype");
	topiccount=request.getParameter("topiccount");
	replycount=request.getParameter("replycount");
	ruser=request.getParameter("ruser");
	replydate=request.getParameter("replydate");
	desc=request.getParameter("desc");
	sno=request.getParameter("sno");
%>

<FORM action="/LBCOM/forums.StudentReplyForum?sno=<%=sno%>&sid=<%=schoolid%>&fid=<%=forumid%>&topic=<%=topic%>&user=<%=auser%>&puser=<%=puser%>&postdate=<%= posteddate %>&dir=<%= dir %>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&type=2" METHOD="POST" enctype="multipart/form-data" NAME="PostReply" onSubmit = "return Validate();" >

<input type=hidden name="topic" value="<%= topic %>"  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)">

<b>
		<font color="#660033" face="Verdana" size=1>Date:&nbsp;<%=new java.util.Date()%>
</b><BR><BR>

<table border="0" cellPadding="0" cellSpacing="0" width="100%" align=center>
  <tr height="20">
	<td align="left" bgColor="#dcdcde" width="25%"> <font color="#000000" face="Arial" size="2"><a href="/LBCOM/studentAdmin/Forums/ShowDirTopics.jsp?emailid=<%=emailid%>&schoolid=<%=schoolid%>&mode=findex" style="COLOR: #5468789; TEXT-DECORATION: none"><b>&nbsp;&nbsp;Forum Index&nbsp;</b></a></font></td>
	<td align="right" bgColor="#dcdcde" width="35%"> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;</font></td>
	<td align="right" bgColor="#dcdcde" width="40%"> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;</font></td>
  </tr>
    <tr> 
      <td bgColor="#546878" width="25%" align=left> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">&nbsp;School:</font><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">&nbsp;<%= schoolid %></font></b></font> 
      </td>
      <td bgColor="#546878" width="35%" align=left><font color="#000080" size="2" face="Arial"><b><font color="#FFFFFF">Forum:&nbsp;<%= dir %></font></b></font></td>
      <td bgColor="#546878" width="40%" align=left><font size="2" face="Arial"><b><font color="#FFFFFF">Topic:&nbsp;<%= topic %></font></b></font></td>
	</tr>
	 <tr> 
      <td bgColor="#FFFFFF" vAlign="top" width="25%"><font color="#800000" face="Arial" size="2"><b>Note</b></font></td>
      <td bgColor="#FFFFFF" vAlign="top" width="40%"><font color="#800000" face="Arial" size="2"> 
        <li>Authorized users can post a reply to this topic.</li>
        <br>
        <li>All comments are monitored for appropriateness.</li>
        </font></td>
		<td align=right bgColor="#FFFFFF" width="35%"> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;</font></td>
    </tr>
	</table>

	<table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#546878" bordercolordark="#546878" bordercolorlight="#546878">
    <tr>
        <td width="468" bgcolor="#546878" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Post a Reply</b></span></font></p>
        </td>
        <td width="468" height="24" bgcolor="#546878">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" valign="top" height="25" colspan="2">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="3" height="12">
                <tr>
                    <td width="930" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="12" align="left">
                        <table align="center" border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#546878" bordercolordark="#546878" bordercolorlight="#546878" height="61">
                            <tr>
                                <td width="68" align="left" valign="top">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b>Subject</b></span></font></p>
                                </td>
                                <td width="846" align="left" valign="top">
								<INPUT type="text" maxLength="100" size=120 name="emailid" value="Re: <%=topic%>" name="subject" readonly>                 
                                </td>
                            </tr>
                            <tr>
                                <td width="68" valign="top" align="left">
                                    <p align="left"><font face="Arial"><span style="font-size:10pt;"><b>Reply</b></span></font></p>
                                </td>
                                <td width="846" valign="top">
                                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                        
                                        <tr>
                                            <td width="100%" colspan="2">
                                                <font size="2" face="Arial"> 
        <textarea cols="45" name="message" rows="10" wrap="VIRTUAL"></textarea>
		<script language="JavaScript">
			generate_wysiwyg('message');
		 </script>
        </font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="751" height="43">
                                                <p align="center"><FONT face=arial size=2>Attachment:<INPUT type=file name=forumattachfile></FONT></p>
                                            </td>
                                            <td width="396" height="43">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="751"> 
                                                <p align="center">&nbsp;<input type="submit" value="Submit"><input type="reset" value="Cancel" onclick="javascript: history.go(-1);"></p>
                                            </td>
                                            <td width="396">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="100%" colspan="2">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

  </table>
</form>
</body>
</html>
