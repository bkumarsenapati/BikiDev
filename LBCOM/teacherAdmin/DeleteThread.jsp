<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form name=show>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	boolean statusFlag=false;
	String mode="",schoolId="",forumId="",threadName="",forumName="",posteduser="",postedDate="",status="",uType="";
	int i=0,sno=0;
%>
<%
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		uType    = (String)session.getAttribute("logintype");
		mode = request.getParameter("mode");
		sno=Integer.parseInt(request.getParameter("sno"));
		schoolId = request.getParameter("sid");
		forumId=request.getParameter("fid");
		threadName=request.getParameter("topic");
		threadName=threadName.replaceAll("\"","&#34;");
		threadName=threadName.replaceAll("\'","&#39;");

		forumName=request.getParameter("dir");
		posteduser=request.getParameter("user");
		postedDate=request.getParameter("postdate");
		status=request.getParameter("status");
	
		if(mode.equals("delete"))
		{
			i = st.executeUpdate("delete from  forum_post_topic_reply where sno="+sno+" and topic='"+threadName+"' and user_id='"+posteduser+"' and school_id='"+schoolId+"' and forum_id='"+forumId+"'");
			if(i==1)
			{

				if(uType.equals("teacher"))
					uType="teacher";
				response.sendRedirect("/LBCOM/"+uType+"Admin/ShowThreads.jsp?fid="+forumId+"&user="+posteduser+"&fname="+forumName+"&topic="+threadName+"&postdate="+postedDate+"&dir="+forumName+"&status="+status);
					
			
			}
		}

	}
	catch(Exception se)
	{
		System.out.println("Exception in DeleteThread is..."+se.getMessage());			
	}
	finally
		{
			try  
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
				{
					con.close();
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("DeleteThread.jsp","closing connections","SQLException",se.getMessage());
			}
		}
%>

</form>
</body>
</html>
