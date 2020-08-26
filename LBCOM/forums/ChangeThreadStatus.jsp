<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body onload="RedirectWithDelay();"><br><center><b><i><font face="Arial" size="2" align="center">Topic Status Changed Successfully</font></i></b></center></body>
<form name=show>
<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null;
	boolean statusFlag=false;
	String fId="",emailid="",schoolId="",fStatus="",tStatus="",uType="",sno="",fname="";
	int i=0,j=0;
%>
<%
	try
	{
		emailid=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		uType    = (String)session.getAttribute("logintype");

		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		fId=request.getParameter("fid");
		fname=request.getParameter("fname");
		tStatus=request.getParameter("status");
		sno=request.getParameter("sno");
		fStatus=request.getParameter("status1");
		if(tStatus.equals("1"))
		{
			//fStatus="0";
			tStatus="2";
		}
		else if(tStatus.equals("2"))
		{
			//fStatus="1";
			tStatus="1";
		}
		
		//i=st.executeUpdate("update forum_master set status='"+fStatus+"' where forum_id='"+fId+"' and school_id='"+schoolId+"'");
		j=st1.executeUpdate("update forum_post_topic_reply set status='"+tStatus+"' where forum_id='"+fId+"' and school_id='"+schoolId+"' and sno='"+sno+"' ");
		
		//response.sendRedirect("/LBCOM/schoolAdmin/ForumMgmtIndex.jsp?schoolid="+schoolId+"&emailid="+emailid);
		out.println("<html><head><title></title>");
		if(uType.equals("admin"))
						uType="school";
		if(uType.equals("teacher"))
						uType="teacher";
		out.println("<script language=\"JavaScript\">function Redirect(){	document.location.href='/LBCOM/"+uType+"Admin/ShowThreads.jsp?fid="+fId+"&fname="+fname+"&status="+fStatus+"';}");
		out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',1000);}</script></head>");
		out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">&nbsp;</font></i></b></center></body></html>");
		
	}
	catch(Exception se)
	{
		System.out.println("Exception in ChangeForumStatus.jsp is..."+se.getMessage());			
	}
	finally
	{
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>

</form>
</body>
</html>