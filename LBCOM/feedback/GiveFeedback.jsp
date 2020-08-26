<%
     String sessid;
	 sessid=session.getId();
	 if(sessid==null)
     {
		out.println("<html><script> top.location.href='/LB/student/NoSession.html'; \n </script></html>");
		return;
     }
	 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Learn Beyond</TITLE>
<LINK href="images/style.css" type=text/css rel=stylesheet>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<STYLE type=text/css>.style2 {
	FONT-SIZE: 11px
}
</STYLE>
 <SCRIPT LANGUAGE="JavaScript" SRC="validationscripts.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript">
           function validate(sform)
		    {  
			          
			 if(sform.fname.value=="")
	            {
				alert("Please enter firstname");
			    sform.fname.focus();
			    return false;
		        }
		     if(sform.lname.value=="")
		        {
			    alert("Please enter lastname");
			    sform.lname.focus();
			    return false;
		        }
            if(isValidEmail(sform.email.value)==false||sform.email.value=="")
			    {
				sform.email.focus();
				return false;
			    }
                  if (isNaN(sform.phno.value)) 
			    {
		        alert("Please enter only numbers for phone number");
		        sform.phno.focus();
		        return false;
	            }
			
      	}

    </SCRIPT>
<META content="Microsoft FrontPage 5.0" name=GENERATOR>
</HEAD>
<BODY class=bodybg align="center">
<FORM name=sform  action="/LBCOM/products.FeedBack"	 onsubmit="return validate(this);" action="" method=post>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="154">
   <tr>
    <td width="100%" height="111" colspan="3">&nbsp;</td>
   </tr>
    <tr>
    <td width="20%" height="329">&nbsp;</td>
    <td width="60%" height="329">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2" height="119">
     <TBODY>
      <TR class=mainhead>
        <TD class=mainhead width=588 colSpan=2 height=24>
         <P align=left><b>Inquiry Form</b></P>
        </TD>
      </TR>
      <TR class=td>
       <TD class=td colSpan=2 height="15" align="right"> 
        <FONT color=#ff0000><SPAN style="FONT-WEIGHT: 400">* fields are required.</SPAN></FONT>
       <TD>
      </TR>
      <TR class=td>
       <TD class=tdleft align=right height="21">First Name</TD>
       <TD height="21"><INPUT id=firstname maxLength=30 name=fname size="24">  <FONT color=#ff0000>*</FONT>
       </TD>
      </TR>
      <TR class=td>
       <TD class=tdleft align=right height="21">Last Name</TD>
       <TD height="21"><INPUT id=lastname maxLength=30 name=lname size="24">   <FONT color=#ff0000>*</FONT></TD>
      </TR>
      <TR class=td>
       <TD class=tdleft align=right height="21">School/Organization</TD>
       <TD height="21"><INPUT id=dateofbirth maxLength=30 name="org" size="24"></TD>
      </TR>
      <TR class=td>
       <TD class=tdleft align=right height="21">Email ID</TD>
       <TD height="21"><INPUT id=parentmailid maxLength=30 name=email size="24"><FONT color=#ff0000>*</FONT>
       </TD>
      </TR>
      <TR class=td>
       <TD class=tdleft align=right height="21">Phone</TD>
       <TD height="21"><INPUT id=studentphone maxLength=30 name=phno size="24">
       </TD>
      </TR>
      <TR class=td>
        <TD class=tdleft align=right height="21">How did you know about us?</TD>
        <TD height="21"><SELECT size=1 name="info">
	  <OPTION value=none selected>--Select--</OPTION>
	  <OPTION value="CLNT">Client Referal</OPTION>
	  <OPTION value="FRND">Friend/Colleague</OPTION>
	  <OPTION value="SRCH">Search Engine</OPTION>
	  <OPTION value="TCHR">Teacher</OPTION>
	  <OPTION value="SCHL">School</OPTION>
	 </SELECT>
         </TD>
      </TR>
      <TR class=td>
       <TD class=tdleft align=right height="20">Please Contact me:</TD>
       <TD height="20"><INPUT value=1 type="radio" name="contact" checked> yes <INPUT value=0 type="radio" name="contact" > no </TD>
      </TR>
      <TR class=td>
       <TD class=tdleft align=right height="20">Please send brochure & course catalog:</TD>
       <TD height="20"><INPUT value=1 type="radio" name="brochure" checked> yes <INPUT value=0 type="radio" name="brochure">no</TD>
     </TR>
     <TR class=td>
       <TD class=tdleft align=right height="20">Please email me your current newsletter:</TD>
       <TD height="20"><INPUT value=1 type="radio" name="newsletter" checked> yes <INPUT value=0 type="radio" name="newsletter"> no</TD>
     </TR>
     <TR class=td >
      <TD  class=td align=right height="20">Comments and Questions:</TD>
      <TD  class=td align=right height="20"></TD>
     </tr>
     <TR class=td >
       <TD colspan=2 height="87" align=center><textarea rows="5" cols="45" name="comments"> </textarea></TD>
     </TR>
     <TR class=td>
      <TD width=588 colSpan=2 height=37><P align=center>
       <INPUT type=submit value="Submit" name=submit></P>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
   </td>
   <td width="20%" height="329">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" height="110" colspan="3">&nbsp;</td>
  </tr>
</table>
</FORM>
</BODY>
</HTML>