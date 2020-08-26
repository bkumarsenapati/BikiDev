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
<table>
 <tr>
     <!--  <td width="73%" colspan="2" height="27" bgcolor="#C0C0C0" align="left">&nbsp;<font face="arial" size="2">Attachment:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" name="logofile" size="20"></font></td> -->
    </tr>
	<tr>
      <td width="73%" colspan="2" height="27" bgcolor="#7C7C7C">
      <p align="center">
		 <input type="button" value="Remove Logo" name="B2" onClick="return changeLogo();"></td>
    </tr>
	</table>

</form>
</BODY>
</HTML>
