<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.Date,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/TALRT/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>

<body>

<% 
	String webId="",title="",videoPath="";

	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	webId=request.getParameter("webid");

	try
	{
		con= db.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select title,video_path from lb_webinar_catalog where webinarid='"+webId+"'");
		
		while(rs.next())
		{
			title=rs.getString("title");
			videoPath=rs.getString("video_path");
		}

		System.out.println("The path is..."+videoPath);

		rs.close();
	}
	catch(Exception e)
	{
		System.out.println("The exception in PlayVideo.jsp is..."+e);
	}
%>

<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="270">
  <tr>
    <td width="33%" height="28">&nbsp;</td>
    <td width="17%" height="28">
    <p align="left"><b>
		<font face="Verdana" color="#800000"><%=title%></font></b>&nbsp;
	</td>
    <td width="16%" height="28">
    <p align="right">      
		<b>      
		<font face="Verdana" size="1" color="#800000"><a href="#">Save to Computer</a></font></b></td>
  </tr>
  <tr>
    <td width="33%" height="219">&nbsp;</td>
    <td width="33%" height="219" align="center" colspan="2">

			<p align="left">

			<OBJECT ID="MediaPlayer" WIDTH="500" HEIGHT="400" CLASSID="CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95" STANDBY="Loading Windows Media Player components..." TYPE="application/x-oleobject">
			<PARAM NAME="FileName" VALUE="/LBCOM/products/videos/<%=videoPath%>">
			<PARAM name="ShowControls" VALUE="true">
			<param name="ShowStatusBar" value="true">
			<PARAM name="ShowDisplay" VALUE="false">
			<PARAM name="autostart" VALUE="false">
			  <EMBED TYPE="application/x-mplayer2" SRC="/LBCOM/products/videos/<%=videoPath%>" NAME="MediaPlayer" WIDTH="500" HEIGHT="400" ShowControls="1" ShowStatusBar="0" ShowDisplay="0" autostart="0">
			</EMBED></OBJECT>

	</td>
    <td width="34%" height="219">&nbsp;</td>
  </tr>
  <tr>
    <td width="33%" height="21">&nbsp;</td>
    <td width="33%" height="21" colspan="2">
		<font face="Verdana" size="2" color="#800000">Rating :&nbsp; <b>* *</b> </font>
		<font face="Verdana" size="2" color="#6F6F6F">* * *</font></b>
	</td>
    <td width="34%" height="21">&nbsp;</td>
  </tr>
</table>

</body>
</html>