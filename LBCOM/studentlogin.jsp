<%@page import = "java.sql.*,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
     Connection con=null;
	 Statement st=null,st1=null,st2=null,st3=null;
	 ResultSet rs=null,rs1=null,rs2=null,rs3=null;
     String schoolId="",studentId="",passWord="";
	 int userId=0;
%>
<%
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		userId=Integer.parseInt(request.getParameter("userid"));
		System.out.println("userId..."+userId);
		System.out.println("select * from smsnew.student where student_id="+userId+"");
		
		rs=st.executeQuery("select * from smsnew.student where student_id="+userId+"");
		if(rs.next())
		{
			studentId=rs.getString("roll");
		}
		st1=con.createStatement();
		rs=st.executeQuery("select * from studentprofile where username='"+studentId+"'");
		if(rs.next())
		{
			passWord=rs.getString("password");
			schoolId=rs.getString("schoolid");
		}
		//schoolId="candor";
		System.out.println("studentId..."+studentId);
		System.out.println("passWord..."+passWord);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link rel="stylesheet" href="css/Learnbeyond-login.css">

<head>
<meta charset="utf-8">
<title>Learnbeyond</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="Responsive HTML template for Your company" name="description">
<meta content=" " name="author">
</head>
<body onload="popupsCheck(); return false;">
<div class="navbar navbar-fixed-top">
<div class="navbar-inner">
<div class="container">

<a class="brand" href="/LBCOM/">
<!-- <img alt="Learnbeyond" src="/LBCOM/session/images/logo.png"> -->
</a>
</div>
</div>
</div>
<div class="container">
<div id="login-wraper">
<!-- <form name="stdpage" method="post" id="stdpage" class="form login-form" onSubmit="validate();return false;"> -->
<form name="stdpage" method="post" id="stdpage" action="/LBCOM/GetUserType">
<div class="body">
	<input type="hidden" name="schoolid" value="<%=schoolId%>">
	<input type="hidden" name="userid" value="<%=studentId%>">
	<input type="hidden" name="password" value="<%=passWord%>">
	<input type="hidden" name="checked" value="unchecked">
		   
		


</div>

<%
}
	catch(Exception e)
	{
		ExceptionsFile.postException("studentlogin.jsp","operations on database","Exception",e.getMessage());
	}
	finally
	{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("studentlogin.jsp","closing statement and connection objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
  %>  
  <script>  
  window.stdpage.submit();
  </script>
  </form>
</body>
</html>