<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String widStr="",tblName="",id="";		
	Hashtable docNames=null;
	StringTokenizer widTokens=null;
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		widStr=request.getParameter("workids");
		tblName=request.getParameter("tblname");

		con=con1.getConnection();
		st=con.createStatement();
		
		docNames=new Hashtable();

		rs=st.executeQuery("select exam_id,exam_name from "+tblName+"");

		while(rs.next())
		{
			docNames.put(rs.getString(1),rs.getString(2));
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
<html>
<head>
</head>
<body>
<center>
<table border="1" cellspacing="1" width="300">
    <tr>
      <td width="100%"><b>
      <font face="Verdana" size="4" color="#008000">List of Assessments</font></b></td>
    </tr>
<%
		widTokens=new StringTokenizer(widStr,",");

		while(widTokens.hasMoreTokens())
		{
			id=widTokens.nextToken();
%>
    <tr>
      <td width="100%"><font face="Verdana" size="2"><%=docNames.get(id)%></font></td>
    </tr>
<%
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