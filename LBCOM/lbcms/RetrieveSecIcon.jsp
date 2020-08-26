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
String developerId="",schoolId="";
String courseId="",unitId="",lessonId="";
String courseName="",unitName="",lessonName="",imageName="",secTitle="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;

int secIconValue=0;
%>

   
<%
	session=request.getSession();
	
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	
     try{
	con=db.getConnection();
	st=con.createStatement();
	
	System.out.println("=======Retrieve========");
		courseId=request.getParameter("courseid");
		System.out.println("courseId..."+courseId);
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		System.out.println("developerId..."+developerId);
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		System.out.println("lessonId..."+lessonId);
		lessonName=request.getParameter("lessonname");
		secIconValue=Integer.parseInt(request.getParameter("imageid"));
		System.out.println("secIconValue in retrieve..."+secIconValue);
		System.out.println("select * from lbcms_dev_sec_icons_master where image_id="+secIconValue+"");
		secTitle=request.getParameter("sectitle");
		
		rs=st.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secIconValue+"");
		if(rs.next())
		 {
			imageName=rs.getString("image_name");
			System.out.println("strndId..."+imageName);
			
		 }
		 rs.close();
		 st.close();
 %><BR>
 <tr><td><a href="/LBCOM/lbcms/SelectAllImages.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=<%=secTitle%>" target="_blank"><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=imageName%>" width='84' height='80' border='0' title="SecIcon"></a>
 </td></tr>
 </table>
	


<%
	
}catch(Exception e){
		ExceptionsFile.postException("StudentLoginReports.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("StudentLoginReports.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	
%>

	
</html>

