<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String schoolId="",sidStr="",id="",uName="";		
	Hashtable studentIds=null;
	StringTokenizer sidTokens= null;
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		schoolId = (String)session.getAttribute("schoolid");
		sidStr=request.getParameter("sidstr");
		
		studentIds = new Hashtable();

		sidTokens=new StringTokenizer(sidStr,",");

		while(sidTokens.hasMoreTokens())
		{
			id=sidTokens.nextToken();
			studentIds.put(id,id);
		}

		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select username,fname,lname from studentprofile where schoolid='"+schoolId+"' order by fname");
%>
<html>
<head>
</head>
<body>
<center>
<table border="1" cellspacing="1" width="300">
<tr>
	<td width="100%"><b><font face="Verdana" size="4" color="#008000">List of Students</font></b></td>
</tr>

<%
		while(rs.next())
		{
			uName=rs.getString("username");
			
			if(studentIds.containsKey(uName))
			{
%>
		    <tr><td width="100%"><font face="Verdana" size="2"><%=rs.getString("fname")%> <%=rs.getString("lname")%></font></td></tr>

<%
			}
		}
		rs.close();
	}
	catch(SQLException se)
	{
		System.out.println("The exception in ListAssignments.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in ListAssignments.jsp is....."+e);
	}	
%>
    <tr>
      <td width="100%">&nbsp;</td>
    </tr>
    <tr>
      <td width="100%" align="center">
		<font face="Verdana" size="2"><a href="#" onclick="javascript:window.close(-1);">CLOSE</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>