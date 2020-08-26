<%@page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	 
	String sessid="",courseId="",schoolId="",classId="",workId="",move="";
	int slNo=0,maxValue=0,aboveNumber=0,belowNumber=0,start=0;
%>
<%
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	try
	{
		con=con1.getConnection();
		st=con.createStatement();

		schoolId = (String)session.getAttribute("schoolid");
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");		
	
		slNo=Integer.parseInt(request.getParameter("slno"));
		start=Integer.parseInt(request.getParameter("start"));
		workId=request.getParameter("workid");
		move=request.getParameter("move");

		rs=st.executeQuery("select max(slno) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs");
		if(rs.next())
		{
			maxValue=Integer.parseInt(rs.getString(1));
		}

		aboveNumber=slNo-1;
		belowNumber=slNo+1;
		maxValue++;

		if(move.equals("up"))
		{
			int i=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_workdocs set slno='"+maxValue+"' where slno='"+aboveNumber+"'");

			int j=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_workdocs set slno='"+aboveNumber+"' where slno='"+slNo+"'");

			int k=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_workdocs set slno='"+slNo+"' where slno='"+maxValue+"'");
		}
		else if(move.equals("down"))
		{
			int i=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_workdocs set slno='"+maxValue+"' where slno='"+belowNumber+"'");

			int j=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_workdocs set slno='"+belowNumber+"' where slno='"+slNo+"'");

			int k=st.executeUpdate("update "+schoolId+"_"+classId+"_"+courseId+"_workdocs set slno='"+slNo+"' where slno='"+maxValue+"'");
		}
		
		response.sendRedirect("OrderAssignments.jsp?start="+start);
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("ChangeOrder.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
		System.out.println("Exception in ChangeOrder.jsp is...."+e);
	}	
	catch(Exception e)
	{
		System.out.println("Exception in ChangeOrder.jsp is...."+e);
		ExceptionsFile.postException("ChangeOrder.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
	}	
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ChangeOrder.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}
%>

<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>
<body>
</body>
</html>
