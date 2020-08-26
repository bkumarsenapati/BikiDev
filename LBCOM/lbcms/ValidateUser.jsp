<%@page import = "java.sql.*,javax.servlet.http.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null;
	String password="",userId="",sessid="",developerid="",schoolId="";
	boolean flg=false;
	try
	{
		sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}
	userId=request.getParameter("userid");
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	rs=st.executeQuery("select userid from lbcms_dev_users where userid='"+userId+"'");
	if(rs.next())
	{
			flg=true;
			developerid=rs.getString("userid");
			session.setAttribute("cb_developer",developerid);

			response.sendRedirect("CourseHome.jsp?userid="+developerid);
			
	}
	else
	{
			flg=true;
			developerid=userId;
			String queryOne = "insert into lbcms_dev_users values('"+userId+"','password')";
			st1.executeUpdate(queryOne);
			session.setAttribute("cb_developer",developerid);
			response.sendRedirect("CourseHome.jsp?userid="+developerid);
		
	}
	if(flg==false)
	{
			response.sendRedirect("/LBCOM/lbcms/index.jsp");
	}
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in ValidateUser.jsp is....."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in ValidateUser.jsp is....."+se.getMessage());
			}
		}
			
%>