<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY >
<%@ page language="java" import="java.sql.*,sqlbean.ContineoSqlbean"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%

Connection con=null;
String username="";
String schoolId="";
String type="";
try{

	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	con=con1.getConnection();
	Statement st=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	username=((String)session.getAttribute("emailid")).toLowerCase();
	type=request.getParameter("type");
	//username="test1";
	
	
	//st.executeUpdate("delete from hsnusers where userid='"+userName+"'");
	//st.executeUpdate("insert into hsnusers values('"+userName+"','"+password+"',now())");
	//ResultSet rs=st.executeQuery("show tables ");
	st.executeUpdate("update session_details set call_time=now() where user_id='"+username+"' and school_id='"+schoolId+"'");
	out.println("<script>");	
	out.println("window.location.href=\"/"+application.getInitParameter("cmsroot")+"/pages/welcome_modified.jsp?username="+username+"&schoolid="+schoolId+"&type="+type+"\";");
	out.println("</script>");
}catch(Exception e){
	System.out.println("Exception in Contineotest.jsp is "+e);
}finally{
	try{
		if(con!=null && ! con.isClosed()){
			con.close();
		}
	}catch(Exception e){
		System.out.println("Exception in contineotest.jsp while closing connection object is "+e);
	}
}

%>


</BODY>
</HTML>
