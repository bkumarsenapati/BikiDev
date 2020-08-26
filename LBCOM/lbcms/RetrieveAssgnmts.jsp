<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 
<title></title>
</head>
<body topmargin=2 leftmargin=0>
<form name="strands" id='strands'>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String courseId="",unitId="",lessonId="";
String courseName="",lessonName="",tblName="";
ResultSet  rs=null;
Connection con=null;
Statement st=null;

%>

   
<%
	session=request.getSession();
	
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
     try{
	con=db.getConnection();
	st=con.createStatement();
	
	
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		tblName=request.getParameter("tblnmae");
		
		System.out.println("======Retrieve Standards=======");
		System.out.println("tblName=="+tblName);
		%>
		<div id="assgncount">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="assgnlist" style="margin-left:20px" onChange ="goAssgn('<%=courseId%>'); return false;">
						<option value="assgnall" selected> -- Assignments --</option>
<%
		
		rs=st.executeQuery("select * from "+tblName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		while(rs.next())
		 {				

%>
				<option value="<%=rs.getString("assgn_no")%>"> <%=rs.getString("assgn_name")%> </option>
<%	
			 }
			
		 rs.close();
		 st.close();
 %>
 
		</select>
	


<%
	
}catch(Exception e){
		ExceptionsFile.postException("RetrieveAssgnmts.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("RetrieveAssgnmts.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	
%>

	
</html>

