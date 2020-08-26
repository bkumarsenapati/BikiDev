<html>
<head>
<title><%=application.getInitParameter("title")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%@ page language="java" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
	Connection con=null;
	String schoolid="",adminid="",logopath="";
	String userId,userType,schoolId;
	userId=(String) session.getAttribute("Login_user");
	schoolId =(String)session.getAttribute("Login_school");
%>

<%
session=request.getSession(false);
schoolid=(String)session.getAttribute("schoolid");
adminid="Admin";
	
	try{
			con = con1.getConnection();
			Statement statement = con.createStatement();
			logopath = "../asm/images/hsn/logo.gif";
	}
    catch(SQLException sqlexception){
			ExceptionsFile.postException("schooladmin1.jsp","Operations on database ","SQLException",sqlexception.getMessage());
            logopath = "../asm/images/hsn/logo.gif";
    }
	
	finally{
			try{
				    if(con!=null && ! con.isClosed())
					con.close();
			}catch(Exception e){
					ExceptionsFile.postException("schooladmin.jsp","closing connection object","Exception",e.getMessage());
					System.out.println("Connection close failed");
			}
	}
%>
<script>
		adminid = "<%= adminid%>"
		schoolid = "<%= schoolid %>"
		logopath = "<%= logopath%>"
</script>

</head>

<frameset rows="90,*,0" framespacing="0" border="0" frameborder="0">
	<frame name="banner" noresize target="contents" scrolling="no" src="/LBCOM/schoolAdmin/top.jsp?schoolid=<%=schoolId%>&userid=<%=userId%>"  noresize border="0">
	<frameset cols="168,0,*">
		<frame name="contents" target="main" scrolling="no" src="/LBCOM/schoolAdmin/left.jsp" noresize border="0">
		<frame name="refreshframe" target="main" scrolling="no" noresize border="0">
		<frame name="main" src="about:blank">
	</frameset>
	<frame name="bottom" id="bottom" scrolling="no" src="/LBCOM/bottom.jsp">
</frameset>
<noframes>
    <body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <p>To view this page correctly, you need a Web browser that supports frames.</p>
	<A HREF="/LBCOM/common/Logout.jsp">Logout</A> 
    </body>
</noframes>
</html>
