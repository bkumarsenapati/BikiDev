<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String schoolId="",assignedStr="",id="",uName="",val="";		
	Hashtable assignedIds=null;
	StringTokenizer assignedTokens= null,finalTokens=null;
	
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		schoolId = (String)session.getAttribute("schoolid");
		assignedStr=request.getParameter("assignedstr");
		
		assignedIds = new Hashtable();

		assignedTokens=new StringTokenizer(assignedStr,";");
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
		while(assignedTokens.hasMoreTokens())
		{
			id=assignedTokens.nextToken();
			finalTokens=new StringTokenizer(id,",");
			while(finalTokens.hasMoreTokens())
			{
				val=finalTokens.nextToken();
				assignedIds.put(val,val);
			}
		}
		
		for(int i=0;i<assignedIds.size();i++)
			out.println("aaa is..."+assignedIds.get(val));
		String id1="",id2="";
		
		for(Enumeration e1 = assignedIds.elements() ; e1.hasMoreElements() ;)
		{
			id1=(String)e1.nextElement();
			out.println(id1);
			id2=id1.substring(0,1);
			if(id2.equals("w"))
			{

			}
			
			out.println("<br>");
		}

// w1,s1;w1,s2;w1,s3;s2,s1;w2,s2;

		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select username,fname,lname from studentprofile where schoolid='"+schoolId+"' order by fname");
%>

<%
		while(rs.next())
		{
			uName=rs.getString("username");
			
			if(assignedIds.containsKey(uName))
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