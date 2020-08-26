<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head>
<link rel="stylesheet" type="text/css" href="Forums/css/style.css" />
<title>.::Welcome to Learnbeyond.net::.</title>
<!-- TinyMCE -->
<script type="text/javascript" src="../tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({

	// General options
		mode : "textareas",
		theme : "advanced",
		plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

		// Theme options
		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		],

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->
<script language="javascript" src="../validationscripts.js"></script>
<!-- <script language="JavaScript" type="text/javascript" src="wysiwyg/2wysiwyg.js"></script> -->
<script language = javascript>

function Validate()
{
	if((document.PostNewTopic.topic.value=="") || (document.PostNewTopic.dir.value=="noval"))
	{
		alert("Please dont Leave any field Blank!");
		return false;
	}
	replacequotes();
	return true;
}

</script>
</head>
<body bgColor="#FFFFFF" topmargin="0" leftmargin="0">
<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%  String user="";
     Connection con=null;
     ResultSet rs=null,rs1=null;
     Statement st=null,st1=null;
     String dir="",type=" ",mode="",topic="",schoolid="",emailid="",forumid="",message="";
	 String sno="",main="";
	 String crtby="",topiccount="",utype="",replycount="",views="",ruser="",desc="",mode1=null,message1="",user2="",replydate="";
%>
<% 
	try{
		con = con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		forumid=request.getParameter("fid");
		schoolid=(String)session.getAttribute("schoolid");
		emailid = (String)session.getAttribute("emailid");
		crtby=request.getParameter("crtby");
		utype=request.getParameter("utype");
		topiccount=request.getParameter("topiccount");
		replycount=request.getParameter("replycount");
		ruser=request.getParameter("ruser");
		replydate=request.getParameter("replydate");
		desc=request.getParameter("desc");
		views=request.getParameter("views");
		mode1=request.getParameter("mode");
		

		

		mode=request.getParameter("mode");
		main=request.getParameter("main");
		if(main==null||main.equals(""))
			main="no";
		else
			main=main;

		if(mode==null||mode.equals(""))
		{
			mode="";
		}
		else
		{
			if(mode.equals("edit"))
			{
			topic=request.getParameter("tid");
		
		topic=topic.replaceAll("\"","&#34;");
		topic=topic.replaceAll("\'","&#39;");
		//message=request.getParameter("message");

		rs1=st1.executeQuery("select * from forum_post_topic_reply where forum_id='"+forumid+"' and topic='"+topic+"' and school_id='"+schoolid+"' and trans_type='1'");
		if(rs1.next())
		{
			message=rs1.getString("message");
		}

		message=message.replaceAll("\"","&#34;");
		message=message.replaceAll("\'","&#39;");
		sno=request.getParameter("sno");
			}

		}
		user = emailid;
		dir = request.getParameter("fname");
		if(dir==null||dir.equals(""))
			dir="select";
		else
			dir=dir;
	}
    catch(Exception ex){
		ExceptionsFile.postException("PostNewTopic.jsp","reading parameters","Exception",ex.getMessage());
		out.println(ex+" its first");
	}
%>
<form  action="/LBCOM/forums.SaveThreadForum?sno=<%=sno%>&sid=<%=schoolid%>&fid=<%=forumid%>&fname=<%=dir%>&type=1&mode=<%=mode%>&topic1=<%=topic%>&crtby=<%=crtby%>&utype=<%=utype%>&desc=<%=desc%>&topiccount=<%=topiccount%>&replycount=<%=replycount%>&ruser=<%=ruser%>&replydate=<%=replydate%>&views=<%=views%>&mode=sree1" method="post"  enctype="multipart/form-data" name="PostNewTopic" onsubmit="return Validate();"><BR>

<span style="font-size:10pt;"><font color="#660033" face="Verdana" size=1><B>&nbsp;Date:&nbsp;<%=new java.util.Date()%></B></font></span><BR><BR>

<table align=center border="0" cellPadding="0" cellSpacing="0" width="100%">
    <tr>
      <td bgColor="white" align=left width="100%" colspan="2"><font color="#000000" face="Arial" size="2"><a href="/LBCOM/teacherAdmin/Forums/ForumManagement.jsp?mode=findex&userid=<%=user%>&schoolid=<%=schoolid%>" style="COLOR: #54687889; TEXT-DECORATION: none"><b>&nbsp;&nbsp;Forum Index&nbsp;</b></a></font></td>
   </tr>
   	<tr>
<td width="100%" colspan="2">&nbsp;</td>
</tr>
  </table>

  <table align="center" border="8" cellpadding="0" cellspacing="0" width="100%" bordercolor="#429EDF" bordercolordark="#429EDF" bordercolorlight="#429EDF">
    <tr>
        <td width="468" bgcolor="#429EDF" height="24">
            <p align="left"><font face="Arial" color="white"><span style="font-size:10pt;"><b>Post a New Topic</b></span></font></p>
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
                                    <p><font face="Arial"><span style="font-size:10pt;"><b>Forum:</b></span></font></p>
                                </td>
                                <td width="846" align="left" valign="top">
								<select id="forumname" name="forumname" disabled>
									<option value="none">Select forum category</option>
 <%
  try
  {
	 
      rs=st.executeQuery("select * from forum_master where school_id='"+schoolid+"' order by forum_id");
	  while(rs.next())
	  {
		    if(forumid.equals(rs.getString("forum_id")))
			{
				out.println("<option value='"+forumid+"' selected>"+rs.getString("forum_name")+"</option>");
			}
			else
			{
				out.println("<option value='"+rs.getString("forum_id")+"'>"+rs.getString("forum_name")+"</option>");
			}
	  }
  }
  catch(Exception e)
  {
		ExceptionsFile.postException("PostNewTopic.jsp","operations on resultset","Exception",e.getMessage());
		System.out.println("Exception in EditAssignemt.jsp 2 is..."+e);
  }
  %>
                                </td>
                            </tr>
							<tr>
                                <td width="68" align="left" valign="top">
                                    <p><font face="Arial"><span style="font-size:10pt;"><b>Topic:</b></span></font></p>
                                </td>
                                <td width="846" align="left" valign="top"><%
	  if(mode.equals("edit"))
	  {
	  %>
        <input maxLength="85" name="topic" id="topic" size="53"  oncontextmenu="return false" value="<%=topic%>">
		<%
	  }
	  else
	  {
	  %>
	   <input maxLength="85" name="topic" id="topic" size="53"  oncontextmenu="return false">
	   <%
	  }
	   %>
                                </td>
                            </tr>
                            <tr>
                                <td width="68" valign="top" align="left">
                                    <p align="left"><font face="Arial"><span style="font-size:10pt;"><b>Message</b></span></font></p>
                                </td>
                                <td width="846" valign="top">
			<% if(message==null)
					{
						message="";		

					}
			%>
                                    <table border="0" width="100%" cellpadding="0" cellspacing="0" height="273">
                                         <tr>
                                            <td width="100%" colspan="2">
                                                <font size="2" face="Arial"> 
		<textarea cols="45" name="message" rows="10" wrap="VIRTUAL"><%=message%></textarea>
		<script language="JavaScript">
			generate_wysiwyg('message');
		 </script>
         </font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="751" height="43">
                                                <p align="center"><FONT face=arial size=2>Attachment : <INPUT type=file name=forumattachfile></FONT></p>
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

  <input type='hidden' name="forumname" value="<%=forumid%>">
  </form>
</body>
</html>
