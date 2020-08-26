<%@ page import="java.sql.*" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<html>
<head>
<script language="javascript" src="/LBCOM/validationscripts.js"></script>
<LINK href="images/style.css" type=text/css rel=stylesheet>
<META http-equiv=Content-Type content="text/html; charset=utf-8">

<script>
function submitForm()
{
	document.searchFrom.searchstr.value=document.searchFrom.item.value;
	replacequotes();
}
</script>
</head>
<body>
<form name=searchFrom method="post" onsubmit="return submitForm();" action="SafeSearchList.jsp">

<%
	Connection connection = null;
    Statement statement = null;
	ResultSet rs=null;
	String item,searchStr="";

	item=request.getParameter("item");
	searchStr=request.getParameter("searchstr");
	
	if(item==null||item.equals(""))
	{
		response.sendRedirect("/LBCOM/search/SafeSearch.jsp");
	}

    if( item!= null&&!item.equals("")&&item.length()>3)
	{
%>
      <table width="100%" cellpadding="0" cellspacing="0">
	  <tr>
		<td width="39" >&nbsp;</td>
		<td width="100%">
			<font face="Verdana" size="2">Safe search lets the students to search the world wide web either for the doubts they have or for the web sites they want to surf in a secured manner. Here you will see only the list of sites which were already surfed by the teachers and were suggested by them.</font>
		</td>
	</tr>
	<tr>
		<td width="39" >&nbsp;</td>
		<td width="100%">&nbsp;</td>
	</tr>
	<tr>
		<td width="39" ></td>
		<td width="100%"><font face="Verdana"><b><font size="2">Safe Search</font></b>
	        <input type="text" name="item" value="<%=searchStr%>" size="20">
			<input type="submit" value="Search">
        </td>
	</tr>
    </table>

	<input type="hidden" name="searchstr" value="">

	<br>	
	
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td width="600" bgcolor="#ECA384"><b><font size="2" face="Verdana">&nbsp;Search Results</font></td>
	</tr>
<%
		connection=con1.getConnection();
		statement= connection.createStatement();
	   
		rs=statement.executeQuery("select * from lb_search where keywords like '" + item + "'");
	   
		if(!rs.next())
		{
%>    
			<tr>
				<td width="918" height="16"><font face="Verdana" size="2">No matches found.</td>
			</tr>   
<%
		}
		else
		{
			rs.previous();
		}
		
		while(rs.next()) 
		{
%> 
			<tr>
				<td width="100%">
					<font face="verdana" size="2"><%= rs.getString("description")%></font><br>
					<font size="2" face="Verdana">
					<a target="_blank" href="http://<%= rs.getString("url")%>"><%= rs.getString("url")%></a>
					</font>
				</td>
			</tr>  
<%
		}
		rs.close();
	}
	else
	{
%>
		<tr>
			<td width="100%">
				<font face="Verdana" size="2">No matches found.&nbsp;&nbsp;&nbsp;
				<a href='javascript:history.go(-1);'><font face="verdana" size="2"><b>Back</b></font></a>
			</td>
		</tr>   
<%
	}
%> 
</table>
</body>
</html>