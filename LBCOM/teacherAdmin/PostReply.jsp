<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title></title>
<script language="javascript" src="../validationscripts.js"></script>
<script language = javascript>
function Validate()
{
if(document.PostReply.message.value=="")
{
alert("Please dont' leave any field blank");return false;} 
replacequotes();
return true;
}

</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth=0 marginheight=0>
<%  
	String emailid="",schoolid="",dir="",topic="",forumid="";
%>

<%
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	dir=request.getParameter("fname");
	topic=request.getParameter("topic");
	forumid=request.getParameter("fid");
	emailid=(String)session.getAttribute("emailid");
	schoolid=(String)session.getAttribute("schoolid");
%>

<FORM action="/LBCOM/forums.SaveForum?sid=<%=schoolid%>&fid=<%=forumid%>&fname=<%=dir%>&type=2" METHOD="POST" NAME="PostReply" onSubmit = "return Validate();" >
<input type=hidden name="topic" value="<%= topic %>">

  <table border="0" cellPadding="0" cellSpacing="0" width="100%" align=center>
  <tr>
	<td align=left bgColor="#A8B8D0" width="25%"> <font color="#000000" face="Arial" size="2"><a href="ShowDirTopics.jsp?emailid=<%= emailid %>&schoolid=<%= schoolid %>" style="COLOR: #000000; TEXT-DECORATION: none"><b>Forums&nbsp;</b></a></font></td>
	<td align=right bgColor="#A8B8D0" width="75%" colspan="2"> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;</font></td>
  </tr>
    <tr> 
      <td bgColor="#40A0E0" width="30%" align=center> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">School:</font><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;<%= schoolid %></font></b></font> 
      </td>
      <td bgColor="#40A0E0" width="35%" align=center><font color="#000080" size="2" face="Arial"><b><font color="#000000">Forum:&nbsp;<%= dir %></font></b></font></td>
      <td bgColor="#40A0E0" width="35%" align=center><font size="2" face="Arial"><b><font color="#000000">Topic:&nbsp;<%= topic %></font></b></font></td>
	</tr>
	<tr>
      <td bgColor="#40A0E0" valign=top width="25%"><font size="1" face="Verdana" color="#800000">Would you 
        like to reply or add your comments?</font></td>
      <td bgColor="#40A0E0" valign=top width="75%" colspan="2"><font size="1" face="Verdana" color="#800000">Any authorized 
        user may post a reply to this topic. All comments are monitored for appropriateness.</font> 
      </td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0"><b><font color="#000000" face="Arial" size="2">User 
        Name:</font></b></td>
      <td bgColor="#A8B8D0" colspan="2"><font size="2" face="Arial"><b><%= emailid %></b></font></td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0" noWrap vAlign="top"><b><font color="#000000" face="Arial" size="2">Reply:</font></b> 
      <td bgColor="#A8B8D0" colspan="2"><font size="2" face="Arial"> 
        <textarea cols="45" name="message" rows="10" wrap="VIRTUAL"></textarea>
        </font></td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0" noWrap vAlign="top">&nbsp;</td>
      <td bgColor="#A8B8D0" colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td bgColor="#A8B8D0" align=right> 
        &nbsp;
      </td>
      <td bgColor="#A8B8D0" align=left colspan="2"> 
        <input type="submit" value="Submit"><input type="reset" value="Clear">
      </td>
    </tr>
    <tr> 
      <td bgColor="#40A0E0" noWrap vAlign="top">&nbsp;</td>
      <td bgColor="#40A0E0" colspan="2">&nbsp;</td>
    </tr>
  </table>
</form>
</body>
</html>
