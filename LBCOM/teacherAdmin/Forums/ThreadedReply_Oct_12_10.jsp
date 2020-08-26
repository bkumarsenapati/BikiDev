<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<title></title>
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<script language="JavaScript" type="text/javascript" src="wysiwyg/2wysiwyg.js"></script>
<script language = javascript>
function showFile(attachfile,user)
{
	var x=window.open("/LBCOM/schoolAdmin/Forums/Attachments/"+user+"/"+attachfile,"Document","width=750,height=600,scrollbars");
	
	return false;
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth=0 marginheight=0>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String emailid="",userid="",schoolid="",dir="",topic="",forumid="",ruser="",posteddate="",replyid="",topicid="";
	String crtby="",topiccount="",replydate="",reply="",attachFile="",desc="",puser="",utype="",replycount="";
%>
<% 
emailid = (String)session.getAttribute("emailid");
userid = emailid;

replyid = request.getParameter("sno");
topicid = request.getParameter("topicid");
attachFile=request.getParameter("attachFile");
dir = request.getParameter("fname");
ruser = request.getParameter("ruser");
posteddate = request.getParameter("postdate");
topic=request.getParameter("topic");
topic=topic.replaceAll("\"","&#34;");
topic=topic.replaceAll("\'","&#39;");

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
	//desc=desc.replaceAll("\"","&#34;");
	//desc=desc.replaceAll("\'","&#39;");

	reply=request.getParameter("reply");

	puser=request.getParameter("auser");

String str1=topic.replaceAll("\"","&quot;");
%>

<FORM action="/LBCOM/forums.SaveNewForum?sid=<%=schoolid%>&fid=<%=forumid%>&tid=<%=replyid%>&atid=<%=topicid%>&topic=<%=topic%>&user=<%=ruser%>&postdate=<%=posteddate%>&dir=<%=dir%>&crtby=<%=crtby%>&auser=<%=puser%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&type=2" METHOD="POST" enctype="multipart/form-data" NAME="PostReply" onSubmit = "return Validate();" >

<input type=hidden name="topic"  style="visibility:hidden" value="<%= str1 %>" >

<b>
		<font color="#660033" face="Verdana" size=1>Date:&nbsp;<%=new java.util.Date()%>
</b><BR><BR>

<table border="0" cellPadding="0" cellSpacing="0" width="100%" align=center>
  <tr height="20">
	<td align=left bgColor="#A8B8D1" width="25%"> <font color="#000000" face="Arial" size="2"><a href="ForumManagement.jsp?emailid=<%= emailid %>&schoolid=<%= schoolid %>&mode=findex" style="COLOR: #54687889; TEXT-DECORATION: none"><b>&nbsp;Forum Index&nbsp;</b></a></font></td>
	<td align="left" bgColor="#A8B8D1" width="35%" colspan="2"> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;</font></td>
	<td align="left" bgColor="#A8B8D1" width="40%" colspan="2"> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#000000">&nbsp;</font></td>
  </tr>
    <tr> 
      <td bgColor="#429EDF" width="25%" align="left"> <font color="#000080"><b><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">School:</font><font face="Arial, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">&nbsp;<%= schoolid %></font></b></font> 
      </td>
      <td bgColor="#429EDF" width="35%" align="left"><font color="#000080" size="2" face="Arial"><b><font color="#FFFFFF">Forum:&nbsp;<%= dir %></font></b></font></td>
      <td bgColor="#429EDF" width="40%" align="left"><font size="2" face="Arial"><b><font color="#FFFFFF">Topic:&nbsp;<%= topic %></font></b></font></td>
	</tr>
	<tr>
     <td bgColor="#FFFFFF" width="100%" height="1" colspan="3">&nbsp;</td>
	 </tr>
	<tr>
     <td bgColor="#FFFFFF" vAlign="top" width="100%" colspan="3">

	 <table align="center" border="8" cellpadding="0" cellspacing="0" width="102%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
    <tr>
        <td width="50%" bgcolor="#429EDF" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Selected Reply for Post a New Reply</b></span></font></p>
        </td>
        <td width="50%" height="24" bgcolor="#429EDF">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" valign="top" height="25" colspan="3" width="880">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="0">
                <tr>
                    <td width="100%" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="12" align="left">
                        <table align="center" border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF" height="61">
                            <tr>
                                <td width="20%" align="left" valign="top" bgcolor="#E1E1E1">
                                    <p><font face="Arial" color="#429EDF"><span style="font-size:9pt;">on <%=replydate%></span></font></p>
                                </td>
                                <td width="40%" align="left" valign="top" bgcolor="#EEEEEE">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b><%=topic%></b></span></font></p>
                                </td>
								<td width="40%" align="left" valign="top" bgcolor="#EEEEEE">
<%
							if(userid.equals("teacher") ||  userid.equals(ruser))
							{
%>								&nbsp;
<%							}
							if(attachFile.equals("") || attachFile==null || attachFile.equals("null"))
							{
				
%>				
									&nbsp;
<%							}
							else
							{				
%>
									 &nbsp;<a href="javascript://" onclick="return showFile('<%=attachFile%>','<%=ruser%>');"><img src="../../forums/images/button_attach.gif" TITLE="Attachments" border=0 width="61" height="17"></a></font>			  
<%							}
			

%>
							</td>
                            </tr>
                            <tr>
                                <td width="20%" valign="top" align="left" bgcolor="#E1E1E1">
                                    <p align="left"><span style="font-size:10pt;"><font face="Arial" color="#429EDF">by</font></span><font face="Arial"><span style="font-size:10pt;"> </span></font><span style="font-size:10pt;"><font face="Arial" color="blue"><%=ruser%></font></span><font face="Arial"><span style="font-size:10pt;"><img src="images/icon_latest_reply.gif" width="18" height="9" border="0"><br>
</span></font></p>
                                </td>
                                <td width="80%" valign="top" bgcolor="#EEEEEE" colspan="2">
                                    <p><font face="Arial" color="#429EDF"><span style="font-size:9pt;"><%= reply%></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

	 </td>
     </tr>
	 <tr>
     <td bgColor="#FFFFFF" width="100%" height="1" colspan="3">&nbsp;</td>
	 </tr>
   </table>

   <table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
    <tr>
        <td width="468" bgcolor="#429EDF" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Post a Reply</b></span></font></p>
        </td>
        <td width="468" height="24" bgcolor="#429EDF">&nbsp;</td>
    </tr>
    <tr>
        <td align="center" valign="top" height="25" colspan="2">
            <table align="center" cellspacing="0" width="100%" bordercolordark="#E3E3E3" bordercolorlight="#E3E3E3" style="border-collapse:collapse;" cellpadding="3" height="12">
                <tr>
                    <td width="930" bgcolor="white" style="border-width:1; border-color:rgb(227,227,227); border-style:double;" height="12" align="left">
                        <table align="center" border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF" height="61">
                            <tr>
                                <td width="68" align="left" valign="top">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b>Subject</b></span></font></p>
                                </td>
                                <td width="846" align="left" valign="top">
                                   
                                        <INPUT class="inputbox autowidth" id=subject tabIndex=2 maxLength=64 size=45 
value="Re: <%=topic%>" name="subject" readonly>  
                                 
                                </td>
                            </tr>
                            <tr>
                                <td width="68" valign="top" align="left">
                                    <p align="left"><font face="Arial"><span style="font-size:10pt;"><b>Reply</b></span></font></p>
                                </td>
                                <td width="846" valign="top">
                                    <table border="0" width="100%" cellpadding="0" cellspacing="0" height="273">
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
                                                <p align="center"><FONT face=arial size=2>Attachment:<INPUT type=file name=forumattachfile size="20"></FONT></p>
                                            </td>
                                            <td width="396" height="43">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="751"> 
                                                <p align="center">&nbsp;<INPUT type=submit value=Submit>&nbsp; <INPUT type="reset" value="Cancel" onclick="javascript: history.go(-1);"></p>
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
        </td>
    </tr>
</table>
  
</form>
</body>
</html>