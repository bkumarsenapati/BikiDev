<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
   String schoolId="",userId="",sessid="";
%>
<%
  schoolId=request.getParameter("schoolid");
  userId= request.getParameter("userid");
 

  	sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
			}
%>

<HTML>
<HEAD>
<TITLE><%=application.getInitParameter("title")%></TITLE>

<script language="javascript">
    
function ltrim ( s )
{
 return s.replace( /^\s*/, "" );
}
var count = 2;


function view()
{
   var y=document.multifiles.logofile.value;
   document.forms[0].elements['logofile'].value = value = path.substr(path.lastIndexOf('\\') + 1);
   y=document.forms[0].elements['logofile'].value;
	   alert(y);
   
   var flag=false;
  	 for(i=0;i<y.length;i++) {
         if (y[i].name=="ip")  { 
		     if (ltrim(y[i].value)!="") {
	   	        flag=true;
		      }
	      }
      }
  	if (flag==false) {
		alert("No file is selected.");
	    return false;
	} else {
		return check();
	}
}
function changeLogo()
{
	var r=confirm("Do you want to delete the logo");
	if (r==true)
	  {
		window.location.href="UploadLogoFiles1.jsp?mode=cancel";
	  }
	else
	  {
	   return true;
	  }

		
	//document.upload.reset();
	//addOptions();
	return false;
}

</script>

</HEAD>

<BODY>

 <form name="multifiles" action ="UploadLogoFiles.jsp?schoolid=<%=schoolId%>&useId=<%=userId%>&mode=add" enctype="multipart/form-data" method="post" onsubmit="javascript: return    view();">
 <BR><BR>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<BR>
<TABLE cellpadding="0" cellspacing="0" border="0" height="91" align="center">
 <tr>
      <TD bgColor=#EEE0A1 height="34" width="73%" align="left"><font face="Arial"><span style="font-size:10pt;">&nbsp;<font face="arial" size="2">Attachment:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" name="logofile" size="20"></font></td>
    </tr>
	 <TR>
        <td width="73%" height="27" align="left" colspan="2" bgcolor="#EEE0A1"><font face="Arial"><span style="font-size:10pt;"><b>&nbsp;Note: </b>The size of the Logo should be <b>Height = 50</b> X <b>Width = 219</b> for best viewing</span></font></td>
    </TR>
	
	<tr>
      <td bgColor=#EEBA4D height="30" width="73%">
      <p align="center">
		<input type="submit" value="Submit" name="B1">&nbsp;&nbsp; <input type="reset" value="Reset" name="B2" onClick="return cleardata();"></td>
    </tr>
	</table>

</form>
</BODY>
</HTML>
