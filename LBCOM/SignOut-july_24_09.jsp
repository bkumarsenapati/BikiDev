<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />

<%
  Connection con = null;
  Statement st = null;
  ResultSet rs = null;
%>

<HTML>
<HEAD>
<TITLE>Sign out - Learnbeyond</TITLE>
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<META content="Microsoft FrontPage 5.0" name=GENERATOR>
<style>
<!--
.style14 {font-size: 9px}
-->
</style>
</HEAD>
<BODY>
<center>
<table bgcolor="white" width="756" cellpadding="0" cellspacing="0">
<tr>
<td>
	<table width="766" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td colspan="2" width="766">
    <img src="lb_images/top_stip.jpg" width="767" height="4" /></td>
	</tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>
	<TABLE cellSpacing=0 width="100%" bgColor=#cccccc border=0 style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="24">
<TR>
	<TD align=middle colSpan=2 width="759" height="24">
		&nbsp;</TD>
</TR>
</TABLE>
</td>
</tr>
<tr>
<td>
<TABLE cellSpacing=0 cellPadding=4 width=758 align=center border=0 height="166">
<TR>
<TD colSpan=3 width="750" height="112">
      <TABLE cellSpacing=0 cellPadding=4 height="99" style="border-collapse: collapse" bordercolor="#111111" width="756">
        <TBODY>
        <TR>
          <TD width="198" height="19">&nbsp;</TD>
          <TD vAlign=bottom noWrap align=right height="19" width="542">
            <b><font face="Verdana" size="2"><a href="index.jsp">
            <font color="#DD5800">HOME</font></a></font></b></TD></TR>
        <TR>
          <TD width="198" height="33">
          <p align="left">
          <font face="Verdana" size="2">
          <IMG alt="Learnbeyond" src="images/logo.gif" border=0 width="198" height="50"> </font> </TD>
          <TD vAlign=bottom noWrap align=right height="33" width="542">
            <HR noShade SIZE=1>
          </TD></TR>
        <TR>
          <TD bgColor=#808080 colSpan=2 height="23" width="100%">
          <FONT face=Verdana color=#FFFFFF 
            size=2><B>Thank you for using 
          Learnbeyond!</B></FONT></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD align=middle colSpan=3 width="750" height="38">
      	<TABLE cellSpacing=0 cellPadding=3 width="759" style="border-collapse: collapse" bordercolor="#111111">
        <TBODY>
        <TR>
        	<TD width="536" align="left">
        		<FONT face=Verdana color=#DD5800 size="2">
        			<B>You have successfully logged out from your account!</B>
        		</FONT>
        	</TD>
        	<TD width="211" align="left">
<p align="right"><b><font face="Verdana" size="2" color="#FF8533">
<!-- <a href="index.jsp"><font color="#DD5800">Login Again</font></a></font></b></p> -->
<a href="/LBCOM/cookie/"><font color="#DD5800">Login Again</font></a></font></b></p>
        	</TD>
        </TR>
        </TBODY>
        </TABLE>
     </TD>
</TR>
</TBODY>
</TABLE>
<br>
<TABLE cellSpacing=0 cellPadding=4 width="725" align=center border=0>
<TBODY>
<TR>
	<TD vAlign=top align=left>
      <FORM name="signout" method=post>
      <TABLE cellSpacing=0 cellPadding=2 width=702 bgColor=#b6c7e5 border=0>
        <TBODY>
        <TR>
          <TD width="698">
            <TABLE cellSpacing=0 cellPadding=2 width="100%" bgColor=#eeeeee border=0>
              <TBODY>
              <TR>
                <TD align=middle bgColor=#ffffff>
                  <TABLE cellSpacing=6 cellPadding=6 width="100%" bgColor=#ffffff border=0>
                    <TBODY>
                    <TR bgColor=#eeeeee>
                      <TD vAlign=top align=left>
                      <div id="noticeBox" style="border: 1px dashed #789;background:#ffe;color:#b88;margin-left:10px;margin-right:10px;padding:5px;">
						<%@ include file="news/SignOutNews.jsp" %>
					</div>
                      </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></FORM></TD>
</TR></TBODY></TABLE>
<CENTER>
<br>
<p><br>
<br>
<br>
&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<TABLE cellSpacing=0 width="767" bgColor=#cccccc border=0 style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" height="24">
<TR>
	<TD align=middle width="646" height="24">
		<font face="Verdana">
		<span class="sheet style14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></font></TD>
	<TD align=middle width="121" height="24">
		<font face="Verdana">
		<span class="sheet style14">&nbsp;<a href="PrivacyPolicy.html"><font color="#000000">Privacy 
        Policy</font></a></span></font></TD>
</TR>
</TABLE>
</td>
</tr>
<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111">
	<tr>
	<td colspan="2"><img src="lb_images/top_stip.jpg" width="767" height="4" /></td>
	</tr>
	</table>
	</td>
</tr>
</table>
</CENTER>
</BODY>
</HTML>