<%@ page language="java" import="java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String userId="",schoolId="",attachFlag="",fromUser="",loginType="";
	String attachmentString ="";
	String flist[] = null;
	String tempUrl="";
	int len = 0;
%>
<%
	try
	{
		session = request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolId = (String)session.getAttribute("schoolid");
		userId = (String)session.getAttribute("emailid");
		loginType = (String)session.getAttribute("logintype");
		
		if(userId.equals("Admin"))
				userId = "admin";
		
		attachFlag = request.getParameter("attach");
		fromUser = request.getParameter("fromuser");
		if(fromUser==null)
			 fromUser = "";
		tempUrl = application.getInitParameter("schools_path");
		tempUrl = tempUrl + "/" + schoolId + "/" + userId + "/attachments/temp";
		File tempFolder = new File(tempUrl);
		
		if(attachFlag!=null)	
		{
			if(tempFolder.isDirectory())
				flist = tempFolder.list();
			for(int i=0;i<flist.length;i++)
			{
				if(i==0)
					attachmentString = flist[i];
				else
					attachmentString = attachmentString + "," + flist[i];	  
			}	 
		}
		else 
		{
			if(tempFolder.isDirectory())
			{
				flist = tempFolder.list();
				for(int i=0;i<flist.length;i++)
				{
					File file = new File(tempFolder,flist[i]);
					file.delete();
				}
				tempFolder.delete(); 
			}
			else
				tempFolder.delete();	
		}	
	}
	catch(IOException ioe)
	{
		System.out.println("error is "+ioe);
		ExceptionsFile.postException("Compose.jsp","IOException","Exception",ioe.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("error is "+e);
		ExceptionsFile.postException("Compose.jsp","some exception","Exception",e.getMessage());
	}
%>

<html>

<head>
<title></title>
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<script language="JavaScript">

<!--
function validate(frm)
{
	var sb =  trim(frm.subject.value);
		 
	if(sb.length>100)
	{
		alert("Subject should be less than 100 characters ");
		return false;
	}
	replacequotes();
			 
	if(frm.rtype.value=="normal")
	{
		//document.composeform.action = "Sent.jsp";
		
		document.composeform.submit();
	}
}

function attachwin()
{
   var attach_window;
   attach_window = window.open("/LBCOM/Commonmail/Attachment.jsp","attach_window","width=400,height=300");
   attach_window.moveTo(200,150);
}

// -->

</script>

</head>

<body link="black" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" bgcolor="#f0f0f0">

<form id="composeform" name="composeform" action="Sent.jsp" method="post" onsubmit="return validate(this);">

	<table bgcolor="#EEE5DE" width="705">
    <tr>
		<td width="691" height="25"><font face="Verdana" size="2"><b>Feedback Mail - </b>Plain Text</font></td>
	</tr>
	</table>

	<table width="707">
	<tr>
		<td width="809" align="right">&nbsp;</td>
	</tr>
	</table>
	
	<table width="707">
	<tr>
		<td width="98" align="right">
			<font face="verdana" size="2"><b>To:</b></font></td>
		<td width="595" colspan="2">
			<input type="text" name="toaddress" id="toaddress" value='' size="67" oncontextmenu="return false" onkeydown="return false" onkeypress="return false">
		</td>
	</tr>
	<tr>
		<td width="98" align="right">
			<font face="verdana" size="2"><b>Subject:</b></font>
		</td>
		<td colspan="2">
			<input type="text" id="subject" name="subject" size="67">
			<input type="checkbox" name="sentcheck" value="sent" checked>
			<font face="arial" size="1">Save in Sent Mails</font>
		</td>
	</tr>
	<tr>
	    <td align="right"><font face="arial" size="2">Attachments:</font></td>
	    <td><input type="text" name="attachment" id="attachid" size="60" disabled></td>
	    <td><input type="button" name="attachbtn" value="Add/Remove Attachment" onclick="javascript: attachwin()"></td>
	</tr>
	<tr>
		<td width="98" align="right" valign="top">
			<font face="verdana" size="2"><b>Message:</b></font></td>
		<td colspan="2" width="599">
			<textarea cols="51" rows="15" name="message" wrap="hard" id="mess"></textarea>
		</td>
	</tr>
	<tr>
		<td width="98" align="right" valign="top">&nbsp;</td>
		<td colspan="2" width="599">
			<input type="submit" name="submit" value="          SEND MAIL           ">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" name="cancelbtn" value="  CANCEL SENDING  " onClick="window.close();">
		</td>
	</tr>
	</table>   
  
<input type="hidden" id="rtype" name="rtype" value="normal">

</form>
</body>

<script>
	var mw=window.opener;
	document.composeform.message.value=mw.parent.messageBody;
	document.composeform.toaddress.value=mw.parent.toAddress;
	document.composeform.subject.value=mw.parent.subject;
</script>

</html>
