<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.Date,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/TALRT/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />

<% 
	String newsId="",title="",content="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	int count=0;

	try
	{
		con= db.getConnection();
		st=con.createStatement();

		rs=st.executeQuery("select * from lb_news where status=1 order by news_id desc");
%>
<html>

<head>
<title>Learnbeyond.net [News]</title>
<meta name="generator" content="Namo WebEditor v5.0">
<style>A:hover {
	COLOR: red
}
A {
	TEXT-DECORATION: none
}</style>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" background="images/lbeyond_bg.gif">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="879" background="images/LBRT_07.gif">
    <tr>
        <td width="100%"><table id="Table_01" width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="24">
			<img id="LBRT_02" src="images/LBRT_02.gif" width="24" height="32" alt="" /></td>
		<td width="409" background="images/LBRT_03.gif" valign="middle">
                        <p align="left" style="letter-spacing:2;"><span style="font-size:8pt;"><font face="Arial">www.learnbeyond.net</font></span></p>
</td>
		<td width="409" background="images/LBRT_03.gif" valign="middle">
                        <div align="right">
                            <table border="0" cellpadding="0" cellspacing="0" width="300">
                                <tr>
                                    <td width="70" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="images/faq.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="31" align="center" valign="bottom">
                                        <p><span style="font-size:8pt;"><font face="Arial"><a href="/LBCOM/faq.html">FAQ</a></font></span></p>
                                    </td>
                                    <td width="49" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="images/sitemap.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="51" align="center" valign="bottom">
                                        <p><span style="font-size:8pt;"><font face="Arial"><a href="/LBCOM/sitemap.html">Site 
                                        Map</a></font></span></p>
                                    </td>
                                    <td width="34" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="images/contactus.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="65" align="center" valign="bottom">
                                        <p align="left"><span style="font-size:8pt;"><font face="Arial">&nbsp;<a href="/LBCOM/contactus.html">Contact 
                                        Us</a></font></span></p>
                                    </td>
                                </tr>
                            </table>
                        </div>
</td>
		<td width="36">
			<img id="LBRT_05" src="images/LBRT_05.gif" width="36" height="32" alt="" /></td>
	</tr>
</table>
        </td>
    </tr>
    <tr>
        <td width="100%">
            <table border="0" cellpadding="5" cellspacing="5" width="100%" height="100%">
                <tr>
                    <td width="431"><a href="/LBCOM/index.jsp"><img id="LBRT_10" src="images/LBRT_10.gif" width="251" height="75" alt="www.learnbeyond.com" / border="0"></a></td>
                    <td width="431">                        <p align="right"><img src="images/mohaninglogo.jpg" width="313" height="76" border="0"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="34">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="11"><img id="LBRT_15" src="images/LBRT_15.gif" width="11" height="32" alt="" /></td>
                    <td width="100%" background="images/LBRT_17.gif">			
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="90%">
                            <tr>
                                <td width="24" valign="middle" height="24" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/home.gif" width="16" height="17" border="0"></font></span></p>
                                </td>
                                <td width="87" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/index.jsp"><font face="Arial">Home</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/abt.gif" width="15" height="18" border="0"></font></span></p>
                                </td>
                                <td width="95" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/aboutus.html"><font face="Arial">About 
                                    Us</font></a></span></p>
                                </td>
                                <td width="29" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/service.gif" width="29" height="20" border="0"></font></span></p>
                                </td>
                                <td width="157" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/products/CourseIndex2.jsp"><font face="Arial">Products 
                                    &amp; Services</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/rigister.gif" width="21" height="21" border="0"></font></span></p>
                                </td>
                                <td width="96" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/register/StudentRegistration.jsp"><font face="Arial">Register</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/news.gif" width="23" height="21" border="0"></font></span></p>
                                </td>
                                <td width="81" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/news/News.jsp"><font face="Arial">News</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="images/feedback_01.gif" width="24" height="17" border="0"></font></span></p>
                                </td>
                                <td width="105" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/feedback/feedback.html"><font face="Arial">Feedback</font></a></span></p>
                                </td>
                            </tr>
                        </table>
</td>
                    <td width="11">			
                        <p align="right"><img id="LBRT_18" src="images/LBRT_18.gif" width="11" height="32" alt="" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="10">
        </td>
    </tr>
    <tr>
        <td width="100%">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="106" valign="top">
                        <table id="Table_01" border="0" cellpadding="0" cellspacing="0" height="240" width="639">
	<tr>
		<td height="14" valign="top">
			<img id="lbeyond_30" src="images/lbeyond_30.gif" width="639" height="14" alt="" /></td>
	</tr>
	<%
		while(rs.next())
		{
			count++;
			newsId=rs.getString("news_id");
			title=rs.getString("title");
			content=rs.getString("content");
%>

	<a name="news<%=newsId%>">
	<tr>
		<td height="100%" background="images/lbeyond_31.gif" valign="top">
                                    <table border="0" cellpadding="0" cellspacing="5" width="100%">
                                        <tr>
                                            <td>
											<font face="Verdana" size="2" color="#800000"><%=title%></font></b>
											</td>
										</tr>
										<tr>
											<td width="100%">
                                            <p align="justify"><font face="Arial"><span style="font-size:10pt;"><%=content%></span></font></p>
											</td>
</td>
                                        </tr>
                                    </table>
									<%
		}	

	if(count==0)
	{
%>
 <p align="center"><font face="verdana" size="2">There are no News.</font></p>
<%
	}	
	}
	catch(Exception e)
	{
		System.out.println("The exception in News.jsp is..."+e);
	}
%>
			</td>
	</tr>
	<tr>
		<td height="13" valign="bottom">
			<img id="lbeyond_36" src="images/lbeyond_36.gif" width="639" height="13" alt="" /></td>
	</tr>
</table>
                    </td>
                    <td width="721" valign="top" align="right">
                        <p><img src="images/img2_news.jpg" width="200" height="322" border="0"></p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="10">

        </td>
    </tr>
    <tr>
        <td width="100%">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="11">			<img id="LBRT_15" src="images/LBRT_15.gif" width="11" height="32" alt="" /></td>
                    <td width="100%" background="images/LBRT_17.gif">                        <table align="center" border="0" width="70%" height="32">
                            <tr>
                                <td width="274" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;"><a target="_blank" target="_blank" href="/LBCOM/tech.html#browsers">Browser 
                                    Specific Requirements</a></span></font></p>
                                </td>
                                <td width="-1" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="74" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="/LBCOM/faq.html">FAQ's</a></span></font></p>
                                </td>
                                <td width="4" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="103" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="/LBCOM/sitemap.html">Site 
                                    Map</a></span></font></p>
                                </td>
                                <td width="3" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="87" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="/LBCOM/feedback/feedback.html">Feedback</a></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="11">			
                        <p align="right"><img id="LBRT_18" src="images/LBRT_18.gif" width="11" height="32" alt="" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%"><table id="Table_01" width="100%" border="0" cellpadding="0" cellspacing="0" background="images/LBRT_46.gif">
	<tr>
		<td width="16">
			<img id="LBRT_43" src="images/LBRT_43.gif" width="16" height="27" alt="" /></td>
		<td width="846">
                        <p align="center"><font face="Arial"><span style="font-size:9pt;">Copyright 
                        � 2007-2008 <b>Learnbeyond</b>. All Rights Reserved.</span></font></p>
</td>
		<td width="17">
			<img id="LBRT_47" src="images/LBRT_47.gif" width="17" height="27" alt="" /></td>
	</tr>
</table>
        </td>
    </tr>
</table>
</body>

</html>

