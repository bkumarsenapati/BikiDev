<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title></title>
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<script language="JavaScript" type="text/javascript" src="wysiwyg/2wysiwyg.js"></script>
<script language = javascript>
/*function Validate()
{

if(document.PostReply.message.value=="")
{
	alert("Please dont Leave any field Blank!");
	//alert("Please exit html editor");
	return false;
}
replacequotes();
return true;
}*/
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth=0 marginheight=0>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String emailid="",schoolid="",dir="",topic1="",forumid="",ruser="",posteddate="";
%>
<% 
dir = request.getParameter("dir");
schoolid = request.getParameter("sid");
ruser = request.getParameter("user");
posteddate = request.getParameter("postdate");
topic1=request.getParameter("topic");
forumid=request.getParameter("fid");
emailid=(String)session.getAttribute("emailid");
//schoolid=(String)session.getAttribute("schoolid");
String str1=topic1.replaceAll("\"","&quot;");
%>

<FORM action="/LBCOM/forums.SaveNewForum?sid=<%=schoolid%>&fid=<%=forumid%>&topic=<%=topic1%>&user=<%=ruser%>&postdate=<%= posteddate %>&dir=<%= dir %>&type=2" METHOD="POST" enctype="multipart/form-data" NAME="PostReply" onSubmit = "return Validate();" >


  <table border="0" cellPadding="0" cellSpacing="0" width="100%" align=center>
  <tr>
	<td align=left bgColor="#F0E0A0" width="25%"> <font color="#000000" face="Arial" size="2"><a href="ForumManagement.jsp?emailid=<%= emailid %>&schoolid=<%= schoolid %>" style="COLOR: #000000; TEXT-DECORATION: none"><b>Forum Management&nbsp;</b></a></font></td>
	<td align=right bgColor="#F0E0A0" width="75%" colspan="2"> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;</font></td>
  </tr>
    <tr> 
      <td bgColor="#F0B850" width="30%" align=center> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">School:</font><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;<%= schoolid %></font></b></font> 
      </td>
      <td bgColor="#F0B850" width="35%" align=center><font color="#000080" size="2" face="Arial"><b><font color="#000000">Forum:&nbsp;<%= dir %></font></b></font></td>
      <td bgColor="#F0B850" width="35%" align=left><font size="2" face="Arial"><b><font color="#000000">Thread:&nbsp;<%= topic1 %></font></b></font></td>
	</tr>
	<tr>
     <td bgColor="#FFFFFF" vAlign="top" width="20%"><font color="#800000" face="Arial" size="2"><b>Note</b></font></td>
      <td bgColor="#FFFFFF" vAlign="top" width="80%"><font color="#800000" face="Arial" size="2"> 
        <!--<li>Would you like to reply or add your comments?</li>-->
        <li>Authorized users can post a reply to this topic.</li>
        <li>All comments are monitored for appropriateness.</li>
        </font></td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0"><b><font color="#000000" face="Arial" size="2">User 
        Name:</font></b></td>
      <td bgColor="#F0E0A0" colspan="2"><font size="2" face="Arial"><b><%= emailid %></b></font></td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0" noWrap vAlign="top"><b><font color="#000000" face="Arial" size="2">Reply:</font></b>
      <td bgColor="#F0E0A0" colspan="2"><font size="2" face="Arial"> 
        <textarea cols="45" name="message" rows="10" wrap="VIRTUAL"></textarea>
		<script language="JavaScript">
			generate_wysiwyg('message');
		 </script>
        </font></td>
    </tr>
	<tr>
	<td bgColor="#F0E0A0" align="left">&nbsp;</td>
      <td  colspan="2" height="27" bgcolor="#C0C0C0" align="right">&nbsp;<font face="arial" size="2">Attachment:<input type="file" name="forumattachfile" size="20"></font></td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0" noWrap vAlign="top">&nbsp;</td>
      <td bgColor="#F0E0A0" colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td bgColor="#F0E0A0" align=right> 
        &nbsp;
      </td>
      <td bgColor="#F0E0A0" align=left colspan="2"> 
        <input type="submit" value="Submit"><input type="reset" value="Clear">
      </td>
    </tr>
    <tr> 
      <td bgColor="#F0B850" noWrap vAlign="top">&nbsp;</td>
      <td bgColor="#F0B850" colspan="2">&nbsp;</td>
    </tr>
  </table>
  <input type=text name="topic"  style="visibility:hidden"value="<%= str1 %>">
</form>
</body>
</html>
