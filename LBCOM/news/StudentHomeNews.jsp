<%@ page language="java" %>
<%@ page import = "java.sql.*,java.lang.*,java.io.* " %>


<% 
	String newsId="",title="";
	int count=0;

	try
	{
		con= db.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select * from lb_news where status=1 order by news_id desc");
		
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>

<body>

<table border="0" cellpadding="0" cellspacing="0" bordercolor="#111111" height="140">
   <tr>
    <td width="16%"></td>
    <td width="82%"></td>
    <td width="3%"></td>
  </tr>

<%
		while(rs.next())
		{	
			newsId=rs.getString("news_id");
			title=rs.getString("title");
			
			if(title.length() > 30 )
			{
				title=title.substring(0,30);
				title=title+".....";
			}

%>

  <tr>
    <td width="16%" align="center"><img border="0" src="/LBCOM/lb_images/bullet.jpg"></td>
    <td width="82%">
    	<font face="Verdana" size="1">
    	<a href="/LBCOM/news/StudentNews.jsp#news<%=newsId%>"><%=title%></a></font>
    </td>
    <td width="2%"></td>
  </tr>

<%
			count++;
			if(count==4)
				break;
		}
%>
<%
		for(int i=0;i<4-count;i++)
		{
%>
		  <tr>	
		    <td width="16%"></td>
		    <td width="82%"></td>
		    <td width="3%"></td>
		  </tr>
<%
		}	
%>
  <tr>
    <td width="16%"></td>
    <td width="82%"></td>
    <td width="3%"></td>
  </tr>
  <tr>
    <td width="16%">&nbsp;</td>
    <td width="82%">
    <p align="right"><font face="Verdana" size="1"><a href="/LBCOM/news/StudentNews.jsp">More&gt;&gt;</a></font></td>
    <td width="3%">&nbsp;</td>
  </tr>
</table>
</body>

<%
	}
	catch(Exception e)
	{
		System.out.println("The exception in HomeNews.jsp is..."+e);
	}
%>

</body>

</html>