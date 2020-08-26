<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />

<%
  Connection con = null;
  Statement st = null;
  ResultSet rs = null;
%>

<%
	String webId="",mode="",feedback="",studentId="";
	webId=request.getParameter("webid");
	mode=request.getParameter("mode");

	studentId=(String)session.getAttribute("emailid");

	if(mode.equals("edit"))
	{
		con=db.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select feedback from lb_student_webinars where student_id='"+studentId+"' and webinar_id='"+webId+"'");
		if(rs.next())
		{
			feedback=rs.getString(1);
		}
	}

%>

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

}
</SCRIPT>

<META content="Microsoft FrontPage 5.0" name=GENERATOR>
</HEAD>
<BODY class=bodybg align="center">
<FORM name=sform  action="/LBCOM/webinars.AddEditFeedback?webid=<%=webId%>" onsubmit="return validate(this);" action="" method=post>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="42">
   <tr>
    <td width="100%" height="48" colspan="3">&nbsp;</td>
   </tr>
    <tr>
    <td width="20%" height="280">&nbsp;</td>
    <td width="60%" height="280">
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2" height="119">
     <TBODY>
      <TR class=mainhead>
        <TD class=mainhead width=588 colSpan=2 height=24>
         <p align="left"><font face="Verdana" size="2" color="#800000"><b>
         Add/Edit Feedback :</b></font></TD>
      </TR>
     <TR class=td >
      <TD  class=td align=right height="20">&nbsp;</TD>
      <TD  class=td align=right height="20"></TD>
     </tr>
     <TR class=td >
       <TD colspan=2 height="87" align=center>
		<textarea rows="5" cols="45" name="feedback"><%=feedback%></textarea></TD>
     </TR>
     <TR class=td>
      <TD width=588 colSpan=2 height=37><P align=center>
       <INPUT type=submit value="Submit" name=submit></P>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
   </td>
   <td width="20%" height="280">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" height="110" colspan="3">&nbsp;</td>
  </tr>
</table>
</FORM>
</BODY>
</HTML>