<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page language="java" import="java.sql.*,java.io.*,java.util.Date,coursemgmt.ExceptionsFile" %>
<% 
	String qry="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String salutation="",firstname="",middlename="",lastname="",title="",description="",schooltype="",schooladdress="";
	String address2="",phone="",fax="",state="",country="",emailaddress="",website="",schoolemailid="";
	String schoolname="";	
//	StringBuffer schoolname1="";
%>
<%
	try{
			
			con = con1.getConnection();
			st=con.createStatement();
	    }
	catch(Exception e)
	{
		ExceptionsFile.postException("register.jsp","creating connection and statement objects ","Exception",e.getMessage());
	out.println(e);
	}
	try{
		salutation=request.getParameter("salutation");
		firstname=request.getParameter("firstname");
			firstname=firstname.replace('\'',' ');
		middlename=request.getParameter("middlename");
			if(middlename.equals(""))
				middlename=" ";	
			middlename=middlename.replace('\'',' ');
		lastname=request.getParameter("lastname");
			lastname=lastname.replace('\'',' ');
			if(lastname.equals(""))
				lastname=" ";

		title=request.getParameter("title");
			title=title.replace('\'',' ');
		emailaddress=request.getParameter("emailaddress");
			emailaddress=emailaddress.replace('\'',' ');	
		schoolname=request.getParameter("schoolname");
			schoolname=schoolname.replace('\'',' ');
		
		
		/*if(schoolname.indexOf("'")>0)
			{
			 
			schoolname=schoolname.replace('\'',' ');
			out.println(schoolname);
			}  */

		description=request.getParameter("description");
			description=description.replace('\'',' ');
			if(description.equals(""))
				description=" ";
		
		schooltype=request.getParameter("schooltype");
			schooltype=schooltype.replace('\'',' ');
		schooladdress=request.getParameter("schooladdress");
			schooladdress=schooladdress.replace('\'',' ');
		address2=request.getParameter("address2");
			address2=address2.replace('\'',' ');
			if(address2.equals(""))
				address2=" ";
		phone=request.getParameter("phone");
		fax=request.getParameter("fax");
			if(fax.equals(""))
				fax=" ";
		state=request.getParameter("state");
			state=state.replace('\'',' ');
		country=request.getParameter("country");
			country=country.replace('\'',' ');
		schoolemailid=request.getParameter("schoolemailid");
			schoolemailid=schoolemailid.replace('\'',' ');
			if(schoolemailid.equals(""))
				schoolemailid=" ";	
		website=request.getParameter("website");
			website=website.replace('\'',' ');
			if(website.equals(""))
				website=" ";
				
		rs=st.executeQuery("select * from schoolregistration where emailaddress='"+emailaddress+"';");
		if(rs.next())
		{
		out.println("<p><b><font color=\"#0000FF\">Already Registerd,Contact Hotschools</font></b> <a				href=\"/LBCOM/contactus.html\"><b> Contact Us</b></a></p>");
		}
		else
		{
		
	qry = "insert into schoolregistration values		('"+salutation+"','"+firstname+"','"+middlename+"','"+lastname+"','"+title+"','"+emailaddress+"','"+schoolname+"','"+description+"','"+schooltype+"','"+schooladdress+"','"+address2+"','"+phone+"','"+fax+"','"+state+"','"+country+"','"+schoolemailid+"','"+website+" ',curdate());" ;
			int temp=st.executeUpdate(qry);
			if(temp==1)
			{ %>
<html>

<head>
<title><%=application.getInitParameter("title")%></title>
<meta name="generator" content="Namo WebEditor v5.0">
<style>
<!--
a{text-decoration:none}
//-->
</style>
<meta name="author" content="Hotschools, Inc.">
</head>

<body bgcolor="white" text="black" link="black" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" background="images/bg.gif">
<table align="center" border="1" cellpadding="0" cellspacing="0" width="770" bordercolordark="black" bordercolorlight="black" name="T_main">
    <tr>
        <td width="974"><table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" name="T1">
    <tr>
        <td width="779" height="7" background="images/hslay_01.gif" colspan="4">
          
       </td>
    </tr>
    <tr>
        <td width="525" height="33" align="left" valign="top" background="images/hslay_033.gif">
            <p><a href="index.jsp"><img src="images/hsn/logo.gif" width="204" height="42" border="0" TITLE=".:: www.hotschools.net ::."></a></p>
        </td>
        <td width="85" valign="bottom" background="images/hslay_02.gif">
          
            <p align="right"><a href="index.jsp"><img src="images/hslay_06.gif" width="85" height="49" border="0" TITLE=".:: www.hotschools.net ::."></a></p>
        </td>
        <td width="84" valign="bottom" background="images/hslay_02.gif">
          
            <p align="right"><a href="aboutus.html" title="About Hotschools'"><img src="images/hslay_07.gif" width="84" height="49" border="0" TITLE="About Hotschools'"></a></p>
        </td>
        <td width="84" valign="bottom" background="images/hslay_02.gif">
          
            <p align="right"><a href="contactus.html" title="Contact Hotschools'"><img src="images/hslay_08.gif" width="84" height="49" border="0" TITLE="Contact Hotschools'"></a></p>
        </td>
    </tr>
    <tr>
        <td width="772" height="35" background="images/hslay_070.gif" colspan="4">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="146"><P align=center><SPAN style="FONT-SIZE: 10pt"><FONT face=Arial><B><A 
href="solserv.html" title="Solutions / Services">Solutions/Services</A></B></FONT></SPAN></P></td>
                                <td width="198">
                                    <p align="center"><SPAN style="FONT-SIZE: 10pt"><FONT face=Arial><B><A 
href="pprojects.html" title="Partnership Clients">Partners / Clients</A></B></FONT></SPAN></td>
                                
                                <td width="89"><P align="center"><SPAN style="FONT-SIZE: 10pt"><FONT face=Arial><B><A 
href="news.html" title="News">News</A></B></FONT></SPAN></P></td>
                                <td width="120"><P align="center"><SPAN style="FONT-SIZE: 10pt"><FONT face=Arial><B><A title="Live Help" 
href="livehelp.html">Live 
Help</A></B></FONT></SPAN></P></td>
                                <td width="114"><P align="center"><SPAN style="FONT-SIZE: 10pt"><FONT face=Arial><B><A title="Online Tour" 
href="tour.html" 
target=_self>Online Tour</A></B></FONT></SPAN></P></td>
                            </tr>
                        </table>
        </td>
    </tr>
</table><table id="Table_01" align="center" border="0"
 cellpadding="0" cellspacing="0" width="778">
              <tbody>
                <tr>
                  <td width="778" colspan="7"> <table width="778" border="0" cellpadding="0" cellspacing="0" name="T1">
	<tr>
		<td>
			<img src="images/top2_01.gif" width="19" height="22" TITLE=""></td>
		<td width="327" height="22" align="center" valign="middle" bgcolor="black">
            <p align="center"><span style="font-size: 10pt;"><font
 color="white" face="Arial"><b>for quality eLearning experience</b></font></span></p>
</td>
		<td>
			<img src="images/top2_03.gif" width="432" height="22" TITLE=""></td>
	</tr>
</table>
</td>
                </tr>
              <tbody>
                <tr>
                  <td width="38"> <img src="images/hslay_inside_14.gif" TITLE=""
 height="60" width="103"></td>
                  <td width="157"> <img src="images/hslay_inside_15.gif" TITLE=""
 height="60" width="92"></td>
                  <td width="96"> <img src="images/hslay_inside_16.gif" TITLE=""
 height="60" width="96"></td>
                  <td width="122"> <img src="images/hslay_inside_17.gif" TITLE=""
 height="60" width="122"></td>
                  <td width="142"> <img src="images/hslay_inside_18.gif" TITLE=""
 height="60" width="142"></td>
                  <td width="85"> <img src="images/hslay_inside_19.gif" TITLE=""
 height="60" width="85"></td>
                  <td width="138">
                  <p align="right"><img src="images/hslay_inside_20.gif" TITLE=""
 height="60" width="138"></p>
                  </td>
                </tr>
                <tr>
                  <td colspan="5" width="555" bgcolor="white">
                  <h1 align="left">&nbsp;</h1>
                  </td>
                  <td width="85" bgcolor="white">
                  <p>&nbsp;</p>
                  </td>
                  <td align="right" valign="top" width="138" bgcolor="white">
                  <p align="right"><img src="images/hslay_inside_22.gif"
 border="0" height="39" width="138"></p>
                  </td>
                </tr>
              </tbody>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="779" align="center" valign="middle" bgcolor="white">
                        <p align="left">&nbsp;</p>
                        <p align="center"><span style="font-size:10pt;"><font face="Arial"><b><br><br><br><br><br><br></b></font></span><FONT color=#0000ff><B><FONT face=Verdana size=2>Thank you for visiting 
</FONT></B></FONT><FONT face=Verdana><B><FONT size=2><FONT face=Verdana 
color=#0000ff size=2>www.</FONT><FONT face=Verdana color=blue 
size=2>hotschools.net</FONT><FONT face=Verdana 
color=#0000ff size=2>.</FONT><FONT face=Verdana color=blue size=2><FONT color=#0000ff>&nbsp;<BR>A 
representative from Hotschools' </FONT></FONT></FONT></B></FONT><B><FONT 
face=Verdana color=blue size=2>will contact you soon</FONT></B><span style="font-size:10pt;"><font face="Arial"><b><br><br><br><br><br><br><br><br></b></font></span><br><br>&nbsp;</p>
                    </td>
                </tr>
            </table>
<table id="Table_01" width="779" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td width="778" height="55" valign="bottom" background="images/hslay_23.gif">
            <p align="center"><span style="font-size:9pt;"><font face="Arial">Copyright 
            1999 - 2005 <b>Hotschools, Inc</b>. All Rights Reserved. Terms and Conditions 
            Apply. Privacy Policy.</font></span></p>
</td>
	</tr>
</table>

        </td>
    </tr>
</table>

</body>

</html>


					
			
			<%}
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("register.jsp","Operations on database and reading parameters","Exception",e.getMessage());
		out.println(e);
		out.println("Please check values properly");
	}

	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e){
			ExceptionsFile.postException("register.jsp","closing connection and statement objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	     }		 		
	
%>

			
	
		
