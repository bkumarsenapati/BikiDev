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
String developerId="",schoolId="",strndId="",strandDesc="";
String courseId="",unitId="",lessonId="";
String courseName="",unitName="",lessonName="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
%>

   
<%
	session=request.getSession();
	flag=false;
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	
     try{
	con=db.getConnection();
	st=con.createStatement();
	
	
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		
		System.out.println("======Retrieve Standards=======");
		System.out.println("select * from lbcms_dev_cc_standards_lessons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
	
		rs=st.executeQuery("select * from lbcms_dev_cc_standards_lessons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		while(rs.next())
		 {
			strndId=rs.getString("standard_code");
			System.out.println("strndId..."+strndId);
			st1=con.createStatement();
			//System.out.println("select * from lbcms_dev_cc_standards where standard_type='common' and standard_code='"+strndId+"'");
			rs1=st1.executeQuery("select * from lbcms_dev_cc_standards where standard_type='common' and standard_code='"+strndId+"'");
			if(rs1.next())
			 {
				System.out.println("Before ...strandDesc..."+strandDesc);
				strandDesc=rs1.getString("standard_desc");
				System.out.println("strandDesc..."+strandDesc);
				

			%>
<br>
			<tr>
					
				<td width="70%" colspan="4"><%=strandDesc%></td>
				</td>
			</tr>
<%	
			 }
			rs1.close();
			st1.close();



		 }
		 rs.close();
		 st.close();
 %><BR>
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

