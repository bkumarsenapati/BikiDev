<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.Date,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/TALRT/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />

<% 
	String studentId="",schoolId="",webId="",title="",catId="",catName="",feedBack="",desc="",iPath="";
	Connection con=null;
	Statement st1=null,st2=null,st3=null;
	ResultSet rs1=null,rs2=null,rs3=null;

	Hashtable categories=null, titles=null, descriptions=null, imagepaths=null;
	
	try
	{
		con= db.getConnection();
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();

		studentId=(String)session.getValue("emailid");
		schoolId=(String)session.getValue("schoolid");

		categories = new Hashtable();
		titles = new Hashtable();
		descriptions = new Hashtable();
		imagepaths = new Hashtable();
		
		rs1=st1.executeQuery("select category_id,category_name from webinar_categories");
		
		while(rs1.next())
		{
			catId=rs1.getString(1);
			catName=rs1.getString(2);

			categories.put(catId,catName);
		}

		rs2=st2.executeQuery("select * from webinars");

		while(rs2.next())
		{
			webId=rs2.getString("webinar_id");
			title=rs2.getString("title");
			desc=rs2.getString("description");
			iPath=rs2.getString("image_path");

			titles.put(webId,title);	
			descriptions.put(webId,desc);
			imagepaths.put(webId,iPath);
		}

		rs3=st3.executeQuery("select * from student_webinars where student_id='"+studentId+"'");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>List of Webinars</title>
</head>

<body>
<br>
<br>
<table width="627" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<table width="627" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="213">
            <img src="images/videos_03.jpg" width="213" height="40" /></td>
			<td width="414" align="left" valign="top">
				<table width="414" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >&nbsp;</td>
				</tr>
				<tr>
					<td width="397" height="23" valign="top">
                    <img src="images/videos_06.jpg" width="397" height="22" /></td>
		            <td width="17" valign="top">
                    <img src="images/videos_07.jpg" width="17" height="22" /></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>

<%
		while(rs3.next())
		{
			webId=rs3.getString("webinar_id");
			catId=rs3.getString("category_id");
			feedBack=rs3.getString("feedback");

			if(feedBack == null || feedBack.equals(""))
			{
				feedBack="<a href=\"AddEditFeedback.jsp?mode=add&webid="+webId+"\">ADD</a>";
			}
			else
			{
				feedBack=feedBack+" (<a href=\"AddEditFeedback.jsp?mode=edit&webid="+webId+"\">EDIT</a>)";
			}
%>

<table width="627" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
			<td><img src="images/videos_08.jpg" width="627" height="8" /></td>
		</tr>
		</table>
		<table width="627" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
			<td width="20" rowspan="3" valign="bottom" bgcolor="EEECEA"><img src="images/index_09.jpg" width="18" height="140" /></td>
			<td width="140" bgcolor="#EEECEA">&nbsp;</td>
			<td width="467" rowspan="3" align="left" valign="top" bgcolor="EEECEA">
	            <div align="center">
                  <center>
	            <table width="419" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111">
				<tr>
					<td width="156" height="30" align="left" class="style1">
						<font face="Verdana" size="2"  color="#800000"><b><%=titles.get(webId)%></b></font> 
					</td>
					<td width="263" height="30" align="right" class="style2">
						<font face="Verdana" size="2" color="#800000"><b><%=categories.get(catId)%></b></font></td>
				</tr>
				<tr>
					<td colspan="2" width="419" align="justify" class="style3" valign="top" height="60">
						<font face="Verdana" size="2"><%=descriptions.get(webId)%></font></td>
				</tr>
				<tr>
					<td colspan="2" width="419" align="justify" class="style3" valign="top" height="1">
						<br>
						<font face="Verdana" size="2">Feedback :</font>
						<font face="Verdana" size="1"><%=feedBack%></font>
					</td>
				</tr>
				</table>
			      </center>
                </div>
			</td>
		</tr>
        <tr>
			<td bgcolor="EEECEA" class="box" width="1">
				<a href="PlayVideo.jsp?webid=<%=webId%>">
				<img border="0" src="<%=imagepaths.get(webId)%>" width="115" height="88"></a>
			</td>
        </tr>
        <tr>
			<td bgcolor="#EEECEA" width="140">&nbsp;</td>
        </tr>
		</table>
		<table width="627" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
			<td><img src="images/videos_15.jpg" width="627" height="8" /></td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table width="750" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td height="2"><img src="images/index_25.gif" width="737" height="1"></td>
</tr>
</table>
<%
		}
%>

</body>

<%
	}
	catch(Exception e)
	{
		System.out.println("The exception in ListWebinars.jsp is..."+e);
	}
%>
</html>
